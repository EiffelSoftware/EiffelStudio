indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class STC_OCTET

inherit
    STATIC_TYPE_INFO

feature

    create_object : ANY is

        local
            o : OCTET

        do
            create o.make (0)
            result := o
        end
----------------------

    marshal (ec : DATA_ENCODER; a : ANY) is

        local
            o : OCTET

        do
            o ?= a
            check
                o_nonvoid : o /= void
            end
            ec.put_octet (o) 
        end
----------------------

    demarshal (dc : DATA_DECODER) : ANY is

        do
            result := dc.get_octet
        end

end -- class STC_OCTET

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
