indexing
	description: "Window to search help system"
	author: "Parker Abercrombie"
	date: "$Date$"

class
	HELP_SEARCH_WINDOW

inherit
	EV_WINDOW
		rename
			make as make_window
		end

create
	make

feature --  Initialization

	make  (par: EV_WINDOW; target: HELP_DOCUMENT_DISPLAY) is
			-- Create window as a child of `par'.  Documents will be displayed in `target'.
		do
			make_window (par)
			target_display := target
			get_index
			create_widgets
			setup_widgets
		end;

feature -- Access

	target_display: HELP_DOCUMENT_DISPLAY
			-- Where the documents will be displayed.

	index: HELP_INDEX
			-- The help index.

	canvas: EV_VERTICAL_BOX
			-- Container to enclose `main_window ' area.

	search_bar: EV_HORIZONTAL_BOX
			-- Container to enclose the search option widgets.

	button_bar: EV_HORIZONTAL_BOX
			-- Container to enclose `display_button' and `cancel_button'.

	search_field_label: EV_LABEL
			-- Label for search field.

	search_field: EV_TEXT_FIELD
			-- Text field for search words.

	search_button: EV_BUTTON
			-- Search button.  Triggers search when pressed.

	search_mode_label: EV_LABEL
			-- Label for search mode combo box.

	search_mode_combo: EV_COMBO_BOX
			-- Combo box to set search mode ("any" or "all").

	search_mode_all: EV_LIST_ITEM
			-- Combo box entry for "all" mode.

	search_mode_any: EV_LIST_ITEM
			-- Combo box entry for "any" mode.

	results_list: EV_LIST
			-- List of search results.

	results_label: EV_LABEL
			-- Label for the results list.

	display_button: EV_BUTTON
			-- Displays arcticle selected in `results_list' when clicked.

	cancel_button: EV_BUTTON
			-- Exit search tool.


feature -- Status Setting

	create_widgets is
			-- Create buttons, text fields, etc. for the window.
		do
			-- Containers
			create canvas.make (current)
			create search_bar.make (canvas)

			-- Search field
			create search_field_label.make_with_text (search_bar, "Search for:")
			create search_field.make (search_bar)

			-- Search mode
			create search_mode_label.make_with_text (search_bar, "Match:")
			create search_mode_combo.make (search_bar)
			create search_mode_all.make_with_text (search_mode_combo, "all words")
			create search_mode_any.make_with_text (search_mode_combo, "any word")

			-- Search button
			create search_button.make_with_text (search_bar, "Search")

			-- Results list
			create results_label.make_with_text (canvas, "Results:")
			create results_list.make (canvas)

			-- Display and Cancel buttons
			create button_bar.make (canvas)
			create display_button.make_with_text (button_bar, "Display")
			create cancel_button.make_with_text (button_bar, "Cancel")
		end;

	setup_widgets is
			-- Set up the widgets in the windows.
		local
			search_cmd: SEARCH_COMMAND
			search_arg: EV_TUPLE_ARGUMENT
			tpl: TUPLE

			display_cmd: DISPLAY_COMMAND
			display_arg: EV_ARGUMENT3 [STRING, EV_LIST, HELP_DOCUMENT_DISPLAY]

			cancel_cmd: CANCEL_COMMAND
			cancel_arg: EV_ARGUMENT1 [EV_WINDOW]

			set_button_state_cmd: SET_BUTTON_STATE_COMMAND
			set_button_state_arg: EV_ARGUMENT2 [BOOLEAN, EV_BUTTON]
		do
			-- Containers
			canvas.set_border_width (8)
			canvas.set_homogeneous (false)

			search_bar.set_expand (false)
			search_bar.set_homogeneous (false)
			search_bar.set_spacing (5)

			button_bar.set_spacing (40)
			button_bar.set_border_width (4)

			-- Search field
			search_field_label.set_expand (False)
			search_field.set_minimum_width (200)

			create search_cmd
			create tpl.make
			tpl.array_make (1, 5)
			create search_arg.make (tpl)

			search_arg.put (search_field, 1)
			search_arg.put (search_mode_combo, 2)
			search_arg.put (results_list, 3)
			search_arg.put (index, 4)
			search_arg.put (target_display, 5)

			search_field.add_activate_command (search_cmd, search_arg)

			create set_button_state_cmd
			create set_button_state_arg.make (false, display_button)
			search_field.add_activate_command (set_button_state_cmd, set_button_state_arg)

			-- Search mode
			search_mode_label.set_expand (False)

			search_mode_combo.set_editable (false)
			search_mode_combo.select_item (1)
			search_mode_combo.set_minimum_width (80)

			-- Search button

			-- `set_button_state_cmd' and `set_button_state_arg' where created in the `search_field' section
			search_button.add_click_command (set_button_state_cmd, set_button_state_arg)

			-- `search_cmd' and `search_arg' were created in the `search_field' section.
			search_button.add_click_command (search_cmd, search_arg)

			-- Results list
			results_list.set_minimum_height (200)

			create set_button_state_cmd
			create set_button_state_arg.make (true, display_button)
			results_list.add_selection_command (set_button_state_cmd, set_button_state_arg)

			-- Display button
			display_button.set_insensitive (true)
			display_button.set_minimum_height (25)

			create display_cmd
			create display_arg.make (index.base_path, results_list, target_display)
			display_button.add_click_command (display_cmd, display_arg)

			-- Cancel button
			cancel_button.set_minimum_height (25)

			create cancel_cmd
			create cancel_arg.make (current)
			cancel_button.add_click_command (cancel_cmd, cancel_arg)
		end;

feature -- Basic operations

	get_index is
			-- Load `index' from disk.
		do
			create index.make
			index ?= index.retrieve_by_name ("d:\help\help_index\word_list")
			index.set_base_path ("d:\help\help_index\files")
		end;

end -- class HELP_SEARCH_WINDOW
