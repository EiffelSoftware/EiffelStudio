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

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			temp_column_positions_string, temp_row_positions_string,
			temp_widths_string, temp_heights_string: STRING
			an_object: GB_OBJECT
			layout_item, current_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			current_table_widget: EV_WIDGET
		do			
			if first.columns /= 1 then
				add_element_containing_integer (element, columns_string, first.columns)	
			end
			if first.rows /= 1 then
				add_element_containing_integer (element, rows_string, first.rows)	
			end
			if first.column_spacing /= 0 then
				add_element_containing_integer (element, column_spacing_string, first.column_spacing)
			end
			if first.row_spacing /= 0 then
				add_element_containing_integer (element, row_spacing_string, first.row_spacing)
			end
			
			if first.border_width /= 0 then
				add_element_containing_integer (element, border_width_string, first.border_width)
			end

			an_object := object_handler.object_from_display_widget (first)
			layout_item := an_object.layout_item
			
			temp_column_positions_string := ""
			temp_row_positions_string := ""
			temp_widths_string := ""
			temp_heights_string := ""
			from
				layout_item.start
			until
				layout_item.off
			loop
				current_layout_item ?= layout_item.item
				current_table_widget ?= current_layout_item.object.object
				temp_column_positions_string := temp_column_positions_string + add_leading_zeros (first.item_column_position (current_table_widget).out)--item_list.item).out)
				temp_row_positions_string := temp_row_positions_string + add_leading_zeros (first.item_row_position (current_table_widget).out)
				temp_widths_string := temp_widths_string + add_leading_zeros (first.item_column_span (current_table_widget).out)
				temp_heights_string := temp_heights_string + add_leading_zeros (first.item_row_span (current_table_widget).out)
				layout_item.forth
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
		
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			
			element_info := full_information @ (Columns_string)
			if element_info /= Void then
				for_all_objects (agent {EV_TABLE}.resize (element_info.data.to_integer, first.rows))
			end
			element_info := full_information @ (Rows_string)
			if element_info /= Void then
				for_all_objects (agent {EV_TABLE}.resize (first.columns, element_info.data.to_integer))
			end
			element_info := full_information @ (Column_spacing_string)
			if element_info /= Void then
				for_all_objects (agent {EV_TABLE}.set_column_spacing (element_info.data.to_integer))
			end
			element_info := full_information @ (Row_spacing_string)
			if element_info /= Void then
				for_all_objects (agent {EV_TABLE}.set_row_spacing (element_info.data.to_integer))
			end
			element_info := full_information @ (Border_width_string)
			if element_info /= Void then
				for_all_objects (agent {EV_TABLE}.set_border_width (element_info.data.to_integer))
			end			
				-- All the building for an EV_FIXED needs to be deferred so
				-- we set up some deferred building now.
			deferred_builder.defer_building (Current, element)
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
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

			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (columns_string)
			if element_info /= Void then
				columns := element_info.data
			else
				columns := "1"
			end
			element_info := full_information @ (rows_string)
			if element_info /= Void then
				rows := element_info.data
			else
				rows := "1"
			end
			
			Result := info.name + ".resize (" + columns + ", " + rows + ")"
			
			element_info := full_information @ (row_spacing_string)
			if element_info /= Void then
				Result := Result + indent + info.name + ".set_row_spacing (" + element_info.data + ")"
			end
			
			element_info := full_information @ (column_spacing_string)
			if element_info /= Void then
				Result := Result + indent + info.name + ".set_column_spacing (" + element_info.data + ")"
			end
			
			element_info := full_information @ (border_width_string)
			if element_info /= Void then
				Result := Result + indent + info.name + ".set_border_width (" + element_info.data + ")"
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
				Result := Result + indent + "%T-- Insert and position all children of `" + info.name + "'."
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
					Result := Result + indent + info.name + ".put_at_position (" + current_child_name + ", " + column_position + ", " +
						row_position + ", " + column_span + ", " + row_span + ")"			
					counter := counter + 1
				end			
			end
			Result := strip_leading_indent (Result)
		end
		
feature {GB_DEFERRED_BUILDER} -- Status setting

	modify_from_xml_after_build (element: XML_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			temp_column_positions_string, temp_row_positions_string,
			temp_column_spans_string, temp_row_spans_string: STRING
			extracted_column, extracted_row, extracted_column_span, extracted_row_span: STRING
			first_items, second_items, temp_item_list: ARRAYED_LIST [EV_WIDGET]
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
				first_items := table_items (first)
				second_items := table_items (objects @ 2)
				temp_item_list := table_items (first)
				from
					temp_item_list.start
				until
					temp_item_list.off
				loop
					first.prune (temp_item_list.item)
					temp_item_list.forth
				end
				temp_item_list := (objects @ 2).item_list
				from
					temp_item_list.start
				until
					temp_item_list.off
				loop
					(objects @ 2).prune (temp_item_list.item)
					temp_item_list.forth
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
