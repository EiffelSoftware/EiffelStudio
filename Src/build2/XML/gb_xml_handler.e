indexing
	description: "Objects that manipulate XML for saving/loading and possibly other%
		%internal uses."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_XML_HANDLER

inherit
	
	INTERNAL
	
	GB_CONSTANTS
	
	GB_XML_UTILITIES
	
	TOE_TREE_FACTORY
	
	GB_SHARED_TOOLS
		
feature -- Basic operations

	save is
			-- Save the currently built window to XML.
		local
			xml_store: GB_XML_STORE
		do
			create xml_store
			xml_store.store
		end
		
	load is
			-- Retrieve the current built window from XML
		local
			xml_load: GB_XML_LOAD
		do
			create xml_load
			xml_load.load
		end
		
	load_components is
			-- Load previously stored components in `component_document',
			-- or create `component_document' if no component file exists.
		require
			component_doc_void: component_document = Void
		local
			file: RAW_FILE
			an_element, component_element: XML_ELEMENT
			toe_document: TOE_DOCUMENT
			buffer: STRING
			parser: XML_TREE_PARSER
		do
			create file.make (component_filename)
			if file.exists then
					-- Load the existing file into `component document'
				parser := create_tree_parser
				file.make_open_read (component_filename)
				create buffer.make (file.count)
				file.start
				file.read_stream (file.count)
				buffer := file.last_string
				parser.parse_from_string (buffer)
				parser.set_end_of_document
				component_document := parser.document
				an_element ?= component_document.first
				component_element ?= an_element.first
				
				component_selector.add_components (all_child_element_names (an_element))
			else
					-- Create `component_document'.
				component_element := new_root_element ("components", "")
				add_attribute_to_element (component_element, "xsi", "xmlns", "http://www.w3.org/1999/XMLSchema-instance")
				create toe_document.make
				create component_document.make_from_imp (toe_document)
				component_document.start
				component_document.force_first (component_element)
			end
		ensure
			component_doc_not_void: component_document /= Void
		end

	add_new_component (an_object: GB_OBJECT; component_name: STRING) is
			-- Add a new component based on `an_object', named `component_name'
			-- to `component_document'.
		require
			object_not_void: an_object /= Void
			name_ok: component_name /= Void and not component_name.is_empty
		local
			xml_store: GB_XML_STORE
			first_element: XML_ELEMENT
			component_element: XML_ELEMENT
			new_element: XML_ELEMENT
		do
			create xml_store
			first_element ?= component_document.first
			component_element := new_child_element (first_element, component_name, "Component")
			first_element.force_last (component_element)
			new_element := create_widget_instance (component_element, an_object.type)
			component_element.force_last (new_element)
			xml_store.add_new_object_to_output (an_object, new_element, False)
		end

	save_components is
			-- Store `component_document' into file
			-- `component_filename'.
		require
			component_doc_not_void: component_document /= Void
		local
			formater: XML_FORMATER
			file: RAW_FILE
		do
			create formater.make
			formater.process_document (component_document)
			create file.make_open_write (component_filename)
			file.start
			file.putstring (xml_format)
			file.putstring (formater.last_string.to_utf8)
			file.close
		end
		
	remove_component (component_name: STRING) is
			-- Removed component named `name' from `component_document'.
		require
			vaid_component_name: component_name /= Void and not component_name.is_empty
		local
			an_element: XML_ELEMENT
			element_to_remove: XML_ELEMENT
		do
			an_element ?= component_document.first
			element_to_remove := child_element_by_name (an_element, component_name)
			an_element.delete (element_to_remove)
		end
		
		
feature {GB_COMPONENT_SELECTOR_ITEM, GB_COMPONENT, GB_OBJECT} -- Implementation

	xml_element_representing_named_component (a_name: STRING): XML_ELEMENT is
			-- `Result' is the element representing component `a_name' in
			-- `component_document'.
		local
			an_element: XML_ELEMENT
		do
			an_element ?= component_document.first
			Result := child_element_by_name (an_element, a_name)
		ensure
			result_not_void: Result /= Void
		end
		
	component_root_element_type (a_name: STRING): STRING is
			-- `Result' is the type of object representing the root element
			-- of the component. i.e. "EV_BUTTON".
		local
			an_element: XML_ELEMENT
			component_element: XML_ELEMENT
			internal_element: XML_ELEMENT
			current_name: STRING
		do
			an_element ?= component_document.first
			component_element := child_element_by_name (an_element, a_name)
			from
				component_element.start
			until
				component_element.off or Result /= Void
			loop
				internal_element ?= component_element.item_for_iteration
				current_name := internal_element.name.to_utf8
				if current_name.is_equal (Item_string) then
					Result := internal_element.attribute_by_name (type_string).value.to_utf8
				end
				component_element.forth
			end
		ensure
			Result_not_void: Result /= Void
		end
		
		
feature {NONE} -- Implementation

	component_document: XML_DOCUMENT
		-- Document which contains representations of all components
		-- that have been defined by the user.

end -- class GB_XML_HANDLER
