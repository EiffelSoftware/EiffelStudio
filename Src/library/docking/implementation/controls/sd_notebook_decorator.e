indexing
	description:
		"[
			A EV_NOTEBOOK with a min tool bar area and a close button.
		]"
	appearance:
		"[
			  _______  _______  _______     _______________    _
			_/ tab_1 \/_tab_2_\/_tab_3_\___|_mini tool bar_|__|X|
			|                              						|
			|         selected_item          					|
			|                                					|
			----------------------------------------------------
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_DECORATOR

inherit
	EV_FIXED

create
	make

feature {NONE} -- Initialization

	make (a_notebook: EV_NOTEBOOK) is
			-- Creation method
		require
			a_notebook_not_void: a_notebook /= Void
			a_note_book_parent_void: a_notebook.parent = Void
		do
			default_create
			create internal_shared

			notebook := a_notebook
			extend (notebook)
			notebook.set_tab_position ({EV_NOTEBOOK}.tab_top)

			create tool_bar_cell
			extend (tool_bar_cell)
			tool_bar_cell.set_minimum_height (internal_shared.title_bar_height - 2)

			create close_button_bar
			create close_button
			close_button.set_pixmap (internal_shared.icons.close)
			close_button_bar.extend (close_button)
			close_button_bar.set_minimum_size (internal_shared.title_bar_height - 2, internal_shared.title_bar_height - 2)
			extend (close_button_bar)

			close_button.pointer_button_press_actions.extend (agent on_close_button_pointer_press)

			resize_actions.extend (agent on_fixed_resize)
		ensure
			set: a_notebook = notebook
		end

feature -- Basic operation

	set_mini_tool_bar (a_mini_tool_bar: EV_TOOL_BAR) is
			-- Set `a_mini_tool_bar' to `tool_bar_cell'.
		require
			a_mini_tool_bar_not_void: a_mini_tool_bar /= Void
		do
			if tool_bar_cell.full then
				tool_bar_cell.wipe_out
			end
			tool_bar_cell.extend (a_mini_tool_bar)
		ensure
			tool_bar_cell.item = a_mini_tool_bar
		end

feature -- Query

	close_request_actions: like internal_close_request_actions is
			-- `internal_close_request_actions'.
		do
			if internal_close_request_actions = Void then
				create internal_close_request_actions
			end
			Result := internal_close_request_actions
		ensure
			not_void: Result /= Void
		end

	mini_tool_bar: EV_TOOL_BAR is
			-- 	EV_TOOL_BAR in `Current' if it exist.
		local
			l_tool_bar: EV_TOOL_BAR
		do
			if tool_bar_cell.item /= Void then
				l_tool_bar ?= tool_bar_cell.item
				check cell_only_has_tool_bar: l_tool_bar /= Void end
				Result := l_tool_bar
			end
		end

feature {NONE} -- Agents

	on_close_button_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle when close button pressed.
		do
			if internal_close_request_actions /= Void then
				internal_close_request_actions.call ([])
			end
		end

	on_fixed_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle when EV_FIXED resized.
		do
			set_item_size (notebook, a_width, a_height)
			set_item_position (close_button_bar, width - close_button_bar.width, 1)

			set_minimum_size (internal_shared.title_bar_height * 3, internal_shared.title_bar_height)
		end

feature {NONE} -- Implementation

	notebook: EV_NOTEBOOK
			-- NOTEBOOK.

	close_button_bar: EV_TOOL_BAR
			-- Close button bar hold `close_button'.

	close_button: EV_TOOL_BAR_BUTTON
			-- Close button which shown at top right.

	tool_bar_cell: EV_CELL
			-- Container for a EV_TOOL_BAR.

	internal_close_request_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions when user press close button.

	internal_shared: SD_SHARED
			-- All singletons.

invariant

	internal_shared_not_void: internal_shared /= Void
	tool_bar_cell_not_void: tool_bar_cell /= Void
	close_button_bar_not_void: close_button_bar /= Void
	close_button_not_void: close_button /= Void

end
