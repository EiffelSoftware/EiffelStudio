indexing

description: "Access the system's null device as IO_MEDIUM.";
keywords: "null device";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class NULL_DEVICE

inherit
    IO_MEDIUM
        redefine
            is_plain_text
        end

feature -- Access

    name : STRING is "/dev/null"
        -- Medium name

    retrieved : ANY
        -- Retrieved object structure
        -- To access resulting object under correct type,
        -- use assignment attempt.
        -- Will raise an exception (code `Retrieve_exception')
        -- if content is not a stored Eiffel structure.

feature -- Element change

    basic_store (object : ANY) is
        -- Produce an external representation of the
        -- entire object structure reachable from `object'.
        -- Retrievable within current system only.

        do
        end
 
    general_store (object : ANY) is
        -- Produce an external representation of the
        -- entire object structure reachable from `object'.
        -- Retrievable from other systems for same platform
        -- (machine architecture).
        --| This feature may use a visible name of a class written
        --| in the `visible' clause of the Ace file. This makes it
        --| possible to overcome class name clashes.

        do
        end
 
    independent_store (object : ANY) is
        -- Produce an external representation of the
        -- entire object structure reachable from `object'.
        -- Retrievable from other systems for the same or other
        -- platform (machine architecture).

        do
        end
 
feature -- Status report

    handle : INTEGER
        -- Handle to medium

    handle_available : BOOLEAN is false
        -- Is the handle available after class has been
        -- created?

    is_plain_text : BOOLEAN is true
        -- Is file reserved for text (character sequences)?

    exists : BOOLEAN is true
        -- Does medium exist?

    is_open_read : BOOLEAN is true
        -- Is this medium opened for input

    is_open_write : BOOLEAN is true
        -- Is this medium opened for output

    is_readable : BOOLEAN is true
        -- Is medium readable?

    is_executable : BOOLEAN is false
        -- Is medium executable?

    is_writable : BOOLEAN is true
        -- Is medium writable?

    readable : BOOLEAN is false
        -- Is there a current item that may be read?

    extendible : BOOLEAN is true
        -- May new items be added?

    is_closed : BOOLEAN is false
        -- Is the I/O medium open

    support_storable : BOOLEAN is false
        -- Can medium be used to store an Eiffel object?

feature -- Status setting

    close is
        -- Close medium.

        do
        end

feature -- Output

    put_new_line, new_line is
        -- Write a new line character to medium

        do
        end

    put_string, putstring (s : STRING) is
        -- Write `s' to medium.

        do
        end

    put_character, putchar (c : CHARACTER) is
        -- Write `c' to medium.

        do
        end

    put_real, putreal (r : REAL) is
        -- Write `r' to medium.

        do
        end

    put_integer, putint (i : INTEGER) is
        -- Write `i' to medium.

        do
        end

    put_boolean, putbool (b : BOOLEAN) is
        -- Write `b' to medium.

        do
        end

    put_double, putdouble (d : DOUBLE) is
        -- Write `d' to medium.

        do
        end

feature -- Input

    read_real, readreal is
        -- Read a new real.
        -- Make result available in `last_real'.

        do
        end

    read_double, readdouble is
        -- Read a new double.
        -- Make result available in `last_double'.

        do
        end

    read_character, readchar is
        -- Read a new character.
        -- Make result available in `last_character'.

        do
        end

    read_integer, readint is
        -- Read a new integer.
        -- Make result available in `last_integer'.

        do
        end

    read_stream, readstream (nb_char : INTEGER) is
        -- Read a string of at most `nb_char' bound characters
        -- or until end of medium is encountered.
        -- Make result available in `last_string'.

        do
        end

    read_line, readline is
        -- Read characters until a new line or
        -- end of medium.
        -- Make result available in `last_string'.

        do
        end

end -- class NULL_DEVICE

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
