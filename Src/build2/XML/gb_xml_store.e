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
	
	XML_UTILITIES
	
	GB_ACCESSIBLE
	
	INTERNAL
	
	GB_CONSTANTS
	
feature -- Basic operation

	store is
			-- Store `display_window' and contents in XML format in file `filename'.
		local
			application_element: XML_ELEMENT
			toe_document: TOE_DOCUMENT
			formater: XML_FORMATER
			window_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			window_element: XML_ELEMENT
		do
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
			window_element := create_widget_instance (application_element, "EV_TITLED_WINDOW")
			application_element.force_last (window_element)
			--output_attributes (window_item.object, window_element)
			add_new_object_to_output (window_item.object, window_element)
			
			
			create formater.make
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
		
		
feature {NONE} -- Implementation

	add_new_object_to_output (an_object: GB_OBJECT; element: XML_ELEMENT) is
			-- Add XML representation of `an_object' to `element'.
		local
			gb_cell_object: GB_CELL_OBJECT
			gb_container_object: GB_CONTAINER_OBJECT
			gb_primitive_object: GB_PRIMITIVE_OBJECT
			layout_item, current_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			new_widget_element: XML_ELEMENT
			counter: INTEGER
			new_type_element: XML_ELEMENT
		do
			output_attributes (an_object, element)
				-- If `object' is a primitive then there are no children, so we do nothing.
				-- When we support items, we will need to alter this.
			if not is_instance_of (an_object, dynamic_type_from_string (gb_primitive_object_class_name)) then
				gb_cell_object ?= an_object
				if gb_cell_object /= Void then
					if not gb_cell_object.layout_item.is_empty then
						layout_item ?= gb_cell_object.layout_item.first
						new_widget_element := create_widget_instance (element, layout_item.object.type)
						element.force_last (new_widget_element)
						add_new_object_to_output (layout_item.object, new_widget_element)
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
							add_new_object_to_output (current_layout_item.object, new_widget_element)
							layout_item.forth
						end
					end
				end
			end
		end
		
		
	output_attributes (an_object: GB_OBJECT; element: XML_ELEMENT) is
			--
		local
			handler: GB_EV_HANDLER
			supported_types: ARRAYED_LIST [STRING]
			current_type: STRING
			gb_ev_any: GB_EV_ANY
			display_object: GB_DISPLAY_OBJECT
			new_type_element: XML_ELEMENT
			vision2_type: STRING
		do
			create handler
				-- We must store the name and other attributes
				-- which are used internallly. These are not in the
				-- interface of Vision2
			if an_object.xml_storage_required then
				new_type_element := new_child_element (element, Internal_properties_string, "")
				element.force_last (new_type_element)	
				an_object.generate_xml (new_type_element)
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

feature {NONE} -- Implementation

	xml_format: STRING is "<?xml version=%"1.0%" encoding=%"UTF-8%"?>"
		-- XML format type, included at start of `document'.

	filename: STRING is "D:\work\build2\xml_output.xml"
		-- File to be generated.
		
	document: XML_DOCUMENT
		-- XML document generated from created window.


end -- class GB_XML_STORE
