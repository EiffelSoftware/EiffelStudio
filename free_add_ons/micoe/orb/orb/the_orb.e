indexing

description: "Implements the singleton pattern; each component should %
             %have just one instance of the class ORB.";
keywords: "static", "singleton";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class THE_ORB

inherit
    ADDRESS_STATICS;
    ORB_STATICS

creation
    make

feature -- Initialization

    make (argc   : INTEGER_REF;
          argv   : ARRAY [STRING];
          the_id : STRING) is
        -- It should be possible to call `make' as many times
        -- as desired and always get the same ORB by accessing
        -- ORB_instance.

        local
            dummy : ORB

        do
            dummy := ORB_init (argc, argv, the_id)            
        end
----------------------
feature -- Access

    ORB_instance : ORB is

        local
            argc : INTEGER_REF

        once
            create argc
            result := ORB_init (argc, void, "")
                -- The arguments are irrelevant; it's a once function.
                -- Provided ORB_init has been called with valid arguments
                -- at the beginning of the programm ...
        end
----------------------
feature { CORBA_GENERAL }

    ORB_init (argc   : INTEGER_REF;
              argv   : ARRAY [STRING];
              the_id : STRING) : ORB is

        require
            nonvoid_args : argc   /= void and then
                           the_id /= void

        local
            run_iiop_server : BOOLEAN
            run_iiop_proxy  : BOOLEAN
            imr_ior         : STRING
            imr_addr        : STRING
            ir_ior          : STRING
            ir_addr         : STRING
            naming_ior      : STRING
            naming_addr     : STRING
            trading_ior     : STRING
            trading_addr    : STRING
            conffile        : STRING
            tracepath       : STRING
            debuglevel      : INTEGER
            bindaddrs       : INDEXED_LIST [STRING]
            iiopaddrs       : INDEXED_LIST [STRING]
            opts            : DICTIONARY [STRING, STRING]
            opt_parser      : GET_OPTS
            r               : BOOLEAN
            o               : INDEXED_CATALOG [STRING, STRING]
            id              : STRING
            proxy           : IIOP_PROXY
            i, n            : INTEGER
            oid             : ARRAY [INTEGER]
            lprof           : LOCAL_PROFILE
            is_local        : BOOLEAN
            laddr           : LOCAL_ADDRESS
            ee              : EXECUTION_ENVIRONMENT
            log             : IO_MEDIUM

        once
            exception_init
            codeset_init
            ssl_init
            run_iiop_server := true
            run_iiop_proxy  := true
            id              := the_id    

            create opts.make
            opts.put ("unique", "-ORBConfFile")
            create opt_parser.make (opts)
            r := opt_parser.parse3 (argc, argv, true)
            check
                could_parse : r
            end
            o := opt_parser.opts
            if o.has ("-ORBConfFile") then
                conffile := o.at ("-ORBConfFile").at (1)
            else
                conffile := rc_file
            end
            opts.make
            opts.put ("", "-ORBNoIIOPServer")
            opts.put ("", "-ORBNoIIOPProxy")
            opts.put ("nonunique", "-ORBIIOPAddr")
            opts.put ("unique", "-ORBId")
            opts.put ("unique", "-ORBImplRepoIOR")
            opts.put ("unique", "-ORBImplRepoAddr")
            opts.put ("unique", "-ORBIfaceRepoIOR")
            opts.put ("unique", "-ORBIfaceRepoAddr")
            opts.put ("unique", "-ORBNamingIOR")
            opts.put ("unique", "-ORBNamingAddr")
            opts.put ("unique", "-ORBTradingIOR")
            opts.put ("unique", "-ORBTradingAddr")
            opts.put ("unique", "-ORBTrace")
            opts.put ("unique", "-ORBDebugLevel")
            opts.put ("nonunique", "-ORBBindAddr")
            opt_parser.make (opts)
            if fs.file_exists (conffile) then
                r := opt_parser.parse_file2 (conffile, true)
                check
                    could_parse_file : r
                end
            end
            r := opt_parser.parse3 (argc, argv, true)
            check
                could_parse_argv : r
            end
            o := opt_parser.opts
            if o.has ("-ORBNoIIOPServer") then
                run_iiop_server := false
            end
            if o.has ("-ORBNoIIOPProxy") then
                run_iiop_proxy := false
            end
            if o.has ("-ORBIIOPAddr") then
                iiopaddrs := o.at ("-ORBIIOPAddr")
            end
            if o.has ("-ORBId") then
                id := o.at ("-ORBId").at (1)
            end
            if o.has ("-ORBImplRepoIOR") then
                imr_ior := o.at ("-ORBImplRepoIOR").at (1)
                if not run_iiop_proxy then
                    io.put_string ("%NIt is not permissible to use %
                                    %-ORBNoIIOPProxy and %
                                    %-ORBImplRepoIOR simultaneously%N")
                    logger.panic_mode ("Bad commandline")
                end
            end
            if o.has ("-ORBImplRepoAddr") then
                imr_addr := o.at ("-ORBImplRepoAddr").at (1)
                if not run_iiop_proxy then
                    io.put_string ("%NIt is not permissible to use %
                                    %-ORBNoIIOPProxy and %
                                    %-ORBImplRepoAddr simultaneously%N")
                    logger.panic_mode ("Bad commandline")
                end
            end
            if o.has ("-ORBIfaceRepoIOR") then
                ir_ior := o.at ("-ORBIfaceRepoIOR").at (1)
                if not run_iiop_proxy then
                    io.put_string ("%NIt is not permissible to use %
                                    %-ORBNoIIOPProxy and %
                                    %-ORBIfaceRepoIOR simultaneously%N")
                    logger.panic_mode ("Bad commandline")
                end
            end
            if o.has ("-ORBIfaceRepoAddr") then
                ir_addr := o.at ("-ORBIfaceRepoAddr").at (1)
                if not run_iiop_proxy then
                    io.put_string ("%NIt is not permissible to use %
                                    %-ORBNoIIOPProxy and %
                                    %-ORBIfaceRepoAddr simultaneously%N")
                    logger.panic_mode ("Bad commandline")
                end
            end
            if o.has ("-ORBNamingIOR") then
                naming_ior := o.at ("-ORBNamingIOR").at (1)
                if not run_iiop_proxy then
                    io.put_string ("%NIt is not permissible to use %
                                    %-ORBNoIIOPProxy and %
                                    %-ORBNamingIOR simultaneously%N")
                    logger.panic_mode ("Bad commandline")
                end
            end
            if o.has ("-ORBNamingAddr") then
                naming_addr := o.at ("-ORBNamingAddr").at (1)
                if not run_iiop_proxy then
                    io.put_string ("%NIt is not permissible to use %
                                    %-ORBNoIIOPProxy and %
                                    %-ORBNamingAddr simultaneously%N")
                    logger.panic_mode ("Bad commandline")
                end
            end
            if o.has ("-ORBTradingIOR") then
                trading_ior := o.at ("-ORBTradingIOR").at (1)
                if not run_iiop_proxy then
                    io.put_string ("%NIt is not permissible to use %
                                    %-ORBNoIIOPProxy and %
                                    %-ORBTradingIOR simultaneously%N")
                    logger.panic_mode ("Bad commandline")
                end
            end
            if o.has ("-ORBTradingAddr") then
                trading_addr := o.at ("-ORBTradingAddr").at (1)
                if not run_iiop_proxy then
                    io.put_string ("%NIt is not permissible to use %
                                    %-ORBNoIIOPProxy and %
                                    %-ORBTradingAddr simultaneously%N")
                    logger.panic_mode ("Bad commandline")
                end
            end
            if o.has ("-ORBTrace") then
                tracepath := o.at ("-ORBTrace").at (1)
            end
            debuglevel := logger.debug_level
            if o.has ("-ORBDebugLevel") then
                if o.at ("-ORBDebugLevel").at (1).is_integer then
                    debuglevel := o.at ("-ORBDebugLevel").at (1).to_integer
                else
                    io.put_string ("%NORBDebugLevel must be an integer%N")
                    logger.panic_mode ("Bad commandline")
                end
            end
            if o.has ("-ORBBindAddr") then
                bindaddrs := o.at ("-ORBBindAddr")
                if bindaddrs.count = 1 then
                    laddr ?= address_parse (bindaddrs.at (1))
                    if laddr /= void then
                        is_local := true
                    end
                end
                if not run_iiop_proxy and then not is_local then
                    io.put_string ("%NIt is not permissible to use %
                                    %-ORBNoIIOPProxy and %
                                    %-ORBBindAddr simultaneously %
                                    %unless the address is local:%N")
                    logger.panic_mode ("Bad commandline")
                end
            end

            logger.set_debug_level (debuglevel)
            set_tracefile (tracepath)

            if id /= void and then not equal (id, "mico-local-orb") then
                log := logger.log (logger.Log_warning, "General", 
                                   "THE_ORB", "ORB_init")
                log.put_string ("unknown ORB id: " )
                log.put_string (id)
                log.new_line
            end
            create result.make (argc, argv, conffile)

            -- interceptors
            r := init_exec_initialize (result,
                                       "mico-local-orb",
                                       argc, argv)

            -- XXX what should we do on error
            check
                interceptor_initialized: r
            end

            -- set default bind addresses
            if bindaddrs /= void then
                result.set_bindaddrs (bindaddrs)
            end
            -- create IIOP client
            if run_iiop_proxy then
                create proxy.make (result)
            end
            -- create IIOP server
            if run_iiop_server then
                create_iiop_server (result, iiopaddrs)
            else -- not run_iiop_server
                create oid.make (1, 0)
                create lprof.make (oid)
                result.ior_template.add_profile (lprof)
            end -- if run_iiop_server

            connect_to_implementation_repository (result, imr_ior, imr_addr)

            connect_to_interface_repository (result, ir_ior, ir_addr)

            connect_to_naming_service (result, naming_ior, naming_addr)

            connect_to_trading_service (result, trading_ior, trading_addr)
        end
----------------------
feature { NONE } -- Routines needed by ORB_init

    ssl_init is

        local
            ssli : SSL_INIT

        do
--            create ssli.make -- disabled for now
        end
----------------------

    create_iiop_server (orb: ORB; iiopaddrs : INDEXED_LIST [STRING]) is

        local
            i, n   : INTEGER
            server : IIOP_SERVER
            addr   : ADDRESS
            iaddr  : STRING
            log    : IO_MEDIUM

        do
            create server.make (orb)
            if iiopaddrs = void or else iiopaddrs.count = 0 then
                iaddr := "inet:"
                iaddr.append (hostname)
                iaddr.append (":0")
                addr := address_parse (iaddr)
                if addr = void then
                    log := logger.log (logger.Log_err, "General",
                                       "THE_ORB", "create_iiop_server")
                    log.put_string ("bad address: ")
                    log.put_string (iaddr)
                    log.new_line
                    check
                        good_address : false
                    end
                else -- addr /= void
                    server.listen_at (addr)
                        -- This call puts the appropriate profile
                        -- in the IOR template of `orb'.
                end -- if addr = void then ...
            else -- iiopaddrs /= void and then iiopaddrs.count > 0
                from
                    i := iiopaddrs.low_index
                    n := iiopaddrs.high_index
                until
                    i > n
                loop
                    addr := address_parse (iiopaddrs.at (i))
                    if addr = void then
                        log := logger.log (logger.Log_err, "General",
                                           "THE_ORB", "create_iiop_server")
                        log.put_string ("bad address: ")
                        log.put_string (iiopaddrs.at (i))
                        log.new_line
                        check
                            good_address : false
                        end
                    else -- addr /= void
                        server.listen_at (addr)
                            -- This call puts the appropriate profile
                            -- in the IOR template of `orb'.
                    end -- if addr = void then ...
                    i := i + 1
                end -- loop
            end -- if iiopaddrs = void or else iiopaddrs.count = 0 then ..
        end
----------------------

    connect_to_implementation_repository (orb : ORB;
                                          imr_ior, imr_addr : STRING) is

        local
            imr : CORBA_OBJECT
            r   : BOOLEAN
            log : IO_MEDIUM

        do
            if imr_ior /= void and then imr_ior.count > 0 then
                imr := orb.string_to_object (imr_ior)
            elseif imr_addr /= void and then imr_addr.count > 0 then
                imr := orb.bind_o2 ("IDL:omg.org/CORBA/ImplRepository:1.0",
                                       imr_addr)
                if imr = void then
                    log := logger.log (logger.Log_warning, "General", "THE_ORB",
                                       "connect_to_implementation_repository")
                    log.put_string ("warning: cannot bind to %
                                     %Implementation Repository at ")
                    log.put_string (imr_addr)
                    log.putchar ('.')
                    log.new_line
                end -- if imr = void then ...
            end -- if imr_ior /= void ...

            if imr /= void then
                r := orb.set_initial_reference ("ImplementationRepository", 
                                                imr)
            end
        end
----------------------

    connect_to_interface_repository (orb : ORB;
                                     ir_ior, ir_addr : STRING) is

        local
            ir  : CORBA_OBJECT
            r   : BOOLEAN
            log : IO_MEDIUM

        do
            if ir_ior /= void and then ir_ior.count > 0 then
                ir := orb.string_to_object (ir_ior)
            elseif ir_addr /= void and then ir_addr.count > 0 then
                ir := orb.bind_o2 ("IDL:omg.org/CORBA/Repository:1.0",
                                       ir_addr)
                if ir = void then
                    log := logger.log (logger.Log_warning, "General", "THE_ORB",
                                       "connect_to_interface_repository")
                    log.put_string ("warning: cannot bind to %
                                     %Interface Repository at ")
                    log.put_string (ir_addr)
                    log.putchar ('.')
                    log.new_line
                end -- if ir = void then ...
            end -- if ir_ior /= void ...
            if ir /= void then
                r := orb.set_initial_reference ("InterfaceRepository", ir)
            end
        end
----------------------

    connect_to_naming_service (orb : ORB; naming_ior, naming_addr : STRING) is

            local
                naming : CORBA_OBJECT
                r      : BOOLEAN
                tag    : ARRAY [INTEGER]

            do
                if naming_ior /= void and then naming_ior.count > 0 then
                    naming := orb.string_to_object (naming_ior)
                elseif naming_addr /= void and then naming_addr.count > 0 then
                        tag    := orb.string_to_tag ("NameService")
                        naming := orb.bind_o3
                         ("IDL:omg.org/CosNaming/NamingContext:1.0",
                          tag, naming_addr)
                end -- if naming_ior /= void ...
                if naming /= void then
                    r := orb.set_initial_reference ("NameService", naming)
                end
            end
----------------------

    connect_to_trading_service (orb : ORB;
                                trading_ior, trading_addr : STRING) is

        local
            trading : CORBA_OBJECT
            r       : BOOLEAN
            log     : IO_MEDIUM

        do
            if trading_ior /= void and then trading_ior.count > 0 then
                trading := orb.string_to_object (trading_ior)
            elseif trading_addr /= void and then trading_addr.count > 0 then
                trading := orb.bind_o2 ("IDLomg.org/CosTrading/Lookup:1.0",
                                        trading_addr)
                if trading = void then
                    log := logger.log (logger.Log_warning, "General", "THE_ORB",
                                       "connect_to_trading_service")
                    log.put_string ("warning: cannot bind to Trading %
                                     %Service at ")
                    log.put_string (trading_addr)
                    log.new_line
                else
                    r := orb.set_initial_reference ("TradingService",
                                                    trading)
                end
            end
        end
----------------------

    set_tracefile (tracepath : STRING) is

        local
            already   : BOOLEAN
            log       : IO_MEDIUM
            tracefile : PLAIN_TEXT_FILE

        do
            if tracepath /= void and then tracepath.count > 0 then
                if fs.file_exists(tracepath) and then
                   not fs.has_writeperm (tracepath) then
                    log := logger.log (logger.Log_err, "General",
                                       "THE_ORB", "set_tracefile")
                    log.put_string ("A tracefile ")
                    log.put_string (tracepath)
                    log.put_string (" already exists%N")
                    log.put_string ("and you don't have write %
                                   %permission for it.%N")
                    already := true
                    except.raise ("Permission")
                else
                    create tracefile.make_open_write (tracepath)
                    logger.set_target (tracefile)
                end -- if fs.file_exists (tracepath) and then ...
            end -- if tracepath /= void and then ...

        rescue
            if not already then
                log := logger.log (logger.Log_err, "General",
                                   "THE_ORB", "set_tracefile")
                log.put_string ("The tracefile ")
                log.put_string (tracepath)
                log.put_string (" could not be opened for writing. %
                                 %Check for a full disk.%N")
            end
        end
----------------------

    except : EXCEPTIONS is

        once
            create result
        end
----------------------

    rc_file   : STRING is "~/.micorc"

end -- class THE_ORB

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
