indexing
	description: "Objects that store the write an XML representation of%
		%the window that has been built."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_XML_STORE
	
inherit

	TOE_TREE_FACTORY
	
	GB_XML_UTILITIES
	
	GB_ACCESSIBLE
	
	INTERNAL
	
	GB_CONSTANTS
	
	GB_NAMING_UTILITIES
	
feature -- Basic operation

	store is
			-- Store `display_window' and contents in XML format in file `filename'.
		local
			formater: XML_FORMATER
		do
				-- Generate an XML representation of the system in `document'.
			generate_document (False)
			create formater.make
				-- Process the document ready for output
			formater.process_document (document)
				-- Save our XML ouput to disk in `filename'.
			write_file_to_disk (formater.last_string.to_utf8)
		end
		
feature {NONE} -- Basic operation.
	
	write_file_to_disk (xml_text: STRING) is
			-- Create a file named `filename' with content `xml_text'.
		local
			file: RAW_FILE
		do
			create file.make_open_write (filename)
			file.start
			file.putstring (xml_format)
			file.put_string (xml_text)
			file.close
		end
		
feature {GB_XML_HANDLER} -- Implementation

	add_new_object_to_output (an_object: GB_OBJECT; element: XML_ELEMENT; add_names: BOOLEAN) is
			-- Add XML representation of `an_object' to `element'.
		local
			gb_cell_object: GB_CELL_OBJECT
			gb_container_object: GB_CONTAINER_OBJECT
			layout_item, current_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			new_widget_element: XML_ELEMENT
		do
			output_attributes (an_object, element, add_names)
				-- If `object' is a primitive then there are no children, so we do nothing.
				-- When we support items, we will need to alter this.
			if not is_instance_of (an_object, dynamic_type_from_string (gb_primitive_object_class_name)) then
				gb_cell_object ?= an_object
				if gb_cell_object /= Void then
					if not gb_cell_object.layout_item.is_empty then
						layout_item ?= gb_cell_object.layout_item.first
						new_widget_element := create_widget_instance (element, layout_item.object.type)
						element.force_last (new_widget_element)
						add_new_object_to_output (layout_item.object, new_widget_element, add_names)
					end
				end
				gb_container_object ?= an_object
				if gb_container_object /= Void then
					layout_item := gb_container_object.layout_item
					if not layout_item.is_empty then
						from
							layout_item.start	
						until
							layout_item.off
						loop
							current_layout_item ?= layout_item.item
							new_widget_element := create_widget_instance (element, current_layout_item.object.type)
							element.force_last (new_widget_element)
							add_new_object_to_output (current_layout_item.object, new_widget_element, add_names)
							layout_item.forth
						end
					end
				end
			end
		end
		
		
	output_attributes (an_object: GB_OBJECT; element: XML_ELEMENT; add_names: BOOLEAN) is
			--
		local
			handler: GB_EV_HANDLER
			supported_types: ARRAYED_LIST [STRING]
			current_type: STRING
			gb_ev_any: GB_EV_ANY
			new_type_element: XML_ELEMENT
			vision2_type: STRING
			new_name: STRING
		do
			create handler
				-- We must store the name and other attributes
				-- which are used internallly. These are not in the
				-- interface of Vision2
			if an_object.xml_storage_required then
				new_type_element := new_child_element (element, Internal_properties_string, "")
				element.force_last (new_type_element)	
				an_object.generate_xml (new_type_element)
				-- Generate a name if `add_names'.
			elseif add_names then
				new_type_element := new_child_element (element, Internal_properties_string, "")
				element.force_last (new_type_element)
				new_name := unique_name (generated_names, an_object.short_type)
				generated_names.force (new_name)
				add_element_containing_string (new_type_element, name_string, new_name)--generate_new_name (an_object.short_type))
			end
			
				-- Now store all attributes from interface of Vision2.
			supported_types := clone (handler.supported_types)
			from
				supported_types.start
			until
				supported_types.off
			loop
				current_type := supported_types.item
				current_type.to_upper
				vision2_type := current_type.substring (4, current_type.count)
				if is_instance_of (an_object.object, dynamic_type_from_string (vision2_type)) then
					gb_ev_any ?= new_instance_of (dynamic_type_from_string (current_type))
					gb_ev_any.default_create
					check
						gb_ev_any_exists: gb_ev_any /= Void
					end
					
					gb_ev_any.add_object (an_object.object)
						new_type_element := new_child_element (element, vision2_type, "")
						element.force_last (new_type_element)	
						gb_ev_any.generate_xml (new_type_element)
				end
				supported_types.forth
			end
		end
		
feature {GB_CODE_GENERATOR} -- Implementation
		
	generate_document (add_names: BOOLEAN) is
			-- Generate an XML representation of the
			-- current system in `document'.
			-- If `add_names' then generate a name
			-- automatically and insert for any object
			-- that was not named by the user.
		local
			application_element: XML_ELEMENT
			toe_document: TOE_DOCUMENT
			window_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			window_element: XML_ELEMENT
		do
				-- If we are adding names, then we must ensure that the list of
				-- names is empty when we being generating.
			if add_names then
				generated_names.wipe_out
			end
			application_element := new_root_element ("application", "")
			add_attribute_to_element (application_element, "xsi", "xmlns", "http://www.w3.org/1999/XMLSchema-instance")	
			
			create toe_document.make
			create document.make_from_imp (toe_document)
			document.start
				-- Add `application_element' as the root element of `document'.
			document.force_first (application_element)
			

			window_item ?= layout_constructor.first
			check
				window_item /= Void
			end
			
				-- We explicitly add the titled window. When we support more than
				-- one window, then this will need to be updated.
			window_element := create_widget_instance (application_element, Ev_titled_window_string)
			application_element.force_last (window_element)
			add_new_object_to_output (window_item.object, window_element, add_names)		
		end
		
	document: XML_DOCUMENT
		-- Result of last call to `generate_document'.
		-- XML document generated from created window.

feature {NONE} -- Implementation
			
	generated_names: ARRAYED_LIST [STRING] is
			-- All names generated automatically.
		once
			create Result.make (0)
		end

end -- class GB_XML_STORE
