indexing
	description: "Objects that represent a menu client programmer supplied."
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
		do
			title := a_title
			menu_items := a_items
		ensure
			set: title = a_title
		end

	make_with_tool_bar (a_title: STRING; a_tool_bar: EV_TOOL_BAR) is
			--
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
		end

feature -- Properties

	title: STRING
		-- Menu title.

	menu_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
			-- All 	EV_TOOL_BAR_ITEM in `Current'.

end
