
class DEBUG_INFO

creation

	make

feature

	make is
			-- Initialize Current.
		do
			make_debuggables;
			make_breakpoints;
		end;

	wipe_out is
			-- Empty Current.
		do
			clear_debuggables;
			clear_breakpoints;
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
		end;

	restore_debuggables is
			-- Restore debuggables. See comment
			-- of feature `restore'
		do
			sent_debuggables.merge (new_debuggables);
			new_debuggables := sent_debuggables;
			!! sent_debuggables.make (10)
		end;

	clear_debuggables is
			-- Clear debuggable structures.
		do
			sent_debuggables.clear_all;
			new_debuggables.clear_all
		end;

	add_feature (f: FEATURE_I) is
			-- Generate debuggable byte code corresponding to
			-- `feature_i' and record the corresponding information.
			-- Do nothing if `f' has previously been added.
		do
			if not has_feature (f) then
			    new_debuggables.put (f.debuggables, f.feature_id)
			end
		end;

	debuggable_count: INTEGER is
			-- Number of new byte arrays since last transfer
			-- between workbench and application. 
		local
			ll: LINKED_LIST [DEBUGGABLE]
		do
			from
				new_debuggables.start
			until
				new_debuggables.offright
			loop
				ll := new_debuggables.item_for_iteration;	
				Result := Result + ll.count;
				new_debuggables.forth
			end;
		end;

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
		end;

	has_feature (feature_i: FEATURE_I): BOOLEAN is
			-- Has debuggable byte code already been 
			-- generated for `feature_i'?
			--|
		do
			Result := 
				new_debuggables.has (feature_i.feature_id) or else 
				sent_debuggables.has (feature_i.feature_id)
		end;

	debuggables (f: FEATURE_I): LINKED_LIST [DEBUGGABLE] is
			-- List of debuggables corresponding to
			-- `feature_i'
		require
			has_feature (f)
		do
			if new_debuggables.has (f.feature_id) then
				Result := new_debuggables.item (f.feature_id);
			else
				Result := sent_debuggables.item (f.feature_id);
			end;
		ensure
			Result /= Void
		end;

feature -- Breakpoints

--| Note: the managment of breakpoints could be improved.
--|	Currently, a new BREAKPOINT structure is inserted into 
--| the structure `new_breakpoints' whenever the user sets
--| or removes a breakpoint. The consequence is that there
--| could be several BREAKPOINT structures for one given
--| breakable point.
--| The mechanism could be optimized by only having one
--| BREAKPOINT structure for a given breakable point and
--| update its attribute `is_set'. 
--| With that kind of mechanism you would have to be careful
--| when implementing the tenuring mecahism. (For instance:
--| New breakpoint + Remove breakpoint = No breakpoint).
--| With the current mechanism the order in which the BREAKPOINT
--| objects are stored is important.

	new_breakpoints: LINKED_LIST [BREAKPOINT];

	sent_breakpoints: LINKED_LIST [BREAKPOINT];

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
			sent_breakpoints.finish;
			sent_breakpoints.merge_right (new_breakpoints);
			!! new_breakpoints.make
		end;

	restore_breakpoints is
			-- Restore breakpoints. See comment
			-- of feature `restore'.
		do
			sent_breakpoints.finish;
			sent_breakpoints.merge_right (new_breakpoints);
			new_breakpoints := sent_breakpoints;
			!! sent_breakpoints.make
		end;

	clear_breakpoints is
			-- Clear the breakpoint structures.
		do
			!! new_breakpoints.make;
			!! sent_breakpoints.make
		end;

	add_breakpoint (bp: BREAKPOINT) is
			-- Add a breakpoint to be sent
			-- to the application.
		do
			new_breakpoints.add (bp)		
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

end
