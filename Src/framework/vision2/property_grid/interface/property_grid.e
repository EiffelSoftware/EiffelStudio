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
			row_type,
			on_key_pressed
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
			create expanded_section_store.make (0)

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
			key_press_actions.extend (agent on_key_pressed)
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
	current_section_name: STRING
			-- Current section, that will be used for insertion.

feature -- Update

	reset is
			-- Reset to empty property grid.
		do
			wipe_out
			set_column_count_to (2)
			sections.wipe_out
			create expanded_section_store.make (0)
			resize (0, 0, 0, 0)
		end

	add_section (a_name: STRING) is
			-- If there is no section with `a_name', add a new section with `a_name' and use this section for further additions of properties.
			-- Else use the existing section.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		local
			l_row: EV_GRID_ROW
			l_item: EV_GRID_LABEL_ITEM
			l_font: EV_FONT
		do
			if not sections.has (a_name) then
				insert_new_row (row_count + 1)
				l_row := row (row_count)
				create l_item.make_with_text (a_name)
				create l_font
				l_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
				l_item.set_font (l_font)

				l_row.set_item (1, l_item)
				l_row.set_background_color (separator_color)
				sections.force (l_row, a_name)
				current_section := l_row
				current_section_name := a_name
				l_row.collapse_actions.extend (agent update_expanded_status (False, a_name))
				l_row.expand_actions.extend (agent update_expanded_status (True, a_name))
			else
				current_section := sections.found_item
				current_section_name := a_name
			end
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
			l_name_item.select_actions.extend (agent show_description (a_property))
			a_property.select_actions.extend (agent show_description (a_property))
			if a_property.description /= Void then
				l_name_item.set_tooltip (a_property.description)
			end
			l_row.set_item (1, l_name_item)
			l_row.set_item (2, a_property)
			l_name_item.pointer_button_press_actions.extend (agent a_property.check_right_click)

			if expanded_section_store.has (current_section_name) then
				if expanded_section_store.found_item and not current_section.is_expanded then
					current_section.expand
				elseif not expanded_section_store.found_item and current_section.is_expanded then
					current_section.collapse
				end
			end
		end

	set_description_field (a_field: like description_field) is
			-- Set place for descriptions.
		do
			description_field := a_field
		ensure
			description_field_set: description_field = a_field
		end

	set_expanded_section_store (a_store: HASH_TABLE [BOOLEAN, STRING]) is
			-- Store for the expanded sections, will get updated if sections are expanded or collapsed.
		require
			a_store_not_void: a_store /= Void
		do
			expanded_section_store := a_store
			from
				a_store.start
			until
				a_store.after
			loop
				if sections.has (a_store.key_for_iteration) and then sections.found_item.is_expandable then
					if a_store.item_for_iteration then
						sections.found_item.expand
					else
						sections.found_item.collapse
					end
				end
				a_store.forth
			end
		ensure
			expanded_section_store_set: expanded_section_store = a_store
		end

feature {NONE} -- Agents

	update_expanded_status (a_is_expanded: BOOLEAN; a_section: STRING) is
			-- Update expanded status to `a_is_expanded' of `a_section'.
		require
			a_section_ok: a_section /= Void and then not a_section.is_empty
		do
			expanded_section_store.force (a_is_expanded, a_section)
		end

	on_key_pressed (a_key: EV_KEY) is
			-- `a_key' was pressed.
		do
			Precursor (a_key)
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				if selected_items /= Void and then selected_items.count = 1 then
					selected_items.first.activate
				end
			end
		end

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
			l_y: INTEGER
		do
			l_y := y_pos + virtual_y_position
			remove_selection
			if l_y >= 0 and l_y <= virtual_height then
				l_row ?= row_at_virtual_position (l_y, False)
				if l_row /= Void and then l_row.property /= Void then
					l_row.item (1).enable_select
				end
			end
		end

	show_description (a_property: PROPERTY) is
			-- Show description for `a_property'.
		require
			a_property_not_void: a_property /= Void
		do
			if description_field /= Void then
				if a_property.name.is_empty then
					description_field.set_text (a_property.description)
				elseif a_property.description.is_empty then
					description_field.set_text (a_property.name)
				else
					description_field.set_text (a_property.name + ": " + a_property.description)
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

	expanded_section_store: HASH_TABLE [BOOLEAN, STRING]
			-- Expanded status of the sections.

invariant
	expanded_section_store_not_void: expanded_section_store /= Void

end
