return {
  "shortcuts/no-neck-pain.nvim",
  cmd = { "NoNeckPain", "NoNeckPainResize", "NoNeckPainWidthUp", "NoNeckPainWidthDown" },
  config = function()
    require("no-neck-pain").setup({})
  end,
  keys = {
    { "=", "<cmd>NoNeckPain<cr>", desc = "Center the current buffer (NoNeckPain)" }
  }
}
