-- Single-place task management + focus timer.
-- nvim-orgmode: TODO states, agenda, capture, clocking (org-mode emulation).
-- pomo.nvim: Pomodoro timer with break cycles + notifications, wired to
-- org clock-in/out so starting a pomodoro also starts time tracking on the task.
--
-- orgmode ships its own default keymaps (global prefix <leader>o):
--   <leader>oa  agenda prompt      <leader>oc  capture prompt
--   <leader>oxi clock in (org buf) <leader>oxo clock out (org buf)
-- Its treesitter grammar installs itself on first run — no nvim-treesitter entry needed.
return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    config = function()
      require("orgmode").setup({
        org_agenda_files = "~/org/**/*",
        org_default_notes_file = "~/org/refile.org",
        org_todo_keywords = { "TODO(t)", "NEXT(n)", "|", "DONE(d)" },
        org_todo_keyword_faces = {
          TODO = ":foreground #fb4934 :weight bold", -- gruvbox red
          NEXT = ":foreground #fabd2f :weight bold", -- gruvbox yellow
          DONE = ":foreground #b8bb26 :weight bold", -- gruvbox green
        },
        org_capture_templates = {
          t = {
            description = "Task",
            template = "* TODO %?\n  %u",
            target = "~/org/refile.org",
          },
          n = {
            description = "Note",
            template = "* %?\n  %u",
            target = "~/org/refile.org",
          },
        },
      })
    end,
  },

  {
    "epwalsh/pomo.nvim",
    version = "*",
    cmd = { "TimerStart", "TimerStop", "TimerSession", "TimerRepeat" },
    keys = {
      {
        "<leader>pp",
        function()
          -- If cursor is on an org headline, clock in via orgmode's own
          -- buffer-local mapping before starting the work/break cycle.
          if vim.bo.filetype == "org" then
            local keys = vim.api.nvim_replace_termcodes("<leader>oxi", true, false, true)
            vim.api.nvim_feedkeys(keys, "m", false)
          end
          vim.cmd("TimerSession Pomodoro")
        end,
        desc = "Start pomodoro session (+ org clock-in)",
      },
      {
        "<leader>ps",
        function()
          if vim.bo.filetype == "org" then
            local keys = vim.api.nvim_replace_termcodes("<leader>oxo", true, false, true)
            vim.api.nvim_feedkeys(keys, "m", false)
          end
          vim.cmd("TimerStop")
        end,
        desc = "Stop pomodoro (+ org clock-out)",
      },
      { "<leader>pb", "<cmd>TimerStart 5m Break<cr>", desc = "Start standalone short break" },
    },
    dependencies = { "rcarriga/nvim-notify" },
    opts = {
      notifiers = {
        { name = "Default", opts = { sticky = true } },
      },
      sessions = {
        -- Ultradian-rhythm cycle: 90m deep work, 15m break. <leader>pp
        -- re-runs this session, so back-to-back cycles just mean pressing it again.
        Pomodoro = {
          { name = "Work", duration = "90m" },
          { name = "Break", duration = "15m" },
        },
      },
    },
    config = function(_, opts)
      require("pomo").setup(opts)

      -- Upstream bug: pomo.util.format_time() formats a plain duration (seconds)
      -- with os.date("%Hh %Mm", ...) but never forces UTC, so the displayed
      -- time gets skewed by the local UTC offset (e.g. 90m shows as 2h30m at
      -- UTC+1). Patch it to force UTC formatting; logic otherwise unchanged
      -- from pomo/util.lua.
      local util = require("pomo.util")
      util.format_time = function(time_left)
        if time_left <= 60 then
          return string.format("%ds", time_left)
        elseif time_left <= 300 then
          if math.fmod(time_left, 60) == 0 then
            return os.date("!%Mm", time_left)
          else
            return os.date("!%Mm %Ss", time_left)
          end
        elseif time_left < 3600 then
          return os.date("!%Mm", time_left)
        else
          if math.fmod(time_left, 3600) == 0 then
            return os.date("!%Hh", time_left)
          else
            return os.date("!%Hh %Mm", time_left)
          end
        end
      end
    end,
  },
}
