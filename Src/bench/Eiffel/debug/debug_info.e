
class DEBUG_INFO

inherit

	SHARED_WORKBENCH

creation

	make

feature

	make is
			-- Initialize Current.
		do
			make_debuggables;
			make_breakpoints;
			!! debugged_routines.make;
			!! removed_routines.make
		end;

	Once_request: ONCE_REQUEST is
			-- Facilities to inspect whether a once routine
			-- has already been called
		once
			!! Result.make
		end;

	wipe_out is
			-- Empty Current.
		do
			clear_debuggables;
			clear_breakpoints;
			debugged_routines.wipe_out;
			removed_routines.wipe_out;
				-- Reset the supermelted body_ids counters.
			System.reset_debug_counter
		end;

	restore is
			-- Restore all the data structures marked
			-- as sent.
		do
			restore_debuggables;
			restore_breakpoints;
		end;

	tenure is
			-- Transfer all the structures sent to the application
			-- into the appropriate data structures so that they
			-- can be restored later, namely when the application
			-- is being run again after having terminated.
		do
			tenure_debuggables;
			tenure_breakpoints;
		end;

feature -- Debuggables (Byte code,...)

	debugged_routines: LINKED_LIST [FEATURE_I];
			-- Routines that are currently debugged

	removed_routines: LINKED_LIST [FEATURE_I];
			-- Routines that are not currently debugged

	new_debuggables: EXTEND_TABLE [LINKED_LIST [DEBUGGABLE], INTEGER];
			-- Debuggable structures not 
			-- sent to the application yet

	sent_debuggables: EXTEND_TABLE [LINKED_LIST [DEBUGGABLE], INTEGER];
			-- Debuggable structures already 
			-- sent to the application

	once_debuggables: EXTEND_TABLE [LINKED_LIST [DEBUGGABLE], INTEGER];
			-- Debuggable structures of once routines which have already
			-- been called. In That case, the supermelted byte code
			-- won't be sent to the application until next execution
			-- to prevent any overriding of once's memory (i.e. already
			-- called and result value if any)

	new_once_debuggables: EXTEND_TABLE [LINKED_LIST [DEBUGGABLE], INTEGER];
			-- Debuggable structures of once routines which have already
			-- been called, but were not recorded in `once_debuggables' last
			-- time we sent information to the application
			--| This table is useful to figure out the number of new melted
			--| routines, an dbe able to reallocate the corresponding
			--| data structures once and for all.
			--| The structures held in this table are also held in
			--| `once_debuggables', and this table must be cleared each
			--| information are sent to the application.

	make_debuggables is
		do
			!! new_debuggables.make (10);
			!! sent_debuggables.make (10);
			!! once_debuggables.make (10);
			!! new_once_debuggables.make (10)
		end;

	tenure_debuggables is
			-- Tenure debuggables. See comment
			-- of feature `tenure'.
		do
			sent_debuggables.merge (new_debuggables);
			new_debuggables.clear_all;
				-- Get rid of the new once routines already called.
				-- These routines were already stored in `new_debuggables'.
			new_once_debuggables.clear_all
		end; -- tenure_debuggables

	restore_debuggables is
			-- Restore debuggables. See comment
			-- of feature `restore'
		do
			sent_debuggables.merge (new_debuggables);
			new_debuggables := sent_debuggables;
			new_debuggables.merge (once_debuggables);
			!! sent_debuggables.make (10);
			once_debuggables.clear_all;
			new_once_debuggables.clear_all
		end; -- restore_debuggables

	clear_debuggables is
			-- Clear debuggable structures.
		do
			sent_debuggables.clear_all;
			new_debuggables.clear_all;
			once_debuggables.clear_all;
			new_once_debuggables.clear_all
		end; -- clear_debuggables

	add_feature (f: FEATURE_I) is
			-- Generate debuggable byte code corresponding to
			-- `feature_i' and record the corresponding information.
			-- Do nothing if `f' has previously been added.
		local
			f_debuggables: LINKED_LIST [DEBUGGABLE]
		do
			if not has_feature (f) then
				if f.is_once and then Once_request.already_called (f) then
					f_debuggables := f.debuggables;
					once_debuggables.put (f_debuggables, f.body_id);
					new_once_debuggables.put (f_debuggables, f.body_id)
				else
					new_debuggables.put (f.debuggables, f.body_id)
				end;
				debugged_routines.extend (f)
			end
		end; -- add_feature

	switch_feature (f: FEATURE_I) is
			-- Switch `f' from debugged to removed or from removed to debugged.
		require
			has_feature (f)
		do
			if debugged_routines.has (f) then
				debugged_routines.start;
				debugged_routines.prune (f);
				removed_routines.extend (f);
			else
				removed_routines.start;
				removed_routines.prune (f);
				debugged_routines.extend (f)
			end
		end;

	debuggable_count: INTEGER is
			-- Number of new byte arrays since last transfer
			-- between workbench and application 
		do
			from
				new_debuggables.start
			until
				new_debuggables.after
			loop
				Result := Result + new_debuggables.item_for_iteration.count;
				new_debuggables.forth
			end
		end; -- debuggable_count

	new_extension: INTEGER is
			-- Number of new byte arrays since last transfer
			-- between workbench and application corresponding
			-- to features which were initially frozen
			--|This information is usefull for the debugged
			--|application in order to reallocate memory
			--|for the melted table once and for all before
			--|the actual transfer of debuggable byte code
			--|occurs
		local
			ll: LINKED_LIST [DEBUGGABLE]
		do
			from
				new_debuggables.start
			until
				new_debuggables.after
			loop
				ll := new_debuggables.item_for_iteration;	
				from
					ll.start
				until
					ll.after
				loop
					if ll.item.was_frozen then
						Result := Result + 1;
					end;
					ll.forth
				end;
				new_debuggables.forth
			end;
				-- We have to make room for once routines in the melt
				-- table, even if we do not send the corresponding
				-- byte code (the body id is used anyway, shifting the
				-- other body ids).
			from
				new_once_debuggables.start
			until
				new_once_debuggables.after
			loop
				ll := new_once_debuggables.item_for_iteration;	
				from
					ll.start
				until
					ll.after
				loop
					if ll.item.was_frozen then
						Result := Result + 1;
					end;
					ll.forth
				end;
				new_once_debuggables.forth
			end
		end;

	has_feature (feature_i: FEATURE_I): BOOLEAN is
			-- Has debuggable byte code already been 
			-- generated for `feature_i'?
		do
			Result := 
				new_debuggables.has (feature_i.body_id) or else 
				once_debuggables.has (feature_i.body_id) or else 
				sent_debuggables.has (feature_i.body_id)
		end; -- has_feature

	debuggables (f: FEATURE_I): LINKED_LIST [DEBUGGABLE] is
			-- List of debuggables corresponding to `feature_i'
		require
			has_feature (f)
		do
			if new_debuggables.has (f.body_id) then
				Result := new_debuggables.item (f.body_id);
			elseif once_debuggables.has (f.body_id) then
				Result := once_debuggables.item (f.body_id)
			else
				Result := sent_debuggables.item (f.body_id);
			end;
		ensure
			Result /= Void
		end; -- debuggables

	breakable_index (f: INTEGER; offset: INTEGER): INTEGER is
		local
			breakables: SORTED_TWO_WAY_LIST [AST_POSITION];
			i: INTEGER;
		do
			if sent_debuggables.has (f) then
				breakables := sent_debuggables.item (f).first.breakable_points;
				from
					breakables.start;
					i := 1	
				until
					Result > 0 or breakables.after
				loop
					if breakables.item.position = offset then
						Result := i
					else
						i := i + 1;
						breakables.forth;
					end
				end
			end;
		end; -- breakable_index

	real_body_id (f: FEATURE_I): INTEGER is
			-- Real body id of `f' at execution time.
			-- This id may have been modified during supermelting.
		require
			f_exists: f /= Void;
			is_debuggable: f.is_debuggable
		do
			if sent_debuggables.has (f.body_id) then
					-- `f' has been supermelted.
				Result := sent_debuggables.item (f.body_id).first.real_body_id
			else
				Result := f.real_body_id
			end
		end;

feature -- Breakpoints

	new_breakpoints: BREAK_LIST;
			-- Breakpoint settings or removals to
			-- be sent to the application

	sent_breakpoints: BREAK_LIST;
			-- Breakpoint settings or removals already
			-- been sent to the application

	make_breakpoints is
			-- Create breakpoints structures.
		do
			!! new_breakpoints.make;
			!! sent_breakpoints.make
		end;

	tenure_breakpoints is
			-- Tenure breakpoints. See comment
			-- of feature `tenure'.		
		do
			sent_breakpoints.append (new_breakpoints);
			new_breakpoints.wipe_out
		end;

	restore_breakpoints is
			-- Restore breakpoints. See comment
			-- of feature `restore'
		do
			clear_breakpoints
		end;
						
	clear_breakpoints is
			-- Clear the breakpoint structures.
		do
			new_breakpoints.wipe_out;
			sent_breakpoints.wipe_out
		end;

	switch_breakpoint (f: FEATURE_I; i: INTEGER) is
			-- Switch the `i'-th breakpoint of `f' ?
		require
			prepared_for_debug: has_feature (f)
		local
			debug_bodies: LINKED_LIST [DEBUGGABLE];
			is_stop: BOOLEAN;
			bp: BREAKPOINT;
			ap: AST_POSITION;
			pos: INTEGER;
			debug_item: DEBUGGABLE
		do
			debug_bodies := debuggables (f);
			from
				debug_bodies.start;
				ap := debug_bodies.item.breakable_points.i_th (i);
				pos := ap.position;
				is_stop := not ap.is_set;
			until
				debug_bodies.after
			loop
				debug_item := debug_bodies.item;
				debug_item.breakable_points.i_th (i).set_stop (is_stop);
				debug_bodies.forth
			end;
			if is_stop and removed_routines.has (f) then
				switch_feature (f)
			end
		end;
			

	is_breakpoint_set (f: FEATURE_I; i: INTEGER): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' set?
		do
			Result := has_feature (f) and then 
						debuggables (f).first.is_breakpoint_set (i)
		end;

	has_breakpoint_set (f: FEATURE_I): BOOLEAN is
			-- Has `f' a breakpoint set to stop?
		do
			Result := has_feature (f) and then 
						debuggables (f).first.has_breakpoint_set
		end;
			
	is_first_breakpoint (i: INTEGER; f: FEATURE_I): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' related to
			-- the entrance of that routine's coumpound?
		require
			f_debuggable: has_feature (f)
		do
			Result := i = 1
		end;

	is_last_breakpoint (i: INTEGER; f: FEATURE_I): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' the last breakable point?
			-- (end of the compound, not of the rescue clause)
		require
			f_debuggable: has_feature (f)
		local
			breakable_points: SORTED_TWO_WAY_LIST [AST_POSITION];
			internal_as: INTERNAL_AS
		do
			breakable_points := debuggables (f).first.breakable_points;
			if i >= 1 and i <= breakable_points.count then
				internal_as ?= breakable_points.i_th (i).ast_node
			end;
			Result := internal_as /= Void
		end;

feature -- Breakpoints setting

	set_all_breakpoints is 
			-- Set all the user-defined breakpoints.
		do
			from
				debugged_routines.start
			until
				debugged_routines.after
			loop
				set_routine_breakpoints (debugged_routines.item);
				debugged_routines.forth
			end
		end;

	set_all_breakables is 
			-- Set all the breakable points of all the debugged routines.
		do
			from
				debugged_routines.start
			until
				debugged_routines.after
			loop
				set_routine_breakables (debugged_routines.item);
				debugged_routines.forth
			end
		end;

	set_out_of_routine_breakables (fi: FEATURE_I) is 
			-- Set all the breakable points of all the debugged routines
			-- execept those of `fi'.
		require
			fi_exists: fi /= Void
		local
			d_list: LINKED_LIST [DEBUGGABLE];
			breakable_points: SORTED_TWO_WAY_LIST [AST_POSITION];
			r_body_id: INTEGER;
			bp: BREAKPOINT
		do
			set_all_breakables;
			if 
				has_feature (fi) and then 
				not once_debuggables.has (fi.body_id) 
			then
					-- If the supermelted byte code of a once routine has 
					-- not been sent to the application (because it had 
					-- already been called at that time) we don't sent its
					-- breakpoints neither.
				from
					d_list := debuggables (fi);
					d_list.start
				until
					d_list.after
				loop
					from
						breakable_points := d_list.item.breakable_points;
						r_body_id := d_list.item.real_body_id;
						breakable_points.start
					until
						breakable_points.after
					loop
						!! bp;
						bp.set_continue;
						bp.set_offset (breakable_points.item.position);
						bp.set_real_body_id	(r_body_id);
						new_breakpoints.extend (bp);
						breakable_points.forth
					end;
					d_list.forth
				end
			end
		end;

	set_routine_breakpoints (fi: FEATURE_I) is
			-- Set the user-defined breakpoints in `fi'.
		require
			fi_exists: fi /= Void;
			has_feature (fi);
		local
			d_list: LINKED_LIST [DEBUGGABLE];
			breakable_points: SORTED_TWO_WAY_LIST [AST_POSITION];
			r_body_id: INTEGER;
			bp: BREAKPOINT
		do
			if not once_debuggables.has (fi.body_id) then
					-- If the supermelted byte code of a once routine has 
					-- not been sent to the application (because it had 
					-- already been called at that time) we don't sent its
					-- breakpoints neither.
				from
					d_list := debuggables (fi);
					d_list.start
				until
					d_list.after
				loop
					breakable_points := d_list.item.breakable_points;
					r_body_id := d_list.item.real_body_id;
					from
						breakable_points.start
					until
						breakable_points.after
					loop
						if breakable_points.item.is_set then
							!! bp;
							bp.set_stop;
							bp.set_offset (breakable_points.item.position);
							bp.set_real_body_id	(r_body_id);
							new_breakpoints.extend (bp);
						end;
						breakable_points.forth
					end;
					d_list.forth
				end
			end
		end;

	set_routine_breakables (fi: FEATURE_I) is
			-- Set all the breakable points of `fi'.
			-- Used for stepping through the routine.
		require
			fi_exists: fi /= Void;
			has_feature (fi)
		local
			d_list: LINKED_LIST [DEBUGGABLE];
			breakable_points: SORTED_TWO_WAY_LIST [AST_POSITION];
			r_body_id: INTEGER;
			bp: BREAKPOINT
		do
			if not once_debuggables.has (fi.body_id) then
					-- If the supermelted byte code of a once routine has 
					-- not been sent to the application (because it had 
					-- already been called at that time) we don't sent its
					-- breakpoints neither.
				from
					d_list := debuggables (fi);
					d_list.start
				until
					d_list.after
				loop
					from
						breakable_points := d_list.item.breakable_points;
						r_body_id := d_list.item.real_body_id;
						breakable_points.start
					until
						breakable_points.after
					loop
						!! bp;
						bp.set_stop;
						bp.set_offset (breakable_points.item.position);
						bp.set_real_body_id	(r_body_id);
						new_breakpoints.extend (bp);
						breakable_points.forth
					end;
					d_list.forth
				end
			end
		end;

	set_routine_last_breakable (fi: FEATURE_I) is
			-- Set the last breakable point of `fi'.
			-- (end of compound, not of rescue clause)
		require
			fi_exists: fi /= Void;
			has_feature (fi)
		local
			d_list: LINKED_LIST [DEBUGGABLE];
			ast_pos: AST_POSITION;
			r_body_id, i: INTEGER;
			bp: BREAKPOINT
		do
			if not once_debuggables.has (fi.body_id) then
					-- If the supermelted byte code of a once routine has 
					-- not been sent to the application (because it had 
					-- already been called at that time) we don't sent its
					-- breakpoints neither.
				d_list := debuggables (fi);
				from
					i := d_list.first.breakable_points.count
				until
					i < 1 or else is_last_breakpoint (i, fi)
				loop
					i := i - 1
				end;
				if i >= 1 then
					from
						d_list.start
					until
						d_list.after
					loop
						r_body_id := d_list.item.real_body_id;
						ast_pos := d_list.item.breakable_points.i_th (i);
						!! bp;
						bp.set_stop;
						bp.set_offset (ast_pos.position);
						bp.set_real_body_id	(r_body_id);
						new_breakpoints.extend (bp);
						d_list.forth
					end
				end
			end
		end;

	remove_all_breakpoints is
			-- Remove all breakpoints which have been set and 
			-- sent to the application.
		local
			bp: BREAKPOINT
		do
			from
				sent_breakpoints.start
			until
				sent_breakpoints.off
			loop
				bp := sent_breakpoints.item_for_iteration;
				if not bp.is_continue then
					bp := clone (bp);
					bp.set_continue;
					new_breakpoints.extend (bp)
				end;
				sent_breakpoints.forth
			end
		end;

feature -- Trace

	trace is
		local
			i: INTEGER;
			dl: EXTEND_TABLE [LINKED_LIST [DEBUGGABLE], INTEGER];
			second_time: BOOLEAN
		do
			io.putstring ("============ DEBUG INFO ===========%N%N");
			io.putstring ("New extension: "); 
			io.putint (new_extension); 
			io.new_line;
			io.putstring ("---> New debuggables%N");
			trace_debuggables (new_debuggables);
			io.putstring ("---> Sent debuggables%N");
			trace_debuggables (sent_debuggables);
		end;

	trace_debuggables (dl: EXTEND_TABLE [LINKED_LIST [DEBUGGABLE], INTEGER]) is
		local
			l: LINKED_LIST [DEBUGGABLE]
		do
			from
				dl.start
			until
				dl.after
			loop
				l := dl.item_for_iteration;
				from
					l.start
				until
					l.after
				loop
					io.putstring (l.item.tagged_out);
					l.forth
				end;
				dl.forth
			end;
		end

end -- class DEBUG_INFO
