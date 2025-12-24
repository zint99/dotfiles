-- =========================================================
-- WezTerm Configuration - Zellij Container Edition
-- =========================================================

local wezterm = require 'wezterm'

-- 使用 config_builder 确保向后兼容
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- =========================================================
-- 1. 核心启动策略 (WSL 优先)
-- =========================================================
-- 默认进入 WSL 发行版
-- 💡 提示：在 PowerShell 运行 `wsl -l -v` 查看确切名称
config.default_domain = 'WSL:Ubuntu'

-- 启动时的默认窗口尺寸 (避免打开是个小方块)
config.initial_cols = 120
config.initial_rows = 36

-- 自动热加载配置
config.automatically_reload_config = true

-- =========================================================
-- 2. Zellij 深度适配 (关键优化)
-- =========================================================
-- 🚫 禁用 WezTerm 的 Alt 键劫持
-- Zellij 极度依赖 Alt 键。如果不关这个，你的 Alt+H/J/K/L 可能会输出奇怪字符
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- 🚫 隐藏 WezTerm 标签栏
-- 既然用 Zellij 管理标签，WezTerm 这一层就应该隐形
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- 🖱️ 滚动优化
-- 关闭滚动条，将滚轮事件透传给 Zellij (用于 Zellij 的 Scroll/Search 模式)
config.enable_scroll_bar = false

-- =========================================================
-- 3. 视觉盛宴 (Acrylic & Padding)
-- =========================================================
config.color_scheme = 'Catppuccin Mocha'

-- 字体配置
config.font = wezterm.font_with_fallback {
  'JetBrainsMono NF',    -- 确保 Windows 已安装此字体 (Nerd Font版)
  'Cascadia Code',       -- 备选1
  'Microsoft YaHei',     -- 中文备选
}
config.font_size = 11.0

-- 连体字与渲染特性
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }
-- 解决某些字体行高过紧的问题
config.line_height = 1.0

-- ✨ 窗口背景特效
config.window_background_opacity = 0.85
config.win32_system_backdrop = 'Acrylic'

-- 🖼️ 窗口装饰与边距
-- RESIZE: 无标题栏，保留可拖拽边缘
config.window_decorations = "RESIZE"

-- 增加一点内边距，防止文字贴着显示器边缘，看起来更优雅
config.window_padding = {
  left = '4px',
  right = '4px',
  top = '4px',
  bottom = '0',
}

-- =========================================================
-- 4. 交互微调
-- =========================================================
-- 鼠标右键粘贴 (符合 Windows 直觉)
config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
  -- 💡 拖拽窗口技巧：
  -- 因为去掉了标题栏，如果你需要移动窗口，
  -- 可以按住 ALT + 鼠标左键 拖动窗口任意位置
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'ALT',
    action = wezterm.action.StartWindowDrag,
  },
}

-- =========================================================
-- 5. 性能与硬件
-- =========================================================
config.max_fps = 120
config.front_end = "WebGpu"

return config
