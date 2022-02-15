note
	description	: "Facilities to manage the history of a development window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

class
	EB_HISTORY_MANAGER

inherit
	EB_RECYCLABLE

	EB_SHARED_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make (a_owner: EB_HISTORY_OWNER)
			   -- Initialization
		local
			max_size: INTEGER
		do
			create history.make (10)
			index_active := 1
			target := a_owner
			create back_command.make (a_owner)
			create forth_command.make (a_owner)
			max_size := max_display_size
			create class_display_list.make (max_size)
			create cluster_display_list.make (max_size)
			create feature_display_list.make (max_size)
				-- Register the recyclable command
			auto_recycle (back_command)
			auto_recycle (forth_command)

				-- register itself as recyclable to parent
			a_owner.auto_recycle (Current)
		end

feature -- Access

	active: STONE
			-- Active item. Void if history is empty or current stone is invalid.
		do
			if not is_empty then
				Result := history.i_th (index_active)
				if Result /= Void and then not Result.is_valid then
					Result := Result.synchronized_stone
					if Result /= Void and then not Result.is_valid then
						Result := Void
					end
				end
			end
		ensure
			return_only_valid_stones: (Result /= Void) implies Result.is_valid
				-- Does not hold for invalid stones.
--			not_empty_iff_result_not_void: (not is_empty) = (Result /= Void)
		end

	count: INTEGER
			-- Number of elements in the history
		do
			Result := history.count
		end

	list: LIST [STONE]
			-- Linear representation of the history.
		do
			Result := history
		end

	class_display_list: ARRAYED_LIST [CELL2 [CLASSI_STONE, INTEGER]]
			-- Representation of the class history without repeating classes.

	cluster_display_list: ARRAYED_LIST [CELL2 [CLUSTER_STONE, INTEGER]]
			-- Representation of the class history without repeating classes.

	feature_display_list: ARRAYED_LIST [CELL2 [FEATURE_STONE, INTEGER]]
			-- Representation of the feature history without repeating features.

	target: EB_HISTORY_OWNER
			-- Target for current history.

	back_command: EB_HISTORY_BACK_COMMAND
			-- Command to go back in the history

	forth_command: EB_HISTORY_FORTH_COMMAND
			-- Command to go forth in the history

	new_menu: EB_HISTORY_MANAGER_MENU
			-- Menu representing the history, automatically
			-- recycled when Current will be recycled.
		do
			create Result.make (Current)
			auto_recycle (Result)
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is the history empty?
		do
			Result := (history.count = 0)
		end

	is_back_possible: BOOLEAN
			-- Is the operation `back' possible?
			-- Yes iff `active_index' > 1 and there is one stone before that is not `Void'.
		local
			valid_found: BOOLEAN
			cur: INTEGER
		do
			if not history.is_empty then
				from
					cur := index_active - 1
				until
					valid_found or cur <= 0
				loop
					valid_found := history.i_th (cur) /= Void
					cur := cur - 1
				end
				Result := valid_found
			else
				Result := False
			end
		ensure
				--| `cur + 1' because in the loop we decrement `cur'.
				-- This means there is a valid stone before `active' in the history.
--			found: Result implies (cur + 1 < index_active and history.i_th (cur + 1) /= void)
		end

	is_forth_possible: BOOLEAN
			-- Is the operation `forth' possible?
		local
			valid_found: BOOLEAN
			cur: INTEGER
		do
			if not history.is_empty then
				from
					cur := index_active + 1
				until
					valid_found or cur > history.count
				loop
					valid_found := history.i_th (cur) /= Void
					cur := cur + 1
				end
				Result := valid_found
			else
				Result := False
			end
		ensure
				--| `cur - 1' because in the loop we increment `cur'.
				-- This means there is a valid stone after `active' in the history.
--			found: Result implies (cur - 1 > index_active and history.i_th (cur - 1) /= void)
		end

	is_go_i_th_possible (i: INTEGER): BOOLEAN
			-- Is the operation `go_i_th (i)' possible?
		do
			Result := (not is_empty) and (i >= 1) and (i <= count)
		end

	has (a_stone: STONE): BOOLEAN
			-- Does current has `a_stone'?
		local
			l_history: like history
			l_index: INTEGER
		do
			l_history := history
			l_index := l_history.index
			from
				l_history.start
			until
				l_history.after or else Result
			loop
				if l_history.item /= Void and then a_stone.same_as (l_history.item) then
					Result := True
				end
				l_history.forth
			end
			l_history.go_i_th (l_index)
		end

feature -- Element change

	back
			-- go back in the history
		require
			operation_possible: is_back_possible
		local
			valid_found: BOOLEAN
			initial: INTEGER
		do
			initial := index_active
			fresh_active_position
			from
				index_active := index_active - 1
			until
				valid_found
			loop
				check
					valid_index: index_active >= 1
					-- Because of the precondition
				end
				valid_found := history.i_th (index_active) /= Void
				index_active := index_active - 1
			end
			index_active := index_active + 1
			notify_observers (notify_move, Void, index_active)
			target.set_stone (active)
			if target.history_moving_cancelled then
					-- The user cancelled the set_stone.
					-- We must go back to our previous position.
				index_active := initial
				notify_observers (notify_move, Void, index_active)
				target.set_history_moving_cancelled (False)
			end
		end

	forth
			-- go forward in the history
		require
			operation_possible: is_forth_possible
		local
			valid_found: BOOLEAN
			initial: INTEGER
		do
			initial := index_active
			fresh_active_position
			from
				index_active := index_active + 1
			until
				valid_found
			loop
				check
					valid_index: index_active <= history.count
					-- Because of the precondition
				end
				valid_found := history.i_th (index_active) /= Void
				index_active := index_active + 1
			end

			index_active := index_active - 1
			notify_observers (notify_move, Void, index_active)
			target.set_stone (active)
			if target.history_moving_cancelled then
					-- The user cancelled the set_stone.
					-- We must go back to our previous position.
				index_active := initial
				notify_observers (notify_move, Void, index_active)
				target.set_history_moving_cancelled (False)
			end
		end

	go_i_th (i: INTEGER)
			-- Go to level `i' of history. 1 stands for the begginning
			-- of the history, `count' for the most recently stone added
			-- to history.
			-- Warning: This may position the history on an invalid stone (a Void one).
		require
			operation_possible: is_go_i_th_possible (i)
		local
			initial: INTEGER
		do
			initial := index_active
			fresh_active_position
			index_active := i
			notify_observers (notify_move, Void, index_active)
			target.set_stone (active)
			if target.history_moving_cancelled then
					-- The user cancelled the set_stone.
					-- We must go back to our previous position.
				index_active := initial
				notify_observers (notify_move, Void, index_active)
				target.set_history_moving_cancelled (False)
			end
		end

	navigate_to (a_stone: STONE)
			-- Navigate to `a_stone'.
		require
			has_a_stone: has (a_stone)
		local
			l_history: like history
			l_item: STONE
			l_found: BOOLEAN
			initial: INTEGER
		do
			initial := index_active
			l_history := history.twin
			from
				l_history.start
			until
				l_history.after or else l_found
			loop
				l_item := l_history.item
				if l_item /= Void and then a_stone.same_as (l_item) then
					index_active := l_history.index
					notify_observers (notify_remove, l_item, index_active)
					l_found := True
				end
				l_history.forth
			end
			if target.history_moving_cancelled then
					-- The user cancelled the set_stone.
					-- We must go back to our previous position.
				index_active := initial
				notify_observers (notify_move, Void, index_active)
				target.set_history_moving_cancelled (False)
			end
		ensure
			active_is_a_stone: a_stone.same_as (active)
		end

	extend (a_stone: STONE)
			-- Add `a_stone' to the right of `active'. Remove everything
			-- after `active'.
		local
			history_item: STONE
			fst: FEATURE_STONE
			active_is_cst: BOOLEAN
			i: INTEGER
		do
			active_is_cst := attached {CLASSI_STONE} active and not attached {FEATURE_STONE} active
			if active_is_cst then
				fst := {FEATURE_STONE} / a_stone
			else
				fst := Void
			end
			if
					-- We do not want the same stone twice in the history...
				(active /= Void and then
				a_stone /= Void and then
				not (active.same_as (a_stone)) or else
				active = Void or else
				a_stone = Void) or else
					-- ...Unless it is a feature stone following a class stone.
				fst /= Void and then
				not fst.same_as (active)
					--| Useless test: if fst /= Void, then active is not Void and a classi_stone.
				--active_is_cst
			then
				fresh_active_position
				if is_forth_possible then
						-- Wipe out everything after `active'
					from
						history.go_i_th (index_active)
						history.forth
						i := index_active + 1
					until
						history.after
					loop
						history_item := history.item
						history.remove
						notify_observers (notify_remove, history_item, i)
						i := i + 1
					end
				end

					-- Add the new stone at the end of the history.
				fst := Void
				if attached {FEATURE_STONE} a_stone as fst2  then
					history.extend (fst2)
				else
					history.extend (a_stone)
				end

					-- Set the new stone to be the active one.
				index_active := history.count

				build_display_lists

				if fst = Void then
					notify_observers (notify_add, a_stone, index_active)
				else
					notify_observers (notify_add, fst, index_active)
				end
				notify_observers (notify_move, Void, index_active)
			end
		ensure
			--| Does not hold for call_Stack_stones, which are converted into feature stones.
--			stone_is_active: equal (a_stone, active)
		end

	synchronize
			-- Replace all invalid stones with `Void' in the history.
			-- Should be called after each compilation.
		local
			cur: CURSOR
		do
			from
				cur := history.cursor
				history.start
			until
				history.after
			loop
				if history.item /= Void then
					history.replace (history.item.synchronized_stone)
				end
				history.forth
			end
			history.go_to (cur)
			build_display_lists
			notify_observers (notify_changed, Void, 0)
		end

feature {EB_HISTORY_MANAGER_OBSERVER} -- Observer pattern / Registration

	add_observer (an_observer: EB_HISTORY_MANAGER_OBSERVER)
			-- Add `an_observer' to the list of observers for Current.
		require
			valid_observer: an_observer /= Void
		do
			if observers = Void then
				create observers.make (2)
			end
			observers.extend (an_observer)
		end

	remove_observer (an_observer: EB_HISTORY_MANAGER_OBSERVER)
			-- Remove `an_observer' to the list of observers for Current.
		require
			valid_observer: an_observer /= Void
		do
			if observers /= Void then
				observers.prune_all (an_observer)
			end
		end

feature {NONE} -- Recyclable

	internal_recycle
			-- Recycle
		do
			target := Void
		end

feature {NONE} -- Observer pattern / Implementation

	notify_observers (a_notification_code: INTEGER; a_stone: STONE; a_position: INTEGER)
			-- The history or the active position has changed.
		do
			if observers /= Void then
				from
					observers.start
				until
					observers.after
				loop
					inspect a_notification_code
					when notify_move then
						observers.item.on_position_changed
					when notify_add then
						observers.item.on_item_added (a_stone, a_position)
					when notify_remove then
						observers.item.on_item_removed (a_stone, a_position)
					when notify_changed then
						observers.item.on_update
					end
					observers.forth
				end
			end
		end

	observers: ARRAYED_LIST [EB_HISTORY_MANAGER_OBSERVER]
			-- All observers for Current.

	notify_move: INTEGER = 0
	notify_add: INTEGER = 1
	notify_remove: INTEGER = 2
	notify_changed: INTEGER = 3

feature {NONE} -- Implementation

	history: ARRAYED_LIST [STONE]
			-- History

	index_active: INTEGER
			-- Index of the active item.

	build_display_lists
			-- Generate the *_display_list according to the history state.
		local
			already_displayed: BOOLEAN
			max_size: INTEGER
			l_history_item: STONE
		do
			feature_display_list.wipe_out
			class_display_list.wipe_out
			cluster_display_list.wipe_out
			max_size := max_display_size
			from
				history.finish
			until
				history.before
			loop
					--| First find the first valid item.
				from
				until
					history.before or else
					history.item /= Void
				loop
					history.back
				end

				already_displayed := False
				if not history.before then
					l_history_item := history.item
						--| Is it a feature?
					if attached {FEATURE_STONE} l_history_item as conv_f then
						if feature_display_list.count < max_size then
							from
								feature_display_list.start
							until
								feature_display_list.after
							loop
								if feature_display_list.item.item1.same_as (l_history_item) then
									already_displayed := True
									feature_display_list.finish
								end
								feature_display_list.forth
							end
							if not already_displayed then
								feature_display_list.extend (create {CELL2 [FEATURE_STONE, INTEGER]}.make (conv_f, history.index))
								feature_display_list.finish
							end
						end

						--| Is it a class?
					elseif attached {CLASSI_STONE} l_history_item as conv_cl then
						if class_display_list.count < max_size then
							from
								class_display_list.start
							until
								class_display_list.after
							loop
								if class_display_list.item.item1.same_as (l_history_item) then
									already_displayed := True
									class_display_list.finish
								end
								class_display_list.forth
							end
							if not already_displayed then
								class_display_list.extend (create {CELL2 [CLASSI_STONE, INTEGER]}.make (conv_cl, history.index))
								class_display_list.finish
							end
						end

						--| Is it a cluster?
					elseif attached {CLUSTER_STONE} l_history_item as conv_clu then
						if cluster_display_list.count < max_size then
							from
								cluster_display_list.start
							until
								cluster_display_list.after
							loop
								if cluster_display_list.item.item1.same_as (l_history_item) then
									already_displayed := True
									cluster_display_list.finish
								end
								cluster_display_list.forth
							end
							if not already_displayed then
								cluster_display_list.extend (create {CELL2 [CLUSTER_STONE, INTEGER]}.make (conv_clu, history.index))
								cluster_display_list.finish
							end
						end
					end
					history.back
				end
			end
		end

	max_display_size: INTEGER
			-- Maximum number of items displayed in the history (in the address combo boxes).
		do
			Result := preferences.development_window_data.max_history_size
		end

	fresh_active_position
			-- Fresh active stone position
		do
			if active /= Void then
				if target.position >= 0 then
					active.set_position (target.position)
				else
					active.set_position (0)
				end
				if target.pos_container /= Void then
					active.set_pos_container (target.pos_container)
				else
					active.set_pos_container (Void)
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_HISTORY_MANAGER

