class 

	CONCURRENCY 

feature -- Change Daemon's port

	cur_set_daemon_port(port: INTEGER) is
		external
			"C"
		end;

feature -- Local server's port number

	cur_port_of_local_server: INTEGER is
		external
			"C"
		end;

feature -- Change configure table
	-- If user does not call any of the features listed in the section,
	-- Concurrent Eiffel Compiler will automatically dispatch separate
	-- object(s) to the local host, i.e., before user calls any of the  
	-- features listed in the section,  the configure table
	-- contains a default group "Current" which contains an entry for 
	-- the local host with capacity 1.

	cur_clear_configure_table is
		external
			"C"
		end;

	cur_load_configure_file(fname: STRING) is
			-- Load the information in the configure file into configure
			-- table, whose original entries will be erased.
			-- The feature will automatically set the cursor of configure
			-- table to the first available host(whose capacity is greater
			-- than 0).
		require 
			not_void: fname /= Void
		local
			tmp: ANY
		do
			tmp := fname.to_c;
			con_make ($tmp);	
		end;

	cur_add_group (gname: STRING) is
			-- Add a group into configure table(if the group already exists, do nothing). 
			-- Note: the group is appended to the end of the existing group list.
		require 
			not_void: gname /= Void
		local
			tmp: ANY
		do
			tmp := gname.to_c;
			add_group ($tmp);	
		end;

	cur_add_host (gname: STRING; hname: STRING; cap: INTEGER; dir: STRING; exe: STRING) is
			-- Add a host into configure table(If the group does not exist, append it; if the
			-- host exists in the corresponding group, do nothing).
			-- Note: the host is appended to the end of the existing host list associated
			-- with the group.
		require 
			not_void: gname /= Void and dir /= Void and exe /= Void
		local
			tmp1, tmp2, tmp3, tmp4: ANY
		do
			tmp1 := gname.to_c;
			tmp2 := hname.to_c;
			tmp3 := dir.to_c;
			tmp4 := exe.to_c;
			add_host ($tmp1, $tmp2, cap, $tmp3, $tmp4);	
		end;

	cur_goto_group (gname: STRING) is
			-- Reset the cursor of configure table to the first host of the group 
			-- whose capacity is greater than 0.
		require 
			not_void: gname /= Void
		local
			tmp: ANY
		do
			tmp := gname.to_c;
			reset_by_level ($tmp);	
		end;

	cur_goto_host (gname: STRING; hname: STRING) is
			-- Reset the cursor of configure table to the host of the group,
			-- the host's capacity must be greater than 0.
		require 
			not_void: gname /= Void and hname /= Void
		local
			tmp1, tmp2: ANY
		do
			tmp1 := gname.to_c;
			tmp2 := hname.to_c;
			reset_by_host ($tmp1, $tmp2);	
		end;

	cur_change_capacity_of_configure_table_item (gname: STRING; hname: STRING; cap: INTEGER) is
			-- Change the capacity of the host of the group in configure table.
			-- If the group does not exist or the host does not exist in the group,
			-- do nothing.
		require
			not_void: gname /= Void and hname /= Void
		local
			tmp1, tmp2: ANY
		do
			tmp1 := gname.to_c;
			tmp2 := hname.to_c;
			change_capacity_of_host ($tmp1, $tmp2, cap);
		end;
		
	cur_print_configure_table is 
			-- Print the current configure table and the cursor.
		external
			"C"
		alias	
			"print_config"
		end;

feature -- Set options

	cur_set_with_rejection is
			-- make a separate object reject requests from other separate objects 
			-- if it is being accessed by a separate object. This is the default 
			-- option. In the case, deadlock will not (easily) happen.
		external
			"C"
		end;

	cur_unset_with_rejection is
			-- if a separate object is being accessed by another separate object,
			-- it will not reject requests from other separate objects, and just
			-- buffer them for later(when it's freed) processing.
		external
			"C"
		end;

feature -- Change sleeping time

	cur_set_sleeping_time_of_reserve_sep_para (to: INTEGER) is
			-- set the sleeping time when failed to reserve a separate parameter in a 
			-- feature.
			-- The unit of the time is Micro Second(0.0000001 second).
			-- If you want to set back to the system default value, use -1.
		external
			"C"
		end;

	cur_set_sleeping_time_of_precondition (to: INTEGER) is
			-- set the sleeping time when a feature's pre-condition involving separate
			-- feature/attribute call(s) is evaluated to be false.
			-- The unit of the time is Micro Second(0.0000001 second).
			-- If you want to set back to the system default value, use -1.
		external
			"C"
		end;

--feature -- Change the period of explicitly calling GC
--NOT AVAILABLE AT PRESENT.
--	cur_set_gc_period (p: INTEGER) is
--			-- set the period of calling GC so that the abandoned network connection can be 
--			-- released.
--			-- The unit of the time is Micro Second(0.0000001 second).
--			-- If you want to set back to the system default value, use -1.
--		external
--			"C"
--		end;

feature {NONE} -- Implementation

	con_make (f: POINTER) is
		external
			"C"
		end;

	add_group (g: POINTER) is
		external
			"C"
		end;

	add_host (g, h: POINTER; c: INTEGER; d, e: POINTER) is
		external
			"C"
		end;

	reset_by_level (g: POINTER) is
		external
			"C"
		end;

	reset_by_host (g, h: POINTER) is
		external
			"C"
		end;

	change_capacity_of_host (g: POINTER; h: POINTER; c: INTEGER) is
		external
			"C"
		end;

end -- CONCURRENCY
