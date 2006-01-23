indexing
	description: "Objects that provide useful utilities for XML."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_XML_UTILITIES

inherit
	
	ANY
	
	GB_CONSTANTS
		export
			{NONE} all
		end
		
	BASIC_ROUTINES

feature -- Access

	new_child_element (a_parent: XM_COMPOSITE; a_name, a_ns_prefix: STRING): XM_ELEMENT is
			-- `Result' is a new child element with name `a_name' and ns_prexif `a_ns_prefix'.
		require
			parent_not_void: a_parent /= Void
			name_not_void: a_name /= Void
		do
			create Result.make (a_parent, a_name, create {XM_NAMESPACE}.make (a_ns_prefix, ""))
		ensure
			Result_not_void: Result /= Void
		end

	add_attribute_to_element (element: XM_ELEMENT; a_name, a_prefix, a_value: STRING) is
			-- Add an atribute with name `a_name', prefix `a_prefix' and value `a_value' to `element'.
		require
			element_not_void: element /= Void
			a_name_not_void: a_name /= Void
			a_prefix_not_void: a_prefix /= Void
			a_value_not_void: a_value /= Void
		local
			attribute: XM_ATTRIBUTE
		do
			create attribute.make (a_name, create {XM_NAMESPACE}.make_default, a_value, element)
			element.force_last (attribute)
		end
	
	add_element_containing_integer (element: XM_ELEMENT; element_name: STRING; value: INTEGER) is
			-- Add an element named `element' containing integer data `value' to `element'.
		require
			element_not_void: element /= Void
			element_name_not_void: element_name /= Void
			element_name_not_empty: element_name.count >= 1
		local
			new_element: XM_ELEMENT
		do
			new_element := new_child_element (element, element_name, "")
			element.force_last (new_element)
			add_string_data (new_element, value.out)
		end
		
	add_element_containing_integer_constant (element: XM_ELEMENT; element_name: STRING; constant: STRING) is
			-- 	Add an element named `element' marked `constant', containing another element named `element_name' with
			-- constant named `constant'. This is the format used to store integer constants.
		require
			element_not_void: element /= Void
			element_name_not_void: element_name /= Void
			element_name_not_empty: element_name.count >= 1
		local
			new_element, new_constant_element: XM_ELEMENT
		do
			new_constant_element := new_child_element (element, element_name, "")
			element.force_last (new_constant_element)
			new_element := new_child_element (new_constant_element, Constant_string, "")
			new_constant_element.force_last (new_element)
			add_string_data (new_element, constant)
		end

	add_element_containing_string (element: XM_ELEMENT; element_name, value: STRING) is
			-- Add an element named `element' containing string data `value' to `element'.
		require
			element_not_void: element /= Void
			element_name_not_void: element_name /= Void
			element_name_not_empty: element_name.count >= 1
			value_not_void: value /= Void
		local
			new_element: XM_ELEMENT
		do
			new_element := new_child_element (element, element_name, "")
			element.force_last (new_element)
			add_string_data (new_element, value)
		end

	add_element_containing_boolean (element: XM_ELEMENT; element_name: STRING; value: BOOLEAN) is
			-- Add an element named `element' containing boolean data `value' to `element'.
		require
			element_not_void: element /= Void
			element_name_not_void: element_name /= Void
			element_name_not_empty: element_name.count >= 1
		local
			new_element: XM_ELEMENT
		do
			new_element := new_child_element (element, element_name, "")
			element.force_last (new_element)
			add_boolean_data (new_element, value)
		end

	add_boolean_data (element: XM_ELEMENT; content: BOOLEAN) is
			-- Add boolean character data with content `content' to `element'
		require
			element_not_void: element /= Void
		local
			string_data: STRING
		do
			if content then
				string_data := True_string
			else
				string_data := False_string
			end
			add_string_data (element, string_data)
		end

	add_string_data (element: XM_ELEMENT; content: STRING) is
			-- Add string character data with content `content' to `element'
		require
			element_not_void: element /= Void
			content_not_void: content /= Void
		local	
			new_element: XM_CHARACTER_DATA
		do
			create new_element.make (element, content)
			element.force_last (new_element)
		end

	create_widget_instance (element: XM_ELEMENT; widget_name: STRING): XM_ELEMENT is
			-- Create a new instance of a widget `widget_name' in `element'.
		require
			element_not_void: element /= Void
			widget_name_not_void: widget_name /= Void
			widget_name_not_empty: widget_name.count >= 1
		do
			Result := new_child_element (element, Item_string, "")
			
			add_attribute_to_element (Result, "type", "xsi", widget_name)
		ensure
			Result_not_void: Result /= Void
		end
		
	get_unique_full_info (element: XM_ELEMENT): HASH_TABLE [ELEMENT_INFORMATION, STRING] is
			-- `Result' provides access to all child_elements and XML character
			-- data of `Current' referenced by their unique names.
			-- Ignores `item'.
		require
			element_not_void: element /= Void
		local
			current_element, inner_element: XM_ELEMENT
			current_data_element: XM_CHARACTER_DATA
			char_data: STRING
			info: ELEMENT_INFORMATION
		do
			create Result.make (8)
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					if not current_element.name.is_equal (Item_string) and
						not current_element.name.is_equal ("item_text") then
						create info
						info.set_name (current_element.name)
						info.set_element (current_element)
						from
							current_element.start
						until
							current_element.off
						loop
							inner_element ?= current_element.item_for_iteration
							if inner_element /= Void  then
								if inner_element.name.is_equal (Constant_string) then
									from
										inner_element.start
									until
										inner_element.off
									loop
										current_data_element ?= inner_element.item_for_iteration
										if current_data_element /= Void then
											char_data := current_data_element.content
											if data_valid (char_data) then
												info.set_data (char_data)
												info.set_as_constant
											end
										end
										inner_element.forth
									end
								end
							end
							if not info.is_constant then
								current_data_element ?= current_element.item_for_iteration
								if current_data_element /= Void then
									char_data := current_data_element.content
									if data_valid (char_data) then
										info.set_data (char_data)
									end
								end
							end
							current_element.forth
						end
					Result.put (info, info.name)
					end
				end
				element.forth
			end
		ensure
			result_not_void: Result /= Void
		end
		
	all_child_element_names (element: XM_ELEMENT): ARRAYED_LIST [STRING] is
			-- `Result' is a list of all names of the child elements of `element'
		require
			element_not_void: element /= Void
		local
			current_element: XM_ELEMENT
		do
			create Result.make (0)
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					Result.extend (current_element.name)
				end
				element.forth
			end
		end
		
	child_element_by_name (element: XM_ELEMENT; a_name: STRING): XM_ELEMENT is
			-- `Result' is child element of `element' with name equal to `a_name'.
		require
			element_not_void: element /= Void
			name_not_void_or_empty: a_name /= Void and then a_name.count > 0 
		local
			current_element: XM_ELEMENT
			found: BOOLEAN
			index: INTEGER
		do
			index := element.index
			from
				element.start
			until
				element.off or found
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void and then current_element.name.is_equal (a_name) then
					found := True
					Result := current_element
				end
				element.forth
			end
			element.go_i_th (index)
		ensure
			cursor_not_moved: old element.index = element.index
		end
		
	string_from_xm_document (a_document: XM_DOCUMENT): STRING is
			-- Return a string representation of XM document `a_document'.
		require
			a_document_not_void: a_document /= Void
		local
			pretty_print: XM_INDENT_PRETTY_PRINT_FILTER
			xmlns_generator: XM_XMLNS_GENERATOR
			output_stream: KL_STRING_OUTPUT_STREAM
		do
			create output_stream.make ("")
			create pretty_print.make_null
			pretty_print.set_output_stream (output_stream)
			create xmlns_generator.set_next (pretty_print)
			a_document.process_to_events (xmlns_generator)
			Result := output_stream.string
		ensure	
			result_not_void: Result /= Void
		end		
		
	add_tabs (a_string: STRING; index, count: INTEGER) is
			-- Add `count' tab characters to `a_string' at index `index'.
		local
			counter: INTEGER
			temp_string: STRING
		do
			create temp_string.make (0)
			from
				counter := 1
			until
				counter > count
			loop
				temp_string.append ("%T")
				counter := counter + 1
			end
			a_string.append (temp_string)--insert_string (temp_string, index)
		ensure
			new_count_correct: a_string.count = old a_string.count + count
		end
		
	show_element (element: XM_ELEMENT; window: EV_TITLED_WINDOW) is
			-- Show contents of `element' in a dialog displayed modally to `window'.
		require
			element_not_void: element /= Void
			window_not_void: window /= Void
			window_displayed: window.is_displayed
		local
			dialog: EV_DIALOG
			vertical_box: EV_VERTICAL_BOX
			text: EV_TEXT
			cancel_button: EV_BUTTON
			namespace: XM_NAMESPACE
			document: XM_DOCUMENT
			l_string: STRING
		do		
			create namespace.make_default
			create document.make
				-- If we do not twin the element, the parent is changed which
				-- is a side effect that we do not wish.
			document.set_root_element (element.deep_twin)
			l_string := string_from_xm_document (document)
			
			create dialog
			dialog.set_minimum_size (400, 600)
			create vertical_box
			dialog.extend (vertical_box)
			create text
			vertical_box.extend (text)
			create cancel_button.make_with_text ("Cancel")
			vertical_box.extend (cancel_button)
			vertical_box.disable_item_expand (cancel_button)
			cancel_button.select_actions.extend (agent dialog.destroy)
			dialog.set_default_cancel_button (cancel_button)
			text.set_text (l_string)
			dialog.show_modal_to_window (window)
		end
		
	remove_nodes_recursive (element: XM_ELEMENT; node_name: STRING) is
			-- Recursively remove all nodes named `node_name' from `element'.
		require
			element_not_void: element /= Void
			node_name_not_void: node_name /= Void
		local
			current_element: XM_ELEMENT
			current_name: STRING
		do
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.is_equal (node_name) then
						element.remove_at
					else
						remove_nodes_recursive (current_element, node_name)
					end
				end
				element.forth
			end
		end
		
	all_elements_by_name (element: XM_ELEMENT; node_name: STRING): ARRAYED_LIST [XM_ELEMENT] is
			-- Recursively remove all nodes named `node_name' from `element'.
		require
			element_not_void: element /= Void
			node_name_not_void: node_name /= Void
		do
			create Result.make (10)
			all_elements_by_name_internal (element, node_name, Result)
		end
		
	all_elements_by_name_internal (element: XM_ELEMENT; node_name: STRING; elements: ARRAYED_LIST [XM_ELEMENT]) is
			-- Recursively remove all nodes named `node_name' from `element'.
		require
			element_not_void: element /= Void
			node_name_not_void: node_name /= Void
			elements_not_void: elements /= Void
		local
			current_element: XM_ELEMENT
			current_name: STRING
		do
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.is_equal (node_name) then
						elements.extend (current_element)
					end
					all_elements_by_name_internal (current_element, node_name, elements)
				end
				element.forth
			end
		end
		
feature {NONE} -- Implementation

	data_valid (current_data: STRING):BOOLEAN is
			-- Is `current_data' not empty and valid?
		require
			data_not_void: current_data /= Void
		do
			if current_data.count > 0 then
				Result := True
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class XML_UTILITIES
