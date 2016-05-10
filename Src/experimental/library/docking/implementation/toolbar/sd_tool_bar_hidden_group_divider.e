note
	description: "[
		When show hidden SD_TOOL_BAR_ITEMs by SD_TOOL_BAR_HIDDEN_ITEM_DIALOG,
		We use this class to make sure items grouping looks nice.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_HIDDEN_GROUP_DIVIDER

create
	make

feature {NONE} -- Initlization

	make (a_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM])
			-- Creation method
		require
			not_void: a_items /= Void
		local
			l_widths: ARRAYED_LIST [INTEGER]
		do
			from
				create l_widths.make_filled (a_items.count)
				a_items.start
			until
				a_items.after
			loop
				l_widths.put_i_th (a_items.item.width, a_items.index)
				a_items.forth
			end
			create algorithm.make (a_items.count, l_widths)
			internal_items := a_items
		ensure
			set: internal_items = a_items
		end

feature -- Properties

	max_width_allowed: INTEGER
			-- Maximum width allowed

	set_max_width_allowed (a_max_width: INTEGER)
			-- Set `max_width_allowed'
		require
			valid: 0 < a_max_width
		do
			max_width_allowed := a_max_width
		ensure
			set: max_width_allowed = a_max_width
		end

feature -- Query

	grouped_items
			-- Grouped items by `max_width_allowed'
		require
			set: max_width_allowed > 0
		local
			l_group_count: INTEGER
			l_group_info: ARRAYED_LIST [ARRAYED_LIST [INTEGER]]
			l_stop: BOOLEAN
		do
			from
				l_group_count := 1
			until
				l_group_count > internal_items.count or l_stop
			loop
				if algorithm.maximum_group_width (l_group_count) <= max_width_allowed then
					l_stop := True
					l_group_info := algorithm.best_grouping_when (l_group_count).deep_twin
					from
						l_group_info.start
					until
						l_group_info.after
					loop
						if l_group_info.index /= 1 and internal_items.valid_index (l_group_info.item.first - 1) then
							internal_items.i_th (l_group_info.item.first - 1).set_wrap (True)
						else
							internal_items.i_th (l_group_info.index).set_wrap (False)
						end

						l_group_info.forth
					end
				end
				l_group_count := l_group_count + 1
			end
			internal_items.last.set_wrap (False)
		end

feature {NONE}	-- Implementation

	algorithm: 	SD_HUFFMAN_ALGORITHM
			-- Grouping algorithm

	internal_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Items to be grouped

invariant
	not_void: algorithm /= Void
	not_void: internal_items /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
