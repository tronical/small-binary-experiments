# Small Binaries

What is the smallest binary that we can build with SixtyFPS?

Note: The examples only work with nightly.

# Changes to `Cargo.toml`:

* Enable automatic stripping via `cargo-features = ["strip"]` at the top of `Cargo.toml` and then `strip = true` in the `[profile.release]` section
* `panic = "abort"` in the `[profile.release]` section to disable unwinding
* `lto = true`,`opt-level = "s"` and `codegen-units = 1` in the `[profile.release]` section

# Build command

Build with nightly, recompile the std library:

    `cargo +nightly build -Z build-std=panic_abort,std -Z build-std-features=panic_immediate_abort --target=x86_64-apple-darwin --release`

## Size comparison x86-64:

<!-- begin x86_64-apple-darwin -->
| rust-minimal | sixtyfps-hello-world |
|-|-|
| `51608` | `167544` |
<!-- end x86_64-apple-darwin -->

## Size comparison ARMv7:

<!-- begin armv7-unknown-linux-gnueabihf -->
| rust-minimal | sixtyfps-hello-world |
|-|-|
| `22140` | `128700` |
<!-- end armv7-unknown-linux-gnueabihf -->
