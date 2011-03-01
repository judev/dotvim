This is a complete Vim configuration that I'm using everywhere

Plugins that are available form a git repository were added with
[Braid](http://github.com/evilchelu/braid) for easy upgrading.

*Some* help tips are provided for *some* of the plugins. please check out the plugin's docs for more info.

##### Installation

From your homedirectory (on Linux/Mac OSX):

* `git clone git://github.com/astrails/dotvim.git`
* `ln -sfn dotvim .vim`
* `ln -sfn dotvim/vimrc .vimrc`

Note: if you alrady have `~/.vim` `~/.vimrc` REMOVE THEM (you might want to backup them ifirst :)

#### General configuration

`,` is used as mapleader

* `,e` mapped to `:e **/`. essentially you do `,efoo<tab>` to get a list of all files starting with foo
* `,s` - toggle invisible characters display
* `Ctrl-E` - switch between 2 last buffers  (its just a `:b#<cr>` :)
* `Ctrl-N` to cancel current search highlighing

Check out the 'vimrc' file for more...

#### "Interesting" Plugins:

*   nerdtree ([github](http://github.com/scrooloose/nerdtree))

    hax0r vim script to give you a tree explorer

    * `Ctrl-P` - open directory browser
	* `,p` - to find and highlight the currently open file in the tree

*   nerdcommenter ([github](http://github.com/scrooloose/nerdcommenter))

    Vim plugin for intensely orgasmic commenting

    * `,/` - toggle comment
    * `,cc` - add commenting
    * `,cu` - Uncomment
    * check docs for more

*   fuzzyfinder 3.5 ([vim.org](http://www.vim.org/scripts/script.php?script_id=1984))

	buffer/file/command/tag/etc explorer with fuzzy matching

	* `,f` - FufFile - fuzzy find file

*   autocomplpop 2.14.1 ([vim.org](http://www.vim.org/scripts/script.php?script_id=1879))

    Automatically opens popup menu for completions

    Shouldn't require config.

*   taglist ([vim.org](http://www.vim.org/scripts/script.php?script_id=273))

    Source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc)

    * `,t` - toggle tags window

*   minibufexpl 6.3.2 ([vim.org](http://www.vim.org/scripts/script.php?script_id=159))

    Elegant buffer explorer - takes very little screen space

    * `,b` to open buffer list window.
    * `Enter` in the list window to open the buffer

*    yankring 100 ([vim.org](http://www.vim.org/scripts/script.php?script_id=1234))

     Maintains a history of previous yanks, changes and deletes 

	 * `,y` to show the yankring
	 * `,[`/`,]` - to cycle the just-pasted text though the yankring.
	 * `:h yankring.txt` and `:h yankring-tutorial` for more

*   fugitive ([github](http://github.com/tpope/vim-fugitive))

    A Git wrapper so awesome, it should be illegal

    *    `:Gstatus`

         Bring up the output of git-status in the preview
         window.  Press `-` to stage or unstage the file on the
         cursor line.  Press `p` to do so on a per hunk basis
         (--patch).  Press `C` to invoke |:Gcommit|.

    *    `:Gcommit [args]`

         A wrapper around git-commit.

    *    `:Ggrep [args]`

         |:grep| with git-grep as 'grepprg'.

    *   `:Gblame`

        Run git-blame on the file and open the results in a
        scroll bound vertical split.  Press enter on a line to
        reblame the file as it was in that commit.

    Much more in the plugin's doc

*   rails ([vim.org](http://www.vim.org/scripts/script.php?script_id=1567)) ([github](http://github.com/tpope/vim-rails))

    Ruby on Rails: easy file navigation, enhanced syntax highlighting, and more

	* `:AV` - open "alternate" file in a new vertical split
	* `:AS` - open "alternate" file in a new horizontal split
	* `:RV` - open "related" file in a new vertical split
	* `:RS` - open "related" file in a new horizontal split
	* `:Rextract` - extract partial (select text for extraction first)
	* `:Rinvert` - takes a self.up migration and writes a self.down.
	* `gf` - remapped to take context into account. recognizes models
	  associations, partials etc.
	* `:h rails` for more info ;)

*   syntastic ([github](http://github.com/scrooloose/syntastic))
	
	syntax checking plugin

	it will display the number of syntax errors in the current file in the vim's status line.

	use `:Errors` to display a window detailing the errors

*   snipmate ([vim.org](http://www.vim.org/scripts/script.php?script_id=2540)) ([github](http://github.com/msanders/snipmate.vim))

    TextMate-style snippets for Vim

	write a snipped text and press TAB to expand it.

    To see the list of available snippets type `Ctrl-R <Tab>` in the insert mode

*   space ([github](http://github.com/scrooloose/vim-space))

	Smart Space key for Vim

	press SPACE to repeat last motion command

*   surround ([vim.org](http://www.vim.org/scripts/script.php?script_id=1697)) ([github](http://github.com/tpope/vim-surround))

    Delete/change/add parentheses/quotes/XML-tags/much more with ease

    * `dsX` - delete surround X
    * `csXY` - change surround X with Y
    * `s/S` in visual mode - wrap selection 
    * `ysMovementX` - surround movement with X

    You should REALLY read the docs if you want to use this one

*   conque ([vim.org](http://www.vim.org/scripts/script.php?script_id=2771))

	Conque is a Vim plugin allowing users to execute and interact with programs, typically a shell such as bash, inside a buffer window.

	This one is much better then vimsh that I was using before

	`,sh` - start a vimsh window
	`,r`  - opens vim prompt for command to run

*   drillctg 1.1.3 ([vim.org](http://www.vim.org/scripts/script.php?script_id=2013))

    Allows fast drill-down search across the pathnames in your ctags file

    `:Drill` to open drill window

*   vividchalk ([vim.org](http://www.vim.org/scripts/script.php?script_id=1891)) ([github](http://github.com/vitaly/vim-vividchalk))

    A colorscheme strangely reminiscent of Vibrant Ink for a certain OS X editor

#### "Support" and minor plugins

*   pathogen 1.2 ([vim.org](http://www.vim.org/scripts/script.php?script_id=2332)) ([github](http://github.com/tpope/vim-pathogen))

    Allows to separate each plugin into its own subdirectory. `~/.vim/bundles` directory
    is used as the common root for all the plugins.

    Already configured

*   misc-lang-settings 

    ts/sw/et settings for various filetypes

*   endwise ([vim.org](http://www.vim.org/scripts/script.php?script_id=2386)) ([github](http://github.com/tpope/vim-endwise))

    Wisely add "end" in ruby, endfunction/endif/more in vim script, etc 

*   kwdbi 1.1 ([vim.org](http://www.vim.org/scripts/script.php?script_id=2103))

    Keep Window on Buffer Delete - Improved

*   pastie ([vim.org](http://www.vim.org/scripts/script.php?script_id=1624)) ([github](http://github.com/tpope/vim-pastie))

    integration with http://pastie.org

*   repeat ([vim.org](http://www.vim.org/scripts/script.php?script_id=2136)) ([github](http://github.com/tpope/vim-repeat))

    Use the repeat command "." with supported plugins

*   showmarks 2.2 ([vim.org](http://www.vim.org/scripts/script.php?script_id=152))

    Visually shows the location of marks.

*   unimpaired ([github](http://github.com/tpope/vim-unimpaired))

    pairs of assorted bracket maps

#### Syntax plugins

*   tmux 

    [tmux](http://tmux.sourceforge.net/) syntax  suupport (extracted from tmux-1.1)

*   rcov

    [rcov](http://eigenclass.org/hiki.rb?rcov) support (extracted from rcov-0.8.1.2.0 ruby gem)

*   puppet ([vim.org](http://www.vim.org/scripts/script.php?script_id=2094))

    Syntax Highlighting for Puppet

*   json 0.4 ([vim.org](http://www.vim.org/scripts/script.php?script_id=1945))

    synntax highlighting file for JSON

*   cucumber ([github](http://github.com/tpope/vim-cucumber))

    syntax, indent, etc. for [Cucumber](http://github.com/aslakhellesoy/cucumber)

*   haml ([vim.org](http://www.vim.org/scripts/script.php?script_id=1433)) ([github](http://github.com/tpope/vim-haml))

    [HAML](http://haml-lang.com/) syntax etc.

*   markdown ([github](http://github.com/plasticboy/vim-markdown))

    syntax for [Markdown](http://daringfireball.net/projects/markdown/)

### Misc

The following is a list of commands and key bindings that I personally find interesting
stored for easy refreshing my memory of them. there is no much 'system' to it, just
randomly chosen bits of vim goodness.


* `ga` print ascii value of character under the cursor
* `g#` like "#", but without using "\<" and "\>"
* `g<` display previous command output
* `z<CR>` redraw, cursor line to top of window
* `z-` redraw, cursor line at bottom of window
* `CTRL-W x` exchange current window with n-th window (or next if no count given)
* `gv` reselect last selection

