indexing
	description: "Property grid"
	date: "$Date$"
	revision: "$Revision$"

class
	PROPERTY_GRID

inherit
	ES_GRID
		redefine
			initialize,
			is_in_default_state,
			row_type
		end

create
	default_create,
	make_with_description

feature {NONE} -- Initialization

	make_with_description (a_field: like description_field) is
			-- Create with `a_field' to put descriptions.
		require
			a_field_not_void: a_field /= Void
		do
			default_create
			description_field := a_field
		ensure
			description_field_set: description_field = a_field
		end

	initialize is
			-- Create.
		do
			Precursor
			disable_last_column_use_all_width
			disable_selection_on_click

			enable_row_separators
			enable_column_separators
			enable_tree
			hide_header
			hide_tree_node_connectors

			create sections.make (5)

			set_column_count_to (2)
			column (name_column).set_width (initial_name_column_width)
			column (value_column).set_width (initial_value_column_width)

			pointer_button_press_actions.extend (agent select_name_item)
			resize_actions.extend (agent resize)
		end

feature -- Status

	valid_current_section: BOOLEAN is
			-- Is there a valid current section?
		do
			Result := current_section /= Void
		end

feature -- Access

	section (a_name: STRING): EV_GRID_ROW is
			-- Get section with `a_name' if it exists.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			Result := sections.item (a_name)
		end

	current_section: EV_GRID_ROW
			-- Current section, that will be used for insertion.

feature -- Update

	reset is
			-- Reset to empty property grid.
		do
			wipe_out
			set_column_count_to (2)
			resize (0, 0, 0, 0)
		end

	add_section (a_name: STRING) is
			-- Add a new section with `a_name' and use this section for further additions of properties.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		local
			l_row: EV_GRID_ROW
		do
			insert_new_row (row_count + 1)
			l_row := row (row_count)
			l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text (a_name))
			l_row.set_background_color (separator_color)
			sections.force (l_row, a_name)
			current_section := l_row
		ensure
			valid_current_section: valid_current_section
		end

	add_property (a_property: PROPERTY) is
			-- Add `a_property'.
		require
			valid_current_section
		local
			l_row: like row_type
			l_index: INTEGER
			l_name_item: EV_GRID_LABEL_ITEM
		do
			l_index := current_section.subrow_count + 1
			current_section.insert_subrow (l_index)
			l_row ?= current_section.subrow (l_index)
			l_row.set_property (a_property)
			create l_name_item.make_with_text (a_property.name)
			if a_property.description /= Void then
				l_name_item.set_tooltip (a_property.description)
			end
			l_row.set_item (1, l_name_item)
			l_row.set_item (2, a_property)
			l_name_item.pointer_button_press_actions.extend (agent a_property.check_right_click)
		end

	set_description_field (a_field: like description_field) is
			-- Set place for descriptions.
		do
			description_field := a_field
		ensure
			description_field_set: description_field = a_field
		end

feature {NONE} -- Agents

	resize (a_x, a_y, a_width, a_height: INTEGER) is
			-- Resize window.
		local
			l_w1, l_w2: INTEGER
			l_available_width: INTEGER
		do
			if not is_destroyed then
				l_w1 := column (name_column).width
				l_w2 := column (value_column).width
				l_available_width := width
				l_w1 := l_w1 + (l_available_width - l_w1 - l_w2)//2
				l_w2 := l_available_width - l_w1
				l_w1 := l_w1.max (10)
				l_w2 := l_w2.max (10)
				column (name_column).set_width (l_w1)
				column (value_column).set_width (l_w2)
			end
		end

	select_name_item (x_pos, y_pos, a_button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; x_screen, y_screen: INTEGER) is
			-- Select name item of the current row.
		local
			l_row: like row_type
			l_prop: PROPERTY
			l_y: INTEGER
		do
			l_y := y_pos + virtual_y_position
			remove_selection
			if l_y >= 0 and l_y <= virtual_height then
				l_row ?= row_at_virtual_position (l_y, False)
				if l_row /= Void and then l_row.property /= Void then
					l_prop := l_row.property
					l_row.item (1).enable_select
					if description_field /= Void then
						if l_prop.name.is_empty then
							description_field.set_text (l_prop.description)
						elseif l_prop.description.is_empty then
							description_field.set_text (l_prop.name)
						else
							description_field.set_text (l_prop.name + ": " + l_prop.description)
						end
					end
				end
			end
		end

feature -- Type anchors

	row_type: PROPERTY_ROW

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is True
			-- Is `Current' in its default state?

feature {NONE} -- Layout constants

		-- column sizes
	initial_name_column_width: INTEGER is 230
	initial_value_column_width: INTEGER is 200

feature {NONE} -- Constants

		-- columns
	name_column: INTEGER is 1
	value_column: INTEGER is 2

feature {NONE} -- Implementation

	sections: HASH_TABLE [EV_GRID_ROW, STRING]
			-- Property sections.

	description_field: EV_TEXTABLE
			-- Place to put descriptions.

end
