indexing
	description	: "Facilities to manage the history of a development window."
	date		: "$Date$"
	revision	: "$Revision $"

class
	EB_HISTORY_MANAGER

inherit
	EB_RECYCLABLE
	
	EB_RECYCLER
		rename
			destroy as recycle
		end

	SHARED_RESOURCES

creation
	make

feature {NONE} -- Initialization

	make (a_owner: EB_HISTORY_OWNER) is
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
			add_recyclable (back_command)
			add_recyclable (forth_command)

				-- register itself as recyclable to parent
			a_owner.add_recyclable (Current)
		end

feature -- Access

	active: STONE is
			-- Active item. Void iff history is empty or current stone is invalid.
		do
			if not is_empty then
				Result := history.i_th (index_active)
			end
		ensure
			return_only_valid_stones: (Result /= Void) implies Result.is_valid
				-- Does not hold for invalid stones.
--			not_empty_iff_result_not_void: (not is_empty) = (Result /= Void)
		end

	count: INTEGER is
			-- Number of elements in the history
		do
			Result := history.count
		end

	list: LIST [STONE] is
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

	new_menu: EB_HISTORY_MANAGER_MENU is
			-- Menu representing the history, automatically
			-- recycled when Current will be recycled.
		do
			create Result.make (Current)
			add_recyclable (Result)
		end

feature -- Status report

	is_empty: BOOLEAN is
			-- Is the history empty?
		do
			Result := (history.count = 0)
		end

	is_back_possible: BOOLEAN is
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

	is_forth_possible: BOOLEAN is
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

	is_go_i_th_possible (i: INTEGER): BOOLEAN is
			-- Is the operation `go_i_th (i)' possible?
		do
			Result := (not is_empty) and (i >= 1) and (i <= count)
		end

feature -- Element change

	back is
			-- go back in the history
		require
			operation_possible: is_back_possible
		local
			valid_found: BOOLEAN
			initial: INTEGER
		do
			initial := index_active
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
			target.advanced_set_stone (active)
			if not target.stone.is_equal (active) then
					-- The user cancelled the set_stone.
					-- We must go back to our previous position.
				index_active := initial
				notify_observers (notify_move, Void, index_active)
			end
		end

	forth is
			-- go forward in the history
		require
			operation_possible: is_forth_possible
		local
			valid_found: BOOLEAN
			initial: INTEGER
		do
			initial := index_active
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
			target.advanced_set_stone (active)
			if not target.stone.is_equal (active) then
					-- The user cancelled the set_stone.
					-- We must go back to our previous position.
				index_active := initial
				notify_observers (notify_move, Void, index_active)
			end
		end

	go_i_th (i: INTEGER) is
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
			index_active := i
			notify_observers (notify_move, Void, index_active)
			target.advanced_set_stone (active)
			if not target.stone.is_equal (active) then
					-- The user cancelled the set_stone.
					-- We must go back to our previous position.
				index_active := initial
				notify_observers (notify_move, Void, index_active)
			end
		end

	extend (a_stone: STONE) is
			-- Add `a_stone' to the right of `active'. Remove everything
			-- after `active'.
		local
			history_item: STONE
			fst, fst2: FEATURE_STONE
			cst: CLASSI_STONE
			active_is_cst: BOOLEAN
			i: INTEGER
		do
			cst ?= active
			fst ?= active
			active_is_cst := cst /= Void and fst = Void
			if active_is_cst then
				fst ?= a_stone
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
				fst2 ?= a_stone
				if fst2 /= Void  then
					create fst.make (fst2.e_feature)
					history.extend (fst)
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

	synchronize is
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

	add_observer (an_observer: EB_HISTORY_MANAGER_OBSERVER) is
			-- Add `an_observer' to the list of observers for Current.
		require
			valid_observer: an_observer /= Void
		do
			if observers = Void then
				create observers.make (2)
			end
			observers.extend (an_observer)
		end

	remove_observer (an_observer: EB_HISTORY_MANAGER_OBSERVER) is
			-- Remove `an_observer' to the list of observers for Current.
		require
			valid_observer: an_observer /= Void
		do
			if observers /= Void then
				observers.prune_all (an_observer)
			end
		end

feature {NONE} -- Observer pattern / Implementation

	notify_observers (a_notification_code: INTEGER; a_stone: STONE; a_position: INTEGER) is
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

	notify_move: INTEGER is 0
	notify_add: INTEGER is 1
	notify_remove: INTEGER is 2
	notify_changed: INTEGER is 3
	
feature {NONE} -- Implementation

	history: ARRAYED_LIST [STONE]
			-- History

	index_active: INTEGER
			-- Index of the active item.
			
	build_display_lists is
			-- Generate the *_display_list according to the history state.
		local
			already_displayed: BOOLEAN
			conv_cl: CLASSI_STONE
			conv_clu: CLUSTER_STONE
			conv_f: FEATURE_STONE
			max_size: INTEGER
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
						--| Is it a feature?
					conv_f ?= history.item
					if conv_f /= Void then
						if feature_display_list.count < max_size then
							from
								feature_display_list.start
							until
								feature_display_list.after
							loop
								if feature_display_list.item.item1.same_as (history.item) then
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
					else
							--| Is it a class?
						conv_cl ?= history.item
						if conv_cl /= Void then
							if class_display_list.count < max_size then
								from
									class_display_list.start
								until
									class_display_list.after
								loop
									if class_display_list.item.item1.same_as (history.item) then
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
						else
								--| Is it a cluster?
							conv_clu ?= history.item
							if conv_clu /= Void then
								if cluster_display_list.count < max_size then
									from
										cluster_display_list.start
									until
										cluster_display_list.after
									loop
										if cluster_display_list.item.item1.same_as (history.item) then
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
						end
					end
					history.back
				end
			end
		end

	max_display_size: INTEGER is
			-- Maximum number of items displayed in the history (in the address combo boxes).
		do
			Result := integer_resource_value ("maximum_history_size", 10)
		end
	
end -- class EB_HISTORY_MANAGER
