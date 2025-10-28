local g = vim.g

g.netrw_sort_reverse = 1
g.is_tty = os.getenv("TERM") == "linux"
