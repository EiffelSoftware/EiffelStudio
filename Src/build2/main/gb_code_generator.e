indexing
	description: "Objects that generate an Eiffel class text based on the%
		%current system built by the user."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CODE_GENERATOR
	
inherit
	
	GB_CONSTANTS
	
	XML_UTILITIES
	
	GB_ACCESSIBLE_OBJECT_HANDLER
	
	INTERNAL

feature -- Basic operation

	generate (a_file_name: STRING; a_class_name: STRING) is
			-- Generate a new Eiffel class in `a_file_name',
			-- named `a_class_name'. The rest is built from the
			-- current state of the display_window.
		require
			a_file_name_ok: a_file_name /= Void and not a_file_name.is_empty
			a_class_name_ok: a_class_name /= Void and not a_class_name.is_empty
		local
			store: GB_XML_STORE
			template_file, output_file: RAW_FILE
		do
			create type_string.make_from_string ("type")
			create store
			store.generate_document (True)
			current_document := store.document
			check
				current_document_not_void: current_document/= Void
			end
			
				-- Retrieve the template for a class file to generate.
			create template_file.make_open_read (template_file_name)
			create class_text.make (template_file.count)
			template_file.start
			template_file.read_stream (template_file.count)
			class_text := template_file.last_string
			template_file.close
			
				-- We must now perform the generation into `class_text'.
				-- First replace the name of the class
			set_class_name (a_class_name)

				-- Generate the widget declarations and creation lines.
			generate_declarations (current_document.root_element, 1)
			
			
				-- Create storage for all parent child name pairs.
			create parent_child.make (0)
				-- Generate the widget building code.
			generate_structure (current_document.root_element, 1, "")
			
				-- Generate the widget setting code.
			generate_setting (current_document.root_element, 1)
			
			
			

			local_tag_index := class_text.substring_index (local_tag, 1)
			class_text.replace_substring_all (local_tag, "")			
			class_text.insert (local_string, local_tag_index)
			
			create_tag_index := class_text.substring_index (create_tag, 1)
			class_text.replace_substring_all (create_tag, "")			
			class_text.insert (create_string, create_tag_index)
			
			build_tag_index := class_text.substring_index (build_tag, 1)
			class_text.replace_substring_all (build_tag, "")			
			class_text.insert (build_string, build_tag_index)
			
			set_tag_index := class_text.substring_index (set_tag, 1)
			class_text.replace_substring_all (set_tag, "")			
			class_text.insert (set_string, set_tag_index)
			
			
			
				
				-- Store `class_text'.
			create output_file.make_open_write (a_file_name)
			output_file.start
			output_file.putstring (class_text)
			output_file.close
				
		end
		
feature {NONE} -- Implementation

	set_class_name (a_name: STRING) is
			--
		do
			a_name.to_upper
			class_text.replace_substring_all (class_name_tag, a_name)
		end

	generate_declarations (element: XML_ELEMENT; depth: INTEGER) is
			-- With information in `element', generate code which includes the
			-- attribute declarations and creation of all components in system.
		local
			current_element: XML_ELEMENT
			current_name: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			current_type: STRING
		do
			if element.has_attribute_by_name (type_string) then
				current_type := element.attribute_by_name (type_string).value.to_utf8
			end
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name.to_utf8
					if current_name.is_equal (Item_string) then
						generate_declarations (current_element, depth + 1)
					else
						if current_name.is_equal (Internal_properties_string) and depth > 2 then
								full_information := get_unique_full_info (current_element)
								element_info := full_information @ (name_string)
								add_local (current_type, element_info.data)
								create_local (element_info.data)
						else
						end
					end
				end
				element.forth
			end
		end
		
		
	generate_structure (element: XML_ELEMENT; depth: INTEGER; parent_name: STRING) is
			-- With information in `element', generate code which will
			-- parent all objects.
		local
			current_element: XML_ELEMENT
			current_name: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			current_type: STRING
			new_object : GB_OBJECT
			found_name: STRING
		do
			
				-- Retrieve the current type represented by `element'.
			if element.has_attribute_by_name (type_string) then
				current_type := element.attribute_by_name (type_string).value.to_utf8
			end
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name.to_utf8
					if current_name.is_equal (Item_string) then
						if found_name = Void then
							found_name := ""
						end
						generate_structure (current_element, depth + 1, found_name)
					else
						if current_name.is_equal (Internal_properties_string) and depth > 2 then
								full_information := get_unique_full_info (current_element)
								element_info := full_information @ (name_string)
								new_object := object_handler.build_object_from_string (current_type)
									--| FIXME we must use the extend from the parent type.
									
									-- Because at the top level we are a window, we do not need to include the
									-- windows name in the code generated. Checking the current depth tells us whether
									-- we are generating code for a window or not. i.e for the window code
									-- generated should be "extend (widget)" instead of "something.extend (widget)".
								if depth = 3 then
									add_build (new_object.extend_xml_representation (element_info.data))						
								else
									add_build (parent_name + "." + new_object.extend_xml_representation (element_info.data))
										-- Store the parent and child attribute names in `parent_child'.
									
									parent_child.extend (parent_name)
									parent_child.extend (element_info.data)
								end
								found_name := element_info.data
						else
						end
					end
				end
				element.forth
			end
		end
		
	generate_setting (element: XML_ELEMENT; depth: INTEGER) is
			-- With information in `element', generate code which will
			-- set_all_objects.
		local
			current_element: XML_ELEMENT
			current_name: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			current_type: STRING
			gb_ev_any: GB_EV_ANY
			current_iterative_name: STRING
		do
			if element.has_attribute_by_name (type_string) then
				current_type := element.attribute_by_name (type_string).value.to_utf8
			end
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name.to_utf8
					if current_name.is_equal (Item_string) then
						generate_setting (current_element, depth + 1)
					else
						if current_name.is_equal (Internal_properties_string) then
							full_information := get_unique_full_info (current_element)
							element_info := full_information @ (name_string)
							current_iterative_name := element_info.data
						else
							gb_ev_any ?= new_instance_of (dynamic_type_from_string ("GB_" + current_name))
						
								-- Call default_create on `gb_ev_any'
							gb_ev_any.default_create
						
							-- Ensure that the new class exists.
						check
							new_instance_exists: gb_ev_any /= Void
						end
							-- Add the appropriate objects to `objects'.
						if current_type.is_equal ("EV_TITLED_WINDOW") then
							add_set (gb_ev_any.generate_code (current_element, "", Void))
						else
							add_set (gb_ev_any.generate_code (current_element, current_iterative_name, child_names (current_iterative_name)))
						end
						end
					end
				end
				element.forth
			end
		end
		
		
		
		
	actual_name (element: XML_ELEMENT) is
			--
		local
			current_element: XML_ELEMENT
			current_name: STRING
		do
			element.start
			current_element ?= element.item_for_iteration
			if current_element /= Void then
				current_name := current_element.name.to_utf8
				check
					current_name.is_equal (Internal_properties_string)
				end
			end
		end
		
		
	add_local (local_type, name: STRING) is
			--
		local
			temp_string: STRING
		do
			if local_string = Void then
				local_string := ""
				temp_string := name + ": " + local_type
			else
				temp_string := indent + name + ": " + local_type
			end
			
			local_string := local_string + temp_string
		end
		
	create_local (name: STRING) is
		local
			temp_string: STRING
		do
			if create_string = Void then
				create_string := ""
				temp_string := "create " + name
			else
				temp_string := indent + "create " + name	
			end
			create_string := create_string + temp_string
		end
		
	add_build (constructor: STRING) is
		local
			temp_string: STRING
		do
			if build_string = Void then
				build_string := ""
				temp_string := constructor
			else
				temp_string := indent + constructor
			end
			build_string := build_string + temp_string
		end
		
	add_set (set: STRING) is
		local
			temp_string: STRING
			non_void_set: STRING
		do		
			non_void_set := set
			if non_void_set = Void then
				non_void_set := ""
			end
			
			-- If we are working with an EV_TITLED_WINDOW, then
			-- we may have the . at the start which is uneeded in
			-- the code. Remove it.
			if (non_void_set @ 1) = '.' then
				non_void_set := non_void_set.substring (2, non_void_set.count)
				non_void_set.replace_substring_all (indent + ".", indent)
			end
			
			
			if set_string = Void then
				set_string := ""
				temp_string := non_void_set
			else
				if not non_void_set.is_empty then
					temp_string := indent + non_void_set
				end
			end
			
			if temp_string /= Void then
				set_string := set_string + temp_string
			end
		end
		
	child_names (current_name: STRING): ARRAYED_LIST [STRING]  is
			-- `Result' is attribute names for all children of attribute `current_name'.
			-- Queried from `parent_child'.
		require
			parent_child_not_void: parent_child /= Void
			parent_child_count_even: parent_child.count > 0 implies parent_child.count \\ 2 = 0
		do
			create Result.make (0)
			from
				parent_child.start
			until
				parent_child.off
			loop
				if parent_child.item.is_equal (current_name) then
				
						parent_child.forth

						Result.extend (parent_child.item)

						parent_child.forth
				else
					parent_child.go_i_th (parent_child.index + 2)
				end
			end
		end
		
	parent_child: ARRAYED_LIST [STRING]
		-- A list of all parent attribute names and associated child names in the following format:
		-- parent, child, parent, child, parent, child.
		-- This is not the most efficient format, but can be changed as necessary.


	current_document: XML_DOCUMENT
		-- An XML document representing the current layout built
		-- by the user. We generate the class text from the information
		-- held within.
		
	class_text: STRING
		-- The current representation of the class we are generating.

		
	create_tag_index: INTEGER
	
	local_tag_index: INTEGER
	
	build_tag_index: INTEGER
	
	set_tag_index: INTEGER
	
	type_string: UCSTRING
	
	local_string: STRING
	
	create_string: STRING
	
	build_string: STRING
	
	set_string: STRING

end -- class GB_CODE_GENERATOR
