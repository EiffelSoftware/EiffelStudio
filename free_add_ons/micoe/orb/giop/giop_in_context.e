indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class GIOP_IN_CONTEXT

creation
    make2, make3, make4

feature -- Initialization

    make2 (codec : GIOP_CODEC;
           buf   : BUFFER) is

        require
            nonvoid_arg : codec /= void

        do
            make4 (codec, buf, void, void)
        end
----------------------

    make3 (codec : GIOP_CODEC;
           buf   : BUFFER;
           csc   : CODESET_CONVERTER) is

        require
            nonvoid_arg : codec /= void

        do
            make4 (codec, buf, csc, void)
        end
----------------------

    make4 (codec     : GIOP_CODEC;
           buf       : BUFFER;
           csc, wcsc : CODESET_CONVERTER) is

        require
            nonvoid_arg : codec /= void

        do
            dc := codec.get_dc_proto
            dc.set_buffer (buf)
            dc.set_converter (csc)
            dc.set_wconverter (wcsc)
        end
----------------------

    set_buffer (b : BUFFER) is

        do
            dc.set_buffer (b)
        end
----------------------

    set_converters (csc, wcsc : CODESET_CONVERTER) is

        do
            dc.set_converter (csc)
            dc.set_wconverter (wcsc)
        end
----------------------

    get_dc : DATA_DECODER is

        do
            result := dc
        end
----------------------

    retn : DATA_DECODER is

        do
            result := clone (dc)
            result.make3 (dc.get_buffer, dc.converter, dc.wconverter)
        end
----------------------        
feature { NONE } -- Implementation

    dc : DATA_DECODER

end -- class GIOP_IN_CONTEXT




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
