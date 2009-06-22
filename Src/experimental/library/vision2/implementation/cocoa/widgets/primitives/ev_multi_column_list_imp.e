note
	description: "EiffelVision multi-column-list, Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_IMP

inherit
	EV_MULTI_COLUMN_LIST_I
		redefine
			interface,
			make,
			pixmaps_size_changed,
			remove_row_pixmap,
			ev_children
		end

	EV_PRIMITIVE_IMP
		redefine
			disable_transport,
			on_mouse_button_event,
			make,
			interface,
			destroy,
			able_to_transport,
			ready_for_pnd_menu,
			set_to_drag_and_drop,
			minimum_height,
			minimum_width
		end

	EV_ITEM_LIST_IMP [EV_MULTI_COLUMN_LIST_ROW, EV_MULTI_COLUMN_LIST_ROW_IMP]
		redefine
			destroy,
			interface,
			make,
			ev_children
		end

	EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES_IMP

	EV_PND_DEFERRED_ITEM_PARENT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		local
			l_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
		do
			create ev_children.make (0)
			create {NS_OUTLINE_VIEW}cocoa_item.make

			initialize_item_list
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_MULTI_COLUMN_LIST_I}
			enable_tabable_to
			resize_model_if_needed (25)
				-- Create our model with 25 columns to avoid recomputation each time the column count increases


			previous_selection := selected_items
			initialize_pixmaps
			disable_multiple_selection

				-- Needed so that we can query if the mouse button is down for column resize actions
			l_release_actions := pointer_button_release_actions
		end

feature {NONE} -- Implementation

	call_selection_action_sequences
			-- Call appropriate selection and deselection action sequences
		do
		end

	previous_selection: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW]
		-- Previous selection of `Current'

feature {NONE} -- Implementation

	call_selection_actions (clicked_row: EV_MULTI_COLUMN_LIST_ROW_IMP)
			-- Call the selections actions for `clicked_row'
		do
			if not previous_selection.has (clicked_row.interface) then
					if attached clicked_row.select_actions_internal then
						clicked_row.select_actions_internal.call (void)
					end
					if attached select_actions_internal then
						select_actions_internal.call ([clicked_row.interface])
					end
			end
		end

	call_deselect_actions (deselected_row: EV_MULTI_COLUMN_LIST_ROW_IMP)
			-- Call deselect actions for `deselected_row'
		do
				if attached deselected_row.deselect_actions_internal then
					deselected_row.deselect_actions_internal.call (Void)
				end
				if attached deselect_actions_internal then
					deselect_actions_internal.call ([deselected_row.interface])
				end
		end

	resize_model_if_needed (a_columns: INTEGER)
			--
		do

		end

	on_pointer_motion (a_motion_tuple: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER])
		local
			a_row_number: INTEGER
			a_row_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			--Precursor (a_motion_tuple)
			if not app_implementation.is_in_transport and then a_motion_tuple.integer_item (2) > 0 and a_motion_tuple.integer_item (1) <= width then
				a_row_number := row_index_from_y_coord (a_motion_tuple.integer_item (2))
				if a_row_number > 0 and then a_row_number <= count then
					a_row_imp := ev_children @ a_row_number
					if a_row_imp.pointer_motion_actions_internal /= Void then
						a_row_imp.pointer_motion_actions_internal.call (a_motion_tuple)
					end
				end
			end
		end

	pixmaps_size_changed
			--
		do
		end

feature -- Access

	model_column_count: INTEGER
		do

		end

	rows: INTEGER
			-- Number of rows in the list.
		do
			Result := count
		end

	selected_item: EV_MULTI_COLUMN_LIST_ROW
			-- Item which is currently selected
		do
		end

	selected_items: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW]
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than
			-- `selected_items' for a single selection list.
		do

		end

feature -- Status report

	selected: BOOLEAN
			-- Is at least one item selected ?
		do

		end

	multiple_selection_enabled: BOOLEAN
			-- True if the user can choose several items
			-- False otherwise.
		do
		end

	title_shown: BOOLEAN
			-- True if the title row is shown.
			-- False if the title row is not shown.
		do
			Result := True
		end

feature -- Status setting

	destroy
			-- Destroy screen widget implementation and EV_LIST_ITEM objects.
		do
			wipe_out
			Precursor {EV_PRIMITIVE_IMP}
		end

	enable_multiple_selection
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		do
		end

	disable_multiple_selection
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
		do
		end

	select_item (an_index: INTEGER)
			-- Select an item at the one-based `index' of the list.
		do

		end

	deselect_item (an_index: INTEGER)
			-- Unselect the item at the one-based `index'.
		do
		end

	clear_selection
			-- Clear the selection of the list.
		do
		end

	resize_column_to_content (a_column: INTEGER)
			-- Resize column `a_column' to width of its widest text.
		do
		end




feature -- Element change

	hide_title_row
		do
		end

	show_title_row
		do
		end

	column_count : INTEGER
		do
		end

	column_title_changed (a_txt: STRING_GENERAL; a_column: INTEGER)
			-- Make `a_txt' the title of the column number.
		do
		end

	column_width_changed (value: INTEGER; a_column: INTEGER)
			-- Make `value' the new width of the column number
			-- `a_column'.
		do
		end

	column_alignment_changed (an_alignment: EV_TEXT_ALIGNMENT; a_column: INTEGER)
			-- Set alignment of `a_column' to corresponding `alignment_code'.
		do
		end

	set_row_height (value: INTEGER)
			-- Make `value' the new height of all the rows.
		require
			positive_value: value >= 0
		do
		end

feature -- Minimum size

	minimum_height: INTEGER
			-- Minimum height that the widget may occupy.
		do
			Result := 74 -- Hardcoded, TODO calculate a meaningful height depending on the content
		end

	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		do
			Result := 55 -- Hardcoded, TODO calculate a meaningful width depending on the content
		end

feature -- Implementation

	insert_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP; an_index: INTEGER)
			-- Insert `item_imp' at `an_index'.
		do
			io.put_string ("EV_MULTI_COLUMN_LIST_IMP.insert_item: Not implemented")
		end

	remove_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP)
			-- Remove `item' from the list
		do
			io.put_string ("EV_MULTI_COLUMN_LIST_IMP.remove_item: Not implemented")
		end

	set_to_drag_and_drop: BOOLEAN
			-- Set transport mode to drag and drop.
		do
			if pnd_row_imp /= Void then
				Result := pnd_row_imp.mode_is_drag_and_drop
			else
				Result := mode_is_drag_and_drop
			end
		end

	able_to_transport (a_button: INTEGER): BOOLEAN
			-- Is list or row able to transport PND data using `a_button'.
		do
			if pnd_row_imp /= Void then
				Result := (pnd_row_imp.mode_is_drag_and_drop and a_button = 1) or
				(pnd_row_imp.mode_is_pick_and_drop and a_button = 3)
			else
				Result := (mode_is_drag_and_drop and a_button = 1) or
				(mode_is_pick_and_drop and a_button = 3)
			end
		end

	ready_for_pnd_menu (a_button: INTEGER): BOOLEAN
			-- Is list or row able to display PND menu using `a_button'
		do
			if pnd_row_imp /= Void then
				Result := pnd_row_imp.mode_is_target_menu and then a_button = 3
			else
				Result := mode_is_target_menu and then a_button = 3
			end
		end

	disable_transport
			-- Disable PND transport
		do
			Precursor
			update_pnd_status
		end

	update_pnd_status
			-- Update PND status of list and its children.
		local
			a_enable_flag: BOOLEAN
		do
			from
				ev_children.start
			until
				ev_children.after or else a_enable_flag
			loop
				a_enable_flag := ev_children.item.is_transport_enabled
				ev_children.forth
			end
			update_pnd_connection (a_enable_flag)
		end

	update_pnd_connection (a_enable: BOOLEAN)
			-- Update the PND connection of `Current' if needed.
		do
			if not is_transport_enabled then
				if a_enable or pebble /= Void then
					is_transport_enabled := True
				end
			elseif not a_enable and pebble = Void then
				is_transport_enabled := False
			end
		end

	on_mouse_button_event (
			a_type: INTEGER
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)

			-- Initialize a pick and drop transport.
		local
			a_row_index: INTEGER
		do
			a_row_index := row_index_from_y_coord (a_y)

			if a_row_index > 0 then
				pnd_row_imp := ev_children.i_th (a_row_index)
				if not pnd_row_imp.able_to_transport (a_button) then
					pnd_row_imp := Void
				end
			end

			Precursor (
					a_type,
					a_x, a_y, a_button,
					a_x_tilt, a_y_tilt, a_pressure,
					a_screen_x, a_screen_y
				)
		end

	pnd_row_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			-- Implementation object of the current row if in PND transport.

feature {EV_MULTI_COLUMN_LIST_ROW_IMP} -- Implementation

	row_index_from_y_coord (a_y: INTEGER): INTEGER
			-- Returns the row index at relative coordinate `a_y'.
		do

		end

	row_from_y_coord (a_y: INTEGER): EV_PND_DEFERRED_ITEM
			-- Returns the row at relative coordinate `a_y'
		local
			a_row_index: INTEGER
		do
			a_row_index := row_index_from_y_coord (a_y)
			if a_row_index > 0 then
				Result := ev_children @ a_row_index
			end
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP}

	set_text_on_position (a_column, a_row: INTEGER; a_text: STRING_GENERAL)
			--
		do

		end

	set_row_pixmap (a_row: INTEGER; a_pixmap: EV_PIXMAP)
			-- Set row `a_row' pixmap to `a_pixmap'.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			pixmap_imp ?= a_pixmap.implementation
--			a_list_iter := ev_children.i_th (a_row).list_iter.item
		end

	remove_row_pixmap (a_row: INTEGER)
			-- Remove pixmap from `a_row'
		do
		end

feature {NONE} -- Implementation

	update_child (child: EV_MULTI_COLUMN_LIST_ROW_IMP; a_row: INTEGER)
			-- Update `child'.
		require
			child_exists: child /= Void
		local
			cur: CURSOR
			txt: STRING_32
			list: EV_MULTI_COLUMN_LIST_ROW
			column_counter: INTEGER
		do
			list := child.interface
			cur := list.cursor

			if child.pixmap /= Void then
				set_row_pixmap (a_row, child.pixmap)
			end
			from
				column_counter := 1
				list.start
			until
				column_counter > column_count
			loop
					-- Set the text in the cell
				if list.after then
					txt := ""
				else
					txt := list.item
					if txt = Void then
						txt := ""
					end
				end
				set_text_on_position (column_counter, a_row, txt)
					-- Pixmap gets updated when the text does.

					-- Prepare next iteration
				if not list.after then
					list.forth
				end
				column_counter := column_counter + 1
			end
			list.go_to (cur)
		end

	ensure_item_visible (a_item: EV_MULTI_COLUMN_LIST_ROW)
			-- Ensure `a_item' is visible on the screen.
		local
			list_item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			list_item_imp ?= a_item.implementation
		end

	row_height: INTEGER
			-- Height of rows in `Current'
		do

		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP} -- Implementation

	expand_column_count_to (a_columns: INTEGER)
			-- Expand the number of columns to `a_columns'
		do
		end

feature {EV_ANY_I} -- Implementation

	ev_children: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]

	interface: detachable EV_MULTI_COLUMN_LIST note option: stable attribute end;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_MULTI_COLUMN_LIST_IMP
