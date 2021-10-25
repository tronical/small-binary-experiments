#!/bin/bash
#
# Build with the given target as parameter and replaces the section in README.md
# with the computed sizes
#
# For example ./update.sh x86_64-apple-darwin

file_size(){
    case $(uname) in
        (Darwin)
            stat -Lf %z -- "$1";;
        (*) stat -c %s -- "$1"
    esac
}

target=$1

cargo +nightly build -Z build-std=panic_abort,std -Z build-std-features=panic_immediate_abort --target=x86_64-apple-darwin --release

header="|"
separators="|"
row="|"
for bin in rust-minimal sixtyfps-hello-world; do
    size=$(file_size target/$target/release/$bin)

    header="$header $bin |"
    separators="$separators-|"
    row="$row \`$size\` |"
done

section_start="<!-- begin $target -->"
section_end="<!-- end $target -->"

table="$section_start\\n$header\\\n$separators\\\n$row\\\n$section_end"

ed README.md <<EOT
/$section_start/+1,/$section_end/-1d
/$section_start/a
$header
$separators
$row
.
wq
EOT
