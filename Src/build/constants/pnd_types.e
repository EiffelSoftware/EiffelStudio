indexing
	description: "Pick and drop types."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class PND_TYPES

inherit
	CONSTANTS

feature -- Constants

	argument_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.type_cursor)
		end

--	application_object_type: EV_PND_TYPE is
--		once
--			create Result.make_with_cursor (Cursors.application_cursor)
--		end

	attribute_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.type_cursor)
		end

	behavior_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.behavior_cursor)
		end

	color_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.color_cursor)
		end

	command_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.command_cursor)
		end

	context_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.context_cursor)
		end

	event_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.event_cursor)
		end

	label_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.label_cursor)
		end

	instance_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.command_instance_cursor)
		end

	new_state_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.state_cursor)
		end

	state_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.state_cursor)
		end

	transition_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.transition_cursor)
		end

feature -- Context types

	type_data_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.type_cursor)
		end

	perm_wind_type: EV_PND_TYPE is
			-- Type for perm windows context (PERM_WIND_C)
		once
			create Result.make_with_cursor (Cursors.window_cursor)
		end

	window_child_type: EV_PND_TYPE is
			-- Type for context that accept only a window as parent
		once
			create Result.make_with_cursor (Cursors.type_cursor)
		end

	widget_type: EV_PND_TYPE is
			-- Type for widget context that accept only a container as parent
		once
			create Result.make_with_cursor (Cursors.type_cursor)
		end

	menu_child_type: EV_PND_TYPE is
			-- Type for context that accept only a menu holder as parent
		once
			create Result.make_with_cursor (Cursors.type_cursor)
		end

	menu_item_type: EV_PND_TYPE is
			-- Type for menu_item that accept only a menu item holder as parent
		once
			create Result.make_with_cursor (Cursors.type_cursor)
		end

	toolbar_item_type: EV_PND_TYPE is
			-- Type for context that accept only a tool-bar as parent
		once
			create Result.make_with_cursor (Cursors.type_cursor)
		end

	status_bar_item_type: EV_PND_TYPE is
			-- Type for status bar item that accept only a status bar as parent
		once
			create Result.make_with_cursor (Cursors.type_cursor)
		end

	list_item_type: EV_PND_TYPE is
			-- Type for list item that accept only a list as parent
		once
			create Result.make_with_cursor (Cursors.type_cursor)
		end

	multi_column_row_type: EV_PND_TYPE is
			-- Type for m. c. row that accept only a m. c. list holder as parent
		once
			create Result.make_with_cursor (Cursors.type_cursor)
		end

	tree_item_type: EV_PND_TYPE is
			-- Type for tree_item that accept only a tree item holder as parent
		once
			create Result.make_with_cursor (Cursors.type_cursor)
		end

end -- class PND_TYPES

