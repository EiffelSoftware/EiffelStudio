indexing

description: "A concrete scheduler that uses the BSD function `select'.";
keywords: "scheduling", "event", "select";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SELECT_DISPATCHER

inherit
    THE_LOGGER;
    DISPATCHER

creation
    make

feature -- Initalization

    make is

        do
            last_update := 0
            locked      := 0
            modified    := false
            init        := true
            select_data := ext_create
            check
                create_ok : select_data /= Default_pointer
            end
            create fevents.make (false)
            create tevents.make (false)
        end
---------------------------------
feature -- Operations

    rd_event (cb : DISPATCHER_CALLBACK; fd : INTEGER) is
        -- See header comment of precursor.

        local
            fe : FILE_EVENT

        do
            create fe.make3 (Read_ev, fd, cb)
            fevents.append (fe)
            update_fevents
        end
---------------------------------

    wr_event (cb : DISPATCHER_CALLBACK; fd : INTEGER) is
        -- See header comment of precursor.

        local
            fe : FILE_EVENT

        do
            create fe.make3 (Write_ev, fd, cb)
            fevents.append (fe)
            update_fevents
        end
---------------------------------

    ex_event (cb : DISPATCHER_CALLBACK; fd : INTEGER) is
        -- See header comment of precursor.

        local
            fe : FILE_EVENT

        do
            create fe.make3 (Except_ev, fd, cb)
            fevents.append (fe)
            update_fevents
        end
---------------------------------

    tm_event (cb : DISPATCHER_CALLBACK; tmout : INTEGER) is
        -- See header comment of precursor.

        local
            te1  : TIMER_EVENT
            te2  : TIMER_EVENT
            i, n : INTEGER
            d1   : INTEGER
            d2   : INTEGER
            done : BOOLEAN
             

        do
            create te1.make3 (Timer_ev, tmout, cb)

            update_tevents
            from
                i := 1
                n := tevents.count
            until
                i > n or else done
            loop
                te2 := tevents.at (i)
                d2  := te2.get_delta
                d1  := te1.get_delta 
                if d2 <= d1 then
                    te1.set_delta (d1 - d2)
                    i := i + 1
                else
                    te2.set_delta (d2 - d1)
                    done := true
                end
            end
            tevents.insert (te1, i - 1)
                -- This inserts `te1' at position `i'.
        end
---------------------------------

    remove (cb : DISPATCHER_CALLBACK; ev : INTEGER) is
        -- See header comment of precursor.

        local
            i, n  : INTEGER
            delta : INTEGER
            te1   : TIMER_EVENT
            te2   : TIMER_EVENT
            fe    : FILE_EVENT

        do
            if ev = All_ev or else ev = Timer_ev then
                from
                    i := 1
                    n := tevents.count
                until
                    i > n
                loop
                    te1 := tevents.at (i)
                    if cb = te1.get_cb then -- XXX should this be `equal'???
                        if i < n then
                            te2   := tevents.at (i+ 1)
                            delta := te2.get_delta
                            te2.set_delta (delta + te1.get_delta)
                        end
                        tevents.remove_at (i)
                        n := n - 1
                    else
                        i := i + 1
                    end

                end
            end
            if ev = All_ev or else ev = Read_ev or else
               ev = Write_ev or else ev = Except_ev then
                from
                    i := 1
                    n := fevents.count
                until
                    i > n
                loop
                    fe := fevents.at (i)
                    if fe.get_cb = cb -- XXX same question.
                       and then
                       (ev = All_ev or else fe.get_event = ev) then
                        if islocked then
                            fe.set_deleted (true)
                            i := i + 1
                        else
                            fevents.remove_at (i)
                            n := n - 1
                        end
                    else
                        i := i + 1
                    end
                end
                update_fevents
            end
        end
---------------------------------

    move (disp : DISPATCHER) is
        -- See header comment of precursor.

        local
            tmout : INTEGER
            i, n  : INTEGER
            fe    : FILE_EVENT
            te    : TIMER_EVENT

        do
            check -- cannot make this a precondition because the
                  -- precursor has a trivial precondition.
                islocked : islocked
            end
            from
                i := 1
                n := fevents.count
            until
                i > n
            loop
                fe := fevents.at (i)
                i := i + 1
                inspect (fe.get_event)

                when Read_ev then
                    disp.rd_event (fe.get_cb, fe.get_fd)

                when Write_ev then
                    disp.wr_event (fe.get_cb, fe.get_fd)

                when Except_ev then
                    disp.ex_event (fe.get_cb, fe.get_fd)

                else
                    -- do nothing
                end
            end
            fevents.make (false) -- reinitialize fevents.
            update_fevents
            update_tevents
            from
                i := 1
                n := tevents.count
            until
                i > n
            loop
                te    := tevents.at (i)
                i     := i + 1
                tmout := tmout + te.get_delta
                if tmout < 0 then
                    tmout := 0
                end
                disp.tm_event (te.get_cb, tmout)
            end
            tevents.make (false) -- reinitialize tevents
        end
---------------------------------

    run is
        -- See header comment of precursor.

        local
            sec, usec : INTEGER_REF

        do
            create sec
            create usec
            get_sleeptime (sec, usec)
            debug ("select")
                get_vecs_from_select_sets
            end
            if ext_select (select_data, sec.item, usec.item) then
                handle_fevents
            end
            if tevents.count > 0 then
                handle_tevents
            end
            debug ("select")
                get_vecs_from_select_sets
            end
        end
---------------------------------

    run_forever is
        -- See header comment of precursor.

        do
            from
            until
                false
            loop
                run
            end
        end
---------------------------------

    idle : BOOLEAN is
        -- See header comment of precursor.

        do
            result := true

            if fevents.count > 0 then
                if ext_select (select_data, 0, 0) then
                    debug ("select")
                        get_vecs_from_select_sets
                    end
                    result := false
                end
            end

            if result and then tevents.count > 0 then
                update_tevents
                result := tevents.at (1).get_delta <= 0
                -- XXX Here the MICO code says in effect
                -- result := tevents.at (1).get_delta > 0
                -- To me that looks wrong ...
                -- Reading MICO's function sleeptime I get
                -- the impression that tevent.at (1).get_delta > 0
                -- means there's a time event in the pipeline.
            end
        end
---------------------------------
feature { NONE } -- Implementation

    fevents : INDEXED_LIST [FILE_EVENT]
        -- List of all "file events" to watch for.
        -- "File event" typically means "socket event".
    tevents : INDEXED_LIST [TIMER_EVENT]
        -- List of all timer events to watch for.
    last_update : INTEGER
        -- Used by `update_tevents' to compute next timeout.
    locked : INTEGER
        -- Number of calls to `lock' for which there
        -- was as yet no matching `unlock'.
    modified : BOOLEAN
        -- Set by 'update_fevents', reset by `lock'
        -- and queried by `unlock'.
    init : BOOLEAN
        -- Are we in the initialization phase?
    select_data : POINTER
        -- Pointer to C data structure used by the system
        -- call `select'.
    rvec : ARRAY [INTEGER]
        -- To facilitate debugging
    wvec : ARRAY [INTEGER]
        -- To facilitate debugging
    xvec : ARRAY [INTEGER]
        -- To facilitate debugging
    curr_rvec : ARRAY [INTEGER]
        -- To facilitate debugging
    curr_wvec : ARRAY [INTEGER]
        -- To facilitate debugging
    curr_xvec : ARRAY [INTEGER]
        -- To facilitate debugging
----------------------

    get_vecs_from_select_sets is

        local
            p  : POINTER
            st : STRING

        do
            p := ext_get_rset (select_data)
            st := ""
            st.from_c (p)
            create rvec.make (1,0)
            set_to_vec (st, rvec)

            p := ext_get_wset (select_data)
            st := ""
            st.from_c (p)
            create wvec.make (1,0)
            set_to_vec (st, wvec)

            p := ext_get_xset (select_data)
            st := ""
            st.from_c (p)
            create xvec.make (1,0)
            set_to_vec (st, xvec)

            p := ext_get_curr_rset (select_data)
            st := ""
            st.from_c (p)
            create curr_rvec.make (1,0)
            set_to_vec (st, curr_rvec)

            p := ext_get_curr_wset (select_data)
            st := ""
            st.from_c (p)
            create curr_wvec.make (1,0)
            set_to_vec (st, curr_wvec)

            p := ext_get_curr_xset (select_data)
            st := ""
            st.from_c (p)
            create curr_xvec.make (1,0)
            set_to_vec (st, curr_xvec)
        end
----------------------

    set_to_vec (set : STRING; vec : ARRAY [INTEGER]) is

        local
            i, n : INTEGER
            j    : INTEGER

        do
            from
                i := 1
                n := set.count
            until
                i > n
            loop
                if set.item (i) = '1' then
                    j := j + 1
                end
                i := i + 1
            end

            if j > 0 then
                vec.resize (1, j)
            end

            from
                i := 1
                n := set.count
                j := 1
            until
                i > n
            loop
                if set.item (i) = '1' then
                    vec.put (i - 1, j)
                    j := j + 1
                end
                i := i + 1
            end
        end
----------------------

    lock is

        do
            check
                nonnegative : locked >= 0
            end
            if locked <= 0 then
                modified := false
            end
            locked := locked + 1
        end
----------------------

    unlock is

        local
            i, n : INTEGER
            fe   : FILE_EVENT

        do
            locked := locked - 1
            if locked <= 0 then
                check
                    nonnegative : locked = 0
                end
                if modified then
                    from
                        i := 1
                        n := fevents.count
                    until
                        i > n
                    loop
                        fe := fevents.at (i)
                        if fe.get_deleted then
                            fevents.remove_at (i)
                            n := n - 1
                        else
                            i := i + 1
                        end
                    end
                end
            end
        end
----------------------

    islocked : BOOLEAN is

        do
            result := (locked > 0)
        end
----------------------

    update_tevents is

        local
            curr  : INTEGER
            delta : INTEGER

        do
            curr := get_time

            if init or else tevents.empty or else (curr < last_update) then
                init := false
            else
                delta := tevents.at (1).get_delta
                tevents.at (1).set_delta (delta - curr + last_update)
            end
            last_update := curr
        end
----------------------

    handle_tevents is

        local
            t : TIMER_EVENT
            d : INTEGER

        do
            from
                update_tevents
            until
                tevents.empty or else tevents.at (1).get_delta > 0
            loop
                t := tevents.at (1)
                tevents.remove_at (1)
                if not tevents.empty then
                    d := tevents.at (1).get_delta
                    tevents.at (1).set_delta (d + t.get_delta)
                end
                t.get_cb.callback_d (current, t.get_event)
                update_tevents
            end
        end
----------------------

    update_fevents is

        local
            i, n : INTEGER
            fe   : FILE_EVENT

        do
            modified := true

            from
                ext_zero_fdsets (select_data)
                debug ("select")
                    get_vecs_from_select_sets
                end
                i := 1
                n := fevents.count
            until
                i > n
            loop
                fe := fevents.at (i)
                i := i + 1
                if not fe.get_deleted then
                    inspect (fe.get_event)

                    when Read_ev then
                        ext_add_to_rset (select_data, fe.get_fd)

                    when Write_ev then
                        ext_add_to_wset (select_data, fe.get_fd)

                    when Except_ev then
                        ext_add_to_xset (select_data, fe.get_fd)

                    end
                end
            end
            debug ("select")
                get_vecs_from_select_sets
            end
        end
----------------------

    handle_fevents is

        local
            i, n : INTEGER
            fe   : FILE_EVENT

        do
            logger.trace_enter ("SELECT_DISPATCHER", "handle_fevents")
            lock -- Avoid race conditions.
            from
                i := 1
                n := fevents.count
            until
                i > n
            loop
                fe := fevents.at (i)
                i  := i + 1
                if not fe.get_deleted then
                    inspect (fe.get_event)

                    when Read_ev then
                        if ext_is_set_in_rset (select_data, fe.get_fd) then
                            fe.get_cb.callback_d (current, Read_ev)
                        end

                    when Write_ev then
                        if ext_is_set_in_wset (select_data, fe.get_fd) then
                            fe.get_cb.callback_d (current, Write_ev)
                        end

                    when Except_ev then
                        if ext_is_set_in_xset (select_data, fe.get_fd) then
                            fe.get_cb.callback_d (current, Except_ev)
                        end

                    end -- inspect
                end -- if not fe.get_deleted then ...
            end
            unlock
            logger.trace_leave ("SELECT_DISPATCHER", "handle_fevents")
        end
----------------------

    get_sleeptime (sec, usec : INTEGER_REF) is

        require
            nonvoid_args : sec /= void and then usec /= void

        local
            t : INTEGER

        do
            if tevents.empty or else tevents.at (1).get_delta <= 0 then
                t := 10000
            else
                t := tevents.at (1).get_delta
            end
            sec.set_item (t // 1000)
            usec.set_item ((t \\ 1000) * 1000)
        end
----------------------

    get_time : INTEGER is

        external "C"
        alias "MICO_get_time"

        end
----------------------

    ext_create : POINTER is

        external "C"
        alias "MICO_create_select_dispatcher"

        end
----------------------

    ext_zero_fdsets (sp : POINTER) is

        external "C"
        alias "MICO_zero_fdsets"

        end
----------------------

    ext_add_to_rset (sp : POINTER; fd : INTEGER) is

        external "C"
        alias "MICO_add_to_rset"

        end
----------------------

    ext_add_to_wset (sp : POINTER; fd : INTEGER) is

        external "C"
        alias "MICO_add_to_wset"

        end
----------------------

    ext_add_to_xset (sp : POINTER; fd : INTEGER) is

        external "C"
        alias "MICO_add_to_xset"

        end
----------------------

    ext_is_set_in_rset (sp : POINTER; fd : INTEGER) : BOOLEAN is

        external "C"
        alias "MICO_is_set_in_rset"

        end
----------------------

    ext_is_set_in_wset (sp : POINTER; fd : INTEGER) : BOOLEAN is

        external "C"
        alias "MICO_is_set_in_wset"

        end
----------------------

    ext_is_set_in_xset (sp : POINTER; fd : INTEGER) : BOOLEAN is

        external "C"
        alias "MICO_is_set_in_xset"

        end
----------------------

    ext_select (sp : POINTER; sec, usec : INTEGER) : BOOLEAN is

        external "C"
        alias "MICO_select"

        end
----------------------

    ext_get_rset (sp : POINTER) : POINTER is

        external "C"
        alias "MICO_get_rset"

        end
----------------------

    ext_get_wset (sp : POINTER) : POINTER is

        external "C"
        alias "MICO_get_wset"

        end
----------------------

    ext_get_xset (sp : POINTER) : POINTER is

        external "C"
        alias "MICO_get_xset"

        end
----------------------

    ext_get_curr_rset (sp : POINTER) : POINTER is

        external "C"
        alias "MICO_get_curr_rset"

        end
----------------------

    ext_get_curr_wset (sp : POINTER) : POINTER is

        external "C"
        alias "MICO_get_curr_wset"

        end
----------------------

    ext_get_curr_xset (sp : POINTER) : POINTER is

        external "C"
        alias "MICO_get_curr_xset"

        end
----------------------

    ext_string_from_fdset (sp : POINTER) : POINTER is

        external "C"
        alias "MICO_string_from_fdset"

        end

end -- class SELECT_DISPATCHER

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
