indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SSL_COMPONENT_DECODER

inherit
    COMPONENT_DECODER

creation
    make

feature -- Access

    has_id (id : INTEGER) : BOOLEAN is

        do
            result := id = Tag_ssl_sec_trans
        end
----------------------
feature -- Decoding

    decode (dc : DATA_DECODER; pid, len : INTEGER) : CORBA_COMPONENT is

        local
            f1, f2 : FLAGS
            port   : INTEGER
            dum    : BOOLEAN
            ir     : INTEGER_REF

        do
            -- MICO_SSL_VB_COMPAT; XXX we may have trouble here
            -- if sizeof (Security::AssociationOptions) = 16 ...

            dum := dc.struct_begin
            create ir
            dc.get_ulong (ir)
            create f1.make (ir.item, Sizeof_ULong)
            dc.get_ulong (ir)
            create f2.make (ir.item, Sizeof_ULong)
            dc.get_ushort (ir)
            port := ir.item
            dum := dc.struct_end
            create {SSL_COMPONENT} result.make3 (port, f1, f2)
        end
----------------------
feature { NONE }

    Sizeof_ULong : INTEGER is 32

end -- class SSL_COMPONENT_DECODER

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
