note
	description: "Summary description for {ER_SAVE_PROJECT_COMMAND}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SAVE_PROJECT_COMMAND

inherit
	ER_COMMAND

create
	make

feature {NONE} -- Initlization

	make (a_menu: EV_MENU_ITEM)
			-- Creation method
		do
			init
			create shared_singleton
			menu_items.extend (a_menu)
		end

feature -- Command

	execute
			--
		do
			if attached shared_singleton.layout_constructor_cell.item as l_layout_constructor then
				l_layout_constructor.save_tree
			end
		end

feature -- Query

	new_menu_item: SD_TOOL_BAR_BUTTON
			--
		do
			create Result.make
			Result.set_text ("Save")
			Result.select_actions.extend (agent execute)
			tool_bar_items.extend (Result)
		end

feature {NONE} -- Implementation

	main_window: detachable EV_WINDOW
			--

	shared_singleton: ER_SHARED_SINGLETON
			--
end
