// dylibsurfer-bindgen/src/generators/mod.rs
pub mod ffi;
pub mod types;
// pub mod safe_wrapper;
// pub mod templates;
// pub mod utils;
// Re-export the main generator
pub use ffi::FfiGenerator;
