indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CODESET_CONVERTER_DB

inherit
    CODESET_STATICS

creation
    make

feature -- Initialization

    make is

        do
            create converters.make
        end
----------------------

    find (frm, to : INTEGER) : CODESET_CONVERTER is

        local
            key : INTEGER
            cl  : CODESET
            sv  : CODESET

        do
            key := 512 * frm + to
            cl  := create_codeset_with_id(frm)
            if cl /= void then
                sv := create_codeset_with_id (to)
                if sv /= void then
                    result := create_converter (cl, sv)
                    converters.put (result, key)
                end
            end
        end
----------------------

    reverse (conv : CODESET_CONVERTER) : CODESET_CONVERTER is

        local
            key   : INTEGER
            it    : INTEGER
            cl    : CODESET
            sv    : CODESET

        do
            if conv /= void then
                key := 512 * conv.get_to.id + conv.get_from.id
                if converters.has (key) then
                    result := converters.at (key)
                else
                    cl := clone (conv.get_to)
                    sv := clone (conv.get_from)

                    result := create_converter (cl, sv)
                    if result /= void then
                        converters.put (result, key)
                    end
                end
            end
        end
----------------------
feature { NONE } -- Implementation

    converters : DICTIONARY [CODESET_CONVERTER, INTEGER]

end -- class CODESET_CONVERTER_DB

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
