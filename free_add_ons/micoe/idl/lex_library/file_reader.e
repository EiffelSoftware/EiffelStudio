indexing

description: "Reader that reads from a file";
keywords: "Lex framework";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class FILE_READER

inherit
    READER
        redefine
            compute_lexeme, path
        end

creation
    make

feature

    set_text (tf : PLAIN_TEXT_FILE) is

        require
            good_file : tf /= void

        do
            file        := tf
            list_from_file
            restart
        end
--------------------------------------------------------------

    path : STRING is
        -- Path of file in which current lexeme occurs.

        do
            result := file.name
        end
--------------------------------------------------------------

    has_text : BOOLEAN is

        do
            result := (ftext /= void)
        end
--------------------------------------------------------------

    advance is

        do
            old_col  := cur_col 
            old_line := cur_line

            cur_col := cur_col + 1

            if cur_col > text.count + 1 then
                skip_empty_lines
                cur_col := 1

                if cur_line > max_line then
                    end_of_text := true
                else
                    text := ftext.at (cur_line)
                end
            end
        end
--------------------------------------------------------------

    retreat is
        -- Put the last input back on the input stream.

        do
            cur_col  := old_col
            cur_line := old_line
            if cur_line > max_line then
                end_of_text := true
            else
                text := ftext.at (cur_line)
            end
        end
--------------------------------------------------------------

    accept is

        do
            if cur_line > start_line or else cur_col >= start_col then
                if cur_line <= max_line then
                    compute_lexeme
                end
            end

            line := start_line
            col  := start_col

            if not end_of_text then
                advance
            end

            start_col  := cur_col 
            start_line := cur_line 
        end
--------------------------------------------------------------

    return is
        -- Start over at the beginning of the current lexeme.

        do
            if cur_line /= start_line then
                text := ftext.at (start_line)
            end

            cur_line := start_line
            cur_col  := start_col

            end_of_text := (cur_line > max_line)
        end
--------------------------------------------------------------
    
feature { NONE }

    Comment_char : CHARACTER is '/'

    file     : PLAIN_TEXT_FILE
    ftext    : INDEXED_LIST [STRING]
    old_col  : INTEGER
    old_line : INTEGER
    max_line : INTEGER

--------------------------------------------------------------

    special_restart is

        do
            text        := void
            max_line    := ftext.count 
            cur_line    := 0
            skip_empty_lines

            cur_col     := 1
            start_line  := cur_line
            start_col   := 1
            text        := ftext.at (cur_line)
            old_col     := 1
            end_of_text := (cur_line > max_line)
        end
--------------------------------------------------------------

    skip_empty_lines is

        local
            good_line : BOOLEAN

        do
            from
                cur_line := cur_line + 1
            until
                good_line 
                or else
                cur_line > max_line 
            loop
                good_line := ftext.at (cur_line).count > 0

                if not good_line then
                    cur_line := cur_line + 1
                end
            end
        end
--------------------------------------------------------------

    compute_lexeme is

        local
            l, b, c : INTEGER
            str     : STRING

        do
            lexeme := void

            from
                l := start_line
            until
                l > cur_line 
            loop
                if l = start_line then
                    b := start_col
                else
                    b := 1
                end

                if l = cur_line then
                    c := cur_col 
                else
                    c := ftext.at (l).count
                end

                if b <= c and then c <= ftext.at (l).count then
                    str := ftext.at (l).substring (b, c)
                else
                    str := " "
                end

                if lexeme = void then
                    lexeme := str
                else
                    lexeme.append (str)
                end

                l := l + 1
            end
        end
--------------------------------------------------------------


     list_from_file is

        do
            from
                create ftext.make (false)
            until
                file.end_of_file or else not file.file_readable
            loop
                file.read_line
                ftext.append (clone(file.last_string))
            end
        end

invariant
    consistent  : start_line < cur_line or else
                  (start_line = cur_line and then start_col <= cur_col)
    inside_text : end_of_text or else cur_line <= max_line

end -- class FILE_READER

------------------------------------------------------------------------
--                                                                    --
--  MICO/E --- a free CORBA implementation                            --
--  Copyright (C) 1999 by Robert Switzer                              --
--                                                                    --
--  This library is free software; you can redistribute it and/or     --
--  modify it under the terms of the GNU Library General Public       --
--  License as published by the Free Software Foundation; either      --
--  version 2 of the License, or (at your option) any later version.  --
--                                                                    --
--  This library is distributed in the hope that it will be useful,   --
--  but WITHOUT ANY WARRANTY; without even the implied warranty of    --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
--  Library General Public License for more details.                  --
--                                                                    --
--  You should have received a copy of the GNU Library General Public --
--  License along with this library; if not, write to the Free        --
--  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.--
--                                                                    --
--  Send comments and/or bug reports to:                              --
--                 micoe@math.uni-goettingen.de                       --
--                                                                    --
------------------------------------------------------------------------
