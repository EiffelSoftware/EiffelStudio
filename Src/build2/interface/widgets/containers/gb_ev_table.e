indexing
	description: "Objects that manipulate objects of type EV_TABLE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TABLE

	-- The following properties from EV_TABLE are manipulated by `Current'.
	-- columns - Performed on the real object and the display_object child.
	-- rows - Performed on the real object and the display_object child.
	-- border_width - Performed on the real object and the display_object child.
	-- row_spacing - Performed on the real object and the display_object child.
	-- column_spacing - Performed on the real object and the display_object child.
	-- is_homogeneous - Performed on the real object and the display_object child.

inherit
	
	GB_EV_ANY
		undefine
			attribute_editor			
		redefine
			ev_type,
			modify_from_xml_after_build
		end
		
	GB_EV_TABLE_EDITOR_CONSTRUCTOR

	INTERNAL
		undefine
			default_create
		end
		
	GB_SHARED_DEFERRED_BUILDER
		undefine
			default_create
		end
		
	GB_SHARED_OBJECT_HANDLER
		undefine
			default_create
		end

feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			temp_column_positions_string, temp_row_positions_string,
			temp_widths_string, temp_heights_string: STRING
			an_object: GB_OBJECT
			layout_item, current_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			current_table_widget: EV_WIDGET
			children: ARRAYED_LIST [GB_OBJECT]
		do			
			if first.columns /= 1 or uses_constant (Columns_string) then
				add_integer_element (element, columns_string, first.columns)	
			end
			if first.rows /= 1 or uses_constant (rows_string) then
				add_integer_element (element, rows_string, first.rows)	
			end
			if first.column_spacing /= 0 or uses_constant (column_spacing_string) then
				add_integer_element (element, column_spacing_string, first.column_spacing)
			end
			if first.row_spacing /= 0  or uses_constant (row_spacing_string) then
				add_integer_element (element, row_spacing_string, first.row_spacing)
			end
			
			if first.border_width /= 0 or uses_constant (border_width_string) then
				add_integer_element (element, border_width_string, first.border_width)
			end

			children := object.children
			
			temp_column_positions_string := ""
			temp_row_positions_string := ""
			temp_widths_string := ""
			temp_heights_string := ""
			from
				children.start
			until
				children.off
			loop
				current_table_widget ?= children.item.object
				temp_column_positions_string := temp_column_positions_string + add_leading_zeros (first.item_column_position (current_table_widget).out)
				temp_row_positions_string := temp_row_positions_string + add_leading_zeros (first.item_row_position (current_table_widget).out)
				temp_widths_string := temp_widths_string + add_leading_zeros (first.item_column_span (current_table_widget).out)
				temp_heights_string := temp_heights_string + add_leading_zeros (first.item_row_span (current_table_widget).out)
				children.forth
			end
			if not temp_column_positions_string.is_empty then
				add_element_containing_string (element, column_positions_string, temp_column_positions_string)
			end
			if not temp_row_positions_string.is_empty then
				add_element_containing_string (element, row_positions_string, temp_row_positions_string)
			end
			if not temp_widths_string.is_empty then
				add_element_containing_string (element, column_spans_string, temp_widths_string)
			end
			if not temp_heights_string.is_empty then
				add_element_containing_string (element, row_spans_string, temp_heights_string)
			end
		end
	
	add_leading_zeros (original_string: STRING): STRING is
			-- Add leading zeros to `original_string',
			-- so it is a valid 4 character, Integer representation.
		require
			original_string_length_ok: original_string.count >= 1 and original_string.count < 5
		do
			if original_string.count = 1 then
				Result := "000" + original_string
			elseif original_string.count = 2 then
				Result := "00" + original_string
			elseif original_string.count = 3 then
				Result := "0" + original_string
			end
		ensure
			Result_correct_length: Result.count = 4
			Result_is_integer: Result.is_integer
		end
		
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		do
			full_information := get_unique_full_info (element)
			
			if full_information @ (Columns_string) /= Void then
				for_all_objects (agent {EV_TABLE}.resize (retrieve_and_set_integer_value (Columns_string), first.rows))
			end
			if full_information @ (Rows_string) /= Void then
				for_all_objects (agent {EV_TABLE}.resize (first.columns, retrieve_and_set_integer_value (Rows_string)))
			end
			if full_information @ (Column_spacing_string) /= Void then
				for_all_objects (agent {EV_TABLE}.set_column_spacing (retrieve_and_set_integer_value (Column_spacing_string)))
			end
			if full_information @ (Row_spacing_string) /= Void then
				for_all_objects (agent {EV_TABLE}.set_row_spacing (retrieve_and_set_integer_value (Row_spacing_string)))
			end
			if full_information @ (Border_width_string) /= Void then
				for_all_objects (agent {EV_TABLE}.set_border_width (retrieve_and_set_integer_value (Border_width_string)))
			end			
				-- All the building for an EV_FIXED needs to be deferred so
				-- we set up some deferred building now.
			deferred_builder.defer_building (Current, element)
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
			temp_column_positions_string, temp_row_positions_string,
			temp_column_spans_string, temp_row_spans_string: STRING
			counter: INTEGER
			lower, upper: INTEGER
			current_child_name: STRING
			rows, columns: STRING
			column_position, row_position, column_span, row_span: STRING
			children_names: ARRAYED_LIST [STRING]
		do

			create Result.make (4)
			full_information := get_unique_full_info (element)
			if attribute_set (columns_string) then
				columns := retrieve_integer_setting (columns_string)
			else
				columns := "1"
			end
			if attribute_set (rows_string) then
				rows := retrieve_integer_setting (rows_string)
			else
				rows := "1"
			end
			
			Result.extend (info.name + ".resize (" + columns + ", " + rows + ")")
			
			if attribute_set (row_spacing_string) then
				Result.extend (info.name + ".set_row_spacing (" +  retrieve_integer_setting (row_spacing_string) + ")")
			end
			
			if attribute_set (column_spacing_string) then
				Result.extend (info.name + ".set_column_spacing (" + retrieve_integer_setting (column_spacing_string) + ")")
			end
			
			if attribute_set (border_width_string) then
				Result.extend (info.name + ".set_border_width (" + retrieve_integer_setting (border_width_string) + ")")
			end

			element_info := full_information @ (column_positions_string)
			if element_info /= Void then
				temp_column_positions_string := element_info.data
			end
			element_info := full_information @ (row_positions_string)
			if element_info /= Void then
				temp_row_positions_string := element_info.data
			end
			element_info := full_information @ (column_spans_string)
			if element_info /= Void then
				temp_column_spans_string := element_info.data
			end
			element_info := full_information @ (row_spans_string)
			if element_info /= Void then
				temp_row_spans_string := element_info.data
			end
			if temp_column_positions_string /= Void then
				check
					strings_equal_in_length: temp_column_positions_string.count = temp_row_positions_string.count and
						temp_column_positions_string.count = temp_row_spans_string.count and
						temp_column_positions_string.count = temp_column_spans_string.count
					strings_divisible_by_4: temp_column_positions_string.count \\ 4 = 0
						-- Cannot check this, as `Current' will have been built especially
						-- for code generation purposes, and `objects' will be empty,
						-- hence `first' will be Void.
					--strings_correct_length: temp_x_position_string.count // 4 = first.count			
				end
			end
			children_names := info.child_names
			if not children_names.is_empty then
				Result.extend ("%T-- Insert and position all children of `" + info.name + "'.")
				from
					counter := 1
				until
					counter = temp_column_positions_string.count // 4 + 1
				loop
					lower := (counter - 1) * 4 + 1
					upper := (counter - 1) * 4 + 4
					current_child_name := children_names @ counter
					column_position := temp_column_positions_string.substring (lower, upper)
					row_position := temp_row_positions_string.substring (lower, upper)
					column_span := temp_column_spans_string.substring (lower, upper)
					row_span := temp_row_spans_string.substring (lower, upper)
						-- Now remove all leading 0's from strings.
						-- 0's were added for storage in XML.
					column_position.prune_all_leading ('0')
					row_position.prune_all_leading ('0')
					column_span.prune_all_leading ('0')
					row_span.prune_all_leading ('0')
					Result.extend (info.name + ".put_at_position (" + current_child_name + ", " + column_position + ", " +
						row_position + ", " + column_span + ", " + row_span + ")")
					counter := counter + 1
				end			
			end
		end
		
feature {GB_DEFERRED_BUILDER} -- Status setting

	modify_from_xml_after_build (element: XM_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			element_info: ELEMENT_INFORMATION
			temp_column_positions_string, temp_row_positions_string,
			temp_column_spans_string, temp_row_spans_string: STRING
			extracted_column, extracted_row, extracted_column_span, extracted_row_span: STRING
			first_items, second_items: ARRAYED_LIST [EV_WIDGET]
			temp_item_list: LINEAR [EV_WIDGET]
			lower, upper: INTEGER
		do
				-- Only perfrom subsequent processing of children
				-- if there is one or more children.
			if first.count > 0 then
				
				full_information := get_unique_full_info (element)

				element_info := full_information @ (column_positions_string)
				if element_info /= Void then
					temp_column_positions_string := element_info.data				
				end
				
				element_info := full_information @ (row_positions_string)
				if element_info /= Void then
					temp_row_positions_string := element_info.data				
				end
				
				element_info := full_information @ (column_spans_string)
				if element_info /= Void then
					temp_column_spans_string := element_info.data				
				end
				
				element_info := full_information @ (row_spans_string)
				if element_info /= Void then
					temp_row_spans_string := element_info.data			
				end
	
				check
					strings_equal_in_length: temp_column_positions_string.count = temp_row_positions_string.count and
						temp_column_positions_string.count = temp_row_spans_string.count and
						temp_column_positions_string.count = temp_column_spans_string.count
					strings_divisible_by_4: temp_column_positions_string.count \\ 4 = 0
					strings_correct_length: temp_column_positions_string.count // 4 = first.count
				end
				
					-- We must now remove all the widgets contained in the tables.
					-- We store them, so they can be replaced, in the correct positions.
					-- It is not possible to move them, as any existing widgets that have not yet been
					-- moved to their correct positions may block the desired positions of the current
					-- widgets.
					-- Julian.
					-- Note that we cannot use `item_list' as this returns the items in the wroing order.
					-- In Build, we move down, then across. We used `item_list' previously, but offset of
					-- all widgets was messaed up after loading.
				temp_item_list := first.linear_representation
				create first_items.make (first.count)
				create second_items.make (first.count)
				from
					temp_item_list.start
				until
					temp_item_list.off
				loop
					first_items.extend (temp_item_list.item)
					first.prune (temp_item_list.item)
				end
				temp_item_list := (objects @ 2).linear_representation
				from
					temp_item_list.start
				until
					temp_item_list.off
				loop
					second_items.extend (temp_item_list.item)
					(objects @ 2).prune (temp_item_list.item)
				end
				
				from
					first_items.start
				until
					first_items.off
				loop
						-- We now read all information from the strings retrieved form the XML.
					lower := (first_items.index - 1) * 4 + 1
					upper := (first_items.index - 1) * 4 + 4
					extracted_column := temp_column_positions_string.substring (lower, upper)
					check
						value_is_integer: extracted_column.is_integer
					end
					extracted_row := temp_row_positions_string.substring (lower, upper)
					check
						value_is_integer: extracted_row.is_integer
					end
					extracted_column_span := temp_column_spans_string.substring (lower, upper)
					check
						value_is_integer: extracted_column_span.is_integer
					end
					extracted_row_span := temp_row_spans_string.substring (lower, upper)
					check
						value_is_integer: extracted_row_span.is_integer
					end
					first.put_at_position (first_items.item, extracted_column.to_integer, extracted_row.to_integer, extracted_column_span.to_integer, extracted_row_span.to_integer)
					(objects @ 2).put_at_position (second_items @ first_items.index, extracted_column.to_integer, extracted_row.to_integer, extracted_column_span.to_integer, extracted_row_span.to_integer)
					
					first_items.forth
				end
			end
		end

end -- class GB_EV_TABLE
