indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class STC_WCHAR

inherit
    STATIC_TYPE_INFO

feature

    create_object : ANY is

        local
            cr : CHARACTER_REF

        do
            create cr
            cr.set_item ('%U')
            result := cr
        end
----------------------

    marshal (ec : DATA_ENCODER; a : ANY) is

        local
            ir : INTEGER_REF

        do
            ir ?= a
            check
                ir_nonvoid : ir /= void
            end
            ec.put_wchar (ir.item) 
        end
----------------------

    demarshal (dc : DATA_DECODER) : ANY is

        local
            ir : INTEGER_REF

        do
            create ir
            dc.get_wchar(ir)
            result := ir
        end

end -- class STC_WCHAR

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
