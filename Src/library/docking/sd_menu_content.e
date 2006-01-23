indexing
	description: "Contents that have a menu items client programmer want to managed by docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_CONTENT

create
	make,
	make_with_tool_bar

feature {NONE} -- Initlization

	make (a_title: STRING; a_items: like menu_items) is
			-- Creation method.
		require
			a_title_not_void: a_title /= Void
			a_items_not_void: a_items /= Void
		do
			title := a_title
			menu_items := a_items
		ensure
			set: title = a_title
			set: menu_items = a_items
		end

	make_with_tool_bar (a_title: STRING; a_tool_bar: EV_TOOL_BAR) is
			-- Creation method.
		require
			a_title_not_void: a_title /= Void
			a_tool_bar_not_void: a_tool_bar /= Void
		local
			l_item: EV_TOOL_BAR_ITEM
			l_temp_items: like menu_items
		do
			from
				a_tool_bar.start
				create l_temp_items.make (0)
			until
				a_tool_bar.after
			loop
				l_item := a_tool_bar.item
				if a_tool_bar.parent /= Void then
					a_tool_bar.item.parent.prune (a_tool_bar.item)
				end
				l_temp_items.extend (l_item)
				a_tool_bar.forth
			end
			make (a_title, l_temp_items)
		ensure
			set: a_title = title
			set: a_tool_bar.count = menu_items.count
		end

feature -- Properties

	title: STRING
			-- Menu title.

	menu_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM];
			-- All 	EV_TOOL_BAR_ITEM in `Current'.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
