indexing
	description:
		"[

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
	SD_NOTEBOOK

inherit
	EV_FIXED

create
	make


feature {NONE} -- Initialization

	make (a_notebook: EV_NOTEBOOK)is
			-- Creation method
		require
			a_notebook_not_void: a_notebook /= Void
			a_note_book_parent_void: a_notebook.parent = Void
		do
			default_create
			create shared

			notebook := a_notebook
			extend (notebook)
			notebook.set_tab_position ({EV_NOTEBOOK}.tab_top)

			create tool_bar_cell
			extend (tool_bar_cell)
			tool_bar_cell.set_minimum_height (shared.title_bar_height - 2)

			create close_button_bar
			create close_button
			close_button.set_pixmap (shared.icons.close)
			close_button_bar.extend (close_button)
			close_button_bar.set_minimum_size (shared.title_bar_height - 2, shared.title_bar_height - 2)
			extend (close_button_bar)

			close_button.pointer_button_press_actions.extend (agent on_close_button_pointer_press)

			resize_actions.extend (agent on_fixed_resize)
		ensure
			set: a_notebook = notebook
		end

feature -- Actions

	close_actions: like internal_close_actions is
			-- `internal_close_actions'.
		do
			if internal_close_actions = Void then
				create internal_close_actions
			end
			Result := internal_close_actions
		end

feature -- Basic operation

	set_mini_tool_bar (a_mini_tool_bar: EV_TOOL_BAR) is
			--
		require
			a_mini_tool_bar_not_void: a_mini_tool_bar /= Void
		do
			if tool_bar_cell.full then
				tool_bar_cell.wipe_out
			end
			tool_bar_cell.extend (a_mini_tool_bar)
		end

feature {NONE} -- Implementation

	notebook: EV_NOTEBOOK

	close_button_bar: EV_TOOL_BAR

	close_button: EV_TOOL_BAR_BUTTON

	tool_bar_cell: EV_CELL
			-- Container for a EV_TOOL_BAR.

	internal_close_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions when user press close button.

	shared: SD_SHARED
feature {NONE} -- actions

	on_close_button_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			if internal_close_actions /= Void then
				internal_close_actions.call ([])
			end
		end

	on_fixed_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			--
		do
			set_item_size (notebook, a_width, a_height)
			set_item_position (close_button_bar, width - close_button_bar.width, 1)

			set_minimum_size (shared.title_bar_height * 3, shared.title_bar_height)
		end

end
