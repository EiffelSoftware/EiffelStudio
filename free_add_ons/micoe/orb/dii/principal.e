indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class PRINCIPAL

inherit
    PRINCIPAL_STATICS
        redefine
            copy, is_equal
        end

creation
    make, make_with_transport, make_with_decoder1, make_with_decoder2

feature -- Initialization

    make is

        do
            make_with_transport (void)
        end
----------------------

    make_with_transport (t : TRANSPORT) is

        do
            my_rep    := principal_peer_info
            my_transp := t
        end
----------------------

    make_with_decoder1 (dc : DATA_DECODER) is

        do
            make_with_decoder2 (dc, void)
        end
----------------------

    make_with_decoder2 (dc : DATA_DECODER; t : TRANSPORT) is

        do
            my_transp := t
            decode (dc)
        end
----------------------

    list_properties : ARRAY [STRING] is

        do
            create result.make (1, 3)
            result.put ("peer-info", 1)
            result.put ("auth-method", 2)
            result.put ("perr-address", 3)
        end
----------------------

    get_property (prop_name : STRING) : CORBA_ANY is

        local
            os : ARRAY [INTEGER]
            s  : STRING

        do
            create result.make
            if equal (prop_name, "peer-info") then
                if my_rep /= void and then my_rep.count > 0 then
                    result.put_octets (my_rep)
                else
                    create os.make (1, 0)
                    result.put_octets (os)
                end
            elseif equal (prop_name, "auth-method") then
                result.put_string ("basic", 5)
            elseif equal (prop_name, "peer-address") then
                if my_transp /= void then
                    s := my_transp.peer.stringify
                    result.put_string (s, s.count)
                else
                    result.put_string ("", 0)
                end
            else
                check
                    known_property : false
                end
            end
        end
----------------------

    encode (ec : DATA_ENCODER) is

        do
            if my_rep /= void then
                ec.seq_begin (my_rep.count)
                ec.put_octets (my_rep)
                ec.seq_end
            else
                ec.seq_begin (0)
                ec.seq_end
            end

        end
----------------------

    decode (dc : DATA_DECODER) is

        local
            len : INTEGER

        do
            len := dc.seq_begin
            if len > 0 then
                my_rep := dc.get_buffer.data1 (len)
                dc.get_buffer.rseek_rel (len)
            end
            dc.seq_end
        end
----------------------
feature -- Copying

    copy (other : like current) is

        do
            my_rep := other.my_rep
        end
----------------------
feature -- Equality Test

    is_equal (other : like current) : BOOLEAN is

        do
            result := equal (my_rep, other.my_rep)
        end
----------------------
feature { PRINCIPAL } -- Implementation

    my_rep    : ARRAY [INTEGER]
    my_transp : TRANSPORT

end -- class PRINCIPAL

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
