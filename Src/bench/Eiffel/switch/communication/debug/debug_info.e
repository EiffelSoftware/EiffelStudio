class DEBUG_INFO

inherit
	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

creation {APPLICATION_EXECUTION}
	make

feature {NONE} -- Initialization

	make is
			-- Initialize Current.
		do
			create breakpoints.make
		end

feature -- global

	wipe_out is
			-- Empty Current.
		do
				-- re-create an empty list
			create breakpoints.make
		end

	save (raw_filename: FILE_NAME) is
			-- Save debug information (so far, only the breakpoints)
			-- into the file `raw_filename'.
		require
			valid_filename: raw_filename /= Void and then not raw_filename.is_empty
		local
			raw_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
					-- Reset information about the application
					-- contained in the breakpoints.
				restore
				
				from
					breakpoints.start
				until
					breakpoints.after
				loop
						-- Compact the conditions.
					breakpoints.item_for_iteration.prepare_for_save
					breakpoints.forth
				end

					-- save all breakpoints
				create raw_file.make (raw_filename)
				raw_file.open_write
				raw_file.independent_store (breakpoints)
				raw_file.close

				from
					breakpoints.start
				until
					breakpoints.after
				loop
						-- Restore the conditions.
					breakpoints.item_for_iteration.reload
					breakpoints.forth
				end
			end
		rescue
			retried := True
			retry
		end

	load (raw_filename: FILE_NAME) is
			-- Load debug information (so far, only the breakpoints)
			-- from the file `raw_filename'.
		require
			valid_filename: raw_filename /= Void and then not raw_filename.is_empty
		local
			raw_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create raw_file.make(raw_filename)
				if raw_file.exists and then raw_file.is_readable then
					raw_file.open_read
					breakpoints ?= raw_file.retrieved
					raw_file.close
				end
			
				if breakpoints /= Void then
						-- Reset information about the application
						-- contained in the breakpoints (if any).
					restore

					from
						breakpoints.start
					until
						breakpoints.after
					loop
							-- Restore the conditions.
						breakpoints.item_for_iteration.reload
						breakpoints.forth
					end
				end
			end
			if breakpoints = Void then
				create breakpoints.make
			end
		rescue
			breakpoints := Void
			retried := True
			retry
		end

	restore is
			-- reset information about breakpoints set/removed during execution
		do
				-- loop on the entire list, and reset the application status of the breakpoint
			from
				breakpoints.start
			until
				breakpoints.after
			loop
				breakpoints.item_for_iteration.set_application_not_set
				breakpoints.forth
			end

			update
		end
	
	update is
			-- remove breakpoint that no more usefull from the hash_table
			-- see BREAKPOINT/is_usefull for further comments
		local
			bp: BREAKPOINT
		do
				-- remove useless breakpoints
			from
				breakpoints.start
			until
				breakpoints.after
			loop
				bp := breakpoints.item_for_iteration
				if bp.is_not_usefull or bp.is_corrupted then
					breakpoints.remove(bp)
					breakpoints.start
				else
					breakpoints.forth
				end
			end
		end
		
	has_breakpoints: BOOLEAN is
			-- Does the program have a breakpoint (enabled or disabled) ?
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False

				-- look for the first breakpoint set and enabled
			from
				breakpoints.start
			until
				breakpoints.after or Result
			loop
				bp := breakpoints.item_for_iteration
				Result := bp.is_set and bp.is_valid
				breakpoints.forth
			end
		end
	
	has_enabled_breakpoints: BOOLEAN is
			-- Does the program have a breakpoint set?
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False
				-- look for the first breakpoint set and enabled
			from
				breakpoints.start
			until
				breakpoints.after or Result
			loop
				bp := breakpoints.item_for_iteration
				Result := bp.is_enabled and bp.is_valid
				breakpoints.forth
			end
		end
	
	has_disabled_breakpoints: BOOLEAN is
			-- Does the program have an enabled breakpoint?
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False
				-- look for the first breakpoint set and disabled
			from
				breakpoints.start
			until
				breakpoints.after or Result
			loop
				bp := breakpoints.item_for_iteration
				Result := bp.is_disabled and bp.is_valid
				breakpoints.forth
			end
		end

	error_in_bkpts: BOOLEAN
			-- Did the last operation on breakpoints create an error (because a feature was not fully compiled)?

feature -- changing all breakpoints

	remove_all_breakpoints is
			-- Remove all breakpoints which are currently set (enabled/disabled)
		do
			error_in_bkpts := False
			from
				breakpoints.start
			until
				breakpoints.after
			loop
				breakpoints.item_for_iteration.discard
				breakpoints.forth
			end
		end

	enable_all_breakpoints is
			-- disable all breakpoints which are currently set and enabled
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False
			from
				breakpoints.start
			until
				breakpoints.after
			loop
				bp := breakpoints.item_for_iteration
				if bp.is_disabled then
					bp.enable
				end
				breakpoints.forth
			end
		end

	disable_all_breakpoints is
			-- disable all breakpoints which are currently set and enabled
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False
			from
				breakpoints.start
			until
				breakpoints.after
			loop
				bp := breakpoints.item_for_iteration
				if bp.is_enabled then
					bp.disable
				end
				breakpoints.forth
			end
		end

feature -- changing breakpoints for a feature

	add_breakpoints_for_feature (feat: E_FEATURE; a_list: LIST [INTEGER]) is
			-- Add all the breakpoints `a_list' for feature `feat'.
		local
			id: INTEGER
			bp: BREAKPOINT
		do
			error_in_bkpts := False
			from
				a_list.start
			until
				a_list.after
			loop
				id := a_list.item

				-- create breakpoint
				-- by default, at creation the breakpoint is set and enabled
				create bp.make (feat, id)

				-- add the breakpoint. if it was already in the hashtable, we replace
				-- the old version with the new one, and we send it again to the application
				if not bp.is_corrupted then
					breakpoints.add_breakpoint (bp)
				else
					error_in_bkpts := True
				end
				a_list.forth
			end
		end

	remove_breakpoints_in_feature(f: E_FEATURE) is
			-- remove all breakpoints set for feature 'f'
		local
			f_real_body_id: INTEGER
			bp: BREAKPOINT
			retried: BOOLEAN
		do
			error_in_bkpts := False
			if not retried then
				f_real_body_id := f.real_body_id
	
				-- search in the list of all_breakpoints
				-- all breakpoint set for feature 'f'
				from
					breakpoints.start
				until
					breakpoints.after
				loop
					bp := breakpoints.item_for_iteration
					if bp.real_body_id.is_equal(f_real_body_id) and then bp.is_set then
						bp.discard
					end
					breakpoints.forth
				end
			else
				error_in_bkpts := True
			end
		rescue
			retried := True
			retry
		end

	disable_breakpoints_in_feature(f: E_FEATURE) is
			-- disable all breakpoints set for feature 'f'
		local
			f_real_body_id: INTEGER
			bp: BREAKPOINT
			retried: BOOLEAN
		do
			error_in_bkpts := False
			if not retried then
				f_real_body_id := f.real_body_id
	
				-- search in the list of all_breakpoints
				-- all breakpoint set for feature 'f'
				from
					breakpoints.start
				until
					breakpoints.after
				loop
					bp := breakpoints.item_for_iteration
					if bp.real_body_id.is_equal(f_real_body_id) and then bp.is_set then
						bp.disable
					end
					breakpoints.forth
				end
			else
				error_in_bkpts := True
			end
		rescue
			retried := True
			retry
		end

	enable_breakpoints_in_feature(f: E_FEATURE) is
			-- enable all breakpoints set for feature 'f'
		local
			f_real_body_id: INTEGER
			bp: BREAKPOINT
			retried: BOOLEAN
		do
			error_in_bkpts := False
			if not retried then
				f_real_body_id := f.real_body_id
	
				-- search in the list of all_breakpoints
				-- all breakpoint set for feature 'f'
				from
					breakpoints.start
				until
					breakpoints.after
				loop
					bp := breakpoints.item_for_iteration
					if bp.real_body_id.is_equal(f_real_body_id) and then bp.is_set then
						bp.enable
					end
					breakpoints.forth
				end
			else
				error_in_bkpts := True
			end
		rescue
			retried := True
			retry
		end

	enable_first_breakpoint_of_feature(f: E_FEATURE) is
			-- enable the first breakpoints in feature 'f'
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False

			create bp.make (f, 1)
			if not bp.is_corrupted then
				breakpoints.add_breakpoint (bp)
			else
				error_in_bkpts := True
			end
		end

	enable_first_breakpoints_in_class(c: CLASS_C) is
			-- enable all breakpoints set for feature 'f'
		require
			valid_class_c: c /= Void
		local
			wf: LIST [E_FEATURE]
		do
			error_in_bkpts := False

			if c.has_feature_table then
				wf := c.written_in_features
				from
					wf.start
				until
					wf.after
				loop
					if wf.item.is_debuggable then
						enable_first_breakpoint_of_feature (wf.item)
					end
					wf.forth
				end
			else
				error_in_bkpts := True
			end
		end

feature -- getting breakpoints status for a feature

	has_breakpoint_set (f: E_FEATURE): BOOLEAN is
			-- Has `f' a breakpoint set to stop?
		do
			error_in_bkpts := False
			if f.is_debuggable then
				Result := not breakpoints_set_for(f).is_empty
			end
		end

	breakpoints_set_for (f: E_FEATURE): LIST [INTEGER] is
			-- Breakpoints set for feature `f'
		require
			f_is_debuggable: f.is_debuggable
		local
			bp: BREAKPOINT
			f_real_body_id: INTEGER
			retried: BOOLEAN
		do
			error_in_bkpts := False
			create {LINKED_SET [INTEGER]} Result.make
			if not retried then
				f_real_body_id := f.real_body_id
	
					-- search in the list of all_breakpoints for
					-- at leat one breakpoint set in this feature
				from
					breakpoints.start
				until
					breakpoints.after
				loop
					bp := breakpoints.item_for_iteration
					if bp.real_body_id.is_equal(f_real_body_id) and then bp.is_set then
						Result.extend(bp.breakable_line_number)
					end
					breakpoints.forth
				end
			end
		ensure
			non_void: Result /= Void
		rescue
			-- It's likely that we have not been able to compute `real_body_id' for `f'.
			-- We will remove all breakpoints corresponding to the feature `f'.
			from
				breakpoints.start
			until
				breakpoints.after
			loop
				bp := breakpoints.item_for_iteration
				if bp.routine.is_equal(f) then
					bp.discard
				end
				breakpoints.forth
			end
				-- remove unused breakpoints
			update
			error_in_bkpts := True
			retried := True
			retry
		end
			
	breakpoints_disabled_for (f: E_FEATURE): LIST [INTEGER] is
			-- Breakpoints set for feature `f' and disabled
		require
			f_is_debuggable: f.is_debuggable
		local
			bp: BREAKPOINT
			f_real_body_id: INTEGER
			retried: BOOLEAN
		do
			error_in_bkpts := False
			create {SORTED_TWO_WAY_LIST [INTEGER]} Result.make
			if not retried then 
				f_real_body_id := f.real_body_id

					-- search in the list of all_breakpoints for
					-- at leat one breakpoint disabled in this feature
				from
					breakpoints.start
				until
					breakpoints.after
				loop
					bp := breakpoints.item_for_iteration
					if bp.real_body_id.is_equal(f_real_body_id) and then bp.is_disabled then
						Result.extend(bp.breakable_line_number)
					end
					breakpoints.forth
				end
			end
		ensure
			non_void: Result /= Void
		rescue
			-- It's likely that we have not been able to compute `real_body_id' for `f'.
			-- We will remove all breakpoints corresponding to the feature `f'.
			from
				breakpoints.start
			until
				breakpoints.after
			loop
				bp := breakpoints.item_for_iteration
				if bp.is_corrupted or else bp.routine.is_equal(f) then
					bp.discard
				end
				breakpoints.forth
			end
				-- remove unused breakpoints
			update
			error_in_bkpts := True
			retried := True
			retry
		end
			
	breakpoints_enabled_for (f: E_FEATURE): LIST [INTEGER] is
			-- Breakpoints set for feature `f' and enabled
		require
			f_is_debuggable: f.is_debuggable
		local
			bp: BREAKPOINT
			f_real_body_id: INTEGER
			retried: BOOLEAN
		do
			error_in_bkpts := False
			create {SORTED_TWO_WAY_LIST [INTEGER]} Result.make
			if not retried then
				f_real_body_id := f.real_body_id

					-- search in the list of all_breakpoints for
					-- at leat one breakpoint enabled in this feature
				from
					breakpoints.start
				until
					breakpoints.after
				loop
					bp := breakpoints.item_for_iteration
					if bp.real_body_id.is_equal(f_real_body_id) and then bp.is_enabled then
						Result.extend(bp.breakable_line_number)
					end
					breakpoints.forth
				end
			end
		ensure
			non_void: Result /= Void
		rescue
			-- It's likely that we have not been able to compute `real_body_id' for `f'.
			-- We will remove all breakpoints corresponding to the feature `f'.
			from
				breakpoints.start
			until
				breakpoints.after
			loop
				bp := breakpoints.item_for_iteration
				if bp.is_corrupted or else bp.routine.is_equal(f) then
					bp.discard
				end
				breakpoints.forth
			end
				-- remove unused breakpoints
			update
			error_in_bkpts := True
			retried := True
			retry
		end

feature -- changing breakpoints for a class

	remove_breakpoints_in_class(c: CLASS_C) is
			-- remove all breakpoints set for class 'c'
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False
				-- search in the list of all_breakpoints
				-- all breakpoint set for class 'c'
			from
				breakpoints.start
			until
				breakpoints.after
			loop
				bp := breakpoints.item_for_iteration
				if bp.routine.associated_class.is_equal(c) and then bp.is_set then
					bp.discard
				end
				breakpoints.forth
			end
		end

	disable_breakpoints_in_class(c: CLASS_C) is
			-- disable all breakpoints set for feature 'f'
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False
				-- search in the list of all_breakpoints
				-- all breakpoint set for class 'c'
			from
				breakpoints.start
			until
				breakpoints.after
			loop
				bp := breakpoints.item_for_iteration
				if bp.routine.associated_class.is_equal(c) and then bp.is_set then
					bp.disable
				end
				breakpoints.forth
			end
		end

	enable_breakpoints_in_class(c: CLASS_C) is
			-- enable all breakpoints set for feature 'f'
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False
				-- search in the list of all_breakpoints
				-- all breakpoint set for class 'c'
			from
				breakpoints.start
			until
				breakpoints.after
			loop
				bp := breakpoints.item_for_iteration
				if bp.routine.associated_class.is_equal(c) and then bp.is_set then
					bp.enable
				end
				breakpoints.forth
			end
		end

feature -- changing a specified breakpoint

	switch_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- Switch the `i'-th breakpoint of `f'
		require
			valid_f: not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique)
		local
			bp: BREAKPOINT;
		do
			error_in_bkpts := False
				-- create a 'fake' breakpoint, in order to get the real
				-- one in hash tables
			create bp.make(f, i)

			if not bp.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has(bp) then
						-- yes, the breakpoint is already known, so switch it
					breakpoints.found_item.switch
				else
						-- unknown breakpoint, add it
					breakpoints.add_breakpoint (bp)
				end
			else
				error_in_bkpts := True
			end
		end

	remove_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- Switch the `i'-th breakpoint of `f'
		require
			valid_f: not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique)
		local
			bp: BREAKPOINT;
		do
			error_in_bkpts := False
				-- create a 'fake' breakpoint, in order to get the real
				-- one in hash tables
			create bp.make (f, i)

			if not bp.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has (bp) then
						-- yes, the breakpoint is already known, so switch it
					breakpoints.found_item.discard
				end
			else
				error_in_bkpts := True
			end
		end

	disable_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- disable the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', a disabled breakpoint is created
		require
			valid_f: not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique)
		local
			bp: BREAKPOINT;
		do
			error_in_bkpts := False
				-- create a 'fake' breakpoint, in order to get the real one in hash table
			create bp.make (f, i)

			if not bp.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has (bp) then
						-- yes, the breakpoint is already known, so switch it
					breakpoints.found_item.disable
				else
						-- unknown breakpoint, set it as disabled and add it
					bp.disable
					breakpoints.add_breakpoint (bp)
				end
			else
				error_in_bkpts := True
			end
		end

	enable_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- enable the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', a breakpoint is created
		require
			valid_f: not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique)
		local
			bp: BREAKPOINT;
		do
			error_in_bkpts := False

				-- create a 'fake' breakpoint, in order to get the real one in hash table
			create bp.make (f, i)

			if not bp.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has (bp) then
						-- yes, the breakpoint is already known, so switch it
					breakpoints.found_item.enable
				else
					breakpoints.add_breakpoint (bp)
				end
			else
				error_in_bkpts := True
			end
		end

	set_condition (f: E_FEATURE; i: INTEGER; expr: EB_EXPRESSION) is
			-- Make the breakpoint located at (`f',`i') conditional with condition `expr'.
			-- Create an enabled breakpoint if is doesn't already exist.
		require
			valid_f: f /= Void and then f.is_debuggable
			valid_i: i > 0 and i <= f.number_of_breakpoint_slots
			valid_expr: expr /= Void and then not expr.syntax_error
			good_semantics: expr.is_condition (f)
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False
				-- create a 'fake' breakpoint, in order to get the real one in hash table
			create bp.make (f, i)

			if not bp.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has (bp) then
						-- yes, the breakpoint is already known, so set its condition.
					breakpoints.found_item.set_condition (expr)
				else
						-- No, create it and set its condition.
					breakpoints.add_breakpoint (bp)
					bp.set_condition (expr)
				end
			else
				error_in_bkpts := True
			end
		end

	remove_condition (f: E_FEATURE; i: INTEGER) is
			-- Make the breakpoint located at (`f',`i') unconditional.
		require
			valid_breakpoint: is_breakpoint_set (f, i)
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False
				-- create a 'fake' breakpoint, in order to get the real one in hash table
			create bp.make (f, i)

			if not bp.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has (bp) then
						-- yes, the breakpoint is already known, so remove its condition.
					breakpoints.found_item.remove_condition
				end
			else
				error_in_bkpts := True
			end
		end

feature -- getting the status of a specified breakpoint

	condition (f: E_FEATURE; i: INTEGER): EB_EXPRESSION is
			-- Does breakpoint located at (`f', `i') have a condition?
		require
			valid_breakpoint: is_breakpoint_set (f, i)
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False
				-- create a 'fake' breakpoint, in order to get the real one in hash table
			create bp.make (f, i)

			if not bp.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has (bp) then
						-- yes, the breakpoint is already known, so remove its condition.
					Result := breakpoints.found_item.condition
				end
			else
				error_in_bkpts := True
			end
		end

	is_breakpoint_set (f: E_FEATURE; i: INTEGER): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' set? (enabled or disabled)
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False
			if not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique) then
					-- create a 'fake' breakpoint, in order to get the real one in hash table
				create bp.make(f,i)
				if not bp.is_corrupted then
					if breakpoints.has(bp) then
						Result := breakpoints.found_item.is_set
					end
				else
					error_in_bkpts := True
				end
			end
		end

	is_breakpoint_enabled (f: E_FEATURE; i: INTEGER): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' enabled
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False
			if not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique) then
				create bp.make(f,i)
				if not bp.is_corrupted then
					if breakpoints.has(bp) then
						Result := breakpoints.found_item.is_enabled
					end
				else
					error_in_bkpts := True
				end
			end
		end

	is_breakpoint_disabled (f: E_FEATURE; i: INTEGER): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' disabled
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False
			if not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique) then
				create bp.make(f,i)
				if not bp.is_corrupted then
					if breakpoints.has(bp) then
						Result := breakpoints.found_item.is_disabled
					end
				else
					error_in_bkpts := True
				end
			end
		end

	breakpoint_status (f: E_FEATURE; i: INTEGER): INTEGER is
			-- Returns 0 if the breakpoint is not set,
			--         1 if the breakpoint is set,
			--		   2 if the breakpoint is enabled and has a condition,
			--         -1 if the breakpoint is set but disabled,
			--		   -2 if the breakpoint is disabled and has a condition
		local
			bp: BREAKPOINT
		do
--|			if not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique) then
			error_in_bkpts := False
			if f.valid_body_index then
				create bp.make(f,i)
				if not bp.is_corrupted then
					if breakpoints.has(bp) then
						bp := breakpoints.found_item
						if bp.is_enabled then
							if bp.condition = Void then
								Result := 1
							else
								Result := 2
							end
						elseif bp.is_disabled then
							if bp.condition = Void then
								Result := -1
							else
								Result := -2
							end
						end
					end
				else
					error_in_bkpts := True
				end
			end
		end

feature -- Debug

	trace is
		do
			io.put_string ("============ class DEBUG INFO ===========%N%N");
			from
				breakpoints.start
			until	
				breakpoints.after
			loop
				breakpoints.item_for_iteration.trace
				breakpoints.forth
			end
			io.put_string ("===================================%N%N");
		end

feature {APPLICATION_EXECUTION, FAILURE_HDLR}

	resynchronize_breakpoints is
			-- Resychronize the breakpoints after a compilation.
		do
			error_in_bkpts := False
				-- Remove useless breakpoints.
			update

				-- update every breakpoint
			from
				breakpoints.start
			until	
				breakpoints.after
			loop
				breakpoints.item_for_iteration.synchronize
				breakpoints.forth
			end

				-- Remove useless breakpoints (the synchronization
				-- may have removed some breakpoints)
			update
		end

	feature_bp_list (list: LINKED_LIST [E_FEATURE]): FIXED_LIST [CELL2 [E_FEATURE, LIST [INTEGER]]] is
			-- Create a list with features and breakpoints
		local
			f: E_FEATURE;
			cell2: CELL2 [E_FEATURE, LIST [INTEGER]]
		do
			error_in_bkpts := False
			from
				create Result.make_filled (list.count)
				Result.start;
				list.start
			until
				list.after
			loop
				f := list.item;
				create cell2.make (f, breakpoints_set_for (f));
				Result.replace (cell2);
				Result.forth;
				list.forth
			end
		end

	features_with_breakpoint_set: LIST[E_FEATURE] is
			-- list of all feature with a breakpoint set (enabled or disabled)
		local
			bp: BREAKPOINT
			known_features: ARRAYED_LIST[INTEGER]
			body_index: INTEGER
		do
			error_in_bkpts := False
			create {LINKED_LIST[E_FEATURE]} Result.make
			create known_features.make(5) 

			from 
				breakpoints.start
			until
				breakpoints.after
			loop
				bp := breakpoints.item_for_iteration
				if bp.is_set and not bp.is_corrupted and then bp.is_valid then
					body_index := bp.body_index
						-- have we already added the feature corresponding to this breakpoint ?
					if not known_features.has(body_index) then
							-- feature not already added... so add it
						known_features.extend(body_index)
							-- add the feature to the result list
						Result.extend (bp.routine)
					end
				end
				breakpoints.forth
			end
		ensure
			non_void_result: Result /= Void
		end

feature {EWB_REQUEST}

	breakpoints: BREAK_LIST
			-- list of all breakpoints set, disabled and recently switched.

feature -- Access

	Once_request: ONCE_REQUEST is
			-- Facilities to inspect whether a once routine
			-- has already been called
		once
			create Result.make
		end

end -- class DEBUG_INFO
