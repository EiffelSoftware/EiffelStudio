indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CODESET_INFO
    -- This is actually a struct.

inherit
    ANY
        redefine
            copy, is_equal
        end

creation
    make

feature -- Initialization

    make is

        do
            create charsets.make
        end
----------------------
feature -- Access

    id             : INTEGER
    codepoint_size : INTEGER
    max_codepoints : INTEGER
    charsets       : SORTED_SET [INTEGER]
    desc           : STRING
    name           : STRING
----------------------
feature -- Mutation

    set_id (new_id : INTEGER) is

        do
            id := new_id
        end
----------------------

    set_codepoint_size (new_size : INTEGER) is

        do
            codepoint_size := new_size
        end
----------------------

    set_max_codepoints (new_max : INTEGER) is

        do
            max_codepoints := new_max
        end
----------------------

    set_desc (new_desc : STRING) is

        do
            desc := new_desc
        end
----------------------

    set_name (new_name : STRING) is

        do
            name := new_name
        end
----------------------

    add_char_value (val : INTEGER) is

        do
            charsets.add (val)
        end
----------------------
feature -- Copying

    copy (other : like current) is

        do
            id             := other.id
            codepoint_size := other.codepoint_size
            max_codepoints := other.max_codepoints
            charsets.copy (other.charsets)
            if desc /= void then
                desc.copy (other.desc)
            else
                desc := clone (other.desc)
            end
            if name /= void then
                name.copy (other.name)            
            else
                name := clone (other.name)
            end
        end
----------------------
feature -- Equality Test

    is_equal (other : like current) : BOOLEAN is

        do
            if id /= other.id then
                result := false
            elseif codepoint_size /= other.codepoint_size then
                result := false
            elseif max_codepoints /= other.max_codepoints then
                result := false
            elseif not equal (charsets, other.charsets)   then
                result := false
            else
                result := equal (desc, other.desc) and then
                          equal (name, other.name)
            end
        end

end -- class CODESET_INFO

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
