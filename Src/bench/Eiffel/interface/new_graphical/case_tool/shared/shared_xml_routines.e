indexing
	description: "[
			Common shared routines for XML extraction, saving and deserialization
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_XML_ROUTINES

inherit
	XM_CALLBACKS_FILTER_FACTORY
		export {NONE} all end

feature {NONE} -- Implementation

	Xml_routines: XML_ROUTINES is
			-- Access the common xml routines.
		once
			create Result.default_create
		ensure
			non_void_Xml_routines: Xml_routines /= Void
		end

feature {NONE} -- Redirection

	deserialize_document (a_file_path: STRING): XM_DOCUMENT is
			-- Redirection
		require
			valid_file_path: a_file_path /= Void and then not a_file_path.is_empty
		do
			Result := Xml_routines.deserialize_document (a_file_path)
		end
		
	save_xml_document (ptf: FILE; a_doc: XM_DOCUMENT) is
			-- Redirection
		do
			Xml_routines.save_xml_document (ptf, a_doc)
		end

	valid_tags: INTEGER is
			-- Redirection
		do
			Result := Xml_routines.valid_tags
		end

	reset_valid_tags is
			-- Redirection
		do
			Xml_routines.reset_valid_tags
		end

	xml_integer (elem: XM_ELEMENT; a_name: STRING): INTEGER is
			-- Redirection
		require
			non_void_element: elem /= Void
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			Result := Xml_routines.xml_integer (elem, a_name)
		end

	xml_boolean (elem: XM_ELEMENT; a_name: STRING): BOOLEAN is
			-- Redirection
		require
			non_void_element: elem /= Void
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			Result := Xml_routines.xml_boolean (elem, a_name)
		end

	xml_double (elem: XM_ELEMENT; a_name: STRING): DOUBLE is
			-- Redirection
		require
			non_void_element: elem /= Void
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			Result := Xml_routines.xml_double (elem, a_name)
		end

	xml_string (elem: XM_ELEMENT; a_name: STRING): STRING is
			-- Redirection
		require
			non_void_element: elem /= Void
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			Result := Xml_routines.xml_string (elem, a_name)
		end

	xml_color (elem: XM_ELEMENT; a_name: STRING): EV_COLOR is
			-- Redirection
		require
			non_void_element: elem /= Void
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			Result := Xml_routines.xml_color (elem, a_name)
		end

	element_by_name (elem: XM_ELEMENT; a_name: STRING): XM_ELEMENT is
			-- Redirection
		require
			non_void_element: elem /= Void
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			Result := Xml_routines.element_by_name (elem, a_name)
		end

	xml_node (a_parent: XM_ELEMENT; tag_name, content: STRING): XM_ELEMENT is
			-- Redirection
		require
			non_void_parent: a_parent /= Void
			valid_tag_name: tag_name /= Void and then not tag_name.is_empty
			valid_tag_name: content /= Void and then not content.is_empty
		do
			Result := Xml_routines.xml_node (a_parent, tag_name, content)
		end

	add_attribute (a_name: STRING; a_ns: XM_NAMESPACE; a_value: STRING; a_parent: XM_ELEMENT) is
			-- Redirection
		require
			a_name_not_void: a_name /= void
			a_name_not_empty: a_name.count > 0
			a_value_not_void: a_value /= void
			a_parent_not_void: a_parent /= Void
		do
			Xml_routines.add_attribute (a_name, a_ns, a_value, a_parent)
		end

	display_warning_message (a_warning_msg: STRING) is
			-- Redirection.
		require
			valid_error_message: a_warning_msg /= Void and then not a_warning_msg.is_empty
		do
			Xml_routines.display_warning_message (a_warning_msg)
		end

	display_error_message (an_error_msg: STRING) is
			-- Redirection.
		require
			valid_error_message: an_error_msg /= Void and then not an_error_msg.is_empty
		do
			Xml_routines.display_error_message (an_error_msg)
		end

end -- Class SHARED_XML_ROUTINES