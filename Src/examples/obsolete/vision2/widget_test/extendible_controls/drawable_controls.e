indexing
	description: "Objects that create controls to extend a certain widget type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DRAWABLE_CONTROLS

inherit
	EV_FRAME
		redefine
			initialize,
			is_in_default_state
		end
		
	COMMON_TEST
		undefine
			default_create, copy, is_equal
		end

create
	make_with_control

feature {NONE} -- Initialization

	make_with_control (a_drawable: EV_DRAWABLE; editor: GB_OBJECT_EDITOR) is
			-- Create `Current'.
		local
			pixmap: EV_PIXMAP
			drawing_area: EV_DRAWING_AREA
		do
			drawable := a_drawable
			default_create
			pixmap ?= drawable
			if pixmap /= Void then
				pixmap.set_size (300, 300)
				pixmap.pointer_button_press_actions.force_extend (agent perform_drawing)
			else
				drawing_area ?= drawable
				if drawing_area /= Void then
					drawing_area.pointer_button_press_actions.force_extend (agent perform_drawing)
				else
					check
						False
					end
				end
			end
			object_editor := editor
		end
		
	initialize is
			-- Initialize `Current' and build interface.
		local
			horizontal_box: EV_HORIZONTAL_BOX
			operation_frame: EV_FRAME
			clear_button: EV_BUTTON
			main_vertical_box: EV_VERTICAL_BOX
			list_item: EV_LIST_ITEM
			label: EV_LABEL
			cell: EV_CELL
		do	
			set_text ("Drawing operations")
			create main_vertical_box
			extend (main_vertical_box)
			main_vertical_box.set_padding_width (5)
			main_vertical_box.set_border_width (5)
			
				-- Add basic controls.
			create clear_button.make_with_text ("Clear")
			create horizontal_box
			horizontal_box.set_padding_width (5)
			horizontal_box.extend (clear_button)
			create help_button.make_with_text ("?")
			help_button.select_actions.extend (agent show_help)
			help_button.set_tooltip (help)
			horizontal_box.extend (help_button)
			horizontal_box.disable_item_expand (help_button)
			help_button.set_minimum_width (help_button.minimum_height)
			main_vertical_box.extend (horizontal_box)
			clear_button.select_actions.extend (agent drawable.clear)
			create mode_combo
			mode_combo.disable_edit
			create list_item.make_with_text ("Copy")
			mode_combo.extend (list_item)
			list_item.select_actions.extend (agent drawable.set_copy_mode)
			create list_item.make_with_text ("Invert")
			mode_combo.extend (list_item)
			list_item.select_actions.extend (agent drawable.set_invert_mode)
			create list_item.make_with_text ("Or")
			mode_combo.extend (list_item)
			list_item.select_actions.extend (agent drawable.set_or_mode)
			create list_item.make_with_text ("Xor")
			mode_combo.extend (list_item)
			list_item.select_actions.extend (agent drawable.set_xor_mode)
			create list_item.make_with_text ("And")
			mode_combo.extend (list_item)
			list_item.select_actions.extend (agent drawable.set_and_mode)
				-- Ensure copy mode is selected
			mode_combo.first.enable_select
			create horizontal_box
			main_vertical_box.extend (horizontal_box)
			horizontal_box.extend (create {EV_LABEL}.make_with_text ("Drawing mode :"))
			horizontal_box.set_padding (5)
			horizontal_box.disable_item_expand (horizontal_box.i_th (1))
			horizontal_box.extend (mode_combo)
			
				-- Add control for line width
			create line_width.make_with_value_range (create {INTEGER_INTERVAL}.make (1, 40))
			create horizontal_box
			create label.make_with_text ("Line width :")
			label.align_text_left
			horizontal_box.extend (label)
			create cell
			cell.extend (line_width)
			horizontal_box.extend (cell)
			horizontal_box.set_padding (5)
			horizontal_box.disable_item_expand (horizontal_box.first)
			line_width.change_actions.force_extend (agent update_line_width)
			main_vertical_box.extend (horizontal_box)
			
			update_labels_minimum_width (main_vertical_box)
			
			
				-- Add drawing operation controls.
			create operation_frame.make_with_text ("Drawing operation")
			main_vertical_box.extend (operation_frame)
			create radio_parent
			radio_parent.set_border_width (5)
			operation_frame.extend (radio_parent)
			create argument_holder
			create point_radio_button.make_with_text ("Draw point")
			radio_parent.extend (point_radio_button)
			point_radio_button.select_actions.extend (agent setup_draw_point)
			create pixmap_radio_button.make_with_text ("Draw pixmap")
			radio_parent.extend (pixmap_radio_button)
			pixmap_radio_button.select_actions.extend (agent setup_draw_pixmap)
			create text_radio_button.make_with_text ("Draw text")
			radio_parent.extend (text_radio_button)
			text_radio_button.select_actions.extend (agent setup_draw_text)
			create text_top_left_radio_button.make_with_text ("Draw text top left")
			radio_parent.extend (text_top_left_radio_button)
			text_top_left_radio_button.select_actions.extend (agent setup_draw_text_top_left)
			create segment_radio_button.make_with_text ("Draw segment")
			radio_parent.extend (segment_radio_button)
			segment_radio_button.select_actions.extend (agent setup_draw_segment)
			create straight_line_radio_button.make_with_text ("Draw straight line")
			radio_parent.extend (straight_line_radio_button)
			straight_line_radio_button.select_actions.extend (agent setup_draw_straight_line)
			create draw_arc_radio_button.make_with_text ("Draw arc")
			radio_parent.extend (draw_arc_radio_button)
			draw_arc_radio_button.select_actions.extend (agent setup_draw_arc)
			create draw_rectangle_radio_button.make_with_text ("Draw rectangle")
			radio_parent.extend (draw_rectangle_radio_button)
			draw_rectangle_radio_button.select_actions.extend (agent setup_draw_rectangle)
			create draw_ellipse_radio_button.make_with_text ("Draw ellipse")
			radio_parent.extend (draw_ellipse_radio_button)
			draw_ellipse_radio_button.select_actions.extend (agent setup_draw_ellipse)
			create draw_pie_slice_radio_button.make_with_text ("Draw pie slice")
			radio_parent.extend (draw_pie_slice_radio_button)
			draw_pie_slice_radio_button.select_actions.extend (agent setup_draw_pie_slice)
			
			is_initialized := True
		end
		
feature {NONE} -- Implementation
		
	perform_drawing (x, y: INTEGER) is
			-- A button press has been received by `drawable', so draw appropriate
			-- figure.
		do
			if fields_valid then
				if point_radio_button.is_selected then
					drawable.draw_point (x, y)
				elseif pixmap_radio_button.is_selected then
					drawable.draw_pixmap (x, y, test_pixmap)
				elseif text_radio_button.is_selected then
					drawable.draw_text (x, y, text_entry.text)
				elseif text_top_left_radio_button.is_selected then
					drawable.draw_text_top_left (x, y, text_entry.text)
				elseif segment_radio_button.is_selected then
					drawable.draw_segment (x, y, integer1.text.to_integer, integer2.text.to_integer)
				elseif straight_line_radio_button.is_selected then
					drawable.draw_straight_line (x, y, integer1.text.to_integer, integer2.text.to_integer)
				elseif draw_arc_radio_button.is_selected then
					drawable.draw_arc (x, y, integer1.text.to_integer, integer2.text.to_integer, real1.text.to_real, real2.text.to_real)
				elseif draw_rectangle_radio_button.is_selected then
					if Filled_check_button.is_selected then
						drawable.fill_rectangle (x, y, integer1.text.to_integer, integer2.text.to_integer)
					else
						drawable.draw_rectangle (x, y, integer1.text.to_integer, integer2.text.to_integer)
					end
				elseif draw_ellipse_radio_button.is_selected then
					if Filled_check_button.is_selected then
						drawable.fill_ellipse (x, y, integer1.text.to_integer, integer2.text.to_integer)
					else
						drawable.draw_ellipse (x, y, integer1.text.to_integer, integer2.text.to_integer)
					end
				elseif draw_pie_slice_radio_button.is_selected then
					if Filled_check_button.is_selected then
						drawable.fill_pie_slice (x, y, integer1.text.to_integer, integer2.text.to_integer, real1.text.to_real, real2.text.to_real)
					else
						drawable.draw_pie_slice (x, y, integer1.text.to_integer, integer2.text.to_integer, real1.text.to_real, real2.text.to_real)
					end
				end
			else
				select_bad_field
			end
		end
		
	parent_argument_holder (a_radio_button: EV_RADIO_BUTTON) is
			-- Ensure `argument_holder' is parented in the same parent as `a_radio_button',
			-- at the following position. Also perform adjustment of all labels, so they have the same width:
		local
			a_parent: EV_VERTICAL_BOX
			original_index: INTEGER
		do
			update_labels_minimum_width (argument_holder)
			a_parent ?= a_radio_button.parent
			check
				parent_is_vertical_box: a_parent /= Void
			end
			original_index := a_parent.index_of (a_radio_button, 1)
			a_parent.go_i_th (original_index)
			a_parent.put_right (argument_holder)
			parent_window (Current).unlock_update
		end
		
	update_labels_minimum_width (vertical_box: EV_VERTICAL_BOX )is
			-- Update all labels parented at the second level in `box'.
		local
			label_width: INTEGER
			box: EV_HORIZONTAL_BOX
			label: EV_LABEL
		do
				-- Update widths of all labels
			from
				vertical_box.start
			until
				vertical_box.off
			loop
				box ?= vertical_box.item
				if box /= Void then
					label ?= box.first
					if label /= Void and then label.minimum_width > label_width then
						label_width := label.minimum_width
					end
				end
				vertical_box.forth
			end
			from
				vertical_box.start
			until
				vertical_box.off
			loop
				box ?= vertical_box.item
				if box /= Void then
					label ?= box.first
					if label /= Void then
						label.set_minimum_width (label_width)
					end
				end
				vertical_box.forth
			end	
		end
		
	unparent_argument_holder is
			-- Ensure `argument' holder is not parented and
			-- remove all items.
		do
			parent_window (Current).lock_update
			if argument_holder.parent /= Void then
				argument_holder.parent.prune (argument_holder)	
			end
			argument_holder.wipe_out
		end
		
	setup_draw_pixmap is
			-- initialize controls for drawing pixmaps.
		do
			unparent_argument_holder
			parent_window (Current).unlock_update
		end
		

	setup_draw_point is
			-- Initialize controls for drawing points.
		do
			unparent_argument_holder
			parent_window (Current).unlock_update
		end
		
		
	setup_draw_text is
			-- Initialize controls for drawing text.
		do
			unparent_argument_holder
			add_text_entry_with_label ("text : ")
			parent_argument_holder (text_radio_button)
		end
		
	setup_draw_text_top_left is
			-- Initialize controls for drawing text top left.
		do
			unparent_argument_holder
			add_text_entry_with_label ("text : ")
			parent_argument_holder (text_top_left_radio_button)
		end
		
	setup_draw_segment is
			-- Initialize controls for drawing segments.
		do
			unparent_argument_holder
			add_integer_entry_with_label ("x2 pos : ", 1)
			add_integer_entry_with_label ("y2 pos : ", 2)
			parent_argument_holder (segment_radio_button)
		end
		
	setup_draw_straight_line is
			-- Initialize controls for drawing lines.
		do
			unparent_argument_holder
			add_integer_entry_with_label ("x2 pos : ", 1)
			add_integer_entry_with_label ("y2 pos : ", 2)
			parent_argument_holder (straight_line_radio_button)
		end
		
	setup_draw_arc is
			-- Initialize controls for drawing arcs.
		do
			unparent_argument_holder
			add_integer_entry_with_label ("Width : ", 1)
			add_integer_entry_with_label ("Height : ", 2)	
			add_real_entry_with_label ("Start angle : ", 1)
			add_real_entry_with_label ("Aperture : ", 2)
			parent_argument_holder (draw_arc_radio_button)
		end
		
	setup_draw_rectangle is
			-- Initialize controls for drawing rectangles.
		do
			unparent_argument_holder
			add_integer_entry_with_label ("Width : ", 1)
			add_integer_entry_with_label ("Height : ", 2)
			add_fill_button
			parent_argument_holder (draw_rectangle_radio_button)
		end
		
	setup_draw_ellipse is
			-- Initialize controls for drawing ellipses.
		do
			unparent_argument_holder
			add_integer_entry_with_label ("Width : ", 1)
			add_integer_entry_with_label ("Height : ", 2)
			add_fill_button
			parent_argument_holder (draw_ellipse_radio_button)
		end
		
		
	setup_draw_pie_slice is
			-- Initialize controls for drawing pie slices.
		do	
			unparent_argument_holder
			add_integer_entry_with_label ("Width : ", 1)
			add_integer_entry_with_label ("Height : ", 2)	
			add_real_entry_with_label ("Start angle : ", 1)
			add_real_entry_with_label ("Aperture : ", 2)
			add_fill_button
			parent_argument_holder (draw_pie_slice_radio_button)
		end

	text_entry: EV_TEXT_FIELD is
			-- Once acces to a text field for inputting STRING values.
		once
			create Result.make_with_text ("Sample Text")
		end
		
	integer1: EV_TEXT_FIELD is
			-- Once access to a text field for inputting INTEGER values.
		once
			create Result.make_with_text (default_integer_value.out)
			Result.change_actions.extend (agent validate_integer (Result))
		end
		
	integer2: EV_TEXT_FIELD is
			-- Once access to a text field for inputting INTEGER values.
		once
			create Result.make_with_text (default_integer_value.out)
			Result.change_actions.extend (agent validate_integer (Result))
		end
		
	real1: EV_TEXT_FIELD is
			-- Once access to a text field for inputting REAL values.
		once
			create Result.make_with_text (default_real_value.out)
			Result.change_actions.extend (agent validate_real (Result))
		end
		
	real2: EV_TEXT_FIELD is
			-- Once access to a text field for inputting REAL values.
		once
			create Result.make_with_text (default_real_value.out)
			Result.change_actions.extend (agent validate_real (Result))
		end

	filled_check_button: EV_CHECK_BUTTON is
			-- Once access to a check button control filled status.
		once
			create Result.make_with_text ("Height adjustment")
			Result.set_minimum_height (Result.minimum_height)
			Result.select_actions.extend (agent update_tiled_button)
			Result.remove_text
		end
		
	tiled_check_button: EV_CHECK_BUTTON is
			-- Once access to a check button control filled status
			-- for drawing operations.
		once
			create Result.make_with_text ("Height adjustment")
			Result.set_minimum_height (Result.minimum_height)
			Result.select_actions.extend (agent update_tiled_status)
			Result.remove_text
		end
		
	fields_valid: BOOLEAN is
			-- Are all input fields holding valid information?
		do
			Result := True
			if integer1.is_displayed and not integer1.text.is_integer then
				Result := False
			end
			if integer2.is_displayed and not integer2.text.is_integer then
				Result := False
			end
			if real1.is_displayed and not real1.text.is_real then
				Result := False
			end
			if real1.is_displayed and not real1.text.is_real then
				Result := False
			end
		end
		
	red: EV_COLOR is
			-- Once access to red EV_COLOR.
		once
			Result := (create {EV_STOCK_COLORS}).red
		end
		
	black: EV_COLOR is
			-- Once access to black EV_COLOR.
		once
			Result := (create {EV_STOCK_COLORS}).black
		end
		
	validate_real (text_field: EV_TEXT_FIELD) is
			--
		do
			if text_field.text.is_real then
				text_field.set_foreground_color (black)
			else
				text_field.set_foreground_color (red)
			end
		end
		
	validate_integer (text_field: EV_TEXT_FIELD) is
			--
		do
			if text_field.text.is_integer then
				text_field.set_foreground_color (black)
			else
				text_field.set_foreground_color (red)
			end
		end

	select_bad_field is
			--
		do
			if not integer1.text.is_integer then
				integer1.set_focus
			end
			if not integer2.text.is_integer then
				integer2.set_focus
			end
			if not real1.text.is_real then
				real1.set_focus
			end
			if not real2.text.is_real then
				real2.set_focus
			end
		end
		
	
feature -- Status report

	help: STRING is
			-- Instructions on how to use the control.
		once
			Result := "Select a drawing operation and click on the drawable control.%NThe drawing will occur at the clicked position.%NIf an operation requires further arguments, these will be available below the selected operation."
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
			-- (export status {NONE})
		do
			Result := True	
		end

feature {NONE} -- Implementation

	show_help is
			-- Display help for `Current'.
		local
			information_dialog: EV_INFORMATION_DIALOG
		do
			create information_dialog.make_with_text (help)
			information_dialog.show_modal_to_window (parent_window (Current))
		end
		
	update_line_width is
			-- Update width of line used on `drawable' to value of `line_width'.
		do
			drawable.set_line_width (line_width.value)
		end
		

	update_tiled_status is
			-- Update `drawable' to use tiling dependent on state
			-- of `tiled_check_button'.
		do
			if tiled_check_button.is_selected then
				drawable.set_tile (test_pixmap)
			else
				drawable.remove_tile
			end
		end
		
	update_tiled_button is
			-- Update status of `tiled_check_button' to reflect usability, dependent
			-- on state of `filled_check_button'.
		do
			if filled_check_button.is_selected then
				tiled_check_button.enable_sensitive
			else
				tiled_check_button.disable_sensitive
			end
		end

	add_text_entry_with_label (a_text: STRING) is
			-- Add `text_entry' and label marked `a_text'
			-- to `argument_holder'.
		local
			horizontal_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
		do
			if text_entry.parent /= Void then
				text_entry.parent.wipe_out
			end
			create horizontal_box
			create label.make_with_text (a_text)
			horizontal_box.extend (label)
			horizontal_box.disable_item_expand (label)
			horizontal_box.extend (text_entry)
			if text_entry.text.is_empty then
				text_entry.set_text ("Sample text")
			end
			argument_holder.extend (horizontal_box)
		end
		
	add_integer_entry_with_label (a_text: STRING; entry_number: INTEGER) is
			-- Add an integer entry field based on `entry_number' and label marked `a_text'
			-- to `argument_holder'.
		local
			field: EV_TEXT_FIELD
			horizontal_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
		do
			inspect entry_number
			when 1 then
				field := integer1
			else
				field := integer2
			end
			if field.parent /= Void then
				field.parent.wipe_out
			end
			create horizontal_box
			create label.make_with_text (a_text)
			label.align_text_left
			horizontal_box.extend (label)
			horizontal_box.disable_item_expand (label)
			horizontal_box.extend (field)
			if not field.text.is_integer then
				field.set_text (default_integer_value.out)
			end
			argument_holder.extend (horizontal_box)
		end
		
	add_real_entry_with_label (a_text: STRING; entry_number: INTEGER) is
			-- Add a real entry field based on `entry_number' and label marked `a_text'
			-- to `argument_holder'.
		local
			field: EV_TEXT_FIELD
			horizontal_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
		do
			inspect entry_number
			when 1 then
				field := real1
			else
				field := real2
			end
			if field.parent /= Void then
				field.parent.wipe_out
			end
			create horizontal_box
			create label.make_with_text (a_text)
			label.align_text_left
			horizontal_box.extend (label)
			horizontal_box.disable_item_expand (label)
			horizontal_box.extend (field)
			if not field.text.is_real then
				field.set_text (default_real_value.out)
			end
			argument_holder.extend (horizontal_box)
		end
		
	add_fill_button is
			-- Add `filled_check_button' to `argument_holder',
			-- at first position.
		local
			horizontal_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
		do
			if filled_check_button.parent /= Void then
				filled_check_button.parent.prune (filled_check_button)
			end
			filled_check_button.disable_select
			argument_holder.go_i_th (1)
			create horizontal_box
			create label.make_with_text ("filled?")
			label.align_text_left
			horizontal_box.extend (label)
			horizontal_box.disable_item_expand (horizontal_box.first)
			horizontal_box.extend (filled_check_button)
			argument_holder.put_left (horizontal_box)
			
			if tiled_check_button.parent /= Void then
				tiled_check_button.parent.prune (tiled_check_button)
			end
			tiled_check_button.disable_select
			argument_holder.go_i_th (1)
			create horizontal_box
			create label.make_with_text ("tiled?")
			label.align_text_left
			horizontal_box.extend (label)
			horizontal_box.disable_item_expand (horizontal_box.first)
			horizontal_box.extend (tiled_check_button)
			argument_holder.put_right (horizontal_box)
		end	

	point_radio_button, text_radio_button, text_top_left_radio_button,
	segment_radio_button, straight_line_radio_button, draw_arc_radio_button,
	draw_rectangle_radio_button, draw_ellipse_radio_button,
	draw_pie_slice_radio_button, pixmap_radio_button: EV_RADIO_BUTTON
	
	help_button: EV_BUTTON
	
	argument_holder: EV_VERTICAL_BOX
	
	radio_parent: EV_VERTICAL_BOX
	
	mode_combo: EV_COMBO_BOX
	
	line_width: EV_SPIN_BUTTON
		-- A control to determine the width of lines used on `drawable'.

	drawable: EV_DRAWABLE
		-- The item on which operations must take place.
		
	object_editor: GB_OBJECT_EDITOR
		-- An object editor currently holding `current_type'. This
		-- must be updated to account for any changes.
		
	default_integer_value: INTEGER is 100
	
	default_real_value: REAL is 3.0
	
	test_pixmap: EV_PIXMAP is
			-- Pixmap for drawing operations.
		once
			Result := numbered_pixmap (1)
		end

invariant
	drawable_not_void: drawable /= Void

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


end -- class EXTENDIBLE_CONTROLS
