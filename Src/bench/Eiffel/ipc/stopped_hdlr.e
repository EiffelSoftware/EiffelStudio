class STOPPED_HDLR

inherit

	RQST_HANDLER;
	SHARED_DEBUG;
	SHARED_WORKBENCH;
	BASIC_ROUTINES;
	WINDOWS

creation
	
	make

feature

	make is
			-- Create Current and pass addresses to C
		do
			request_type := Rep_stopped;
			pass_addresses
		end;

	execute is
			-- Register that the application is stopped
			-- and parse ths string passed from C.
			-- The format of the passed string is:
			--    feature name
			--    object address
			--    origin of feature
			--    type of object
			--    offset in byte code
			--    reason for stopping
			--    exception code (undefined if irrelevant)
			--    assertion tag (undefined if irrelevant)
		local
			name: STRING;
			org_type: INTEGER;
			dyn_type: INTEGER;
			offset: INTEGER;
			address: STRING;
			reason: INTEGER
		do

			position := 1;

				--| Seems useless
			run_info.set_is_stopped (true);

				-- Read feature name.
			read_string;
			name := last_string;

				-- Read object address.
			read_string;
			address := last_string;

				-- Read origin of feature
			read_int;
			org_type := last_int + 1;

				-- Read type of current object.
				--| Note: the type id on the C side must be 
				--| incremented by one.
			read_int;
			dyn_type := last_int + 1;

				-- Read offset in byte code.
			read_int;
			offset := last_int;

				-- Read reason for stopping.
			read_int;
			reason := last_int;

				-- Read exception code.
			read_int;

				-- Read asertion tag.
			read_string;

			run_info.set_exception (last_int, last_string);
			run_info.set (name, address, org_type, dyn_type, offset, reason);

			--if (reason /= Pg_viol) then
			
				run_info.dump_stack;
		--	end;

			show_stopped_mark;
			display_status;
		end;

feature {} -- parsing features

	position: INTEGER;
			-- Position in parsed string

	last_string: STRING;
			-- Last parsed string token

	last_int: INTEGER;
			-- Last parsed integer token

	read_string is
			-- Parse string token.
		require
			-- position < detail.count and
			-- detail.substring (position, count).has ('%U')	
		local
			i: INTEGER;
		do
			i := index_of ('%U', position);
			if i = 0 then i := detail.count + 1 end;
			if i <= position then
				last_string := ""
			else
				last_string := detail.substring (position, i - 1);
			end;
			position := i + 1;
		end;

	index_of (c: CHARACTER; pos: INTEGER): INTEGER is
			-- position of first occurence of c
			-- after pos (included). 0 if none
			--| should be in string
		local
			i: INTEGER	
		do
			from
				i := pos
			until
				i > detail.count or Result > 0
			loop
				if detail.item (i) = c then
					Result := i
				else
					i := i + 1
				end
			end
		end;

	read_int is
			-- Parse integer token.
		do
			read_string;
			last_int := last_string.to_integer;
		end;

feature -- Display

	show_stopped_mark is
			-- Show where the execution has stopped in the routine tools
			-- containing the related routine and set with the `show_breakpoints'
			-- format.
		local
			 rout_wnds: LINKED_LIST [ROUTINE_W];
			 rout_text: ROUTINE_TEXT
		do
			from
				rout_wnds := window_manager.routine_win_mgr.active_editors;
				rout_wnds.start
			until
				rout_wnds.after
			loop
				rout_text := rout_wnds.item.text_window;
				if
					rout_text.root_stone.feature_i.body_id = Run_info.feature_i.body_id
					and rout_text.in_debug_format
				then
					rout_text.redisplay_breakable_mark (Run_info.break_index, True)
				end;
				rout_wnds.forth
			end
		end; -- show_stopped_mark

	display_status is
		local
			c, oc: CLASS_C;
			tout_request: TOUT_REQUEST;
			os: OBJECT_STONE;
			temp: STRING;
			ll: LINKED_LIST [STRING];
			fi, ofi: FEATURE_I;
			rid: INTEGER;
			ft: FEATURE_TABLE
		do
			debug_window.clear_window;

				-- Print object address.
			debug_window.put_string ("Stopped in object [");
				!! os.make (Run_info.object_address);
			temp := "0x";
			temp.append (Run_info.object_address);
			debug_window.put_clickable_string (os, temp);
			debug_window.put_string ("]%N");

				-- Print class name.
			debug_window.put_string ("%TClass: ");
			c := Run_info.class_type.associated_class;
			c.append_clickable_name (debug_window);
			debug_window.put_string ("%N");

				-- Print routine name.
			debug_window.put_string ("%TFeature: ");
			if Run_info.feature_i /= Void then
				oc :=  Run_info.origin_type.associated_class;
				if oc /= c then	
					ofi := Run_info.feature_i;
					rid := ofi.rout_id_set.first;
					if rid < 0 then
						rid := - rid
					end;
					ft := c.feature_table;
					fi := ft.origin_table.item (rid);

					if fi /= Void then
						fi.append_clickable_name (debug_window, c);
					else
						debug_window.put_string ("Void")
					end;
					debug_window.put_string (" (");
					if ofi /= Void then
						ofi.append_clickable_name (debug_window, oc);
					else
						debug_window.put_string ("Void")
					end;
					debug_window.put_string (" from ");
					if oc /= Void then
						oc.append_clickable_name (debug_window);
					else
						debug_window.put_string ("Void")
					end;
					debug_window.put_string (")");
				else
					Run_info.feature_i.append_clickable_name (debug_window, c);
				end;
			else
				debug_window.put_string ("Void");
			end;
			debug_window.put_string ("%N");

				-- Print the reason for stopping.
			debug_window.put_string ("%TReason: ");
			inspect Run_info.reason
			when Pg_break then
				debug_window.put_string ("Stop point reached%N")
			when Pg_raise then
				debug_window.put_string ("Explicit exception pending%N");
				display_exception
			when Pg_viol then
				debug_window.put_string ("Implicit exception pending%N");
				display_exception
			else
				debug_window.put_string ("Unknown%N");
			end;	

				-- If we stopped on a breakpoint, display 
				-- the arguments and the calling stack.
			--if (Run_info.reason /= Pg_viol) then
				if not Run_info.where.empty then
					Run_info.where.first.display_arguments;				
					Run_info.where.first.display_locals;				
					debug_window.put_string ("%NCall stack:%N%N");
					debug_window.put_string 
						("Object        Class             Routine%N");
					debug_window.put_string 
						("------        -----             -------%N");
					from
						Run_info.where.start
					until
						Run_info.where.after
					loop
						Run_info.where.item.display_feature;
						debug_window.new_line;
						Run_info.where.forth
					end;
					debug_window.new_line;
				end;
			--end;

			debug_window.display;
		end;

	display_exception is
		local
			e: EXCEPT
		do
			debug_window.put_string ("%T%TCode: ");
			debug_window.put_int (Run_info.exception_code);
			debug_window.put_string (" (");
				!!e;
				debug_window.put_string (e.exception_string (Run_info.exception_code));
			debug_window.put_string (")%N%T%TTag: ");
			debug_window.put_string (Run_info.execption_tag);
			debug_window.new_line
		end;

end
