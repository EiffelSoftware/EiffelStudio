indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SSL_INIT

inherit
    INTERCEPTOR_STATICS
        undefine
            copy, is_equal
        end;
    INIT_INTERCEPTOR
        redefine
            initialize
        end

creation
    make

feature

    initialize (orb : ORB; orbid : STRING;
                argc : INTEGER_REF; argv : ARRAY [STRING]) : INTEGER is

        local
            opts       : DICTIONARY [STRING, STRING]
            opt_parser : GET_OPTS
            r          : BOOLEAN

        do
            create opts.make
            opts.put ("unique", "-ORBSSLverify")
            opts.put ("unique", "-ORBSSLcert")
            opts.put ("unique", "-ORBSSLkey")
            opts.put ("unique", "-ORBSSSLCApath")
            opts.put ("unique", "-ORBSSLcipher")

            create opt_parser.make (opts)
            r := opt_parser.parse_file2 (orb.get_rcfile, true)
            check
                could_parse_file : r
            end
            r := opt_parser.parse3 (argc, argv, true)
            check
                could_parse : r
            end

            SSL_options := opt_parser.opts

            result := Invoke_continue            
        end

end -- class SSL_INIT

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
