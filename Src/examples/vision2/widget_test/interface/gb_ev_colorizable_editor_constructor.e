indexing
	description: "Builds an attribute editor for modification of objects of type EV_COLORIZABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_COLORIZABLE_EDITOR_CONSTRUCTOR

inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end

	GB_CONSTANTS

	INTERNAL
		undefine
			default_create
		end

feature -- Access

	ev_type: EV_COLORIZABLE
		-- Vision2 type represented by `Current'.

	type: STRING is "EV_COLORIZABLE"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			first_object: EV_COLORIZABLE
			bounding_frame: EV_FRAME
			horizontal_box: EV_HORIZONTAL_BOX
			vertical_box: EV_VERTICAL_BOX
			button, button1: EV_BUTTON
			frame: EV_FRAME
			cell: EV_CELL
		do
			create Result.make_with_components (components)
			initialize_attribute_editor (Result)
			create color_dialog
			first_object := objects.first
			create bounding_frame.make_with_text (gb_ev_colorizable_background_color)
			Result.extend (bounding_frame)

			create horizontal_box
			create vertical_box
			bounding_frame.extend (vertical_box)
			vertical_box.extend (horizontal_box)
			create frame
			create b_area
			b_area.set_pebble_function (agent retrieve_color (b_area, False))
			b_area.drop_actions.extend (agent accept_background_color_stone (?))
			frame.set_minimum_width (40)
			b_area.set_tooltip (gb_ev_colorizable_background_color_tooltip)
			create button.make_with_text (Select_button_text)
			button.set_tooltip ("Select background color")
			background_color := first_object.background_color
			frame.extend (b_area)
			horizontal_box.set_padding (2)
			create cell
			horizontal_box.extend (cell)
			horizontal_box.disable_item_expand (cell)
			horizontal_box.extend (frame)
			horizontal_box.extend (button)
			horizontal_box.disable_item_expand (button)
			horizontal_box.disable_item_expand (frame)
			b_area.expose_actions.force_extend (agent b_area.clear)
			button.select_actions.extend (agent update_background_color)
			create horizontal_box
			horizontal_box.set_border_width (2)
			create button1.make_with_text (gb_ev_colorizable_restore_color)
			button1.set_tooltip (background_color_restore)
			button1.select_actions.extend (agent restore_background_color)
			horizontal_box.extend (button1)
			vertical_box.extend (horizontal_box)
			horizontal_box.disable_item_expand (button1)
				-- Add two for the padding of the box
			button1.set_minimum_width (button.minimum_width + frame.minimum_width + 2)



			create bounding_frame.make_with_text (gb_ev_colorizable_foreground_color)
			Result.extend (bounding_frame)

			create horizontal_box
			create vertical_box
			bounding_frame.extend (vertical_box)
			vertical_box.extend (horizontal_box)
			create frame
			create f_area
			f_area.set_pebble_function (agent retrieve_color (f_area, True))
			f_area.drop_actions.extend (agent accept_foreground_color_stone (?))
			frame.set_minimum_width (40)
			f_area.set_tooltip (gb_ev_colorizable_foreground_color_tooltip)
			create button.make_with_text (Select_button_text)
			button.set_tooltip ("Select foreground color")
			foreground_color := first_object.foreground_color
			frame.extend (f_area)
			horizontal_box.set_padding (2)
			create cell
			horizontal_box.extend (cell)
			horizontal_box.disable_item_expand (cell)
			horizontal_box.extend (frame)
			horizontal_box.extend (button)
			horizontal_box.disable_item_expand (button)
			horizontal_box.disable_item_expand (frame)
			f_area.expose_actions.force_extend (agent f_area.clear)
			button.select_actions.extend (agent update_foreground_color)
			create horizontal_box
			horizontal_box.set_border_width (2)
			create button1.make_with_text (gb_ev_colorizable_restore_color)
			button1.set_tooltip (foreground_color_restore)
			button1.select_actions.extend (agent restore_foreground_color)
			horizontal_box.extend (button1)
			vertical_box.extend (horizontal_box)
			horizontal_box.disable_item_expand (button1)
			button1.set_minimum_width (button.minimum_width + frame.minimum_width + 2)

			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end

		update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			update_background_display
			update_foreground_display
		end

feature {NONE} -- Implementation

	accept_foreground_color_stone (stone: GB_COLOR_STONE) is
			-- Set foreground color, based on settings of `stone'.
		require
			stone_not_void: stone /= Void
		do
			actually_set_foreground_color (stone.color)
		end

	accept_background_color_stone (stone: GB_COLOR_STONE) is
			-- Set background color, based on settings of `stone'.
		require
			stone_not_void: stone /= Void
		do
			actually_set_background_color (stone.color)
		end

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			-- Nothing to perform here.
		end

	default_object_by_type (a_type: STRING): EV_ANY is
			-- `Result' is a default object that corresponds to `a_type'.
		deferred
		end

	retrieve_color (label: EV_DRAWING_AREA; is_foreground: BOOLEAN): GB_COLOR_STONE is
			-- `Result' is color for pick and drop, retrieved
			-- from `background_color' of `label'.
		do
			if is_foreground then
				Result := create {GB_COLOR_STONE}.make_with_properties (label.background_color, True)
			else
				Result := create {GB_COLOR_STONE}.make_with_properties (label.background_color, False)
			end
		end

	restore_background_color is
			-- Restore `background_color' of objects to originals.
		local
			colorizable: EV_COLORIZABLE
			p: PROCEDURE [EV_ANY, TUPLE]
		do
			colorizable ?= default_object_by_type (class_name (first))
			p := agent {EV_COLORIZABLE}.set_background_color (colorizable.background_color)
			for_all_objects (p)
			update_editors
			update_background_display
		end

	restore_foreground_color is
			-- Restore `foreground_color' of objects to originals.
		local
			colorizable: EV_COLORIZABLE
			p: PROCEDURE [EV_ANY, TUPLE]
		do
			colorizable ?= default_object_by_type (class_name (first))
			p := agent {EV_COLORIZABLE}.set_foreground_color (colorizable.foreground_color)
			for_all_objects (p)
			update_editors
			update_foreground_display
		end

	update_background_color is
			-- Update `background_color' of objects through an EV_COLOR_DIALOG.
		do
			color_dialog.set_color (background_color)
			color_dialog.show_modal_to_window (parent_window (parent_editor))
			if color_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				actually_set_background_color (color_dialog.color)
			end
		end

	actually_set_background_color (color: EV_COLOR) is
			-- Actually update the background colors.
		local
			p: PROCEDURE [EV_ANY, TUPLE]
		do
			p := agent {EV_COLORIZABLE}.set_background_color (color)
			for_all_objects (p)
--| FIXME ADD THIS and propagate to all instances.
--			container ?= objects.i_th (2)
--			if container /= Void then
--				container ?= container.parent
--				if container /= Void then
--					container.set_background_color (color)
--				end
--			end
			background_color := color
			update_editors
			update_background_display
		end

	update_background_display is
			-- Update area displaying the background color of the EV_COLORIZABLE.
		do
			b_area.set_background_color (first.background_color)
			b_area.clear
		end

	update_foreground_display is
			-- Update area displaying the background color of the EV_COLORIZABLE.
		do
			f_area.set_background_color (first.foreground_color)
			f_area.clear
		end

	update_foreground_color is
			-- Update `foreground_color' of objects through an EV_COLOR_DIALOG.
		do
			color_dialog.set_color (foreground_color)
			color_dialog.show_modal_to_window (parent_window (parent_editor))
			if color_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				actually_set_foreground_color (color_dialog.color)
			end
		end

	actually_set_foreground_color (color: EV_COLOR) is
			-- Actually update the foreground colors.
		local
			p: PROCEDURE [EV_ANY, TUPLE]
		do
			p := agent {EV_COLORIZABLE}.set_foreground_color (color)
			for_all_objects (p)
			foreground_color := color
			update_editors
			update_foreground_display
		end

	build_string_from_color (color: EV_COLOR): STRING is
			-- `Result' is string representation of `color'.
		require
			color_not_void: color /= Void
		do
			create Result.make (0)
			if color.red_8_bit.out.count < 3 then
				Result := Result + add_leading_zeros (3 - color.red_8_bit.out.count)
			end
			Result.append_string (color.red_8_bit.out)
			if color.green_8_bit.out.count < 3 then
				Result := Result + add_leading_zeros (3 - color.green_8_bit.out.count)
			end
			Result.append_string (color.green_8_bit.out)
			if color.blue_8_bit.out.count < 3 then
				Result := Result + add_leading_zeros (3 - color.blue_8_bit.out.count)
			end
			Result.append_string (color.blue_8_bit.out)
		end

	build_color_from_string (a_string: STRING): EV_COLOR is
			-- `Result' is an EV_COLOR built from contents of `a_string'.
		require
			string_correct_length: a_string.count = 9
			a_string_is_integer: a_string.is_integer
		do
			create Result
			Result.set_rgb_with_8_bit (a_string.substring (1, 3).to_integer,
				a_string.substring (4, 6).to_integer,
				a_string.substring (7, 9).to_integer)
		ensure
			Result_not_void: Result /= Void
		end


	add_leading_zeros (count: INTEGER): STRING is
			-- `Result' is `a_string' with `count' '0's added.
		require
			count_ok: count > 0 and count <= 2
		local
			counter: INTEGER
		do
			create Result.make (0)
			from
				counter := 0
			until
				counter = count
			loop
				Result.append_string ("0")
				counter := counter + 1
			end
		ensure
			Result_not_void: Result /= Void
			Result_correct_length: Result.count = count
		end

	foreground_color: EV_COLOR
	background_color: EV_COLOR

	b_area, f_area: EV_DRAWING_AREA

	color_dialog: EV_COLOR_DIALOG;

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


end -- class GB_EV_COLORIZABLE_EDITOR_CONSTRUCTOR
