indexing
	description: "[
					When show hidden SD_TOOL_BAR_ITEMs by SD_TOOL_BAR_HIDDEN_ITEM_DIALOG.
					We use this class to make sure items grouping looks nice.
																						]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_HIDDEN_GROUP_DIVIDER

create
	make

feature {NONE} -- Initlization

	make (a_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]) is
			-- Creation method.
		require
			not_void: a_items /= Void
		do
			create algorithm.make (a_items.count)
			internal_items := a_items
			init_item_width (a_items)
		ensure
			set: internal_items = a_items
		end

	init_item_width (a_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]) is
			-- Initlization items width.
		require
			not_void: a_items /= Void
		local
			l_widths: ARRAY [INTEGER]
		do
			from
				create l_widths.make (1, a_items.count)
				a_items.start
			until
				a_items.after
			loop
				l_widths.put (a_items.item.width, a_items.index)
				a_items.forth
			end
			algorithm.set_items_width (l_widths)
		ensure
			set: algorithm.item_width /= Void
		end

feature -- Properties

	max_width_allowed: INTEGER
			-- Maximum width allowed.

	set_max_width_allowed (a_max_width: INTEGER) is
			-- Set `max_width_allowed'
		require
			valid: 0 < a_max_width
		do
			max_width_allowed := a_max_width
		ensure
			set: max_width_allowed = a_max_width
		end

feature -- Query

	grouped_items is
			-- Grouped items by `max_width_allowed'
		require
			set: max_width_allowed > 0
		local
			l_group_count: INTEGER
			l_group_info: SD_TOOL_BAR_GROUP_INFO
			l_one_group: ARRAYED_LIST [INTEGER]
			l_stop: BOOLEAN
		do
			from
				l_group_count := 1
			until
				l_group_count > internal_items.count or l_stop
			loop

				if algorithm.maximum_group_width (l_group_count) <= max_width_allowed then
					l_stop := True
					l_group_info := algorithm.best_grouping
					from
						l_group_info.start
					until
						l_group_info.after
					loop
						l_one_group := l_group_info.item
						from
							l_one_group.start
						until
							l_one_group.after
						loop
							if l_one_group.index /= l_one_group.count then
								internal_items.i_th (l_one_group.item).set_wrap (False)
							else
								internal_items.i_th (l_one_group.item).set_wrap (True)
							end
							l_one_group.forth
						end
						l_group_info.forth
					end
				end
				l_group_count := l_group_count + 1
			end
			internal_items.last.set_wrap (False)
		end

feature {NONE}	-- Implementation

	algorithm: 	SD_TOOL_BAR_GROUP_ALGORITHM
			-- Grouping algorithm.

	internal_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Items to be grouped.

invariant
	not_void: algorithm /= Void
	not_void: internal_items /= Void

end
