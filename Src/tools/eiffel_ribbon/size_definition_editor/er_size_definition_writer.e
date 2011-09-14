note
	description: "[
					Manager that convert EV_FIGUREs to ribbon markup XML
																			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SIZE_DEFINITION_WRITER

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			reset
			create sub_root_xml_hash_table.make (10)
			create all_generated_figures.make (100)
			create large_button_breaking_x.make (10)
		end

feature -- Command

	reset
			-- Reset XML
		do
			create sub_root_element.make (Void, constants.size_definition, name_space)
		end

	save (a_figures: ARRAYED_LIST [ER_FIGURE]; a_name: STRING)
			-- Start converting EV_FIGURE in GUI to ribbon makrup XML
		require
			valid: a_name /= Void and then not a_name.is_empty
		local
			l_line_1, l_line_2, l_line_3: SORTED_TWO_WAY_LIST [ER_FIGURE]
			l_items: SORTED_TWO_WAY_LIST [ER_FIGURE]
			l_rows: ARRAYED_LIST [ER_FIGURE_ROW]
			l_sorted_rows: SORTED_TWO_WAY_LIST [ER_FIGURE_ROW]

			l_attribute: XML_ATTRIBUTE
--			l_root_xml: XML_ELEMENT
		do
			sub_root_element := root_xml_for_name (a_name)
			sub_root_element.wipe_out
--			create sub_root_element.make (l_root_xml, constants.size_definition, name_space)
--			l_root_xml.put_last (sub_root_element)

			create l_attribute.make ({ER_XML_ATTRIBUTE_CONSTANTS}.name, name_space, a_name, sub_root_element)
			sub_root_element.put_last (l_attribute)

			l_line_1 := buttons_on_y ({ER_SIZE_DEFINITION_CONSTANTS}.up_horizontal_line_y, a_figures)
			l_line_2 := buttons_on_y ({ER_SIZE_DEFINITION_CONSTANTS}.middle_horizontal_line_y, a_figures)
			l_line_3 := buttons_on_y ({ER_SIZE_DEFINITION_CONSTANTS}.lower_horizontal_line_y, a_figures)

			create l_items.make
			l_items.append (l_line_1)
			l_items.append (l_line_2)
			l_items.append (l_line_3)
			add_control_name_maps (l_items)

			l_rows := break_into_rows (l_line_1, true)
			l_rows.append (break_into_rows (l_line_2, false))
			l_rows.append (break_into_rows (l_line_3, false))

			l_sorted_rows := sort_rows (l_rows)
			figures := a_figures
			add_group_size_definitions (l_sorted_rows, {ER_XML_ATTRIBUTE_CONSTANTS}.large)
			--FIXME: save for medium and small size tempoary
			add_group_size_definitions (l_sorted_rows, {ER_XML_ATTRIBUTE_CONSTANTS}.medium)
			add_group_size_definitions (l_sorted_rows, {ER_XML_ATTRIBUTE_CONSTANTS}.small)
		end

	figures: detachable ARRAYED_LIST [ER_FIGURE]
			-- Set by `save'

	load (a_name: STRING)
			-- Load XML to GUI
		require
			has: sub_root_xml_hash_table.has (a_name)
		do
			if attached sub_root_xml_hash_table.item (a_name) as l_sub_xml_root then
				check l_sub_xml_root.name.same_string (constants.size_definition) end
				all_generated_figures.wipe_out

				from
					l_sub_xml_root.start
				until
					l_sub_xml_root.after
				loop
					if attached {XML_ATTRIBUTE} l_sub_xml_root.item_for_iteration as l_attribute and then
						l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.name) then
							check valid: l_attribute.value.same_string (a_name) end

					elseif attached {XML_ELEMENT} l_sub_xml_root.item_for_iteration as l_sub_item and then
						l_sub_item.name.same_string (constants.group_size_definition) then
						load_size_definition (l_sub_item)
					end

					l_sub_xml_root.forth
				end
			end
		end

feature -- Combo box handling

	update_combo_box (a_combo_box: EV_COMBO_BOX; a_select: detachable STRING)
			-- Update combo box list with `root_xml' hash table
		require
			not_void: a_combo_box /= Void
		local
			l_item: EV_LIST_ITEM
			l_stop: BOOLEAN
		do
			from
				a_combo_box.wipe_out
				sub_root_xml_hash_table.start
			until
				sub_root_xml_hash_table.after
			loop
				create l_item.make_with_text (sub_root_xml_hash_table.key_for_iteration)
				a_combo_box.extend (l_item)

				sub_root_xml_hash_table.forth
			end

			if a_select /= Void then
				from
					a_combo_box.start
				until
					a_combo_box.after or l_stop
				loop
					if a_combo_box.item.text.same_string (a_select) then
						l_stop := True
						a_combo_box.item.enable_select
					end
					a_combo_box.forth
				end
			end
		end

	on_combo_box_select (a_combo_box: EV_COMBO_BOX)
			-- Handle combo box select event
		require
			not_void: a_combo_box /= Void
		do
			-- Load xml and display correspond GUI elements
			-- FIXME: not implemented
		end

feature -- Query

	root_xml_for_saving: XML_ELEMENT
			-- Root size definition xml for saving
		require
			not_empty: not is_empty
		do
			create Result.make (Void, constants.ribbon_size_definitions, name_space)
			from
				sub_root_xml_hash_table.start
			until
				sub_root_xml_hash_table.after
			loop
				sub_root_xml_hash_table.item_for_iteration.attach_parent (Result)
--				sub_root_xml_hash_table.item_for_iteration.set_parent (Result)
				Result.put_last (sub_root_xml_hash_table.item_for_iteration)

				sub_root_xml_hash_table.forth
			end
		end

	sub_root_xml_hash_table: HASH_TABLE [XML_ELEMENT, STRING]
			-- XML root for different size definitions

	is_empty: BOOLEAN
			-- If size definition codes not generated?
		do
			Result := sub_root_xml_hash_table.is_empty
		end

	all_generated_figures: ARRAYED_LIST [ER_FIGURE]
			-- Figures generated by `load'

feature {NONE} -- Figure XML loading to GUI

	load_size_definition (a_group_size_definition: XML_ELEMENT)
			-- Load size definition
			-- FIXME: handle medium and small size definition here
		require
			not_void: a_group_size_definition /= Void
		local
			l_size: detachable STRING
		do
			check valid: a_group_size_definition.name.same_string (constants.group_size_definition) end
			from
				a_group_size_definition.start
			until
				a_group_size_definition.after
			loop
				if attached {XML_ATTRIBUTE} a_group_size_definition.item_for_iteration as l_attribute and then
					l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.size) then
					l_size := l_attribute.value
				elseif attached {XML_ELEMENT} a_group_size_definition.item_for_iteration as l_row and then
					l_row.name.same_string (constants.row) then
					if l_size /= Void then
						if l_size.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.large) then
							load_row (l_row)
						end
					end
				elseif attached {XML_ELEMENT} a_group_size_definition.item_for_iteration as l_item and then
					l_item.name.same_string (constants.control_size_definition) then

					check not_implemented: False end
				end
				a_group_size_definition.forth
			end
		end

	load_row (a_row: XML_ELEMENT)
			-- Load row
		require
			not_void: a_row /= Void
		local
			l_count: INTEGER
			l_row_changed: BOOLEAN
		do
			check a_row.name.same_string (constants.row) end
			if all_generated_figures.is_empty then
				current_row_y := {ER_SIZE_DEFINITION_CONSTANTS}.default_start_y
				current_row_x := {ER_SIZE_DEFINITION_CONSTANTS}.default_start_x
			elseif all_generated_figures.last.is_large_image_size then
				current_row_y := {ER_SIZE_DEFINITION_CONSTANTS}.up_horizontal_line_y
				current_row_x := right_most_x (all_generated_figures) + {ER_SIZE_DEFINITION_CONSTANTS}.default_button_padding
			else
				if all_generated_figures.last.y = {ER_SIZE_DEFINITION_CONSTANTS}.up_horizontal_line_y then
					current_row_y := {ER_SIZE_DEFINITION_CONSTANTS}.middle_horizontal_line_y
				elseif all_generated_figures.last.y = {ER_SIZE_DEFINITION_CONSTANTS}.middle_horizontal_line_y then
					current_row_y := {ER_SIZE_DEFINITION_CONSTANTS}.lower_horizontal_line_y
				elseif all_generated_figures.last.y = {ER_SIZE_DEFINITION_CONSTANTS}.lower_horizontal_line_y then
					current_row_y := {ER_SIZE_DEFINITION_CONSTANTS}.up_horizontal_line_y
				end

				check last_row_first_item /= Void end
				if attached last_row_first_item as l_last_row_first then
					current_row_x := l_last_row_first.x
				end

			end
			from
				l_row_changed := True
				l_count := all_generated_figures.count
				a_row.start
			until
				a_row.after
			loop
				if attached {XML_ELEMENT} a_row.item_for_iteration as l_item and then
					l_item.name.same_string (constants.control_size_definition) then

					load_control_size_definition (l_item, l_row_changed)
				end
				if l_count = all_generated_figures.count - 1 then
					last_row_first_item := all_generated_figures.last
				end
				l_row_changed := false

				a_row.forth
			end
		end

	last_row_first_item: detachable ER_FIGURE
			-- First item in last row

	current_row_y: INTEGER
			-- Current y position

	current_row_x: INTEGER
			-- Current x position

	right_most_x (a_figures: ARRAYED_LIST [ER_FIGURE]): INTEGER
			-- Most right X position in `a_figures'
		local
			l_right: INTEGER
		do
			from
				a_figures.start
			until
				a_figures.after
			loop
				l_right := a_figures.item.x + a_figures.item.width
				if Result < l_right then
					Result := l_right
				end
				a_figures.forth
			end
		end

	load_control_size_definition (a_size_definition: XML_ELEMENT; a_row_changed: BOOLEAN)
			-- Load control (button) size definition
		require
			not_void: a_size_definition /= Void
		local
			l_x, l_y: INTEGER
			l_result: ER_FIGURE
		do
			from
				create l_result.make
				if all_generated_figures.is_empty then
					l_x := {ER_SIZE_DEFINITION_CONSTANTS}.default_start_x
				else
					if a_row_changed then
						l_x := current_row_x
					else
						l_x := all_generated_figures.last.x + all_generated_figures.last.width + {ER_SIZE_DEFINITION_CONSTANTS}.default_button_padding
					end

				end
				l_y := current_row_y

				a_size_definition.start
			until
				a_size_definition.after
			loop
				if attached {XML_ATTRIBUTE} a_size_definition.item_for_iteration as l_attribute then
					if l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.control_name) then
						-- Nothing to do here
					elseif l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.image_size) then
						if l_attribute.value.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.large) then
							l_result.set_is_large_image_size (True)

							-- Large image must in first row
							l_y := {ER_SIZE_DEFINITION_CONSTANTS}.up_horizontal_line_y
							l_x := right_most_x (all_generated_figures) + {ER_SIZE_DEFINITION_CONSTANTS}.default_button_padding
						else
							l_result.set_is_large_image_size (False)
						end
					elseif l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.is_label_visible) then
						if l_attribute.value.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.true_value) then
							l_result.set_label_visible (True)
						else
							l_result.set_label_visible (False)
						end
					end
				end

				a_size_definition.forth
			end

			l_result.set_x (l_x)
			l_result.set_y (l_y)

			all_generated_figures.extend (l_result)
		end

feature {NONE} -- Figure implementation

	sub_root_element: XML_ELEMENT
			-- Current sub root element used for `save'

	add_group_size_definitions (a_rows: LIST [ER_FIGURE_ROW]; a_size: STRING)
			-- Save group size definitions
		require
			valid: a_size.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.large) or else
				a_size.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.medium) or else
				a_size.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.small)
		local
			l_group_size_definition: XML_ELEMENT
			l_row: XML_ELEMENT
			l_attribute: XML_ATTRIBUTE
		do
			from
				create l_group_size_definition.make (sub_root_element, constants.group_size_definition, name_space)
				sub_root_element.put_last (l_group_size_definition)

				create l_attribute.make ({ER_XML_ATTRIBUTE_CONSTANTS}.size, name_space, a_size, l_group_size_definition)
				l_group_size_definition.put_last (l_attribute)

				a_rows.start
			until
				a_rows.after
			loop
				create l_row.make (l_group_size_definition, constants.row, name_space)
				l_group_size_definition.put_last (l_row)

				--FIXME: should handle control group here
				add_control_size_definitions (l_row, a_rows.item)

				a_rows.forth
			end
		end

	add_control_size_definitions (a_row: XML_ELEMENT; a_items: ER_FIGURE_ROW)
			-- Save button size definitions
		require
			valid: a_row.name.same_string ({ER_XML_CONSTANTS}.row)
			set: figures /= Void
		local
			l_item: XML_ELEMENT
			l_attribute: XML_ATTRIBUTE
			l_value: STRING
		do
			if attached figures as l_figures then
				from
					a_items.start
				until
					a_items.after
				loop
					create l_item.make (a_row, constants.control_size_definition, name_space)
					a_row.put_last (l_item)

					create l_attribute.make ({ER_XML_ATTRIBUTE_CONSTANTS}.control_name, name_space, {ER_XML_ATTRIBUTE_CONSTANTS}.button_prefix + l_figures.index_of (a_items.item, 1).out, l_item)
					l_item.put_last (l_attribute)

					if a_items.item.is_large_image_size then
						l_value := {ER_XML_ATTRIBUTE_CONSTANTS}.large
					else
						l_value := {ER_XML_ATTRIBUTE_CONSTANTS}.small
					end

					create l_attribute.make ({ER_XML_ATTRIBUTE_CONSTANTS}.image_size, name_space, l_value, l_item)
					l_item.put_last (l_attribute)

					if a_items.item.is_label_visible then
						l_value := {ER_XML_ATTRIBUTE_CONSTANTS}.true_value
					else
						l_value := {ER_XML_ATTRIBUTE_CONSTANTS}.false_value
					end

					create l_attribute.make ({ER_XML_ATTRIBUTE_CONSTANTS}.is_label_visible, name_space, l_value, l_item)
					l_item.put_last (l_attribute)

					a_items.forth
				end
			end
		end

	sort_rows (a_rows: ARRAYED_LIST [ER_FIGURE_ROW]): SORTED_TWO_WAY_LIST [ER_FIGURE_ROW]
			-- Order is first row item's x value, if x valus same, then compare y value
		do
			from
				a_rows.start
				create Result.make
			until
				a_rows.after
			loop
				Result.search_before (a_rows.item)
				Result.put_right (a_rows.item)
				a_rows.forth
			end

		end

	large_button_breaking_x: ARRAYED_LIST [INTEGER]
			-- Large buttons' x position that cross three rows

	break_into_rows (a_figures: LIST [ER_FIGURE]; a_record_large_buttons_x: BOOLEAN): ARRAYED_LIST [ER_FIGURE_ROW]
			-- Break figures into different rows
		local
			l_item: ER_FIGURE_ROW
			l_is_last_large_image: BOOLEAN
			l_should_break: BOOLEAN
		do
			from
				if a_record_large_buttons_x then
					large_button_breaking_x.wipe_out
				end
				create Result.make (a_figures.count)
				create l_item.make (a_figures.count)
				Result.extend (l_item)
				a_figures.start
			until
				a_figures.after
			loop
				if a_figures.index /= 1 then
					if l_is_last_large_image /= a_figures.item.is_large_image_size then
						create l_item.make (a_figures.count)
						Result.extend (l_item)
						if a_record_large_buttons_x then
							large_button_breaking_x.extend (a_figures.item.x)
						end
					end

					l_item.extend (a_figures.item)
				else
					l_item.extend (a_figures.item)
				end

				if a_record_large_buttons_x then
					-- Top line
					l_is_last_large_image := a_figures.item.is_large_image_size
				else
					-- Row 2, row 3
					from
						l_should_break := False
						large_button_breaking_x.start
					until
						large_button_breaking_x.after or l_should_break
					loop
						check must_be_small_image: not a_figures.item.is_large_image_size end

						if a_figures.index /= a_figures.count then
							if a_figures.item.x + a_figures.item.width < large_button_breaking_x.item and then
								large_button_breaking_x.item < a_figures.i_th (a_figures.index + 1).x then
								l_should_break := True
							end
						end
						large_button_breaking_x.forth
					end
					l_is_last_large_image := l_should_break
				end

				a_figures.forth
			end
		end

	add_control_name_maps (a_figures: LIST [ER_FIGURE])
			-- Add button name mappings
		require
			not_already_called: True
		local
			l_element: XML_ELEMENT
			l_item: XML_ELEMENT
			l_attribute: XML_ATTRIBUTE
		do
			create l_element.make (sub_root_element, constants.control_name_map, name_space)
			sub_root_element.put_last (l_element)

			from
				a_figures.start
			until
				a_figures.after
			loop
				create l_item.make (l_element, constants.control_named_efinition, name_space)
				l_element.put_last (l_item)

				create l_attribute.make ({ER_XML_ATTRIBUTE_CONSTANTS}.name, name_space, {ER_XML_ATTRIBUTE_CONSTANTS}.button_prefix + a_figures.index.out, l_item)
				l_item.put_last (l_attribute)

				a_figures.forth
			end
		end

	buttons_on_y (a_y_position: INTEGER; a_figures: ARRAYED_LIST [ER_FIGURE]): SORTED_TWO_WAY_LIST [ER_FIGURE]
			-- Buttons ordered by y position
		do
			from
				create Result.make
				a_figures.start
			until
				a_figures.after
			loop
				if a_y_position = a_figures.item.y then
					Result.search_before (a_figures.item)
					Result.put_right (a_figures.item)
				end
				a_figures.forth
			end
		end

feature {NONE} -- Implementation

	root_xml_for_name (a_name: STRING): XML_ELEMENT
			-- Find root xml element in `root_xml' hash table
			-- If not found, create a new one
		require
			not_void: a_name /= Void
		local
			l_result: detachable XML_ELEMENT
		do
			if sub_root_xml_hash_table.has (a_name) then
				l_result := sub_root_xml_hash_table.item (a_name)
				check not_void: l_result /= Void end
				Result := l_result
			else
				create Result.make (Void, constants.size_definition, name_space)
				sub_root_xml_hash_table.extend (Result, a_name)
			end
		end

	name_space: XML_NAMESPACE
			-- Default namespace
		once
			create Result.make_default
		end

	constants: ER_XML_CONSTANTS
			-- Constants
		once
			create Result
		end
end
