
class DEBUG_INFO

creation

	make

feature

	make is
			-- Initialize Current.
		do
			make_debuggables;
			make_breakpoints;
			!! debugged_routines.make;
			!! stepped_routines.make
		end;

	wipe_out is
			-- Empty Current.
		do
			clear_debuggables;
			clear_breakpoints;
			debugged_routines.wipe_out;
			stepped_routines.wipe_out
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

	new_debuggables: EXTEND_TABLE [LINKED_LIST [DEBUGGABLE], INTEGER];
			-- Debuggable structures not 
			-- sent to the application yet

	sent_debuggables: EXTEND_TABLE [LINKED_LIST [DEBUGGABLE], INTEGER];
			-- Debuggable structures already 
			-- sent to the application

	make_debuggables is
		do
			!! new_debuggables.make (10);
			!! sent_debuggables.make (10)
		end;

	tenure_debuggables is
			-- Tenure debuggables. See comment
			-- of feature `tenure'.
		do
			sent_debuggables.merge (new_debuggables);
			new_debuggables.clear_all;
		end; -- tenure_debuggables

	restore_debuggables is
			-- Restore debuggables. See comment
			-- of feature `restore'
		do
			sent_debuggables.merge (new_debuggables);
			new_debuggables := sent_debuggables;
			!! sent_debuggables.make (10)
		end; -- restore_debuggables

	clear_debuggables is
			-- Clear debuggable structures.
		do
			sent_debuggables.clear_all;
			new_debuggables.clear_all
		end; -- clear_debuggables

	add_feature (f: FEATURE_I) is
			-- Generate debuggable byte code corresponding to
			-- `feature_i' and record the corresponding information.
			-- Do nothing if `f' has previously been added.
		do
			if not has_feature (f) then
				new_debuggables.put (f.debuggables, f.body_id);
				debugged_routines.add (f)
			end
		end; -- add_feature

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
				new_debuggables.offright
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
		end; -- new_extension

	has_feature (feature_i: FEATURE_I): BOOLEAN is
			-- Has debuggable byte code already been 
			-- generated for `feature_i'?
		do
			Result := 
				new_debuggables.has (feature_i.body_id) or else 
				sent_debuggables.has (feature_i.body_id)
		end; -- has_feature

	debuggables (f: FEATURE_I): LINKED_LIST [DEBUGGABLE] is
			-- List of debuggables corresponding to `feature_i'
		require
			has_feature (f)
		do
			if new_debuggables.has (f.body_id) then
				Result := new_debuggables.item (f.body_id);
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

feature -- Breakpoints

	new_breakpoints: BREAK_LIST;
			-- Breakpoint settings or removals to
			-- be sent to the application

	sent_breakpoints: BREAK_LIST;
			-- Breakpoint settings or removals already
			-- be sent to the application

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
--		local
--			debug_bodies: LINKED_LIST [DEBUGGABLE];
--			breakables: SORTED_TWO_WAY_LIST [AST_POSITION];
--			body_id: INTEGER;
--			bp: BREAKPOINT
		do
			new_breakpoints.append (sent_breakpoints);
			sent_breakpoints.wipe_out;
			from
			until
				stepped_routines.empty
			loop
				remove_step_breakpoints;
				stepped_routines.remove
			end

--			!! new_breakpoints.wipe_out;
--			from
--				new_debuggables.start
--			until
--				new_debuggables.offright
--			loop
--				from	
--					debug_bodies := new_debuggables.item_for_iteration;
--					debug_bodies.start
--				until
--					debug_bodies.after
--				loop
--					from 
--						breakables := debug_bodies.item.breakable_points;
--						body_id := debug_bodies.item.real_body_id;
--						breakables.start;
--					until
--						breakables.after
--					loop
--						!!bp;
--						if breakables.item.is_set then
--							bp.set_stop;
--						else
--							bp.set_continue
--						end;
--						bp.set_offset (breakables.item.position);
--						bp.set_real_body_id (body_id);
--						new_breakpoints.extend (bp);
--						breakables.forth
--					end;
--					debug_bodies.forth
--				end;
--				new_debuggables.forth
--			end
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
				!!bp;
				bp.set_offset (pos);
				bp.set_real_body_id	(debug_item.real_body_id);
				if is_stop then
					bp.set_stop
				else
					bp.set_continue
				end;
				new_breakpoints.extend (bp);
				debug_bodies.forth;
			end;	
			is_last_breakpoint_set := is_stop
		end; -- switch_breakpoint
			
		
	is_last_breakpoint_set: BOOLEAN;	
		-- Did last `switch_breakpoint' set a breakpoint to stop ?

	is_breakpoint_set (f: FEATURE_I; i: INTEGER): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' set ?
		do
			Result := has_feature (f) and then debuggables (f).first.is_breakpoint_set (i)
		end; -- is_breakpoint_set

	has_breakpoint_set (f: FEATURE_I): BOOLEAN is
			-- Has `f' a breakpoint set to stop ?
		do
			Result := has_feature (f) and then debuggables (f).first.has_breakpoint_set
		end; -- has_breakpoint_set
			

feature -- Step by step debugging

	
	stepped_routines: LINKED_STACK [FEATURE_I];
			-- Routines that are currently step-by-step debugged

	add_stepped_routine (f: FEATURE_I; i: INTEGER) is
			-- Make `f', whose execution is stopped on the `i'-th
			-- breakpoint, the next routine to be debugged step-by-step.
		require
			f_exists: f /= Void
		local
			retry_as: RETRY_AS
		do
			add_feature (f);
			if stepped_routines.empty then 
					-- No other routines currently in step-by-step 
					-- debugging process.
				stepped_routines.add (f)
			elseif stepped_routines.item.body_id /= f.body_id then				
					-- We just stop in a routine which was not
					-- step-by-step debugged the step before.
				stepped_routines.add (f)
			elseif is_first_breakpoint (i, f) then   
					-- We just renter in the routine we were debugging
					-- step-by-step (Recursive call).
				stepped_routines.add (f)
			-- else
					-- We are already debugging `f' step-by-step.
			end;
			if is_last_breakpoint (i, f) then 
					-- We reached the end of `f' compound so that
					-- there are no steps for `f' any more.
				stepped_routines.remove
			end;
			if 
				i >= 1 and i <= debuggables (f).first.breakable_points.count
			then
				retry_as ?= debuggables (f).first.breakable_points.i_th (i).ast_node
			end;
			last_step_retry := retry_as /= Void
		end;

	remove_stepped_routine is
			-- Remove from `stepped_routines' the last routine 
			-- debugged step-by-step if any.
		do
			if not stepped_routines.empty then
				stepped_routines.remove
			end
		end;

	add_step_breakpoints is
			-- Mark all the breakable points of the next routine to 
			-- be step-by-step debugged to be sure to stop on the 
			-- next breakpoint.
		local
			d_list: LINKED_LIST [DEBUGGABLE];
			breakable_points: SORTED_TWO_WAY_LIST [AST_POSITION];
			real_body_id: INTEGER;
			bp: BREAKPOINT
		do
			if not stepped_routines.empty then
				d_list := debuggables (stepped_routines.item);
				from
					d_list.start
				until
					d_list.after
				loop
					from
						breakable_points := d_list.item.breakable_points;
						real_body_id := d_list.item.real_body_id;
						breakable_points.start
					until
						breakable_points.after
					loop
						!! bp;
						bp.set_stop;
						bp.set_offset (breakable_points.item.position);
						bp.set_real_body_id	(real_body_id);
						new_breakpoints.extend (bp);
						breakable_points.forth
					end;
					d_list.forth
				end
			end
		end;
	
	remove_step_breakpoints is
			-- Remove the breakpoints of ithe last step-by-step 
			-- debugged routine which were set by `add_step_breakpoints'
			-- and leave those set by the user.
		local
			breakable_points: SORTED_TWO_WAY_LIST [AST_POSITION];
			d_list: LINKED_LIST [DEBUGGABLE];
			real_body_id: INTEGER;
			bp: BREAKPOINT
		do
			if not stepped_routines.empty then
				d_list := debuggables (stepped_routines.item);
				from
					d_list.start
				until
					d_list.after
				loop
					from
						breakable_points := d_list.item.breakable_points;
						real_body_id := d_list.item.real_body_id;
						breakable_points.start
					until
						breakable_points.after
					loop
						!! bp;
						if breakable_points.item.is_set then
							bp.set_stop
						else
							bp.set_continue
						end;
						bp.set_offset (breakable_points.item.position);
						bp.set_real_body_id	(real_body_id);
						new_breakpoints.extend (bp);
						breakable_points.forth
					end;
					d_list.forth
				end
			end
		end;
	
	last_step_retry: BOOLEAN;
			-- Was the last step stopped on a retry instruction?

	is_first_breakpoint (i: INTEGER; f: FEATURE_I): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' related to
			-- the entrance of that routine's coumpound?
			-- (A retry intruction is not considered as an entrance)
		require
			f_debuggable: has_feature (f)
		do
			Result := i = 1 and not last_step_retry
		end;

	is_last_breakpoint (i: INTEGER; f: FEATURE_I): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' the last breakable point?
			-- (either the end of the compound or of the rescue clause)
		require
			f_debuggable: has_feature (f)
		local
			internal_as: INTERNAL_AS
		do
			if i = debuggables (f).first.breakable_points.count then
				Result := True
			else
				if 
					i >= 1 and i <= debuggables (f).first.breakable_points.count
				then
					internal_as ?= debuggables (f).first.breakable_points.i_th (i).ast_node;
				end;
				Result := internal_as /= Void
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
				dl.offright
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
