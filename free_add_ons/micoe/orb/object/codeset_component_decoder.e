indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CODESET_COMPONENT_DECODER

inherit
    COMPONENT_DECODER

creation
    make

feature -- Decoding

    decode (dc : DATA_DECODER;
            component_id, len : INTEGER) : CORBA_COMPONENT is

        local
            ncs, nwcs : INTEGER
            conv_cs, conv_wcs     : INDEXED_LIST [INTEGER]
            i, n                  : INTEGER
            ir                    : INTEGER_REF
            dum                   : BOOLEAN

        do
            -- CodeSetComponentInfo
            dum := dc.struct_begin
            -- ForCharData
            dum := dc.struct_begin
            -- native_code_set
            create ir
            dc.get_ulong (ir)
            ncs := ir.item
            -- conversion_code_sets
            n := dc.seq_begin
            if n > 0 then
                from
                    create conv_cs.make (false)
                    i := 1
                until
                    i > n
                loop
                    dc.get_ulong (ir)
                    conv_cs.append (ir.item)
                    i := i + 1
                end -- loop
            end -- if n > 0 then ...
            dc.seq_end
            dum := dc.struct_end

            -- ForWcharData
            dum := dc.struct_begin
            -- native_code_set
            dc.get_ulong (ir)
            nwcs := ir.item
            -- conversion_code_sets
            n := dc.seq_begin
            if n > 0 then
                from
                    create conv_wcs.make (false)
                    i := 1
                until
                    i > n
                loop
                    dc.get_ulong (ir)
                    conv_wcs.append (ir.item)
                    i := i + 1
                end -- loop
            end -- if n > 0 then ...
            dc.seq_end
            dum := dc.struct_end
            dum := dc.struct_end
            create {CODESET_COMPONENT} result.make4 (ncs, nwcs,
                                                     conv_cs, conv_wcs)
        end
---------------------------------------

    has_id (id : INTEGER) : BOOLEAN is

        do
            result := (id = Tag_code_sets)
        end

end -- class CODESET_COMPONENT_DECODER

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
