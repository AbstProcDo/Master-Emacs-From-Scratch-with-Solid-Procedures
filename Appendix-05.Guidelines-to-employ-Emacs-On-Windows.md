# Windows上畅行无碍玩转Emacs27.1的11个步骤

感谢 
@ [aqua0210](https://emacs-china.org/u/aqua0210) 
@ [wsug](https://emacs-china.org/u/wsug) 
@[xhcoding](https://emacs-china.org/u/xhcoding)
@ [realasking](https://emacs-china.org/u/realasking) 
@ [kimim](https://emacs-china.org/u/kimim) 
@ [chenyidao110](https://emacs-china.org/u/chenyidao110) 
@ [doneself](https://emacs-china.org/u/doneself) 
@ [jacklisp](https://emacs-china.org/u/jacklisp)

在求助帖[Windows上用Emacs要做哪些功课？](https://emacs-china.org/t/windows-emacs-27-1/14284?u=action)的热心帮助，终于能在windows上畅行无碍地用emacs了。

将帖子的讨论总结如下，整理作为组织过程资产，作为后续参阅和持续改进的基础。

-----



如果重装了系统，本文将帮助你从windows满血复活doom-emacs。请注意，本文讨论的是windows版本的emacs，非wsl上运行emacs。

# 1.安装scoop包管理工具

我们日常里自己搜索和安装需要的软件，安装一个两个似乎不甚紧要。而且青春正当时，有大把时间等着浪费，一些软件的主页设计得美观诱人。安装软件就如商场购物，体验美妙极了。

然而，倘若年岁已高，稍见天气有了凉意，便顿足捶胸，这一年又转瞬已逝去。

那么就用scoop管理windows上的所有软件吧。安装过程拢共分三步：

1. 以管理员权限打开PowerShell
2. 在其中运行以下代码RemoteSign CurrentUser

```
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
```

1. 运行安装：

```
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

# or shorter
iwr -useb get.scoop.sh | iex
```

站起来伸伸懒腰，10分钟后在回来查看。

scoop极富效率，比如我们要安装git工具，当下就一行代码：

```
scoop install git
```

完全卸载也方便：

```
scoop uninstall git 
```

一点也没有种种冗余的规则。当然，如果心情不错，有时间需要消磨，不妨打开git的主页，只须这一行代码：

```
scoop home git 
```

![img](images/09e104fdf78545258de040cab9924ced)



以上就是scoop的核心操作，我们运行下列代码安装几个程序：

```
scoop install sudo
sudo scoop install 7zip git openssh --global
scoop install aria2 curl grep sed less touch
```

然后再添加extras库：

```
scoop bucket add extras
```

# 2.scoop安装emacs-27.1

首先搜索scoop库中的emacs版本：

```
$ scoop search emacs
'extras' bucket:
    emacs (27.1)
    emax64-pdumper (20180619) --> includes 'runemacs.exe'
```

从结果中看到有最新版的27.1供安装。

但是现在，**切忌先不要着急安装，必须先要修改环境变量HOME的值**。（此处为本文第一次warning）

在Windows中，Emacs将`C:\Users\USERNAME\AppData\Roaming`作为HOME。如果不更改此变量就安装，会引致后续的诸多问题。

环境变量的修改步骤见下图：

![img](images/e9cd31b5317e465ebf75034d94d44554)

修改环境变量HOME

**然后重启电脑**（此处是本文第二处warning，同时也是第一次电脑重启，既然是用windows，只能如此了）。

变更完毕，立刻着手安装：

```
$ scoop install emacs ripgrep fd llvm
Updating Scoop...
Updating 'extras' bucket...
Updating 'main' bucket...
Scoop was updated successfully!
WARN  'emacs' (27.1) is already installed.
Use 'scoop update emacs' to install a new version.
```

由于本机已装载，因而提示already installed.

倘若前述步骤中，没有装上指定的apps，此时须全部装上以下工具：

```
scoop bucket add extras
scoop install git emacs ripgrep fd llvm
```

装好之后，运行scoop info复核：

```
$ scoop info emacs
Name: emacs
Description: An extensible, customizable, free/libre text editor.
Version: 27.1
Website: https://www.gnu.org/software/emacs/
License: GPL-3.0-or-later (https://spdx.org/licenses/GPL-3.0-or-later.html)
Manifest:
  C:\Users\gaowei\scoop\buckets\extras\bucket\emacs.json
Installed:
  C:\Users\gaowei\scoop\apps\emacs\27.1
Binaries:
  bin\runemacs.exe bin\emacs.exe bin\emacsclientw.exe bin\etags.exe bin\ctags.exe
```

此时此刻安装好的emacs长成这般模样。

![img](images/54cb57f136f244429f75ffbf38f2c480)

vanilla-emacs

（题外话，为什么vanilla这个单词描述原生版本呢？因为vanilla的词源是virgin）

# 3.安装doom

新手使用emacs最佳的策略就是配置doom，所谓站在巨人的肩膀上；投入三两分钟的时间，就甩掉普通用户毕生折腾emacs的功夫。

```
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
```

然后运行安装：

```
~/.emacs.d/bin/doom install
```

倘若是新用户，没有个人的配置，整个过程将持续40多分钟，“好饭不怕晚”，请喝杯咖啡，耐心等待。

待到安装完成，**切忌****不要立刻启动emacs。**（此为本文第三处Warning）

从程序notepad中打开文件“~/.doom.d/config”，写入这几行：

```
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("org-cn". "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))


;;Key Configuration for Doom as Vanilla Emacs
(setq evil-default-state 'emacs)
```

需要提醒提醒，要选择all files，不然文件~/.doom.d/config不会显示在窗口中。

![img](images/974bf552b04440afab971f83dd8e5f67)



变更完毕，立刻启动emacs。

![img](images/d79e8bccc8c64d34b5f45128f08fa558)



doom将会呈现给我们比vanilla-emacs漂亮得多的GUI界面。

![img](images/305b184bc92e4e188155b490fa4eba90)



哈，好漂亮。然而，行百里者半九十。到此时此刻，emacs最左侧的图标，一眼所见只是乱码。

# 4.安装all-the-icons的迷思

颇为令人遗憾的是，doom-install并不能自主自动的成功安装all-the-icons到windows系统上，我们必须先进入emacs，然后运行命令：

```
M-x all-the-icons-install-fonts
```

然后在弹出的窗口中，新建"~/.fonts"目录，将all-the-icons下载至其中。

![img](images/ac3054fd5a84432b841dd4b97ab73cb1)



再到~/.fonts目录中找到该字体，手动操作安装。

![img](images/457df71b90d647d7a9f80ea7f13f4059)



安装好之后，**重启电脑**。(此为本文的第四处Warning和第二次电脑重启）

# 5.安装Symbola象形字体

倘若电脑重启，启动emacs后，依然从呈现的界面中看不到全模全样的icons，那就需要安装symbola这款字体。

在“Emacs, fonts and fontsets”这篇文章中，作者文末备注到：

```
Emacs has a default fall-back to Symbola
```

搜索Symbola-font，下载安装。

![img](images/125302d0ae3b4e66be0eea1e003f3469)



安装之后，重启emacs（当然重启电脑也无妨）。

倘若都elisp语言有一丝丝兴趣，此时运行：

```
(font-family-list)
```

核实字体Symbola是否已经加载成功。

如果没有丝毫兴趣，请忽略，这一步无关紧要。

# 6.取消cn-fonts包

重启emacs之后，如果问题仍旧还在。那么请到配置里忍痛割爱取消cn-fonts这个功勋卓著的package。

```
;;(require 'cnfonts)
;;(cnfonts-enable)
```

Comments掉这两行。

再次重启emacs，就能观察到漂亮的icon界面。

![img](images/0f9a5a75fd744f7f9368f650a40a2ebf)



行文到此处，all-the-icons的问题，必然都已解决。

# 7.字体的设置

既然砍掉了“左膀右臂”的cn-fonts package，那就不得不直面设置字体的问题。在此，本文作者“乾坤独断”推荐诸位英文用Monaco字体，中文配置楷体。

将以下字体配置写入config.el文件中：

```
(set-fontset-font t nil "Symbola" nil 'prepend)
(set-face-attribute
 'default nil
 :font (font-spec :name "Monaco" 
                  :weight 'normal
                  :slant 'normal
                  :size 12.5))
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font
   (frame-parameter nil 'font)
   charset
   (font-spec :name "KaiTi"
              :weight 'normal
              :slant 'normal
              :size 15.0)))
```

但是，windows不自带Monaco字体，需要搜索安装。

![img](images/2c364488b0974f9b92e04a779288f86a)



# 8.安装rime输入法

既然咱们用Emacs，则须用起来rime输入法，因为该输入法的快捷键是emacs模式，它在windows上的版本是小狼毫。

![img](images/77be4b473f694c1a903fadfaff8566be)



同时建议，对rime的配置，对Rime/weasel.custom.yaml文件如下修改：

```
patch:
  "style/color_scheme": metroblue
  "style/horizontal"  : true
```

主题选用metroblue,备选词汇横向展示。

![img](images/ae6270410f99409baeaa7d4a31e5db4d)



另外，rime的语言切换与emacs的set-mark-command可能会存在冲突，

```
(set-mark-command ARG)
Key Bindings
global-map C-@
global-map C-SPC
```

# 9.Eshell是个好帮手

在文章破题处，我们单刀直入的点出，用scoop管理windows系统上的安装软件，因为时间金贵，效率就是生产力。基于同样的理由，建议诸位不要在windows上折腾诸般terminal，安安心心用上，用好eshell足矣。

原先在linux系统上，自以为然看待eshell是鸡肋，直到从windows上遇见eshell，心中有些了然开发者的些许用心。

在打开eshell之前，调用scoop安装以下两个Pakcage。

```
$ scoop install coreutils busybox
WARN  'busybox' (3578-g359211429) is already installed. Skipping.
WARN  'coreutils' (5.97.3) is already installed. Skipping.
```

然后将scoop的路径置于环境变量Path的最前面：

```elisp
;;修改windows版本的PATH路径。
(if (eq system-type 'windows-nt)
    (setenv "PATH"
            (concat
             "C:/ProgramData/scoop/shims" ";"
             "C:/Users/gaowei/scoop/shims" ";"
             (getenv "PATH")
             )
            )
  nil)
```

注意将"C:/Users/gaowei/scoop/shims"中的gaowei替换成你的用户名。

享用eshell须留意的一点是，$expansion的语法变化。

```
~/.doom.d [master] λ echo $(echo $HOME)
Symbol’s function definition is void: echo
```

这会报错。因为在eshell中第一公民是elisp而非其他utillities，因为（）留给elisp的代码。

```
~/.doom.d [master] λ echo $(getenv "HOME")
C:\Users\gaowei
```

shell的语法与elisp的语法跨越组合，真大呼过瘾。而对gnu-coreutilies则用花括号。

```
~/.doom.d [master] λ echo ${echo $HOME}
C:\Users\gaowei
```

对eshell，我们到此先浅尝辄止。

# 10.时间格式的问题

倘若你的系统时间设置显示为中文格式，在org中插入当天时间会出现uft-8解码失败的问题。

![img](images/2caddad98b644aef88f2fae0360b3c2d)



正确的显示格式应该为：

```
<2020-08-29 周六>
<2020-08-29 周六 17:24>
```

只有doom-emacs才有此问题，vanilla原生版本并没有。

问题似乎出在utf-8编码上，尝试修改打开系统的utf-8编码

![img](images/25481866bec04659a7761ca8633efea8)



重启后无济于事。恰当的解决方案是修改时间显示的格式，比如修改为加拿大的英文格式。

![img](images/d59c6e016f814415ad1fbd8cec8f9454)



# 11.utf-8编码的问题

令人惊喜的是emacs27.1并没有utf-8编码的问题，我将与此相关的所有配置全部关闭掉，而且没有打开系统的对uft-8编码的beta版本，emacs读写中文畅行无碍。

```
;;--------------------------------------------------
;;Coding system
;;--------------------------------------------------
;; (when (fboundp 'set-charset-priority)
;;   (set-charset-priority 'unicode))
;; (prefer-coding-system        'utf-8)
;; (set-terminal-coding-system  'utf-8)
;; (set-keyboard-coding-system  'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (setq locale-coding-system   'utf-8)
;; (setq-default buffer-file-coding-system 'utf-8)

;;(add-to-list 'file-coding-system-alist '("\\.org\\'" . utf-8))
```

上面的代码，全部备注掉了。换言之，emacs-27.1解决了utf-8编码的问题。

# 收尾总结

以上是在window是上运行emacs这被称之为“神之编辑器”的分步指南。