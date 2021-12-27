require('rust-tools').setup({
  server = {
    cmd = { "rustup", "run", "nightly", "rust-analyzer"}
  }
})
