indexing

description: "A placeholder for an exception that has not yet %
             %been decoded.";
keywords: "exception"

class UNKNOWN_USER_EXCEPTION

inherit
    CORBA_USER_EXCEPTION
        rename
            make as U_make
        redefine
            print_it, encode, repoid, copy, is_equal
        end

creation
    make, make_with_any, make_with_decoder


feature

    make is

        do
            U_make
            create excpt.make
            static_except := void
            decoder       := void
        end
----------------------

    make_with_any (a : CORBA_ANY) is

        do
            excpt         := a
            static_except := void
            decoder       := void
        end
----------------------

    make_with_decoder (dc : DATA_DECODER) is

        do
            excpt         := void
            static_except := void
            decoder       := dc
        end
----------------------

    exception_from_typecode (tc : CORBA_TYPECODE) : CORBA_ANY is

        local
            dum : BOOLEAN

        do
            if excpt = void then
                check
                    nonvoid_typecode : tc /= void
                end
                check
                    nonvoid_decoder : decoder /= void
                end
                create excpt.make
                dum := excpt.demarshal (tc, decoder)
            else
                result := excpt
            end
        end
----------------------

    exception_from_info (stc : STATIC_TYPE_INFO) : STATIC_ANY is

        local
            ec   : SIMPLE_ENCODER
            dc   : SIMPLE_DECODER
            rpos : INTEGER
            dum  : BOOLEAN

        do
            if static_except = void then
                create static_except.make1 (stc)

                if excpt /= void then -- XXX slow...
                    create ec.make
                    create dc.make1 (ec.get_buffer)

                    excpt.marshal (ec)
                    dum := static_except.demarshal (dc)
                else
                    check
                        nonvoid_decoder : decoder /= void
                    end

                    rpos := decoder.get_buffer.rpos
                    dum  := static_except.demarshal (decoder)

                    decoder.get_buffer.rseek_beg (rpos)
                end -- if excpt /= void then ...
            end -- if static_except = void then ...
            result := static_except
        end
----------------------

    print_it is

        do
            io.put_string (except_repoid)
--            io.put_string (" within ")
--            io.put_string (repoid)
            io.new_line
        end
----------------------

    encode (ec : DATA_ENCODER) is

        do
            if excpt /= void then
                excpt.marshal (ec)
            else
                check
                    nonvoid_decoder : decoder /= void
                end

                -- XXX alignment, differing codecs ???
                check
                    match : equal (ec.type, decoder.type)
                end

                ec.put_octets (decoder.get_buffer.data)
            end
        end
----------------------

    repoid : STRING is

        do
            result := "IDL:omg.org/CORBA/UnknownUserException:1.0"
        end
----------------------

    except_repoid : STRING is

        local
            rep  : STRING
            rpos : INTEGER

        do
            if excpt /= void then
                rep := excpt.except_get_begin
                excpt.except_get_end
                ex_repoid := rep
            else -- excpt = void
                check
                    nonvoid_decoder : decoder /= void
                end

                rpos := decoder.get_buffer.rpos

                ex_repoid := decoder.except_begin
                decoder.get_buffer.rseek_beg (rpos)
            end -- if excpt /= void then ...
            result := ex_repoid
        end
----------------------
feature -- Copying

    copy (other : like current) is

        do
            excpt         := clone (other.excpt)
            static_except := clone (other.static_except)
            decoder       := clone (other.decoder)
        end
----------------------
feature -- Equality Test

    is_equal (other : like current) : BOOLEAN is

        do
            result := (equal (excpt, other.excpt)
                       and then
                       equal (static_except, other.static_except)
                       and then
                       equal (decoder, other.decoder))
        end
----------------------
feature { UNKNOWN_USER_EXCEPTION } -- Implementation

    excpt         : CORBA_ANY
        -- Either this or the next object represents the exception
        --that `current' really is.
    static_except : STATIC_ANY
    decoder       : DATA_DECODER
    ex_repoid     : STRING

end -- UNKNOWN_USER_EXCEPTION

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
