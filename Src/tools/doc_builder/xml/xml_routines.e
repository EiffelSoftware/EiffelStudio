indexing
	description: "Common XML routines."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_ROUTINES

inherit
	XM_CALLBACKS_FILTER_FACTORY
		export
			{NONE} all
		end

feature -- Access

	document_text (a_doc: XM_DOCUMENT): STRING is
			-- Full text of `a_doc', including all tags and content.
		require
			doc_not_void: a_doc /= Void
		local
			retried: BOOLEAN
			l_formatter: XM_ESCAPED_FORMATTER
		do				
			if not retried then
				create l_formatter.make
				l_formatter.process_document (a_doc)
				Result := l_formatter.last_string
			end
		rescue
			retried := True
			io.putstring ("Unable to read file.")
			retry
		end

	error_description: STRING
			-- Error string

feature -- Status Setting

	set_attribute (a_doc: XM_DOCUMENT; a_array_path: ARRAY [STRING]; a_attribute, a_value: STRING) is
			-- Set the value of the attribute found at the tag path in string sequence of 
			-- `a_array_path'.  If it does not exist then add a new attribute `a_attribute'.
		require
			doc_not_void: a_doc /= void
			non_void_path: a_array_path /= Void
			valid_path: not a_array_path.has ("")
			non_void_attribute: a_attribute /= Void
			valid_attribute: not a_attribute.is_empty
			non_void_value: a_value /= Void
		local
			cnt: INTEGER
			is_void_element: BOOLEAN
			l_element: XM_ELEMENT
			l_attribute: XM_ATTRIBUTE
		do
			a_array_path.compare_references
			if not a_array_path.has (Void) then
				l_element := a_doc.root_element
				from
					cnt := 2
				until
					cnt > a_array_path.count or is_void_element
				loop
					l_element := l_element.element_by_name (a_array_path.item (2))
					if l_element = Void then
						is_void_element := True
					end
					cnt := cnt + 1
				end
				if l_element /= Void then
					l_attribute := l_element.attribute_by_name (a_attribute)
					if l_attribute /= Void and then a_value.is_empty then
						l_attribute.parent.delete (l_attribute)
					elseif l_attribute /= Void and then not a_value.is_empty then						
						l_attribute.set_value (a_value)
					elseif l_attribute = Void and then not a_value.is_empty then						
						create l_attribute.make (a_attribute, Void, a_value, l_element)
						l_element.put_first (l_attribute)
					end			
				end
			end
		end
	
	set_element (a_doc: XM_DOCUMENT; a_array_path: ARRAY [STRING]; a_element, a_value: STRING) is
			-- Set the value of the element found at the end of tag path with name `a_element' in 
			-- string sequence of `a_array_path'.  If it does not exist then create a new element.
		require
			a_doc_not_void: a_doc /= Void
			non_void_path: a_array_path /= Void
			element_not_void: a_element /= Void
			element_valid: not a_element.is_empty
			valid_path: not a_array_path.has ("")
			non_void_value: a_value /= Void
			first_element_root: a_doc.root_element.name.is_equal (a_array_path.item (1))
		local
			cnt: INTEGER
			is_void_element: BOOLEAN
			l_element, l_child_element: XM_ELEMENT
		do
			a_array_path.compare_references
			if not a_array_path.has (Void) then
				l_element := a_doc.root_element
				from
					cnt := 1
				until
					cnt = a_array_path.count or is_void_element
				loop
					l_child_element := l_element.element_by_name (a_array_path.item (cnt + 1))
					if l_child_element = Void then
						create l_child_element.make_child (l_element, a_array_path.item (cnt + 1), Void)
						l_element.put_first (l_child_element)
					end
					l_element := l_child_element
					cnt := cnt + 1
				end
				if l_element /= Void then
					l_child_element := l_element.element_by_name (a_element)
					if l_child_element = Void then
						create l_child_element.make_child (l_element, a_element, Void)
						l_element.put_first (l_child_element)
					elseif l_child_element.count > 0 then					
						l_child_element.remove (1)
					end
					if a_value.is_empty then
						l_child_element.parent.delete (l_child_element)
					else
						l_child_element.put_first (create {XM_CHARACTER_DATA}.make (l_child_element, a_value))
					end					
				end
			end
		end

feature -- Commands

	deserialize_text (a_text: STRING): XM_DOCUMENT is
			-- Retrieve xml document from content of `a_text'.
			-- If deserialization fails, return Void.
		require
			text_void: a_text /= Void
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_create_read_write ("temporary_file.xml")
			if l_file.exists then
				l_file.put_string (a_text)
				l_file.close
				Result := deserialize_document (create {FILE_NAME}.make_from_string (l_file.name))
				l_file.delete
			end
		end

	deserialize_document (a_doc_name: STRING): XM_DOCUMENT is
			-- Retrieve xml document associated to file with
			-- name 'a_doc_name'.  If deserialization fails, return Void and
			-- put error in `error_descirption'.
		require
			doc_name_not_void: a_doc_name /= Void
		local
			l_parser: XM_EIFFEL_PARSER
			l_tree_pipe: XM_TREE_CALLBACKS_PIPE
			l_file: KL_BINARY_INPUT_FILE
			l_xm_concatenator: XM_CONTENT_CONCATENATOR
		do
			create l_file.make (a_doc_name)
			if l_file.exists then
				l_file.open_read
				if l_file.is_open_read then
					create l_parser.make
					create l_tree_pipe.make
					create l_xm_concatenator.make_null
					l_parser.set_callbacks (standard_callbacks_pipe (<<l_xm_concatenator, l_tree_pipe.start>>))
					l_parser.parse_from_stream (l_file)
					l_file.close
					if l_parser.is_correct then 
						if not l_tree_pipe.error.has_error then
							Result := l_tree_pipe.document
						else
							error_description := l_tree_pipe.error.last_error
						end
					else
						error_description := l_parser.last_error_extended_description
						Result := Void
					end
				else
					error_description :=  "File " + a_doc_name + " cannot not be open"
				end
			else
				error_description := "Try to deserialize unexisting file :%N" + a_doc_name
			end
		end

feature -- Query

	is_valid_xml (xml: STRING): BOOLEAN is
			-- Is `xml' valid xml?
		require
			xml_not_void: xml /= Void
		local
			l_xm_doc: XM_DOCUMENT
		do
			l_xm_doc := deserialize_text (xml)
			Result := l_xm_doc /= Void
		end		

feature -- Access

	pretty_xml (a_xml: STRING): STRING is
			-- Pretty formatted XML of `a_xml'
		require
			xml_not_void: a_xml /= Void
		local
			retried: BOOLEAN
			l_parser: XM_EIFFEL_PARSER
			l_filter: XM_PRETTY_FORMATTER
		do
			if not retried then		
				create Result.make_empty
				create l_parser.make
				create l_filter.make (Result)
				l_parser.set_callbacks (standard_callbacks_pipe (<<l_filter>>))
				l_parser.parse_from_string (a_xml)
				check
					ok_parsing: l_parser.is_correct
				end
				if not l_parser.is_correct then
					Result := l_parser.last_error_extended_description
				end
			end
		rescue
			retried := True
			retry
		end	

feature -- Storage

	save_xml_document (a_doc: XM_DOCUMENT; a_doc_name: FILE_NAME) is
			-- Save `a_doc' in `ptf'
		require
			doc_not_void: a_doc /= Void
			doc_name_not_void: a_doc_name /= Void
		local
			retried: BOOLEAN
			l_formatter: XM_ESCAPED_FORMATTER
			l_output_file: KL_TEXT_OUTPUT_FILE
		do
			if not retried then
					-- Write document
				create l_formatter.make
				l_formatter.process_document (a_doc)
				create l_output_file.make (a_doc_name)
				l_output_file.open_write
				if l_output_file.is_open_write then
					l_output_file.put_string (l_formatter.last_string)
					l_output_file.flush
					l_output_file.close
				else
					io.putstring ("Unable to write file: " + a_doc_name)
				end
			end
		rescue
			retried := True
			io.putstring ("Unable to write file: " + a_doc_name)
			retry
		end

end -- class XML_ROUTINES
