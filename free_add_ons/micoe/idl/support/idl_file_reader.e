indexing

description: "Special file reader forIDL; handles `\' at end of line in %
             %the way the IDL specification requires";
keywords: "reader", "multiline text";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class IDL_FILE_READER

inherit
    FILE_READER
        redefine
            advance
        end

creation
    make

feature

    advance is

        do
            old_col  := cur_col 
            old_line := cur_line

            cur_col := cur_col + 1

            if cur_col= text.count then
                if text.item (cur_col) = '\' then
                    skip_empty_lines
                    cur_col  := 1
                    if cur_line > max_line then
                        end_of_text := true
                    else
                        text := ftext.at (cur_line)
                    end
                end
            end

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

end -- class IDL_FILE_READER

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
