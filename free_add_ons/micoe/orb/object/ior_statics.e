indexing

description: "A trick to achieve the semantics of static features as in %
             %C++ or Java.";
keywords: "static", "global";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class IOR_STATICS

feature -- Statics for the class CORBA_COMPONENT

    Tag_internet_iop        : INTEGER is 0
    Tag_multiple_components : INTEGER is 1
    Tag_local               : INTEGER is 20000 -- The rest are mico extensions
    Tag_any                 : INTEGER is 20001
    Tag_unix_iop            : INTEGER is 20002
    Tag_ssl_internet_iop    : INTEGER is 200002
    Tag_ssl_unix_iop        : INTEGER is 200003

    Tag_code_sets     : INTEGER is 1
    Tag_ssl_sec_trans : INTEGER is 20
        -- Visibroker IIOP over SSL

    get_ior_component_decoders : INDEXED_LIST [COMPONENT_DECODER] is

        do
            result := comp_decoders
        end
----------------------

    unknown_comp_decode (dc : DATA_DECODER;
                         pid, len : INTEGER) : UNKNOWN_COMPONENT is

        do
            if len <= 10000 then -- otherwise it must be garbage
                create result.make (pid)
                result.insert_data (dc.get_buffer.data1 (len), len)
                dc.get_buffer.rseek_rel (len)
            end
        end
----------------------

    codeset_component_decoder : CODESET_COMPONENT_DECODER is

        once
            create result.make
        end
----------------------

    ssl_component_decoder : SSL_COMPONENT_DECODER is

        once
            create result.make
        end
----------------------

    comp_decode (dc : DATA_DECODER) : CORBA_COMPONENT is

        local
            ir       : INTEGER_REF
            pid      : INTEGER
            len      : INTEGER
            state    : INTEGER_REF
            next_pos : INTEGER
            dum      : BOOLEAN

        do
            dum := dc.struct_begin
            create ir
            dc.get_long (ir)
            pid := ir.item
            create state
            len := dc.encaps_begin (state)

            next_pos := dc.get_buffer.rpos + len
            result   := comp_decode_body (dc, pid, len)
            -- seek over everything not read by the profile decoder
            dc.get_buffer.rseek_beg (next_pos)

            dc.encaps_end (state.item)
            dum := dc.struct_end

        ensure
            nonvoid_result : result /= void
        end
----------------------

    comp_decode_body (dc : DATA_DECODER;
                      pid, len : INTEGER) : CORBA_COMPONENT is

        local
            i, n : INTEGER
            done : BOOLEAN

        do
            if comp_decoders = void then
                create comp_decoders.make (false)
                -- populate comp_decoders with some candidates
                register_comp_decoder (codeset_component_decoder)
                register_comp_decoder (ssl_component_decoder)
            end
            from
                i := 1
                n := comp_decoders.count
            until
                i > n or else done
            loop
                if comp_decoders.at (i).has_id (pid) then
                    done := true
                else
                    i := i + 1
                end
            end
            if i <= n then -- known profile
                result := comp_decoders.at (i).decode (dc, pid, len)
            else -- unknown profile
                result := unknown_comp_decode (dc, pid, len)
            end
        end
----------------------

    register_comp_decoder (cd : COMPONENT_DECODER) is

        do
            if comp_decoders = void then
                create comp_decoders.make (false)
            end
            comp_decoders.append (cd)
        end
----------------------

    unregister_comp_decoder (cd : COMPONENT_DECODER) is

        do
            if comp_decoders /= void then
                comp_decoders.remove (cd)
            end
        end
----------------------
feature -- Statics for the class IOR_PROFILE

    CORBA_profile_id_tag_internet_iop        : INTEGER is 0
    CORBA_profile_id_tag_multiple_components : INTEGER is 1
        -- The rest are mico extensions
    CORBA_profile_id_tag_local            : INTEGER is 20000
    CORBA_profile_id_tag_any              : INTEGER is 20001
    CORBA_profile_id_tag_unix_iop         : INTEGER is 20002
    CORBA_profile_id_tag_ssl_internet_iop : INTEGER is 20002
    CORBA_profile_id_tag_ssl_unix_iop     : INTEGER is 20003


    uiop_ior_decoder : UIOP_PROFILE_DECODER is

        once
            create result.make
        end
----------------------

    local_ior_decoder : LOCAL_PROFILE_DECODER is

        once
            create result.make
        end
----------------------

    iiop_ior_decoder : IIOP_PROFILE_DECODER is

        once
            create result.make
        end
----------------------

    ssl_profile_decoder : SSL_PROFILE_DECODER is

        once
            create result.make
        end
----------------------

    unknown_profile_decode (dc : DATA_DECODER;
                            pid, len : INTEGER) : UNKNOWN_PROFILE is
        do
            if len <= 10000 then -- otherwise it's garbage
                create result.make (pid)
                result.insert_data (dc.get_buffer.data1 (len), len)
                dc.get_buffer.rseek_rel (len)
            end
        end
----------------------

    multi_component_profile_decoder : MULTI_COMPONENT_PROFILE_DECODER is

        once
            create result.make
        end
----------------------

    get_ior_profile_decoders : INDEXED_LIST [IOR_PROFILE_DECODER] is

        do
            result := prof_decoders
        end
----------------------

    prof_decode (dc : DATA_DECODER) : IOR_PROFILE is

        local
            ir       : INTEGER_REF
            dum      : BOOLEAN
            next_pos : INTEGER
            pid      : INTEGER
            len      : INTEGER
            state    : INTEGER_REF

        do
            dum := dc.struct_begin
            create ir
            dc.get_ulong (ir)
            pid := ir.item
            create state
            len := dc.encaps_begin (state)

            next_pos := dc.get_buffer.rpos + len
            result := prof_decode_body (dc, pid, len)
            -- seek over everything not read by the profile decoder
            dc.get_buffer.rseek_beg (next_pos)
            dc.encaps_end (state.item)
            dum := dc.struct_end

        ensure
            nonvoid_result : result /= void
        end
----------------------

    prof_decode_body (dc : DATA_DECODER;
                      pid, len : INTEGER) : IOR_PROFILE is

        local
            i, n : INTEGER
            done : BOOLEAN

        do
            if prof_decoders = void then
                -- populate prof_decoders with some candidates
                register_prof_decoder (uiop_ior_decoder)
                register_prof_decoder (iiop_ior_decoder)
                register_prof_decoder (local_ior_decoder)
                register_prof_decoder (multi_component_profile_decoder)
            end

            from
                i := 1
                n := prof_decoders.count
            until
                i > n or else done
            loop
                if prof_decoders.at (i).has_id (pid) then
                    done := true
                else
                    i := i + 1
                end
            end
            if i <= n then -- known decoder
                result := prof_decoders.at (i).decode (dc, pid)
            else -- unknown decoder
              result := unknown_profile_decode (dc, pid, len)
            end
        end
----------------------

    register_prof_decoder (dc : IOR_PROFILE_DECODER) is

        do
            if prof_decoders = void then
                create prof_decoders.make (false)
            end
            prof_decoders.append (dc)
        end
----------------------

    unregister_prof_decoder (dc : IOR_PROFILE_DECODER) is

        do
            if prof_decoders /= void then
                prof_decoders.remove (dc)
            end
        end
----------------------
feature { NONE }

    comp_decoders : INDEXED_LIST [COMPONENT_DECODER]
    prof_decoders : INDEXED_LIST [IOR_PROFILE_DECODER]

end -- class IOR_STATICS

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
