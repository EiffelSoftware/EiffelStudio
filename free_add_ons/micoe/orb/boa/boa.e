indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class BOA

inherit
    THE_FLAGS;
    BOA_CONSTANTS;
    ORB_STATICS;
    TYPECODE_STATICS;
    OBJECT_ADAPTER;
    BOA_INTERFACE


creation
    make

feature

    make (theorb : ORB; argc : INTEGER_REF; argv : ARRAY [STRING]) is

        local
            remote_ior   : STRING
            remote_addr  : STRING
            restore_iors : INDEXED_LIST [STRING]
            opt_parser   : GET_OPTS
            opts         : DICTIONARY [STRING, STRING]
            o            : INDEXED_CATALOG [STRING, STRING]
            r            : BOOLEAN
            obj          : CORBA_OBJECT
            impl         : IMPLEMENTATION_DEFINITION
            i, n         : INTEGER
            robs         : INDEXED_LIST [CORBA_OBJECT]
            host         : ARRAY [INTEGER]
            c            : CHARACTER

        do
            restoring     := false
            state         := BOA_active
            active_object := void
            curr_env      := void
            amode         := Activate_persistent
            oasrv_id      := 0
            queue_count   := 0
            myorb         := theorb
            theid         := 0
            create lobjs.make
            create robjs.make
            myorb.register_oa (current)
            create opts.make
            opts.put ("unique", "-OARemoteIOR")
            opts.put ("unique", "-OARemoteAddr")
            opts.put ("nonunique", "-OARestoreIOR")
            opts.put ("unique", "-OAImplName")
            opts.put ("unique", "-OAServerId")
            create opt_parser.make (opts)
            if fs.file_exists (Conffile) then
                r := opt_parser.parse_file2 (Conffile, true)
                check
                    could_parse_file : r
                end
            end
            r := opt_parser.parse3 (argc, argv, true)
            check
                could_parse_args : r
            end
            o := opt_parser.opts
            if o.has ("-OARemoteIOR") then
                remote_ior := o.at ("-OARemoteIOR").at (1)
            end
            if o.has ("-OARemoteAddr") then
                remote_addr := o.at ("-OARemoteAddr").at (1)
            end
            if o.has ("-OARestoreIOR") then
                restore_iors := o.at ("-OARestoreIOR")
            end
            if o.has ("-OAServerId") then
                oasrv_id := fmt.s2i (o.at ("-OAServerId").at (1))
            end
            if o.has ("-OAImplName") then
                impl_name := o.at ("-OAImplName").at (1)
            end

            -- connect to OA mediator
            oamed := void
            oasrv := void
            if remote_ior /= void and then remote_ior.count > 0 then
                obj := myorb.string_to_object (remote_ior)
            elseif remote_addr /= void and then remote_addr.count > 0 then
                obj := myorb.bind_o2 ("IDL:omg.org/CORBA/OAMediator:1.0",
                                   remote_addr)
                check
                    nonvoid_obj : obj /= void
                end
            end
            if obj /= void then
                oamed ?= obj
                check
                    got_oamed : oamed /= void
                end
            end

            -- Build a template for object ids.

            create id_template.make (1, 11)
            c := 'B'
            id_template.put (c.code, 1)
            c := 'O'
            id_template.put (c.code, 2)
            c := 'A'
            id_template.put (c.code, 3)
            host := hostid
            id_template.put (host.item (1), 4)
            id_template.put (host.item (2), 5)
            id_template.put (host.item (3), 6)
            id_template.put (host.item (4), 7)
            i := getpid
            id_template.put (i \\ 256, 11)
            i := i // 256
            id_template.put (i \\ 256, 10)
            i := i // 256
            id_template.put (i \\ 256, 9)
            i := i // 256
            if i < 0 then
                i := -1
            end
            id_template.put (i \\ 256, 8)

            -- register with mediator
--            impl  := find_impl
--            amode := impl.mode
--            oamed.create_impl (impl, oasrv, oasrv_id)

            -- restore saved_objects ...
            if restore_iors /= void and then restore_iors.count > 0 then
                from
                    i := restore_iors.low_index
                    n := restore_iors.high_index
                until
                    i > n
                loop
                    obj := myorb.string_to_object (restore_iors.at (i))
                    i   := i + 1
                    check
                        obj_nonvoid : obj /= void
                    end
                    restore_internal (obj)
                end
            end
            -- ask for more objects to restore
            if oamed /= void then
                robs := oamed.get_restore_objs (oasrv_id)
                if robs/= void and then robs.count > 0 then
                    restoring := true
                    from
                        i := robs.low_index
                        n := robs.high_index
                    until
                        i > n
                    loop
                        restore_internal (robs.at (i))
                        i := i + 1
                    end
                end
            end
        end
----------------------

    create_ref (id     : ARRAY [INTEGER];
                idef   : CORBA_INTERFACEDEF;
                impl   : IMPLEMENTATION_DEFINITION;
                skel   : IMPLEMENTATION_BASE;
                repoid : STRING) : CORBA_OBJECT is


        local
            key        : ARRAY [INTEGER]
            ior        : IOR
            obj        : CORBA_OBJECT
            rec        : OBJECT_RECORD
            r          : BOOLEAN
            remote_obj : CORBA_OBJECT

        do
            if id = void or else id.empty then
                key := unique_id
            else
                key := id
            end
            ior := clone (myorb.ior_template)
            ior.set_objectkey (key, key.count)
            ior.set_repoid (repoid)
            if skel = void then
                create obj.make_with_ior (ior)
            else
                obj := skel
                obj.make_with_ior (ior)
                -- interfaces derived from other interfaces will
                -- call create for each of the base interfaces
                -- (which is a bug). The next three lines are a
                -- workaround that removes the entries for the
                -- base interfaces.
                if skel /= void and then skel.get_ior /= void then
                    dispose (skel)
                end
            end

            r := boa_exec_create (obj)
            -- XXX what should we do if this fails??
            check
                exec_create_worked : r
            end

            if oamed = void or else oasrv = void then
                -- we are a standalone or OAServer hasn't been
                -- created yet
                create rec.make_l5 (obj, key, idef, impl, skel)
                add_record (rec)
            else
                -- register wit BOA daemon. It will tell us its object
                -- reference, which we store in the newly generated object,
                -- so subsequent invocations will go over the daemon.
                queue
                create remote_obj.make_with_ior (void)
                oamed.create_obj (obj, remote_obj, key, oasrv_id)
                oamed.activate_obj (remote_obj, oasrv_id)

                create rec.make_lr6 (obj, remote_obj, key, idef, impl, skel)
                add_record (rec)

                unqueue
            end

            result := rec.get_remote_obj
        end
----------------------

    am_restoring : BOOLEAN is

        do
            result := restoring
        end
----------------------

    restore (orig   : CORBA_OBJECT;
             refd   : ARRAY [INTEGER];
             interf : CORBA_INTERFACEDEF;
             impl   : IMPLEMENTATION_DEFINITION;
             skel   : IMPLEMENTATION_BASE) : CORBA_OBJECT is

        local
            rec : OBJECT_RECORD

        do
            rec := get_record (orig)
            check
                oamed_nonvoid : oamed /= void
            end

            rec.set_iface (interf)
            rec.set_impl (impl)
            rec.set_skel (skel)
            result := rec.get_remote_obj
        end
----------------------

    orb : ORB is

        do
            result := myorb
        end
----------------------

    get_impl_name : STRING is

        do
            if impl_name = void or else impl_name.count = 0 then
                -- generate a unique impl name ...
                impl_name := hostname
                impl_name.extend (':')
                impl_name.append_integer (getpid)
            end
            result := impl_name
        end
----------------------

    save_objects is

        local
            it : ITERATOR

        do
            from
                it := lobjs.iterator
            until
                it.finished
            loop
                save_object (lobjs.item (it))
                it.forth
            end
        end
----------------------

    dispose_objects is

        local
            it : ITERATOR

        do
            from
                it := lobjs.iterator
            until
                it.finished
            loop
                dispose_object (lobjs.item (it))
                it.forth
            end
        end
----------------------

    dispose (o : CORBA_OBJECT) is

        local
            rec  : OBJECT_RECORD
            obj  : CORBA_OBJECT

        do
            rec := get_record (o)

            if rec /= void then
                if equal (o, active_object) then
                    active_object := void
                end
                if oamed = void and then equal (rec.get_local_obj,
                                           rec.get_remote_obj) then
                    del_record (o)
                else
                    -- make sure ANY.copy_any does not release object again
                    -- during DII invocation to daemon by erasing object from
                    -- object table before making the call.
                    create obj.make_with_ior (clone (o.get_ior))
                    del_record (o)
                    oamed.dispose_obj (obj, oasrv_id)
                end
            end
        end
----------------------

    get_id (o : CORBA_OBJECT) : ARRAY [INTEGER] is

        local
            rec : OBJECT_RECORD

        do
            rec := get_record (o)
            check
                record_found : rec /= void
            end

            result := clone (rec.get_id)
        end
----------------------

    change_implementation (o  : CORBA_OBJECT;
                           im : IMPLEMENTATION_DEFINITION) is

        local
            rec : OBJECT_RECORD

        do
            -- XXX This version works only with the
            -- BOA daemon
            check
                oamed_nonvoid : oamed /= void
            end

            rec := get_record (o)
            check
                record_found : rec /= void
            end

            if rec.get_state = BOA_active then
                rec.set_state (BOA_shutdown)
            end
            shutdown_obj (o)
            save_object (rec)

            oamed.migrate_obj (o, oasrv_id, im)
            dispose_object (rec)
            del_record (o)
        end
----------------------

    get_principal (o   : CORBA_OBJECT;
                   env : ENVIRONMENT) : PRINCIPAL is

        do
            if env /= void then
                result := env.principal
            elseif curr_env /= void then
                result := curr_env.principal
            end
        end
----------------------

    impl_is_ready (idef : IMPLEMENTATION_DEFINITION) is

        do
            -- Beware; before we return from here, the first
            -- invocations may already be arriving.
            if oamed /= void then
                oamed.activate_impl (oasrv_id)
            end
        end
----------------------

    deactivate_impl (idef : IMPLEMENTATION_DEFINITION) is

        do
            if state = BOA_active then
                state := BOA_shutdown

                shutdown_impl
                save_objects

                -- must dispose before deactivating ...
                dispose_objects
                if oamed /= void then
                    oamed.dispose_impl (oasrv_id)
                end
                del_all_records
            end
        end
----------------------

    obj_is_ready (o : CORBA_OBJECT; im : IMPLEMENTATION_DEFINITION) is

        local
            obj : CORBA_OBJECT
            imp : IMPLEMENTATION_DEFINITION

        do
            if o = void then
                obj := find_obj
            else
                obj := o
            end
            if im = void then
                imp := find_impl
            end
            check
                implementation_defined : imp /= void
            end

            active_object := obj

            if oamed /= void then
                -- Beware; before we return from here,
                -- the first invocations may already be arriving.

                oamed.activate_impl (oasrv_id)
            end
        end
----------------------

    deactivate_obj (o : CORBA_OBJECT) is

        local
            obj : CORBA_OBJECT
            rec : OBJECT_RECORD

        do
            if o = void then
                obj := active_object
            else
                obj := o
            end

            if state = BOA_active then
                -- deactivate whole implementation
                state := BOA_shutdown
                shutdown_impl
                save_objects

                -- must dispose before deactivating ...

                dispose_objects
                if oamed /= void then
                    oamed.dispose_impl (oasrv_id)
                    del_all_records
                end
            else -- deactivate one object
                check
                    known_object : obj /= void
                end

                rec := get_record (obj)
                if rec.get_state = BOA_active then
                    rec.set_state (BOA_shutdown)

                    shutdown_obj (obj)
                    save_object (rec)

                    if oamed /= void then
                        oamed.orphan_obj (obj, oasrv_id)
                    end

                    dispose_object (rec)
                    del_record (obj)
                end -- if rec.get_state = BOA_active then ...
            end -- if state = BOA_active then ...
        end
----------------------

    get_oaid : STRING is

        do
            result := "mico-local-boa"
        end
----------------------

    has_object (o : CORBA_OBJECT) : BOOLEAN is

        local
            rec : OBJECT_RECORD

        do
            rec    := get_record (o)
            result := (rec /= void)
        end
----------------------

    is_local : BOOLEAN is

        do
            result := true
        end
----------------------

    address_used_for_object (obj : CORBA_OBJECT) : ADDRESS is

        do
            -- only called for nonlocal OAs.
        end
----------------------

    get_impl (o : CORBA_OBJECT) : IMPLEMENTATION_DEFINITION is

        local
            rec : OBJECT_RECORD
            dum : BOOLEAN

        do
            rec := get_record (o)
            check
                known_object : rec /= void
            end

            dum := load_object (rec)
            result := rec.get_impl
        end
----------------------

    get_iface (o : CORBA_OBJECT) : CORBA_INTERFACEDEF is

        local
            rec : OBJECT_RECORD
            dum : BOOLEAN

        do
            rec := get_record (o)
            check
                known_object : rec /= void
            end

            dum := load_object (rec)
            if rec.get_iface = void then
                rec.set_iface (rec.get_skel.find_iface
                    (rec.get_local_obj.repoid))
            end
            result := rec.get_iface
        end
----------------------

    invoke5 (msgid        : INTEGER;
             o            : CORBA_OBJECT;
             req          : ORB_REQUEST;
             pr           : PRINCIPAL;
             response_exp : BOOLEAN) : BOOLEAN is

        local
            rec   : REQUEST_QUEUE_RECORD
            orec  : OBJECT_RECORD
            ex    : OBJECT_NOT_EXIST
            sreq  : CORBA_SERVER_REQUEST
            svreq : SERVER_REQUEST_BASE
            skel  : IMPLEMENTATION_BASE
            dum   : BOOLEAN

        do
            logger.trace_enter ("BOA", "invoke5")
            if must_queue (msgid) then
                create rec.make_invoke (msgid, req, o, pr, response_exp)
                req_queue.add (rec)
                result := true
            else
                orec := get_record (o)
                if orec = void then
                    -- Object has been deleted since the call to
                    -- has_object and now, while the invocation
                    -- was on the queue.
                    create ex.make
                    req.set_out_args_ex (ex)
                    myorb.answer_invoke (msgid, Invoke_sys_ex, void, req)
                    result := true
                elseif is_builtin_invoke (req.op_name) then
                    create sreq.make5 (req, void, msgid, current, pr)
                    builtin_invoke (o, sreq, pr)
                else
                    dum := load_object (orec)
                    skel := orec.get_skel
                    check
                        known_skeleton : skel /= void
                    end

                    svreq := skel.make_request (req, o, msgid, 
                                                current, pr)
                    -- XXX setting cur_env is a hack to enable
                    -- method implementations to call
                    -- get_principal (..., void,), because they
                    -- do not have access to the environment
                    -- (see also get_principal). This will cause
                    -- problems in a multithreading environment.
                    curr_env := svreq.environment
                    logger.trace_enter ("IMPLEMENTATION_BASE", "doinvoke")
                    skel.doinvoke (svreq, svreq.environment)
                    logger.trace_leave ("IMPLEMENTATION_BASE", "doinvoke")
                    curr_env := void
                end -- if orec = void then ...
                result := true
            end -- if must_queue (msgid) then ...
            if response_exp then
                if sreq = void then
                    sreq ?= svreq
                end
                sreq.finish_request
                    -- This is where the result and out args are written
                    -- to the thunk of type ORB_REQUEST.
            end -- if response_exp then ...
            logger.trace_leave ("BOA", "invoke5")
        end
----------------------

    answer_invoke (msgid : INTEGER;
                   obj   : CORBA_OBJECT;
                   req   : ORB_REQUEST;
                   stat  : INTEGER) is

        do
            logger.trace_enter ("BOA", "answer_invoke")
            myorb.answer_invoke (msgid, stat, void, req)

            if amode = Activate_per_method then
                -- shutdown per-method servers after one
                -- (non-builtin) invocation
                if not is_builtin_invoke (req.op_name) then
                    myorb.shutdown (true)
                end
            end
            logger.trace_leave ("BOA", "answer_invoke")
        end
----------------------

    builtin_invoke (o     : CORBA_OBJECT;
                    svreq : CORBA_SERVER_REQUEST;
                    pr    : PRINCIPAL) is

        local
            dum    : CORBA_NAMED_VALUE
            args   : CORBA_NV_LIST
            res    : CORBA_ANY
            repoid : STRING
            rec    : OBJECT_RECORD
            r      : BOOLEAN
            isa    : BOOLEAN

        do
            -- [12-17]
            if equal (svreq.op_name, "_interface") then
                args := myorb.create_list (0)
                svreq.set_arguments (args)
                create res.make
                res.put_object (void, get_iface (o))
                svreq.set_result (res)
            elseif equal (svreq.op_name, "_implementation") then
                args := myorb.create_list (0)
                svreq.set_arguments (args)
                create res.make
                res.put_object (void, get_impl (o))
                svreq.set_result (res)
            elseif equal (svreq.op_name, "_is_a") then
                args := myorb.create_list (0)
                dum := args.add_item (void, flags.Arg_in)
                args.item (1).value.set_type (Tc_string)
                r := svreq.set_params (args)
                repoid := args.item (1).value.get_string(0)
                check
                    got_repoid : repoid /= void
                end
                rec := get_record (o)
                check
                    got_record : rec /= void
                end
                r := load_object (rec)
                check
                    load_ok : r
                end
                isa := equal (repoid, rec.get_skel.repoid)
                --XXX this is much more primitive than it should be
                create res.make
                res.put_boolean (isa)
                svreq.set_result (res)
            elseif equal (svreq.op_name, "_non_existent") then
                create res.make
                res.put_boolean (false)
                svreq.set_result (res)
            end
        end
----------------------

    is_builtin_invoke (op : STRING) : BOOLEAN is

        do
            result := (equal (op, "_interface")
                       or else
                       equal (op, "_implementation")
                       or else
                       equal (op, "_is_a")
                       or else
                       equal (op, "_non_existent"))
        end
----------------------

    activate (repoid : STRING) : BOOLEAN is

        local
            imr   : IMPLEMENTATION_REPOSITORY
            ims   : ARRAY [IMPLEMENTATION_DEFINITION]
            name  : STRING
            break : BOOLEAN
            shlib : UNIX_SHARED_LIBRARY
            i, n  : INTEGER
            j, m  : INTEGER
            log   : IO_MEDIUM

        do
            imr ?= orb.resolve_initial_references(
                         "ImplementationRepository")
            check
                nonvoid_imr : imr /= void
            end

            ims := imr.find_by_repoid (repoid)

            from
                i := ims.lower
                n := ims.upper
            until
                i > n
            loop
                if ims.item (i).mode = Activate_library then
                    name := ims.item(i).command
                    -- found one; see if already loaded ...
                    from
                        j := shlibs.low_index
                        m := shlibs.high_index
                    until
                        j > m or else equal (name, shlibs.at(j).name)
                    loop
                        j := j + 1
                    end
                end
                if j < m then -- load it
                    create shlib.make (name)
                    shlibs.append (shlib)
                    result := shlib.init
                    if not result then
                        log := logger.log (logger.Log_warning, "General", "BOA", "activate")
                        log.put_string ("could not load shlib ")
                        log.put_string (name)
                        log.put_string (": ")
                        log.put_string (shlib.error)
                        log.new_line
                    end
                else
                    i := i + 1
                end
            end
        end
----------------------

    shutdown (wait_for_completion : BOOLEAN) is

        do
            if amode = Activate_per_method then
                -- automatically deactivate per-method object
                deactivate_obj (void)
            end

            save_objects
            dispose_objects

            -- XXX how do we wait for completion???

            myorb.answer_shutdown (current)
        end
----------------------

    cancel (msgid : INTEGER) is

        do
        end
----------------------

    skeleton (o : CORBA_OBJECT) : CORBA_OBJECT is

        local
            rec : OBJECT_RECORD
            dum : BOOLEAN

        do
            rec :=get_record (o)
            check
                known_object : rec /= void
            end

            dum    := load_object (rec)
            result := rec.get_skel
        end
----------------------

    bind (msgid : INTEGER; repoid : STRING;
          oid : ARRAY [INTEGER]; addr : ADDRESS) : BOOLEAN is

        local
            rqrec : REQUEST_QUEUE_RECORD
            break : BOOLEAN
            ret   : BOOLEAN

        do
            logger.trace_enter ("BOA", "bind")
            if addr /= void and then not addr.is_local then
                result := false
            elseif must_queue (msgid) then
                create rqrec.make_bind (msgid, repoid, oid)
                req_queue.add (rqrec)
                result := true
            else
                from
                    queue
                until
                    break
                loop
                    if dobind (msgid, repoid, oid, addr) then
                        unqueue
                        result := true
                        break  := true
                    else
                        -- if nothing found try loading a shared
                        -- object and repeat search
--                        if not activate (repoid) then
--                            break := true
--                        end
                        unqueue
                        result := false
                        break  := true
                    end
                end
                if not break then
                    ret := boa_exec_bind (repoid, oid)
                    if (ret and then dobind (msgid, repoid, oid, addr)) then
                        result := true
                    end
                    unqueue
                end
            end
            logger.trace_leave ("BOA", "bind")
        end
----------------------

    locate (msgid : INTEGER; o : CORBA_OBJECT) is

        local
            rec : OBJECT_RECORD

        do
            rec := get_record (o)
            check
                known_object : rec /= void
            end

            myorb.answer_locate (msgid, Locate_here, void)   
        end
----------------------
feature -- mico/E extras

    object_to_skeleton (o : CORBA_OBJECT) : IMPLEMENTATION_BASE is

        local
            rec : OBJECT_RECORD

        do
            rec := get_record (o)
            check
                object_is_known : rec /= void
            end
            result := rec.get_skel

        ensure
            nonvoid_result : result /= void
        end
----------------------

    object_to_implementation (o : CORBA_OBJECT) : IMPLEMENTATION_BASE is

        do
            result ?= object_to_skeleton (o).implementation
        end
----------------------
feature { NONE } -- Implementation

    Conffile : STRING is "~/.micorc"

    impl_name     : STRING
    lobjs         : DICTIONARY [OBJECT_RECORD, CORBA_OBJECT]
    robjs         : DICTIONARY [OBJECT_RECORD, CORBA_OBJECT]
    shlibs        : INDEXED_LIST [SHARED_LIBRARY]
    myorb         : ORB
    theid         : INTEGER
    oamed         : OA_MEDIATOR
    oasrv         : OA_SERVER
    active_object : CORBA_OBJECT
    amode         : INTEGER
    restoring     : BOOLEAN
    state         : INTEGER
    req_queue     : REQUEST_QUEUE
    queue_count   : INTEGER
    curr_env      : ENVIRONMENT
    oasrv_id      : INTEGER
    id_template   : ARRAY [INTEGER]

----------------------

    save_object (rec : OBJECT_RECORD) is

        local
            ib : IMPLEMENTATION_BASE

        do
            ib := rec.get_skel
            if ib /= void                          and then
               rec.save                            and then
               rec.get_local_obj /= rec.get_remote_obj then
                rec.set_persistent (ib.save_object)
                rec.set_save (false)
            end
        end
----------------------

    queue is

        do
            if req_queue = void then
                create req_queue.make (current, myorb)
            end
            queue_count := queue_count + 1
        end
----------------------

    unqueue is

        do
            check
                positive_queue_count : queue_count > 0
            end
            queue_count := queue_count - 1
            if queue_count = 0 then
--                req_queue.exec_later
                -- commented out because to me
                -- this looks suspisciously like
                -- busy waiting ...
            end
        end
----------------------

    must_queue (msgid : INTEGER) : BOOLEAN is

        do
            if queue_count > 0 then
                result := true
            end
            -- there are still invocations in the queue, queue it
            -- to preserve invocation order.
        end
----------------------

    find_impl : IMPLEMENTATION_DEFINITION is

        local
            imr   : IMPLEMENTATION_REPOSITORY
            impls : ARRAY [IMPLEMENTATION_DEFINITION]

        do
            imr ?= orb.resolve_initial_references
                       ("ImplementationRepository")
            check
                impl_repos_found : imr /= void
            end
            impls := imr.find_by_name (impl_name)
            if impls.count > 0 then
                result := impls.item (impls.lower)
            end
        end
----------------------

    find_obj : CORBA_OBJECT is

        local
            it : ITERATOR

        do
            from
                it := lobjs.iterator
            until
                it.finished
            loop
                result := lobjs.item (it).get_remote_obj
                it.stop
            end
        end
----------------------

    add_record (rec : OBJECT_RECORD) is

        do
            lobjs.put (rec, rec.get_local_obj)
            if oamed /= void then
                robjs.put (rec, rec.get_remote_obj)
            end
            check
                record_there : lobjs.has (rec.get_local_obj)
            end
        end
----------------------

    get_record (o : CORBA_OBJECT) : OBJECT_RECORD is

        do
            if lobjs.has (o) then
                result := lobjs.at (o)
            else
                -- take a shortcut for local invocations,
                -- i.e. bypass the BOA daemon ...
                if robjs.has (o) then
                    result := robjs.at (o)
                end
            end
        end
----------------------

    del_record (o : CORBA_OBJECT) is

        local
            it : ITERATOR

        do
            from
                it := lobjs.iterator
            until
                it.finished or else equal (o, lobjs.key (it))
            loop
                it.forth
            end
            if it.inside then
                if oamed /= void then
                    robjs.remove (lobjs.item (it).get_remote_obj)
                end
                lobjs.remove (o)
                it.stop
            else -- object not found if standalone ...
                check
                    nonvoid_oamed : oamed /= void
                end
                from
                    it := robjs.iterator
                until
                    it.finished or else equal (o, robjs.key (it))
                loop
                    it.forth
                end
                if it.inside then
                    lobjs.remove (robjs.item (it).get_local_obj)
                    robjs.remove (o)
                    it.stop
                else -- object not found
                    check
                        object_found : false
                    end
                end
            end
        end
----------------------

    del_all_records is

        do
            create lobjs.make
            create robjs.make
        end
----------------------

    unique_id : ARRAY [INTEGER] is

        local
            i, n : INTEGER
            l    : INDEXED_LIST [INTEGER]

        do
            theid := theid + 1
            if theid = 0 then
                theid := 1
            end

            from
                create l.make (false)
                i := id_template.lower
                n := id_template.upper
            until
                i > n
            loop
                l.append (id_template.item (i))
                i := i + 1
            end

            from
                i := theid
            until
                i <= 0
            loop
                l.append (i \\ 256)
                i := i // 256
            end

            from
                i := l.low_index
                n := l.high_index
                create result.make (i, n)
            until
                i > n
            loop
                result.put (l.at (i), i)
                i := i + 1
            end            
        end
----------------------

    shutdown_obj (obj : CORBA_OBJECT) is

        local
            break : BOOLEAN
            rec   : OBJECT_RECORD

        do
            check
                queue_empty : queue_count = 0
            end
            req_queue.exec_now
            if oamed /= void then
                oamed.deactivate_obj (obj, oasrv_id)
            end
            from
            until
                break
            loop
                rec := get_record (obj)
                if rec = void then
                    -- object has been released inbetween
                    break := true
                elseif rec.get_state = Boa_inactive then
                    -- all buffered invocations done
                    break := true
                else
                    orb.dispatcher.run
                end
            end            
        end
----------------------

    shutdown_impl is

        local
            break : BOOLEAN

        do
            check
                queue_empty : queue_count = 0
            end
            req_queue.exec_now

            if oamed /= void then
                oamed.deactivate_impl (oasrv_id)
                from
                until
                    break
                loop
                    if state = Boa_inactive then
                        -- all buffered invocations done
                        break := true
                    else
                        orb.dispatcher.run
                    end
                end                
            end
        end
----------------------

    restore_internal (orig : CORBA_OBJECT) is

        local
            key        : ARRAY [INTEGER]
            id         : ARRAY [INTEGER]
            ior        : IOR
            rec        : OBJECT_RECORD
            remote_obj : CORBA_OBJECT
            obj        : CORBA_OBJECT

        do
            key := unique_id
            ior := clone (orb.ior_template)
            ior.set_objectkey (key, key.count)
            ior.set_objid (orig.repoid)
            create obj.make_with_ior (ior)
            check
                nonvoid_oamed : oamed /= void
            end
            -- register wit BOA daemon: tell him our new local object
            -- reference. we receive a (possibly different) remote object
            -- reference, which we will store in the newly generated
            -- object, so subsequent invocations will go over the daemon.
            queue
            remote_obj := clone (orig)
            create id.make (1, 1)
            oamed.restore_obj (obj, remote_obj, id, oasrv_id)
            oamed.activate_obj (remote_obj, oasrv_id)

            create rec.make_lr6 (obj, remote_obj, id, void, void, void)
            add_record (rec)
            unqueue
        end
----------------------

    dobind (msgid : INTEGER;
            repoid : STRING;
            oid    : ARRAY [INTEGER];
            addr   : ADDRESS) : BOOLEAN is

        require
            nonvoid_oid : oid /= void

        local
            it  : ITERATOR
            rec : OBJECT_RECORD
            ld  : BOOLEAN

        do
            logger.trace_enter ("BOA", "dobind")
            from
                it := lobjs.iterator
            until
                it.finished or else result
            loop
                -- XXX do a more flexible repoid comparison ...
                rec := lobjs.item (it)
                if equal (repoid, rec.get_local_obj.repoid)
                   and then
                   (oid.empty or else equal (oid, rec.get_id)) then
                    ld := load_object (rec)
                    check
                        object_loaded : ld
                    end
                    if oid.empty then
                        oid.copy (rec.get_skel.get_ior.get_objectkey)
                    end
                    orb.answer_bind (msgid, Locate_here, rec.get_skel)
                    result := true
                end
                it.forth
            end
            logger.trace_leave ("BOA", "dobind")
        end
----------------------

    dispose_object (rec : OBJECT_RECORD) is

        local
            sv : BOOLEAN

        do
            if rec.get_skel /= void and then
                rec.get_local_obj /= rec.get_remote_obj then
                sv := rec.save
                check
                    object_savable : sv
                end

                if not rec.get_persistent and then
                   oamed /= void          then
                    oamed.dispose_obj (rec.get_remote_obj, oasrv_id)
                end
            end
        end
----------------------

    load_object (rec : OBJECT_RECORD) : BOOLEAN is

        do
            if rec.get_skel = void then
                -- XXX This could lead to infinite
                -- recursion if the object loader
                -- code (inirectly) makes calls to
                -- ORB/BOA methods (e.g.
                -- ORB:string_to_object) that result
                -- in a call to load_object
                -- for the same object.
                queue
                result := boa_exec_restore (rec.get_remote_obj)
                unqueue
            end -- if rec.get_skel = void then ...
            result := rec.get_skel /= void
        end
----------------------

    fmt : FORMAT is

        once
            create result
        end
----------------------

    getpid : INTEGER is

        external "C"
        alias "MICO_getpid"

        end

end -- class BOA

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
