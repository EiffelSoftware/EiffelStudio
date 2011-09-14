note
	description: "[
					Command to save project
																			]"
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
			-- <Precursor>
		do
			if attached shared_singleton.layout_constructor_list.first as l_layout_constructor then
				l_layout_constructor.save_tree
			end
		end

feature -- Query

	new_menu_item: SD_TOOL_BAR_BUTTON
			-- Create a menu item
		do
			create Result.make
			Result.set_text ("Save Project")
			Result.set_name ("Save Project")
			Result.set_description ("Save Project")
			Result.select_actions.extend (agent execute)
			tool_bar_items.extend (Result)
		end

feature {NONE} -- Implementation

	main_window: detachable EV_WINDOW
			-- Tool's main window

	shared_singleton: ER_SHARED_SINGLETON
			-- Shared singleton
end
