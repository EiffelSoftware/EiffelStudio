indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CODESET_INIT

inherit
    INIT_INTERCEPTOR
        redefine
            initialize
        end
    CODESET_STATICS
        undefine
            copy, is_equal
        end;
    THE_LOGGER
        undefine
            copy, is_equal
        end;

creation
    make

feature

    initialize (orb : ORB; orbid : STRING;
                argc : INTEGER_REF; argv : ARRAY [STRING]) : INTEGER is

            local
            opts       : DICTIONARY [STRING, STRING]
            o          : INDEXED_CATALOG [STRING, STRING]
            opt_parser : GET_OPTS
            cs_name    : STRING
            wcs_name   : STRING
            cs         : CODESET
            disable    : BOOLEAN
            r          : BOOLEAN
            mc         : MULTI_COMPONENT
            mcp        : MULTI_COMPONENT_PROFILE
            csc        : CODESET_COMPONENT
            ccs        : INDEXED_LIST [INTEGER]
            cwcs       : INDEXED_LIST [INTEGER]
            dummy      : BOOLEAN
            log        : IO_MEDIUM

            do
                create opts.make
                opts.put ("unique", "-ORBNativeCS")
                opts.put ("unique", "-ORBNativeWCS")
                opts.put ("", "-ORBNoCodeSets")
                create opt_parser.make (opts)
                r := opt_parser.parse_file2 (orb.get_rcfile, true)
                check
                    could_parse_file : r
                end
                r := opt_parser.parse3 (argc, argv, true)
                check
                    could_parse_args : r
                end

                o := opt_parser.opts
                if o.has ("-ORBNativeCS") then
                    cs_name := o.at ("-ORBNativeCS").at (1)
                end
                if o.has ("-ORBNativeWCS") then
                    wcs_name := o.at ("-ORBNativeWCS").at (1)
                end
                if o.has ("-ORBNoCodeSets") then
                    disable := true
                end

                -- native char code set
                if cs_name = void then
                    cs_name := "*8859-1*"
                end
                cs := create_codeset_with_pattern (cs_name)
                if cs = void then
                    log := logger.log (logger.Log_err, "General", 
                                       "CODESET_INIT", "initialize")
                    log.put_string ("unknown native char code set: ")
                    log.put_string (cs_name)
                    log.new_line
                    check
                        native_codeset_known : false
                    end
                end
                set_special_cs (Native_cs, cs)

                -- native wide char code set
                if wcs_name = void then
                    wcs_name := "*UTF-16*"
                end
                cs := create_codeset_with_pattern (wcs_name)
                if cs = void then
                    log := logger.log (logger.Log_err, "General", 
                                       "CODESET_INIT", "initialize")
                    log.put_string ("unknown native wide char code set: ")
                    log.put_string (wcs_name)
                    log.new_line
                    check
                        native_wide_codeset_known : false
                    end
                end
                set_special_cs (Native_wcs, cs)

                -- default char code set
                cs_name := "*8859-1*"

                cs := create_codeset_with_pattern (cs_name)
                if cs = void then
                    log := logger.log (logger.Log_err, "General", 
                                       "CODESET_INIT", "initialize")
                    log.put_string ("unknown default char code set: ")
                    log.put_string (cs_name)
                    log.new_line
                    check
                        default_codeset_known : false
                    end
                end
                set_special_cs (Default_cs, cs)

                -- default wide char code set
                -- (spec says there is no default ... )

                cs_name := "*UTF-16*"

                cs := create_codeset_with_pattern (cs_name)
                if cs = void then
                    log := logger.log (logger.Log_err, "General", 
                                       "CODESET_INIT", "initialize")
                    log.put_string ("unknown default wide char code set: ")
                    log.put_string (cs_name)
                    log.new_line
                    check
                        default_wide_codeset_known : false
                    end
                end
                set_special_cs (Default_wcs, cs)

                -- fallback char code set
                cs_name := "*UTF-8*"

                cs := create_codeset_with_pattern (cs_name)
                if cs = void then
                    log := logger.log (logger.Log_err, "General", 
                                       "CODESET_INIT", "initialize")
                    log.put_string ("unknown fallback char code set: ")
                    log.put_string (cs_name)
                    log.new_line
                    check
                        default_codeset_known : false
                    end
                end
                set_special_cs (Fallback_cs, cs)

                -- fallback wide char code set
                cs_name := "*UTF-16*"

                cs := create_codeset_with_pattern (cs_name)
                if cs = void then
                    log := logger.log (logger.Log_err, "General", 
                                       "CODESET_INIT", "initialize")
                    log.put_string ("unknown fallback wide char code set: ")
                    log.put_string (cs_name)
                    log.new_line
                    check
                        default_wide_codeset_known : false
                    end
                end
                set_special_cs (Fallback_wcs, cs)

                -- install code set info in ior template
                if not disable then
                    create mc.make
                    create mcp.make (mc)
                    create ccs.make (false)
                    create cwcs.make (false)
                    create csc.make4 (special_cs (Native_cs).id,
                                 special_cs (Native_wcs).id,
                                 ccs, cwcs)
                    mcp.components.add_component (csc)
                    orb.ior_template.add_profile (mcp)
                end
                result := Invoke_continue
                dummy  := codeset_disabled (disable)
            end

end -- class CODESET_INIT

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
