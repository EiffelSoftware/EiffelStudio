indexing

description: "Interface similar to that of PLAIN_TEXT_FILE; %
             %permits delayed storage in file.";
keywords: "delayed storage";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class IO_TEXT

creation
    make

feature -- Initialization

    make is

        do
            tab := Standard_tab
            create store.make (false)
            current_line := ""
        end
----------------------
feature -- Mutation

    set_tab (t : STRING) is

        do
            tab := t
        end
----------------------

    erase_all is
        -- Forget everything written so far.

        do
            store.make (false)
        end
----------------------

    put_string (s : STRING) is

        do
            current_line.append (s)
        end
----------------------

    putint (i : INTEGER) is

        do
            current_line.append_integer (i)
        end
----------------------

    putreal (r : REAL) is

        do
            current_line.append_real (r)
        end
----------------------

    putdouble (d : DOUBLE) is

        do
            current_line.append_double (d)
        end
----------------------

    putchar (c : CHARACTER) is

        do
            current_line.extend (c)
        end
----------------------

    new_line is

        do
            store.append (current_line)
            current_line := ""
        end
----------------------

    indent_to (depth : INTEGER) is

        local
            i : INTEGER

        do
            from
                i := 0
            until
                i >= depth
            loop
                current_line.append (tab)
                i := i + 1
            end
        end
----------------------
feature -- Persistence

    write_to_file (tf : PLAIN_TEXT_FILE) is
        -- Store everything written so far in `tf'.
        -- This does *not* erase the text; an append
        -- is still possible. This routine does not
        -- close `tf'; the caller should do that.

        require
            is_open_write : tf.is_open_write

        local
            i, n : INTEGER

        do
            from
                i := store.low_index
                n := store.high_index
            until
                i > n
            loop
                tf.put_string (store.at (i))
                tf.new_line
                i := i + 1
            end
        end
----------------------
feature { NONE } -- Implementation

    Standard_tab : STRING is "    "

    tab : STRING
        -- `indent_to (n)' appends `n' copies of this string to
        -- `current_line'.
    current_line : STRING
        -- Text line currently be worked on.
    store : INDEXED_LIST [STRING]
        -- All lines written so far.

end -- class IO_TEXT

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
