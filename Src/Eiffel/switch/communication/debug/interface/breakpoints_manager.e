indexing
	description: "Objects that manage breakpoints"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	BREAKPOINTS_MANAGER

create
	make

feature {NONE} -- Initialization

	make (bps: like breakpoints) is
			-- Instanciate Current with `bps'
		do
			set_breakpoints (bps)

			create observers.make (3)
		end

feature -- Properties

	breakpoints: BREAK_LIST
			-- list of all breakpoints set, disabled and recently switched.	

	observers: DS_ARRAYED_LIST [BREAKPOINTS_OBSERVER]
			-- Observer for events on breakpoints.

feature -- Change

	set_breakpoints (lst: like breakpoints) is
			-- Set `breakpoints' value
		do
			if lst /= Void then
				breakpoints := lst
			else
				create breakpoints.make
			end
		end

feature -- Notification

	breakpoints_changed: BOOLEAN
			-- Breakpoints changed ?

	notify_breakpoints_changes is
		do
			breakpoints_changed := True
			observers.do_all (agent {BREAKPOINTS_OBSERVER}.on_breakpoints_change_event)
		end

	reset_breakpoints_changed is
		do
			breakpoints_changed := False
		end

	on_breakpoint_added_or_deleted_event (new_or_deleted: BOOLEAN) is
			-- Notify a new breakpoint
		do
			if new_or_deleted then
				update_breakpoints_tags_provider
			end
			observers.do_all (agent {BREAKPOINTS_OBSERVER}.on_new_breakpoint_event)
		end

feature -- Observers

	add_observer (o: BREAKPOINTS_OBSERVER) is
			-- Add `o' to `observers'
		require
			o_not_void: o /= Void
		do
			observers.put_last (o)
		end

	remove_observer (o: BREAKPOINTS_OBSERVER) is
			-- Remove `o' from `observers'
		require
			o_not_void: o /= Void
		do
			observers.delete (o)
		end

feature -- Breakpoints status

	error_in_bkpts: BOOLEAN
			-- Has an error occurred in the last modification/examination of breakpoints?

	has_breakpoints: BOOLEAN is
			-- Does the program have a breakpoint (enabled or disabled) ?
		local
			bp: BREAKPOINT
			bplst: like breakpoints
		do
			error_in_bkpts := False

				-- look for the first breakpoint set and enabled
			from
				bplst :=  breakpoints
				bplst.start
			until
				bplst.after or Result
			loop
				bp := bplst.item_for_iteration
				Result := bp.is_set and bp.is_valid
				bplst.forth
			end
		end

	has_enabled_breakpoints: BOOLEAN is
			-- Does the program have a breakpoint set?
		local
			bp: BREAKPOINT
			bplst: like breakpoints
		do
			error_in_bkpts := False
				-- look for the first breakpoint set and enabled
			from
				bplst := breakpoints
				bplst.start
			until
				bplst.after or Result
			loop
				bp := bplst.item_for_iteration
				Result := bp.is_enabled and bp.is_valid
				bplst.forth
			end
		end

	has_disabled_breakpoints: BOOLEAN is
			-- Does the program have an enabled breakpoint?
		local
			bp: BREAKPOINT
			bplst: like breakpoints
		do
			error_in_bkpts := False
				-- look for the first breakpoint set and disabled
			from
				bplst := breakpoints
				bplst.start
			until
				bplst.after or Result
			loop
				bp := bplst.item_for_iteration
				Result := bp.is_disabled and bp.is_valid
				bplst.forth
			end
		end

	has_conditional_stop (f: E_FEATURE; i: INTEGER): BOOLEAN is
			-- Does breakpoint located at (`f', `i') have a condition ?
		require
			valid_breakpoint: is_breakpoint_set (f, i)
		do
			Result := condition (f, i) /= Void
		end

feature -- Breakpoints update

	resynchronize_breakpoints is
			-- Resychronize the breakpoints after a compilation.
		local
			bplst: like breakpoints
		do
			error_in_bkpts := False
				-- Remove useless breakpoints.
			update

				-- update every breakpoint
			from
				bplst := breakpoints
				bplst.start
			until
				bplst.after
			loop
				synchronize_breakpoint (bplst.item_for_iteration)
				bplst.forth
			end

				-- Remove useless breakpoints (the synchronization
				-- may have removed some breakpoints)
			update
		end

	synchronize_breakpoint (bp: BREAKPOINT) is
			-- Resychronize the breakpoint after a recompilation.
			--| note: since we might update `body_index' or `breakable_line_number'
			--|       which are used to compute the hash_code of breakpoint
			--|       it is mandatory to call "update" afterwhile
			--|       to reassign the bp to the bp list with fresh hash_code.
		require
			bp_not_void: bp /= Void
		local
			invalid_breakpoint: BOOLEAN
			nb_bps: INTEGER
			l_routine: E_FEATURE
			l_body_index: INTEGER
			l_breakable_line_number: INTEGER
			l_condition: DBG_EXPRESSION
		do
			if not invalid_breakpoint then
					-- update the feature
				l_breakable_line_number := bp.breakable_line_number
				bp.update_routine_version
				l_routine := bp.routine

				if l_routine /= Void and then l_routine.is_debuggable and then l_routine.written_class /= Void then
					nb_bps := l_routine.number_of_breakpoint_slots
					if
						nb_bps = 0 --| more likely a bug in compiler data
						or else l_breakable_line_number <= nb_bps
					then
							-- The line of the breakpoint still exists.
							-- Update `real_body_id' since it may have changed
							-- during recompilation (`body_index' is not supposed to change but
							-- we update it as well in case of)

						l_body_index := l_routine.body_index -- update the body_index as well
						l_condition := bp.condition
						if l_condition /= Void then
							l_condition.reset
							if bp.condition_as_is_true and not l_condition.is_boolean_expression (l_routine) then
								bp.remove_condition
								l_condition := Void
							end
						end
					elseif
						l_breakable_line_number > nb_bps
						and then not is_breakpoint_set (l_routine, nb_bps)
							--| FIXME.
							--| This might be dangerous to access the breakpoints list
							--| since its data are not stable
					then
						check nb_bps > 0 end
						bp.set_breakable_line_number (nb_bps)
					else
							-- set the breakpoint to be removed: the line does no longer exist
						bp.discard
						bp.set_is_corrupted (True)
					end
				else
						-- The breakpoint is now invalid since its feature has been removed
						-- or is no longer debuggable.
					bp.discard
					bp.set_is_corrupted (True)
				end
			else
					-- This is an invalid breakpoint. Discard it.
				bp.discard
				bp.set_is_corrupted (True)
			end
		ensure
			bp.is_set implies bp.routine /= Void
		rescue
				-- The synchronization of the breakpoint has failed.
				-- We declare the breakpoint as "invalid".
			invalid_breakpoint := True
			retry
		end

	update is
		do
			breakpoints.update
		end

	restore is
		do
			breakpoints.restore
		end

feature -- Breakpoints tags

	update_breakpoints_tags_provider is
			-- Update tags providers
		local
			tp, btp: TAGS_PROVIDER
			bps: like breakpoints
		do
			btp := breakpoints_tags_provider
			tp := tags_provider
			btp.wipe_out
			tp.wipe_out

			bps := breakpoints
			from
				bps.start
			until
				bps.after
			loop
				btp.add_tag (bps.item_for_iteration.to_tag_path)
				tp.add_tags (bps.item_for_iteration.tags_as_array)
				bps.forth
			end
			btp.sort
			tp.sort
		end

	global_tags_provider: TAGS_PROVIDER is
		once
			create Result.make (20)
			Result.add_provider (tags_provider, "")
			Result.add_provider (breakpoints_tags_provider, "bp")
		end

	tags_provider: TAGS_PROVIDER is
		once
			create Result.make (20)
		end

	breakpoints_tags_provider: TAGS_PROVIDER is
		once
			create Result.make (20)
		end

feature -- Breakpoints access

	breakpoint (f: E_FEATURE; i: INTEGER): BREAKPOINT is
			-- Breakpoint located at (`f', `i').
		require
			valid_breakpoint: is_breakpoint_set (f, i)
		local
			bpk: BREAKPOINT_KEY
		do
			error_in_bkpts := False
				-- create a 'fake' breakpoint, in order to get the real one in hash table
			create bpk.make (f, i)

			if not bpk.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has_key (bpk) then
						-- yes, the breakpoint is already known, so remove its condition.
					Result := breakpoints.found_item
				end
			else
				error_in_bkpts := True
			end
		end

	condition (f: E_FEATURE; i: INTEGER): DBG_EXPRESSION is
			-- Condition of breakpoint located at (`f', `i').
		require
			valid_breakpoint: is_breakpoint_set (f, i)
		local
			bp: BREAKPOINT
		do
			bp := breakpoint (f, i)
			if bp /= Void then
				Result := bp.condition
			end
		end

	is_breakpoint_set (f: E_FEATURE; i: INTEGER): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' set? (enabled or disabled)
		local
			bpk: BREAKPOINT_KEY
		do
			error_in_bkpts := False
			if not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique) then
					-- create a 'fake' breakpoint, in order to get the real one in hash table
				create bpk.make(f,i)
				if not bpk.is_corrupted then
					if breakpoints.has_key (bpk) then
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
			bpk: BREAKPOINT_KEY
		do
			error_in_bkpts := False
			if not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique or else f.real_body_id = 0) then
				create bpk.make(f,i)
				if not bpk.is_corrupted then
					if breakpoints.has_key (bpk) then
						Result := breakpoints.found_item.is_enabled
					end
				else
					error_in_bkpts := True
				end
			end
		end

	breakpoint_status (f: E_FEATURE; i: INTEGER): INTEGER is
			-- Returns `breakpoint_not_set' if breakpoint is not set,
			--         `breakpoint_set' if breakpoint is set,
			--		   `breakpoint_condition_set' if breakpoint is enabled and has a condition,
			--         `breakpoint_disabled' if breakpoint is set but disabled,
			--		   `breakpoint_condition_disabled' if breakpoint is disabled and has a condition
		local
			bpk: BREAKPOINT_KEY
			bp: BREAKPOINT
		do
--|			if not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique) then
			error_in_bkpts := False
			Result := breakpoint_not_set
			if f.valid_body_index then
				if f.real_body_id /= 0 then
					create bpk.make(f,i)
				end
				if bpk /= Void and then not bpk.is_corrupted then
					if breakpoints.has_key (bpk) then
						bp := breakpoints.found_item
						if bp.is_enabled then
							if bp.condition = Void then
								Result := breakpoint_set
							else
								Result := breakpoint_condition_set
							end
						elseif bp.is_disabled then
							if bp.condition = Void then
								Result := breakpoint_disabled
							else
								Result := breakpoint_condition_disabled
							end
						end
					end
				else
					error_in_bkpts := True
				end
			end
		end

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
			bplst: like breakpoints
			f_body_index: INTEGER
			retried: BOOLEAN
		do
			error_in_bkpts := False
			create {LINKED_SET [INTEGER]} Result.make
			if not retried then
				f_body_index := f.body_index

					-- search in the list of all_breakpoints for
					-- at leat one breakpoint set in this feature
				from
					bplst := breakpoints
					bplst.start
				until
					bplst.after
				loop
					bp := bplst.item_for_iteration
					if bp.body_index.is_equal (f_body_index) and then bp.is_set then
						Result.extend (bp.breakable_line_number)
					end
					bplst.forth
				end
			end
		ensure
			non_void: Result /= Void
		rescue
			-- It's likely that we have not been able to compute `body_index' for `f'.
			-- We will remove all breakpoints corresponding to the feature `f'.
			from
				bplst := breakpoints
				bplst.start
			until
				bplst.after
			loop
				bp := bplst.item_for_iteration
				if bp.routine.is_equal (f) then
					bp.discard
				end
				bplst.forth
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
			bplst: like breakpoints
			f_body_index: INTEGER
			retried: BOOLEAN
		do
			error_in_bkpts := False
			create {SORTED_TWO_WAY_LIST [INTEGER]} Result.make
			if not retried then
				f_body_index := f.body_index

					-- search in the list of all_breakpoints for
					-- at leat one breakpoint enabled in this feature
				from
					bplst := breakpoints
					bplst.start
				until
					bplst.after
				loop
					bp := bplst.item_for_iteration
					if bp.body_index.is_equal (f_body_index) and then bp.is_enabled then
						Result.extend (bp.breakable_line_number)
					end
					bplst.forth
				end
			end
		ensure
			non_void: Result /= Void
		rescue
			-- It's likely that we have not been able to compute `body_index' for `f'.
			-- We will remove all breakpoints corresponding to the feature `f'.
			from
				bplst := breakpoints
				bplst.start
			until
				bplst.after
			loop
				bp := bplst.item_for_iteration
				if bp.is_corrupted or else bp.routine.is_equal(f) then
					bp.discard
				end
				bplst.forth
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
			bplst: like breakpoints
			f_body_index: INTEGER
			retried: BOOLEAN
		do
			error_in_bkpts := False
			create {SORTED_TWO_WAY_LIST [INTEGER]} Result.make
			if not retried then
				f_body_index := f.body_index

					-- search in the list of all_breakpoints for
					-- at leat one breakpoint disabled in this feature
				from
					bplst := breakpoints
					bplst.start
				until
					bplst.after
				loop
					bp := bplst.item_for_iteration
					if bp.body_index.is_equal (f_body_index) and then bp.is_disabled then
						Result.extend (bp.breakable_line_number)
					end
					bplst.forth
				end
			end
		ensure
			non_void: Result /= Void
		rescue
			-- It's likely that we have not been able to compute `body_index' for `f'.
			-- We will remove all breakpoints corresponding to the feature `f'.
			from
				bplst := breakpoints
				bplst.start
			until
				bplst.after
			loop
				bp := bplst.item_for_iteration
				if bp.is_corrupted or else bp.routine.is_equal (f) then
					bp.discard
				end
				bplst.forth
			end
				-- remove unused breakpoints
			update
			error_in_bkpts := True
			retried := True
			retry
		end

	features_with_breakpoint_set: LIST [E_FEATURE] is
			-- list of all feature with a breakpoint set (enabled or disabled)
		local
			bp: BREAKPOINT
			bplst: like breakpoints
			known_features: ARRAYED_LIST [INTEGER]
			body_index: INTEGER
		do
			error_in_bkpts := False
			create {LINKED_LIST [E_FEATURE]} Result.make
			create known_features.make(5)

			from
				bplst := breakpoints
				bplst.start
			until
				bplst.after
			loop
				bp := bplst.item_for_iteration
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
				bplst.forth
			end
		ensure
			non_void_result: Result /= Void
		end

feature -- Query

	breakpoints_tagged (a_tags: ARRAY [STRING_32]): LIST [BREAKPOINT] is
		local
			bp: BREAKPOINT
		do
			if a_tags /= Void and then not a_tags.is_empty then
				create {LINKED_LIST [BREAKPOINT]} Result.make
				from
					breakpoints.start
				until
					breakpoints.after
				loop
					bp := breakpoints.item_for_iteration
					if bp.match_tags (a_tags) then
						Result.extend (bp)
					end
					breakpoints.forth
				end
			end
		end

feature -- Breakpoints status settings

	set_breakpoint_status (f: E_FEATURE; i: INTEGER; bp_status: INTEGER) is
			-- Set  status of  `i'-th breakpoint of `f', on bench side.
			-- DO NOT NOTIFY application of change if application
			-- is running.
			--
			-- Possible value of `bp_status' are taken from BREAKPOINTS_MANAGER class:
			-- bp_status =  Breakpoint_not_set <=> the breakpoint is not set,
			-- bp_status =  Breakpoint_set, Breakpoint_condition_set <=> the breakpoint is set,
			-- bp_status =  Breakpoint_disabled, Breakpoint_condition_disabled <=> the breakpoint is disabled
		do
			inspect bp_status
			when
				breakpoint_not_set
			then
				remove_breakpoint (f, i)

			when
				Breakpoint_set,
				Breakpoint_condition_set
			then
				enable_breakpoint (f, i)

			when
				Breakpoint_disabled,
				Breakpoint_condition_disabled
			then
				disable_breakpoint (f, i)
			end
		end

feature -- Breakpoints addition

	set_breakpoint, enable_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- enable the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', a breakpoint is created
		require
			positive_i: i > 0
			valid_f: not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique)
			debuggable: f.is_debuggable
		local
			bpk: BREAKPOINT_KEY
		do
			error_in_bkpts := False

			if f.body_index /= 0 then
					-- create a 'fake' breakpoint, in order to get the real one in hash table
				create bpk.make (f, i)
			end

			if bpk /= Void and then not bpk.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has_key (bpk) then
						-- yes, the breakpoint is already known, so switch it
					breakpoints.found_item.enable
				else
					breakpoints.add_breakpoint (breakpoints.new_breakpoint (bpk))
				end
			else
				error_in_bkpts := True
			end
			on_breakpoint_added_or_deleted_event (True)
		end

	enable_breakpoints_in_feature (f: E_FEATURE) is
			-- enable all breakpoints set for feature 'f'
		require
			non_void_f: f /= Void
			debuggable: f.is_debuggable
		local
			f_body_index: INTEGER
			bp: BREAKPOINT
			bplst: like breakpoints
			retried: BOOLEAN
		do
			error_in_bkpts := False
			if not retried then
				f_body_index := f.body_index

				-- search in the list of all_breakpoints
				-- all breakpoint set for feature 'f'
				from
					bplst := breakpoints
					bplst.start
				until
					bplst.after
				loop
					bp := bplst.item_for_iteration
					if bp.body_index.is_equal(f_body_index) and then bp.is_set then
						bp.enable
					end
					bplst.forth
				end
				on_breakpoint_added_or_deleted_event (True)
			else
				error_in_bkpts := True
			end
		rescue
			retried := True
			retry
		end

	enable_first_breakpoint_of_feature(f: E_FEATURE) is
			-- enable the first breakpoints in feature 'f'
		require
			non_void_f: f /= Void
			debuggable: f.is_debuggable
		local
			bp: BREAKPOINT
		do
			error_in_bkpts := False

			create bp.make (f, f.first_breakpoint_slot_index)
			if not bp.is_corrupted then
				breakpoints.add_breakpoint (bp)
				on_breakpoint_added_or_deleted_event (True)
			else
				error_in_bkpts := True
			end
		end

	enable_first_breakpoints_in_class (c: CLASS_C) is
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
				on_breakpoint_added_or_deleted_event (True)
			else
				error_in_bkpts := True
			end
		end

	enable_breakpoints_in_class(c: CLASS_C) is
			-- enable all breakpoints set for feature 'f'
		require
			non_void_c: c /= Void
		local
			bp: BREAKPOINT
			bplst: like breakpoints
		do
			error_in_bkpts := False
				-- search in the list of all_breakpoints
				-- all breakpoint set for class 'c'
			from
				bplst := breakpoints
				bplst.start
			until
				bplst.after
			loop
				bp := bplst.item_for_iteration
				if bp.routine.associated_class.is_equal (c) and then bp.is_set then
					bp.enable
				end
				bplst.forth
			end
			on_breakpoint_added_or_deleted_event (True)
		end

feature -- Breakpoints removal

	remove_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- remove the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', do nothing
		require
			positive_i: i > 0
			valid_f: not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique)
		local
			bpk: BREAKPOINT_KEY
		do
			error_in_bkpts := False
				-- create a 'fake' breakpoint, in order to get the real
				-- one in hash tables
			create bpk.make (f, i)

			if not bpk.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has_key (bpk) then
						-- yes, the breakpoint is already known, so switch it
					breakpoints.found_item.discard
					on_breakpoint_added_or_deleted_event (True)
				end
			else
				error_in_bkpts := True
			end
		end

	remove_breakpoints_in_feature (f: E_FEATURE) is
			-- remove all breakpoints set for feature 'f'
		require
			non_void_f: f /= Void
		local
			f_body_index: INTEGER
			bp: BREAKPOINT
			bplst: like breakpoints
			retried: BOOLEAN
		do
			error_in_bkpts := False
			if not retried then
				f_body_index := f.body_index

				-- search in the list of all_breakpoints
				-- all breakpoint set for feature 'f'
				from
					bplst := breakpoints
					bplst.start
				until
					bplst.after
				loop
					bp := bplst.item_for_iteration
					if bp.body_index.is_equal (f_body_index) and then bp.is_set then
						bp.discard
					end
					bplst.forth
				end
				on_breakpoint_added_or_deleted_event (True)
			else
				error_in_bkpts := True
			end
		rescue
			retried := True
			retry
		end

	remove_breakpoints_in_class (c: CLASS_C) is
			-- remove all breakpoints set for class 'c'
		require
			non_void_c: c /= Void
		local
			bp: BREAKPOINT
			bplst: like breakpoints
		do
			error_in_bkpts := False
				-- search in the list of all_breakpoints
				-- all breakpoint set for class 'c'
			from
				bplst := breakpoints
				bplst.start
			until
				bplst.after
			loop
				bp := bplst.item_for_iteration
				if bp.routine.associated_class.is_equal (c) and then bp.is_set then
					bp.discard
				end
				bplst.forth
			end
			on_breakpoint_added_or_deleted_event (True)
		end


	clear_breakpoints is
			-- Clear the debugging information.
			-- Save the information if we want to restore it
			-- after the compilation (do not save the information
			-- if there are compilation errors).
		do
				-- Need to individually remove the breakpoints
				-- since the sent_bp must be updated to
				-- not stop.
			remove_all_breakpoints
			on_breakpoint_added_or_deleted_event (True)
		end

	clear_breakpoints_at_once is
			-- Clear the debugging information at once
		do
			wipe_out_all_breakpoints
			on_breakpoint_added_or_deleted_event (True)
		end

feature -- Breakpoints change

	disable_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- disable the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', a disabled breakpoint is created
		require
			valid_f: not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique)
			positive_i: i > 0
		local
			bpk: BREAKPOINT_KEY
			bp: BREAKPOINT
		do
			error_in_bkpts := False
				-- create a 'fake' breakpoint, in order to get the real one in hash table
			create bpk.make (f, i)

			if not bpk.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has_key (bpk) then
						-- yes, the breakpoint is already known, so switch it
					breakpoints.found_item.disable
				else
						-- unknown breakpoint, set it as disabled and add it
					bp := breakpoints.new_breakpoint (bpk)
					bp.disable
					breakpoints.add_breakpoint (bp)
				end
				on_breakpoint_added_or_deleted_event (False)
			else
				error_in_bkpts := True
			end
		end

	disable_breakpoints_in_feature (f: E_FEATURE) is
			-- disable all breakpoints set for feature 'f'
		require
			non_void_f: f /= Void
		local
			f_body_index: INTEGER
			bp: BREAKPOINT
			bplst: like breakpoints
			retried: BOOLEAN
		do
			error_in_bkpts := False
			if not retried then
				f_body_index := f.body_index

				-- search in the list of all_breakpoints
				-- all breakpoint set for feature 'f'
				from
					bplst := breakpoints
					bplst.start
				until
					bplst.after
				loop
					bp := bplst.item_for_iteration
					if bp.body_index.is_equal(f_body_index) and then bp.is_set then
						bp.disable
					end
					bplst.forth
				end
				on_breakpoint_added_or_deleted_event (False)
			else
				error_in_bkpts := True
			end
		rescue
			retried := True
			retry
		end

	disable_breakpoints_in_class (c: CLASS_C) is
			-- disable all breakpoints set for feature 'f'
		require
			non_void_c: c /= Void
		local
			bp: BREAKPOINT
			bplst: like breakpoints
		do
			error_in_bkpts := False
				-- search in the list of all_breakpoints
				-- all breakpoint set for class 'c'
			from
				bplst := breakpoints
				bplst.start
			until
				bplst.after
			loop
				bp := bplst.item_for_iteration
				if bp.routine.associated_class.is_equal(c) and then bp.is_set then
					bp.disable
				end
				bplst.forth
			end
			on_breakpoint_added_or_deleted_event (False)
		end

	disable_all_breakpoints is
			-- disable all breakpoints which are currently set and enabled
		local
			bp: BREAKPOINT
			bplst: like breakpoints
		do
			error_in_bkpts := False
			from
				bplst := breakpoints
				bplst.start
			until
				bplst.after
			loop
				bp := bplst.item_for_iteration
				if bp.is_enabled then
					bp.disable
				end
				bplst.forth
			end
			on_breakpoint_added_or_deleted_event (False)
		end

	enable_all_breakpoints is
			-- enable all breakpoints which are currently set and disabled
		local
			bp: BREAKPOINT
			bplst: like breakpoints
		do
			error_in_bkpts := False
			from
				bplst := breakpoints
				breakpoints.start
			until
				bplst.after
			loop
				bp := bplst.item_for_iteration
				if bp.is_disabled then
					bp.enable
				end
				bplst.forth
			end
			on_breakpoint_added_or_deleted_event (False)
		end

feature {NONE} -- changing all breakpoints

	wipe_out_all_breakpoints is
			-- Clear breakpoints list
		do
			breakpoints.wipe_out
		end

	remove_all_breakpoints is
			-- Remove all breakpoints which are currently set (enabled/disabled)
		local
			bplst: like breakpoints
		do
			error_in_bkpts := False
			from
				bplst := breakpoints
				bplst.start
			until
				bplst.after
			loop
				bplst.item_for_iteration.discard
				bplst.forth
			end
		end


feature {NONE} -- changing breakpoints for a feature

--	add_breakpoints_for_feature (feat: E_FEATURE; a_list: LIST [INTEGER]) is
--			-- Add all the breakpoints `a_list' for feature `feat'.
--		local
--			id: INTEGER
--			bp: BREAKPOINT
--		do
--			error_in_bkpts := False
--			from
--				a_list.start
--			until
--				a_list.after
--			loop
--				id := a_list.item

--				-- create breakpoint
--				-- by default, at creation the breakpoint is set and enabled
--				create bp.make (feat, id)

--				-- add the breakpoint. if it was already in the hashtable, we replace
--				-- the old version with the new one, and we send it again to the application
--				if not bp.is_corrupted then
--					breakpoints.add_breakpoint (bp)
--				else
--					error_in_bkpts := True
--				end
--				a_list.forth
--			end
--		end

feature -- changing a specified breakpoint

--	switch_breakpoint (f: E_FEATURE; i: INTEGER) is
--			-- Switch the `i'-th breakpoint of `f'
--		require
--			valid_f: not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique)
--		local
--			bpk: BREAKPOINT_KEY
--		do
--			error_in_bkpts := False
--				-- create a 'fake' breakpoint, in order to get the real
--				-- one in hash tables
--			create bpk.make(f, i)
--
--			if not bpk.is_corrupted then
--					-- is the breakpoint known ?
--				if breakpoints.has_key (bpk) then
--						-- yes, the breakpoint is already known, so switch it
--					breakpoints.found_item.switch
--				else
--						-- unknown breakpoint, add it
--					breakpoints.add_breakpoint (breakpoints.new_breakpoint (bpk))
--				end
--			else
--				error_in_bkpts := True
--			end
--		end

	remove_condition (f: E_FEATURE; i: INTEGER) is
			-- Make the breakpoint located at (`f',`i') unconditional.
		require
			valid_breakpoint: is_breakpoint_set (f, i)
		local
			bpk: BREAKPOINT_KEY
		do
			error_in_bkpts := False
				-- create a 'fake' breakpoint, in order to get the real one in hash table
			create bpk.make (f, i)

			if not bpk.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has_key (bpk) then
						-- yes, the breakpoint is already known, so remove its condition.
					breakpoints.found_item.remove_condition
				end
			else
				error_in_bkpts := True
			end
		end

	set_condition (f: E_FEATURE; i: INTEGER; expr: DBG_EXPRESSION) is
			-- Make the breakpoint located at (`f',`i') conditional with condition `expr'.
			-- Create an enabled breakpoint if is doesn't already exist.
		require
			valid_f: f /= Void and then f.is_debuggable
			valid_i: i > 0 and i <= f.number_of_breakpoint_slots
			valid_expr: expr /= Void and then not expr.syntax_error_occurred
			good_semantics: expr.is_boolean_expression (f)
		local
			bpk: BREAKPOINT_KEY
			bp: BREAKPOINT
		do
			error_in_bkpts := False
				-- create a 'fake' breakpoint, in order to get the real one in hash table
			create bpk.make (f, i)

			if not bpk.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has_key (bpk) then
						-- yes, the breakpoint is already known, so set its condition.
					breakpoints.found_item.set_condition (expr)
				else
						-- No, create it and set its condition.
					bp := breakpoints.new_breakpoint (bpk)
					breakpoints.add_breakpoint (bp)
					bp.set_condition (expr)
				end
			else
				error_in_bkpts := True
			end
		end

feature -- Breakpoints constants

	breakpoint_not_set: INTEGER 			=  0
	breakpoint_set: INTEGER 				=  1
	breakpoint_disabled: INTEGER 			= -1
	breakpoint_condition_set: INTEGER 		=  2
	breakpoint_condition_disabled: INTEGER 	= -2
			-- Possible value for `breakpoint_status'.

invariant

	breakpoints_not_void: breakpoints /= Void

;indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
