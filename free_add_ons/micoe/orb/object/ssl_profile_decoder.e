indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SSL_PROFILE_DECODER
    -- Unfortunately SSL does not have its own IOR profile,
    -- but is part of the IIOP profile. Therefore we cannot
    -- use our own profile decoder (the code below) but have
    -- to insert special checks into the IIOP profile decoder.
    -- Except for this unavoidable ugliness the SSL code is
    -- completely independent from the rest of MICO.

inherit
    IOR_STATICS;
    IOR_PROFILE_DECODER

creation
    make

feature -- Initialization

    make is

        do
            register_prof_decoder (current)
        end
----------------------
feature -- Destruction

    cleanup is

        do
            unregister_prof_decoder (current)
        end
----------------------
feature -- Access

    has_id (id : INTEGER) : BOOLEAN is

        do
            result := supported_ssltag (id)
        end
----------------------
feature -- Decoding

    decode (dc : DATA_DECODER; id : INTEGER) : IOR_PROFILE is

        local
            orig_pid : INTEGER
            ior      : IOR_PROFILE
            len      : INTEGER
            sa       : SSL_ADDRESS

        do
            orig_pid := ssltag_to_tag (id)
            len      := dc.get_buffer.rpos
            ior      := prof_decode_body (dc, orig_pid, len)
            
            if ior /= void then
                create sa.make (ior.addr)
                create {SSL_PROFILE} result.make2 (ior, sa)
            end
        end
----------------------
feature { NONE } -- Implementation

    ssltag_to_tag (tag : INTEGER) : INTEGER is
        -- I'm just guessing at this, since I can't find
        -- such a function in MICO. This is the inverse
        -- of `tag_to_ssltag' from SSL_PROFILE.

        do
            inspect tag

            when Tag_ssl_internet_iop then
                result := Tag_internet_iop

            when Tag_ssl_unix_iop then
                result := Tag_unix_iop

            end
        end
----------------------

    supported_ssltag (tag : INTEGER) : BOOLEAN is
        -- I'm just guessing at this, since I can't find
        -- such a function in MICO.

        do
            result := (tag = Tag_ssl_internet_iop
                       or else
                       tag = Tag_ssl_unix_iop)
        end

end -- class SSL_PROFILE_DECODER

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
