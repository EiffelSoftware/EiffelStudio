indexing

description: "A trick to achieve the semantics of static features as in %
             %C++ or Java.";
keywords: "static", "global";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class ADDRESS_STATICS

feature -- Statics for the class ADDRESS

    local_address_parser : LOCAL_ADDRESS_PARSER is

        once
            create result.make
        end
----------------------

    inet_address_parser : INET_ADDRESS_PARSER is

        once
            create result.make
        end
----------------------

    unix_address_parser : UNIX_ADDRESS_PARSER is

        once
            create result.make
        end
----------------------

    ssl_address_parser : SSL_ADDRESS_PARSER is

        once
            create result.make
        end
----------------------

    address_parse (a : STRING) : ADDRESS is

        local
            pos   : INTEGER
            rest  : STRING
            proto : STRING
            a1    : STRING
            i, n  : INTEGER
            done  : BOOLEAN
            ap    : ADDRESS_PARSER

        do
            if addr_parsers = void then
                -- Create and register 4 address parsers; one of
                -- each kind.
                register_parser (inet_address_parser)
                register_parser (unix_address_parser)
                register_parser (local_address_parser)
                register_parser (ssl_address_parser)
            end

            a1  := clone (a)
            pos := a1.index_of (':', 1)
            if pos = 0 then
                rest := ""
            else
                proto := a1.substring (1, pos - 1)
                rest  := a1.substring (pos + 1, a1.count)
            end

            if addr_parsers /= void then
                from
                    i := 1
                    n := addr_parsers.count
                until
                    i > n or else done
                loop
                    if addr_parsers.at (i).has_proto (proto) then
                        done := true
                    else
                        i := i + 1
                    end
                end
                if i <= n then
                    result := addr_parsers.at (i).parse (rest)
                end
            end -- if addr_parsers /= void then ...
        end
----------------------

    register_parser (ap : ADDRESS_PARSER) is

        do
            if addr_parsers = void then
                create addr_parsers.make (false)
            end
            addr_parsers.append (ap)
        end
----------------------

    unregister_parser (ap : ADDRESS_PARSER) is

        do
            if addr_parsers /= void then
                addr_parsers.remove (ap)
            end
        end
----------------------

    hostname : STRING is
        -- The name of the machine this process is
        -- running on.

        local
            a1, a2 : INET_ADDRESS
            aa     : ARRAY [INTEGER]
            p      : POINTER
            trial  : STRING

        do
            if this_host = void then
                this_host := ""
                p         := gethostname
                check
                    got_hostname : p /= Default_pointer
                end
                this_host.from_c (p)
                -- Some OSes do not return an FQDN. So we get
                -- the ip address for the hostname and resolve
                -- that into the FQDN...

                create a1.make1 (this_host)
                aa := a1.ipaddr
                create a2.make_vect (aa, 0)
                trial := a2.get_host
                if trial /= void and then trial.count > 0 then
                    this_host := trial
                end
            end
            result := this_host
        end
----------------------

    hostid : ARRAY [INTEGER] is

        local
            a  : INET_ADDRESS

        do
            create a.make1 (hostname)
            result := a.ipaddr
        end
----------------------

    samehosts (h1, h2 : STRING) : BOOLEAN is

        do
            -- XXX what if `h1' is an alias for `h2' ???
            result := equal (h1, h2)
        end
----------------------
feature { NONE }

    addr_parsers  : INDEXED_LIST [ADDRESS_PARSER]
    this_host     : STRING
----------------------
    gethostname : POINTER is

        external "C"
        alias "ADDR_gethostname"

        ensure
            non_void_result : result /= default_pointer
        end

end -- class ADDRESS_STATICS

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
