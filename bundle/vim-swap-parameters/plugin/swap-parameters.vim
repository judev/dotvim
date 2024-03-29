""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" swap_parameters.vim : swap parameters of a function fun(arg2, arg1, arg3)
"                       swap elements in coma separated lists
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Author:        Kamil Dworakowski <kamil-at-dworakowski.name>
"                Jude Venn <judev@cuttlefish.com>
" Version:       1.1.5
" Last Change:   2014-03-10 - removed bindings in favour of <Plug>commands
" Requires:      Python and Vim compiled with +python or +python3 option
" Licence:       MIT Licence
" Installation:  Drop into plugin directory
" Basic Usecase: Place the cursor inside the parameter you want to swap
"                with the next one, and press gs
" Description:
"
" It is a versatile script to swap parameters of a function
" or any coma separated list of elements.
"
" key bindings (normal mode):
" [count]gs -- where count defaults to 1 -- swap the argument under the
"              cursor with the next one (2gs to swap with the second following)
" [count]gS -- swap with the previous
"
" Below are examples of what happens after pressing gs (equivalent to 1gs).
" On each line the left side shows the line before typing gs, and the right
" side shows the effect. The cursor position is depicted with || symbols.
" par|m|1 means that the cursor is on the character m.
" 
"                   fun(par|m|1, parm2)                    fun(parm2, parm|1|)
"                 fun(par|m|1(), parm2)                  fun(parm2, parm1(|)|)
"                 fun(parm1(|)|, parm2)                  fun(parm2, parm1(|)|)
"         fun(parm|1|(arg,arg2), parm2)          fun(parm2, parm1(arg,arg2|)|)
"         fun(parm1|(|arg,arg2), parm2)          fun(parm2, parm1(arg,arg2|)|)
"         fun(parm1(arg,arg2|)|, parm2)          fun(parm2, parm1(arg,arg2|)|)
"        fun(parm1(arg, arg2|)|, parm2)         fun(parm2, parm1(arg, arg2|)|)
"               fun(arg1, ar|g|2, arg3)                fun(arg1, arg3, arg|2|)
"                   array[a|r|g1, arg2]                    array[arg2, arg|1|]
"                 fun(par|m|1[], parm2)                  fun(parm2, parm1[|]|)
"                 fun(parm1[|]|, parm2)                  fun(parm2, parm1[|]|)
"                 fun(par|m|1, array[])                  fun(array[], parm|1|)
"                            fun(|a|,b)                             fun(b,|a|)
"                      [(p1, p2|)|, p3]                       [p3, (p1, p2|)|]
"       for |a|, b in some_dict.items()        for b, |a| in some_dict.items()
"
" The following lines demonstrate using gS (swap with previous).
"
"                   fun(parm2, par|m|1)                    fun(|p|arm1, parm2)
"                 fun(parm2, par|m|1())                  fun(|p|arm1(), parm2)
"                 fun(parm2, parm1(|)|)                  fun(|p|arm1(), parm2)
"         fun(parm2, parm|1|(arg,arg2))          fun(|p|arm1(arg,arg2), parm2)
"         fun(parm2, parm1|(|arg,arg2))          fun(|p|arm1(arg,arg2), parm2)
"         fun(parm2, parm1(arg,arg2|)|)          fun(|p|arm1(arg,arg2), parm2)
"        fun(parm2, parm1(arg, arg2|)|)         fun(|p|arm1(arg, arg2), parm2)
"               fun(arg1, ar|g|2, arg3)                fun(|a|rg2, arg1, arg3)
"               fun(arg1, arg2, ar|g|3)                fun(arg1, |a|rg3, arg2)
"                   array[arg2, a|r|g1]                    array[|a|rg1, arg2]
"                 fun(parm2, par|m|1[])                  fun(|p|arm1[], parm2)
"                 fun(parm2, parm1[|]|)                  fun(|p|arm1[], parm2)
"                 fun(array[], par|m|1)                  fun(|p|arm1, array[])
"                            fun(b,|a|)                             fun(|a|,b)
"       for a, |b| in some_dict.items()        for |b|, a in some_dict.items()
"
" The above examples are auto-generated from the tests.
"
" Dot repeats don't work with this binding but pressing gs is quick enough I
" think. 
"
" The column position of the cursor is preserved when you go to the next
" line after swap. This allows for streamlined swapping of parameters in the
" case like this:
"
" fun(arg2, blah)
" fun(arg2, blahble)
" fun(arg2, blahblahblah)
"
" You would put cursor on arg2, and the gsjgsjgs
"
" 
" This script is written in python. Therefore it needs Vim compiled with
" +python or +python3 option (:version), as well as Python installed in the system.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has('python') && !has('python3')
    "echo "swap-parameters not loaded - requires vim compiled with +python or +python3"
    finish
endif


function! SwapParams(directionName)
python3 << EOF
leftBrackets = ['[', '(']
rightBrackets = [']', ')']

class Direction(object):
    def isOpenBracket(self, char):
        return char in self.openingBrackets

    def isCloseBracket(self, char):
        return char in self.closingBrackets

    def isBackward(self):
        return self.openingBrackets is rightBrackets

    def isForward(self):
        return not self.isBackward()
    

class RightwardDirection(Direction):
    openingBrackets = leftBrackets
    closingBrackets = rightBrackets
    def opposite(self):
        return LeftwardDirection()

class LeftwardDirection(Direction):
    openingBrackets = rightBrackets
    closingBrackets = leftBrackets
    def opposite(self):
        return RightwardDirection()


def findFirst(predicate, input, direction=None, eolIsDelimiter=False):
    def find(pos=0):
        try:
            head = input.next()
            if predicate(head):
                return pos
            elif direction and direction.isOpenBracket(head):
                charsInsideBrackets = \
                    findFirst(direction.isCloseBracket, input, direction)
                return find(pos + charsInsideBrackets+1 + 1)
            else:
                return find(pos+1)
        except:
            if eolIsDelimiter:
                return pos
            return -1
    return find()


def SwapParams(direction, line, col):

    def areThereNoEnclosinBrackets():
        rightBracketIndex = findFirst(rightBrackets.__contains__,
                                 iter(line[col:]),
                                 RightwardDirection()
        ) 
        return rightBracketIndex == -1

    noEncloseBrackets = areThereNoEnclosinBrackets()

    def findTheSeparatorBeforeTheLeftParam():
        prefixRev = reversed(line[:col+1])
        toTheLeft = 0
        if line[col] in leftBrackets:
            prefixRev.next()
            toTheLeft += 1

        def findNextLeftSeparator(separators=leftBrackets+[',']):
            return findFirst(separators.__contains__,
                             prefixRev,
                             LeftwardDirection(),
                             eolIsDelimiter=True
            ) 

        if direction.isForward() and noEncloseBrackets:
            toTheLeft += findNextLeftSeparator(separators=[' '])
        else:
            toTheLeft += findNextLeftSeparator()

        if direction.isBackward() and noEncloseBrackets:
            toTheLeft += 1 + findNextLeftSeparator(separators=[' '])
        elif direction.isBackward():
            toTheLeft += 1 + findNextLeftSeparator()

        return col - toTheLeft + 1

    start = findTheSeparatorBeforeTheLeftParam()

    nonwhitespace = lambda x: x not in (' ', '\t')

    input = iter(line[start:])
    param1start = start + findFirst(nonwhitespace, input)
    param1end = param1start + findFirst(lambda x: x == ',', 
            iter(line[param1start:]), 
            RightwardDirection()
    ) - 1
    param2start = param1end + 2 + findFirst(nonwhitespace, iter(line[param1end+2:]))
    rightSeparators = rightBrackets + [',']
    if noEncloseBrackets:
        rightSeparators = [' ', ',']
    param2end = param2start - 1 + findFirst(
                                    rightSeparators.__contains__, 
                                    iter(line[param2start:]), 
                                    RightwardDirection(), 
                                    eolIsDelimiter=True)

    if direction.isForward():
        cursorPos = param2end
    else:
        cursorPos = param1start

    return (line[:param1start] 
          + line[param2start: param2end+1] 
          + line[param1end+1: param2start]
          + line[param1start: param1end+1]
          + line[param2end+1:],
          cursorPos
    )


def Swap(line, col):
    return SwapParams(RightwardDirection(), line, col)

def SwapBackwards(line, col):
    return SwapParams(LeftwardDirection(), line, col)
EOF

if a:directionName == 'backwards'
    python3 Swap = SwapBackwards 
endif

python3 << EOF
if __name__ == '__main__':
    import vim
    (row,col) = vim.current.window.cursor
    line = vim.current.buffer[row-1]
    try:
        (line, newCol) = Swap(line,col)
        vim.current.buffer[row-1] = line
        vim.current.window.cursor = (row, newCol)
    except (Exception, e):
        print(e)
EOF
endfunction

nnoremap <silent> <Plug>ForwardSwapParams :<C-U>call SwapParams("forwards")<cr>
nnoremap <silent> <Plug>BackwardSwapParams :<C-U>call SwapParams("backwards")<cr>

