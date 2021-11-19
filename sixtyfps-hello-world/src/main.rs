sixtyfps::include_modules!();
fn main() {
    sixtyfps_rendering_backend_mcu::init();
    App::new().run();
}
