indexing
	description: "Objects that manage breakpoints"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	BREAKPOINTS_MANAGER

inherit {NONE}
	DEBUGGER_COMPILER_UTILITIES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (bps: like breakpoints) is
			-- Instanciate Current with `bps'
		do
			set_breakpoints (bps)
			create observers.make (3)
		end

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

feature -- Properties

	breakpoints: BREAK_LIST
			-- list of all breakpoints set, disabled and recently switched.	

	breakpoints_changed: BOOLEAN
			-- Breakpoints changed ?

	error_in_bkpts: BOOLEAN
			-- Has an error occurred in the last modification/examination of breakpoints?

	observers: DS_ARRAYED_LIST [BREAKPOINTS_OBSERVER]
			-- Observer for events on breakpoints.

feature -- Notification

	notify_breakpoints_changes is
			-- Notify a change in breakpoints
		do
			breakpoints_changed := True
			observers.do_all (agent {BREAKPOINTS_OBSERVER}.on_breakpoints_change_event)
		end

	reset_breakpoints_changed is
			-- Reset `breakpoints_changed'
		do
			breakpoints_changed := False
		end

	on_breakpoint_added_or_deleted_event (new_or_deleted: BOOLEAN) is
			-- Notify a new breakpoint or a removal
		do
			if new_or_deleted then
				update_breakpoints_tags_provider
			end
			observers.do_all (agent {BREAKPOINTS_OBSERVER}.on_breakpoints_creation_or_removal_event)
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

feature -- Factory

	entry_breakpoint_location: BREAKPOINT_LOCATION is
			-- Breakpint location for System's entry point
		local
			fe: E_FEATURE
		do
			fe := entry_point_feature
			if fe /= Void then
				Result := breakpoint_location (fe, fe.first_breakpoint_slot_index, True)
			end
		end

	breakpoint_location (a_routine: E_FEATURE; a_breakable_index: INTEGER; reuse_location: BOOLEAN): BREAKPOINT_LOCATION is
			-- BREAKPOINT_LOCATION for `a_routine' and `a_breakable_index'.
		require
			valid_input: 	a_routine /= Void and then
							a_breakable_index > 0 and then
							a_routine.body_index /= 0
		local
			bp: BREAKPOINT
		do
			create Result.make (a_routine, a_breakable_index)
			if reuse_location and then breakpoints.has_location (Result) then
				bp := breakpoints.found_item
				Result := bp.location
			end
		ensure
			Result_not_void: Result /= Void
		end

	new_user_breakpoint_key (a_loc: BREAKPOINT_LOCATION): BREAKPOINT_KEY is
			-- New BREAKPOINT_KEY for `a_loc'.
		do
			create Result.make (a_loc)
		ensure
			Result_not_void: Result /= Void
		end

	new_hidden_breakpoint_key (a_loc: BREAKPOINT_LOCATION): BREAKPOINT_KEY is
			-- New hidden BREAKPOINT_KEY for `a_loc'.
		do
			create Result.make_hidden (a_loc)
		ensure
			Result_not_void: Result /= Void
		end

	new_breakpoint_key (a_loc: BREAKPOINT_LOCATION; is_hidden: BOOLEAN): BREAKPOINT_KEY is
			-- New BREAKPOINT_KEY for `a_loc'.
		do
			if is_hidden then
				Result := new_hidden_breakpoint_key (a_loc)
			else
				Result := new_user_breakpoint_key (a_loc)
			end
		ensure
			Result_not_void: Result /= Void
		end

	new_user_breakpoint (a_loc: BREAKPOINT_LOCATION): BREAKPOINT is
			-- New BREAKPOINT at `a_loc'.
			-- be sure `a_loc' was retrieved using `breakpoint_location (r, i, True)'
		require
			singleton_location: breakpoints.has_location (a_loc) implies breakpoint_location (a_loc.routine, a_loc.breakable_line_number, True) = a_loc
		do
			create Result.make (a_loc)
		ensure
			Result_not_void: Result /= Void
			Result_enabled: not a_loc.is_corrupted implies Result.is_enabled
		end

	new_hidden_breakpoint (a_loc: BREAKPOINT_LOCATION): HIDDEN_BREAKPOINT is
			-- New hidden BREAKPOINT at `a_loc'.
			-- be sure `a_loc' was retrieved using `breakpoint_location (r, i, True)'
		require
			singleton_location: breakpoints.has_location (a_loc) implies breakpoint_location (a_loc.routine, a_loc.breakable_line_number, True) = a_loc
		do
			create Result.make_hidden (a_loc)
		ensure
			Result_not_void: Result /= Void
			Result_enabled: not a_loc.is_corrupted implies Result.is_enabled
		end

feature -- Breakpoints status

	has_breakpoint: BOOLEAN is
			-- Does the program have breakpoint ?
		do
			Result := breakpoints.count > 0
		end

	has_set_and_valid_breakpoint: BOOLEAN is
			-- Does the program have a breakpoint (enabled or disabled, hidden or not) ?
		local
			bp: BREAKPOINT
			bplst: like breakpoints
		do
			error_in_bkpts := False

				-- look for the first breakpoint set and (enabled or disabled)
			from
				bplst :=  breakpoints
				bplst.start
			until
				bplst.after or Result
			loop
				bp := bplst.item_for_iteration
				Result := bp.is_set and bp.location.is_valid
				bplst.forth
			end
		end

	has_enabled_breakpoint (include_hidden: BOOLEAN): BOOLEAN is
			-- Does the program have enabled breakpoint?
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
				Result := bp.is_enabled and bp.location.is_valid
					and (include_hidden or not bp.is_hidden)

				bplst.forth
			end
		end

	has_disabled_breakpoint (include_hidden: BOOLEAN): BOOLEAN is
			-- Does the program have disabled breakpoint?
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
				Result := bp.is_disabled and bp.location.is_valid
					and (include_hidden or not bp.is_hidden)
				bplst.forth
			end
		end

feature -- Breakpoints update

	updated_breakpoints_locations_status: HASH_TABLE [INTEGER, BREAKPOINT_LOCATION] is
			-- Update breakpoints location status
		local
			bps: like breakpoints
			bp: BREAKPOINT
			loc: BREAKPOINT_LOCATION
			m: INTEGER
		do
			bps := breakpoints
			if bps /= Void and then not bps.is_empty then
				create Result.make (bps.count)
				from
					bps.start
				until
					bps.after
				loop
					bp := bps.item_for_iteration
					loc := bp.location
					m := bp.update_status
					if Result.has_key (loc) then
						if
							(m = {BREAKPOINT}.breakpoint_to_add) or
							(Result.found_item = {BREAKPOINT}.breakpoint_to_add)
						then
							m := {BREAKPOINT}.breakpoint_to_add
						elseif --| no `breakpoint_to_add'
							(m = {BREAKPOINT}.breakpoint_to_remove) and
							(Result.found_item = {BREAKPOINT}.breakpoint_to_remove)
						then
							m := {BREAKPOINT}.breakpoint_to_remove
						else
							m := {BREAKPOINT}.breakpoint_do_nothing
						end
					end
					Result.force (m, loc)
					bps.forth
				end
			end
		end

	resynchronize_breakpoints is
			-- Resynchronize the breakpoints after a compilation
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
			loc: BREAKPOINT_LOCATION
			nb_bps: INTEGER
			l_routine: E_FEATURE
			l_breakable_line_number: INTEGER
			l_condition: DBG_EXPRESSION
		do
			if not invalid_breakpoint then
					-- update the feature
				loc := bp.location
				loc.update_routine_version
				l_routine := loc.routine

				if
					l_routine /= Void and then
					l_routine.is_debuggable and then
					l_routine.written_class /= Void
				then
					l_breakable_line_number := loc.breakable_line_number
					nb_bps := l_routine.number_of_breakpoint_slots
					if
						nb_bps = 0 --| more likely a bug in compiler data
						or else l_breakable_line_number <= nb_bps
					then
							--| The line of the breakpoint still exists.
							--| the location data are already up to date
							--| thanks to previous call to `loc.update_routine_version'
						loc.set_is_corrupted (False) -- Reset
					else
						check l_breakable_line_number > nb_bps end
							--| Location corrupted
						loc.set_is_corrupted (True)

							--| Get new location at `nb_bps'				
						loc := breakpoint_location (l_routine, nb_bps, True)
						if is_breakpoint_set_at (loc, bp.is_hidden) then
								-- set the breakpoint to be removed: the line does no longer exist
							delete_breakpoint (bp)
						elseif loc.is_corrupted then
							delete_breakpoint (bp)
						else
							check not loc.is_corrupted end
							check nb_bps > 0 end
							bp.set_location (loc)
						end
					end
					if bp.is_set and bp.has_condition then
						l_condition := bp.condition
						l_condition.reset
						if bp.condition_as_is_true and not l_condition.is_boolean_expression (l_routine) then
							bp.remove_condition
							l_condition := Void
						end
					end
				else
						-- The breakpoint is now invalid since its feature has been removed
						-- or is no longer debuggable.
					loc.set_is_corrupted (True)
					delete_breakpoint (bp)
				end
			else -- retried
					-- This is an invalid breakpoint. Discard it.
					-- use bp.location since it is rescued
				bp.location.set_is_corrupted (True)
				delete_breakpoint (bp)
			end
		ensure
			bp.is_set implies bp.location.routine /= Void
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
			cursor: CURSOR
			bp: BREAKPOINT
		do
			btp := breakpoints_tags_provider
			tp := tags_provider
			btp.wipe_out
			tp.wipe_out

			bps := breakpoints
			cursor := bps.cursor
			from
				bps.start
			until
				bps.after
			loop
				bp := bps.item_for_iteration
				if not bp.is_hidden then
					btp.add_tag (bp.to_tag_path)
					tp.add_tags (bp.tags_as_array)
				end
				bps.forth
			end
			bps.go_to (cursor)
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

	breakpoints_at (loc: BREAKPOINT_LOCATION): LIST [BREAKPOINT] is
			-- Breakpoints located at `loc'.
			-- first hidden, then user visible breakpoints
		do
			error_in_bkpts := False
				-- create a 'fake' breakpoint, in order to get the real one in hash table

			if not loc.is_corrupted then
					-- is the breakpoint known ?
				create {LINKED_LIST [BREAKPOINT]} Result.make
				if breakpoints.has_key (new_hidden_breakpoint_key (loc)) then
					Result.extend (breakpoints.found_item)
				end
				if breakpoints.has_key (new_user_breakpoint_key (loc)) then
					Result.extend (breakpoints.found_item)
				end
			else
				error_in_bkpts := True
			end
		end

	breakpoint_at (loc: BREAKPOINT_LOCATION; is_hidden: BOOLEAN): BREAKPOINT is
			-- Breakpoint located at `loc'.
		require
			valid_breakpoint: is_breakpoint_set_at (loc, is_hidden)
		do
			error_in_bkpts := False
				-- create a 'fake' breakpoint, in order to get the real one in hash table

			if not loc.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has_key (new_breakpoint_key (loc, is_hidden)) then
						-- yes, the breakpoint is already known, so remove its condition.
					Result := breakpoints.found_item
				end
			else
				error_in_bkpts := True
			end
		end

	user_breakpoint_at (loc: BREAKPOINT_LOCATION): BREAKPOINT is
			-- User Breakpoint located at `loc'.
		require
			valid_breakpoint: is_user_breakpoint_set_at (loc)
		do
			Result := breakpoint_at (loc, False)
		ensure
			Result_not_void: Result /= Void
		end

	hidden_breakpoint_at (loc: BREAKPOINT_LOCATION): like new_hidden_breakpoint is
			-- User Breakpoint located at `loc'.
		require
			valid_breakpoint: is_user_breakpoint_set_at (loc)
		do
			Result ?= breakpoint_at (loc, False)
		ensure
			Result_not_void: Result /= Void
		end

	is_any_breakpoint_set_at (loc: BREAKPOINT_LOCATION): BOOLEAN is
			-- Is breakpoint set at `loc' ? (enabled or disabled)
		do
			error_in_bkpts := False
			if not loc.is_corrupted then
				if breakpoints.has_key (new_user_breakpoint_key (loc)) then
					Result := breakpoints.found_item.is_set
				end
				if not Result and breakpoints.has_key (new_hidden_breakpoint_key (loc)) then
					Result := breakpoints.found_item.is_set
				end
			else
				error_in_bkpts := True
			end
		end

	is_breakpoint_set_at (loc: BREAKPOINT_LOCATION; is_hidden: BOOLEAN): BOOLEAN is
			-- Is breakpoint set at `loc' ? (enabled or disabled)
		do
			error_in_bkpts := False
			if not loc.is_corrupted then
				if breakpoints.has_key (new_breakpoint_key (loc, is_hidden)) then
					Result := breakpoints.found_item.is_set
				end
			else
				error_in_bkpts := True
			end
		end

	is_user_breakpoint_set_at (loc: BREAKPOINT_LOCATION): BOOLEAN is
			-- Is user breakpoint set at `loc' ? (enabled or disabled)
		do
			Result := is_breakpoint_set_at (loc, False)
		end

	is_hidden_breakpoint_set_at (loc: BREAKPOINT_LOCATION): BOOLEAN is
			-- Is hidden breakpoint set at `loc' ? (enabled or disabled)
		do
			Result := is_breakpoint_set_at (loc, True)
		end

feature -- Breakpoints access with feature,index

	is_breakpoint_set (f: E_FEATURE; i: INTEGER; is_hidden: BOOLEAN): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' set? (enabled or disabled)
		do
			error_in_bkpts := False
			if not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique) then
					-- create a 'fake' breakpoint, in order to get the real one in hash table
				Result := is_breakpoint_set_at (breakpoint_location (f, i, False), is_hidden)
			end
		end

	is_breakpoint_enabled (f: E_FEATURE; i: INTEGER): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' enabled
		local
			loc: BREAKPOINT_LOCATION
		do
			error_in_bkpts := False
			if not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique or else f.real_body_id = 0) then
				loc := breakpoint_location (f, i, False)
				if not loc.is_corrupted then
					if breakpoints.has_key (new_user_breakpoint_key (loc)) then
						Result := breakpoints.found_item.is_enabled
					end
					if not Result then
						if breakpoints.has_key (new_hidden_breakpoint_key (loc)) then
							Result := breakpoints.found_item.is_enabled
						end
					end
				else
					error_in_bkpts := True
				end
			end
		end

	has_user_breakpoint_set (f: E_FEATURE): BOOLEAN is
			-- Has `f' a no hidden breakpoint set to stop?
			-- note: non hidden breakpoint
		do
			error_in_bkpts := False
			if f.is_debuggable then
				Result := not breakpoints_set_for (f, False).is_empty
			end
		end

	user_breakpoint (f: E_FEATURE; i: INTEGER): BREAKPOINT is
			-- User breakpoint located at (`f', `i').
		require
			valid_breakpoint: is_breakpoint_set (f, i, False)
		do
			Result := user_breakpoint_at (breakpoint_location (f, i, False))
		ensure
			Result_not_void: Result /= Void
		end


	user_breakpoint_status (f: E_FEATURE; i: INTEGER): INTEGER is
			-- Returns `Breakpoint_not_set' if breakpoint is not set,
			--         `Breakpoint_set' if breakpoint is set,
			--         `Breakpoint_disabled' if breakpoint is set but disabled,
		local
			bp: BREAKPOINT
			loc: BREAKPOINT_LOCATION
		do
--|			if not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique) then
			error_in_bkpts := False
			Result := Breakpoint_not_set
			if f.valid_body_index then
				if f.real_body_id /= 0 then
					loc := breakpoint_location (f, i, False)
					if not loc.is_corrupted then
						if breakpoints.has_key (new_user_breakpoint_key (loc)) then
							bp := breakpoints.found_item
							check bp /= Void end
							if bp.is_enabled then
								Result := Breakpoint_set
							elseif bp.is_disabled then
								Result := Breakpoint_disabled
							end
--						else
--							Result := Breakpoint_not_set
						end
					end
				else
					error_in_bkpts := True
				end
			end
		end

	breakpoints_set_for (f: E_FEATURE; include_hidden: BOOLEAN): LIST [INTEGER] is
			-- Breakpoints set for feature `f'
		require
			f_is_debuggable: f.is_debuggable
		local
			bp: BREAKPOINT
			loc: BREAKPOINT_LOCATION
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
					loc := bp.location
					if
						loc.body_index.is_equal (f_body_index) and then
						bp.is_set and then
						(include_hidden or not bp.is_hidden)
					then
						Result.extend (loc.breakable_line_number)
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
				loc := bp.location
				if loc.routine.same_as (f) then
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

	features_associated_to (bps: LIST [BREAKPOINT]): LIST [E_FEATURE] is
			-- list of all feature with a breakpoint set (enabled or disabled)
		local
			bp: BREAKPOINT
			loc: BREAKPOINT_LOCATION
			bplst: LIST [BREAKPOINT]
			known_features: ARRAYED_LIST [INTEGER]
			body_index: INTEGER
		do
			error_in_bkpts := False
			create {LINKED_LIST [E_FEATURE]} Result.make
			create known_features.make(5)

			from
				bplst := bps
				bplst.start
			until
				bplst.after
			loop
				bp := bplst.item_for_iteration
				loc := bp.location
				if not loc.is_corrupted and then loc.is_valid then
					body_index := loc.body_index
						-- have we already added the feature corresponding to this breakpoint ?
					if not known_features.has (body_index) then
							-- feature not already added... so add it
						known_features.extend (body_index)
							-- add the feature to the result list
						Result.extend (loc.routine)
					end
				end
				bplst.forth
			end
		ensure
			non_void_result: Result /= Void
		end

	features_with_breakpoint_set (include_hidden: BOOLEAN): LIST [E_FEATURE] is
			-- list of all feature with a breakpoint set (enabled or disabled)
		do
			Result := features_associated_to (breakpoints_set (include_hidden))
		ensure
			non_void_result: Result /= Void
		end

feature -- Query

	user_breakpoints_set: LIST [BREAKPOINT] is
			-- User breakpoints which are set
		do
			Result := breakpoints_set (False)
		end

	user_breakpoints_tagged (a_tags: ARRAY [STRING_32]): LIST [BREAKPOINT] is
			-- User breakpoints which are set and match `a_tags'
		do
			Result := breakpoints_tagged (a_tags, False)
		end

	breakpoints_set (include_hidden: BOOLEAN): LIST [BREAKPOINT] is
			-- breakpoints which are set
		local
			bp: BREAKPOINT
			bplst: like breakpoints
		do
			create {ARRAYED_LIST [BREAKPOINT]} Result.make (breakpoints.count)
			from
				bplst := breakpoints
				bplst.start
			until
				bplst.after
			loop
				bp := bplst.item_for_iteration
				if bp.is_set and (include_hidden or not bp.is_hidden) then
					Result.extend (bp)
				end
				bplst.forth
			end
		ensure
			non_void_result: Result /= Void
		end

	breakpoints_tagged (a_tags: ARRAY [STRING_32]; include_hidden: BOOLEAN): LIST [BREAKPOINT] is
			-- breakpoints which are set and match `a_tags'	
		local
			bp: BREAKPOINT
			bplst: like breakpoints
		do
			if a_tags /= Void and then not a_tags.is_empty then
				create {LINKED_LIST [BREAKPOINT]} Result.make
				from
					bplst := breakpoints
					bplst.start
				until
					bplst.after
				loop
					bp := bplst.item_for_iteration
					if bp.is_set and then (include_hidden or not bp.is_hidden) then
						if bp.match_tags (a_tags) then
							Result.extend (bp)
						end
					end
					bplst.forth
				end
			end
		end

feature -- Breakpoints change

	add_breakpoint (a_bp: BREAKPOINT) is
		require
			a_bp_not_void: a_bp /= Void
		do
			breakpoints.add_breakpoint (a_bp)
		end

	delete_breakpoint (bpk: BREAKPOINT_KEY) is
			-- remove breakpoint related to `bpk'
			-- if no breakpoint found, do nothing
			--| Note: accept Void `bpk'
		local
			bp: BREAKPOINT
		do
			if bpk /= Void and then breakpoints.has_key (bpk) then
					-- yes, the breakpoint is already known, so delete it
				bp := breakpoints.found_item
				bp.discard
				on_breakpoint_added_or_deleted_event (True)
			end
		end

feature -- Breakpoints addition

	set_user_breakpoint, enable_user_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- enable the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', a breakpoint is created
		require
			positive_i: i > 0
			valid_f: not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique)
			debuggable: f.is_debuggable
		local
			loc: BREAKPOINT_LOCATION
		do
			error_in_bkpts := False

			if f.body_index /= 0 then
					-- create a 'fake' breakpoint, in order to get the real one in hash table
				loc := breakpoint_location (f, i, True)
			end

			if loc /= Void and then not loc.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has_key (new_user_breakpoint_key (loc)) then
						-- yes, the breakpoint is already known, so switch it
					breakpoints.found_item.enable
				else
					breakpoints.add_breakpoint (new_user_breakpoint (loc))
				end
			else
				error_in_bkpts := True
			end
			on_breakpoint_added_or_deleted_event (True)
		end

	enable_user_breakpoints_in_feature (f: E_FEATURE) is
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
					if
						bp.body_index.is_equal (f_body_index) and then
						bp.is_set and then not bp.is_hidden
					then
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

	enable_first_user_breakpoint_of_feature (f: E_FEATURE) is
			-- enable the first breakpoints in feature 'f'
		require
			non_void_f: f /= Void
			debuggable: f.is_debuggable
		local
			loc: BREAKPOINT_LOCATION
		do
			error_in_bkpts := False

			loc := breakpoint_location (f, f.first_breakpoint_slot_index, True)
			if not loc.is_corrupted then
				if is_user_breakpoint_set_at (loc) then
					user_breakpoint_at (loc).enable
				else
					breakpoints.add_breakpoint (new_user_breakpoint (loc))
					on_breakpoint_added_or_deleted_event (True)
				end
			else
				error_in_bkpts := True
			end
		end

	enable_first_user_breakpoints_in_class (c: CLASS_C) is
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
						enable_first_user_breakpoint_of_feature (wf.item)
					end
					wf.forth
				end
				on_breakpoint_added_or_deleted_event (True)
			else
				error_in_bkpts := True
			end
		end

	enable_user_breakpoints_in_class (c: CLASS_C) is
			-- enable all breakpoints set for feature 'f'
		require
			non_void_c: c /= Void
		local
			bp: BREAKPOINT
			bps: like breakpoints
		do
			error_in_bkpts := False
				-- search in the list of all_breakpoints
				-- all breakpoint set for class 'c'
			from
				bps := breakpoints
				bps.start
			until
				bps.after
			loop
				bp := bps.item_for_iteration
				if
					bp.is_set and then not bp.is_hidden and then
					bp.location.routine.associated_class.is_equal (c)
				then
					bp.enable
				end
				bps.forth
			end
			on_breakpoint_added_or_deleted_event (True)
		end

feature -- Breakpoints removal

	remove_user_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- remove the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', do nothing
		require
			positive_i: i > 0
			valid_f: not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique)
		local
			loc: BREAKPOINT_LOCATION
		do
			error_in_bkpts := False
				-- create a 'fake' breakpoint, in order to get the real
				-- one in hash tables

			loc := breakpoint_location (f, i, False)
			if not loc.is_corrupted then
				delete_breakpoint (new_user_breakpoint_key (loc))
			else
				error_in_bkpts := True
			end
		end

	remove_user_breakpoints_in_feature (f: E_FEATURE) is
			-- remove all breakpoints set for feature 'f'
		require
			non_void_f: f /= Void
		local
			f_body_index: INTEGER
			bp: BREAKPOINT
			bps: like breakpoints
			retried: BOOLEAN
		do
			error_in_bkpts := False
			if not retried then
				f_body_index := f.body_index

					-- search in the list of all_breakpoints
					-- all breakpoints set for feature 'f'
				from
					bps := breakpoints
					bps.start
				until
					bps.after
				loop
					bp := bps.item_for_iteration
					if
						bp.is_set and then
						not bp.is_hidden and then
						bp.body_index.is_equal (f_body_index)
					then
						delete_breakpoint (bp)
					end
					bps.forth
				end
				on_breakpoint_added_or_deleted_event (True)
			else
				error_in_bkpts := True
			end
		rescue
			retried := True
			retry
		end

	remove_user_breakpoints_in_class (c: CLASS_C) is
			-- remove all breakpoints set for class 'c'
		require
			non_void_c: c /= Void
		local
			bp: BREAKPOINT
			bps: like breakpoints
		do
			error_in_bkpts := False
				-- search in the list of all_breakpoints
				-- all breakpoint set for class 'c'
			from
				bps := breakpoints
				bps.start
			until
				bps.after
			loop
				bp := bps.item_for_iteration
				if
					bp.is_set and then
					not bp.is_hidden and then
					bp.location.routine.associated_class.is_equal (c)
				then
					delete_breakpoint (bp)
				end
				bps.forth
			end
			on_breakpoint_added_or_deleted_event (True)
		end

	clear_breakpoints (include_hidden: BOOLEAN) is
			-- Clear the debugging information.
			-- Save the information if we want to restore it
			-- after the compilation (do not save the information
			-- if there are compilation errors).
		local
			bps: like breakpoints
			bp: BREAKPOINT
		do
				-- Need to individually remove the breakpoints
				-- since the sent_bp must be updated to
				-- not stop.
			error_in_bkpts := False
			from
				bps := breakpoints
				bps.start
			until
				bps.after
			loop
				bp := bps.item_for_iteration
				if bp.is_set and (include_hidden or not bp.is_hidden) then
					delete_breakpoint (bp)
				end
				bps.forth
			end
			on_breakpoint_added_or_deleted_event (True)
		end

	clear_breakpoints_at_once is
			-- Clear the debugging information at once
			-- warning: this clear all breakpoints (including hidden breakpoints)
		do
			breakpoints.wipe_out
			on_breakpoint_added_or_deleted_event (True)
		end

feature -- Breakpoints change

	disable_user_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- disable the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', a disabled breakpoint is created
			-- note: non hidden breakpoint
		require
			valid_f: not (f.is_deferred or else f.is_attribute or else f.is_constant or else f.is_unique)
			positive_i: i > 0
		local
			loc: BREAKPOINT_LOCATION
			bp: BREAKPOINT
		do
			error_in_bkpts := False
				-- create a 'fake' breakpoint, in order to get the real one in hash table

			loc := breakpoint_location (f, i, True)
			if not loc.is_corrupted then
					-- is the breakpoint known ?
				if breakpoints.has_key (new_user_breakpoint_key (loc)) then
						-- yes, the breakpoint is already known, so switch it
					breakpoints.found_item.disable
				else
						-- unknown breakpoint, set it as disabled and add it
					bp := new_user_breakpoint (loc)
					bp.disable
					breakpoints.add_breakpoint (bp)
				end
				on_breakpoint_added_or_deleted_event (False)
			else
				error_in_bkpts := True
			end
		end

	disable_user_breakpoints_in_feature (f: E_FEATURE) is
			-- disable all user breakpoints set for feature 'f'
		require
			non_void_f: f /= Void
		local
			f_body_index: INTEGER
			bp: BREAKPOINT
			bps: like breakpoints
			retried: BOOLEAN
		do
			error_in_bkpts := False
			if not retried then
				f_body_index := f.body_index

				-- search in the list of all_breakpoints
				-- all breakpoint set for feature 'f'
				from
					bps := breakpoints
					bps.start
				until
					bps.after
				loop
					bp := bps.item_for_iteration
					if
						bp.body_index.is_equal (f_body_index) and then
						bp.is_set and then
						not bp.is_hidden
					then
						bp.disable
					end
					bps.forth
				end
				on_breakpoint_added_or_deleted_event (False)
			else
				error_in_bkpts := True
			end
		rescue
			retried := True
			retry
		end

	disable_user_breakpoints_in_class (c: CLASS_C) is
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
				if
					bp.is_set and then not bp.is_hidden and then
					bp.location.routine.associated_class.is_equal (c)
				then
					bp.disable
				end
				bplst.forth
			end
			on_breakpoint_added_or_deleted_event (False)
		end

	disable_all_breakpoints (include_hidden: BOOLEAN) is
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
				if
					bp.is_enabled and (include_hidden or not bp.is_hidden)
				then
					bp.disable
				end
				bplst.forth
			end
			on_breakpoint_added_or_deleted_event (False)
		end

	enable_all_user_breakpoints is
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
				if
					not bp.is_hidden and then
					bp.is_disabled
				then
					bp.enable
				end
				bplst.forth
			end
			on_breakpoint_added_or_deleted_event (False)
		end

feature -- Breakpoints constants

	Breakpoint_not_set: INTEGER 	=  0
	Breakpoint_set: INTEGER 		=  1
	Breakpoint_disabled: INTEGER 	= -1
			-- Possible value for `breakpoint_status'.

feature -- Debugging purpose

	metrics: TUPLE [total: INTEGER; not_set: INTEGER; enabled: INTEGER; hidden_enabled: INTEGER; disabled: INTEGER; hidden_disabled: INTEGER] is
			-- Debug purpose breakpoints metrics.
		local
			bps: like breakpoints
			bp: BREAKPOINT
		do
			debug ("breakpoint")
				Result := [breakpoints.count, 0, 0, 0, 0, 0]
				bps := breakpoints
				from
					bps.start
				until
					bps.after
				loop
					bp := bps.item_for_iteration
					if bp.is_set then
						if bp.is_enabled then
							if bp.is_hidden then
								Result.hidden_enabled := Result.hidden_enabled + 1
							else
								Result.enabled := Result.enabled + 1
							end
						elseif bp.is_disabled then
							if bp.is_hidden then
								Result.hidden_disabled := Result.hidden_disabled + 1
							else
								Result.disabled := Result.disabled + 1
							end
						else
							check False end
						end
					else
						Result.not_set := Result.not_set + 1
					end
					bps.forth
				end
			end
		end


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
