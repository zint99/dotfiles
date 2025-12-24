test ! -e "$HOME/.x-cmd.root/local/data/fish/rc.fish" || source "$HOME/.x-cmd.root/local/data/fish/rc.fish" # boot up x-cmd.
if status is-interactive
    # Commands to run in interactive sessions can go here
    # 2. 视觉净化
    # -----------------------------------------------------
    set -g fish_greeting ""

    # 3. 环境变量 (Path)
    # -----------------------------------------------------
    # 你的个人 bin 目录
    fish_add_path ~/.local/bin
    fish_add_path ~/go/bin
    fish_add_path ~/.cargo/bin

    # 4. 现代化工具初始化
    # -----------------------------------------------------
    # [Starship] UI 皮肤
    # 如果你不想安装二进制，也可以用 x-cmd: `x starship init fish | source`
    # 这里假设你保留本地高性能版：
    x starship init fish | source
    
    # [Zoxide] 智能 cd
    zoxide init fish | source

    # 5. 强力缩写 (Abbreviations)
    # -----------------------------------------------------
    # 替换 ls 为 eza
    abbr --add ls "x eza --icons"
    abbr --add ll "x eza -l -g --icons --git"
    abbr --add la "x eza -la -g --icons --git"
    abbr --add lt "x eza --tree --level=2 --icons"

    # 替换 cat 为 bat
    abbr --add cat "x bat"

    # Git 常用缩写
    abbr --add g "git"
    abbr --add gs "git status"
    abbr --add ga "git add ."
    abbr --add gc "git commit -m"
    abbr --add gp "git push"
    abbr --add gl "git log --oneline --graph --decorate"
    abbr --add gd "git diff"

    # 安全操作
    abbr --add rm "rm -i"
    abbr --add cp "cp -i"
    abbr --add mv "mv -i"

    # 6. Zellij 集成
    # -----------------------------------------------------
    # 快捷键 z 进入 workspace
    abbr --add z "zellij attach -c workspace || zellij -s workspace"

    # 7. 编辑器设置
    # -----------------------------------------------------
    set -gx EDITOR nvim
    set -gx VISUAL nvim

    # 8. Vim 模式 (可选)
    # -----------------------------------------------------
    # fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
end
