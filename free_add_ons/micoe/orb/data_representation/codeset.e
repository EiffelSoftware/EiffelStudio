indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CODESET

inherit
    CODESET_STATICS
        redefine
            copy, is_equal
        end

creation { CODESET_STATICS }
    make_with_info

feature { CODESET_STATICS } -- INITIALIZATION

    make_with_info (inf : CODESET_INFO) is

        do
            info := inf
        end
----------------------------------------
feature -- Access

    id : INTEGER is

        do
            result := info.id
        end
----------------------------------------

    name : STRING is

        do
            result := info.name
        end
----------------------------------------

    desc : STRING is

        do
            result := info.desc
        end
----------------------------------------

    codepoint_size : INTEGER is

        do
            result := info.codepoint_size
        end
----------------------------------------

    max_codepoints : INTEGER is

        do
            result := info.max_codepoints
        end
----------------------------------------

    guess_size (nchars : INTEGER) : INTEGER is

        do
            result := (nchars + 1) * info.max_codepoints
        end
----------------------------------------
feature -- Compatibility

    is_compatible_to (other : like current) : BOOLEAN is

        local
            common : SORTED_SET [INTEGER]
        do
            -- They are compatible if they have at least one
            -- charset in common
            common := info.charsets * other.info.charsets
            result := not common.empty
        end
----------------------------------------

    is_compatible_using_id (csid : INTEGER) : BOOLEAN is

        local
            the_info : CODESET_INFO
            cs       : CODESET

        do
            the_info := find_codeset_info_by_id (csid)
            if the_info /= void then
                create cs.make_with_info (the_info)
                result := is_compatible_to (cs)
            end
        end
----------------------------------------
feature -- Copying

    copy (other : like current) is

        do
            info.copy (other.info)
        end
----------------------------------------

    is_equal (other : like current) : BOOLEAN is

        do
           result := equal (info, other.info)
        end
----------------------------------------
feature { CODESET } -- Implementation

    info : CODESET_INFO

end -- class CODESET

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
