indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class GIOP_OUT_CONTEXT

creation
    make1, make2, make3, make_ec

feature -- Initialization

    make1 (codec : GIOP_CODEC) is

        do
            make3 (codec, void, void)
        end
----------------------

    make2 (codec : GIOP_CODEC;
           csc   : CODESET_CONVERTER) is

        do
            make3 (codec, csc, void)
        end
----------------------

    make3 (codec   : GIOP_CODEC;
           csc, wcsc : CODESET_CONVERTER) is

        local
            b : BUFFER

        do
            ec := codec.get_ec_proto
            create b.make
            ec.set_buffer (b)
            ec.set_converter (csc)
            ec.set_wconverter (wcsc)
        end
----------------------

    make_ec (the_ec : DATA_ENCODER) is

        do
            ec := the_ec
        end
----------------------

    set_converters (csc, wcsc : CODESET_CONVERTER) is

        do
            ec.set_converter (csc)
            ec.set_wconverter (wcsc)
        end
----------------------

    get_ec : DATA_ENCODER is

        do
            result := ec
        end
----------------------

    retn : BUFFER is

        do
            result := ec.get_buffer
        end
----------------------
feature { NONE } -- Implementation

    ec : DATA_ENCODER

end -- class GIOP_OUT_CONTEXT

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
