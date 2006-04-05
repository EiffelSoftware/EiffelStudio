indexing
	description: "Common XML routines."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_ROUTINES

inherit
	XM_CALLBACKS_FILTER_FACTORY
		export
			{NONE} all
		end
		
	XM_MARKUP_CONSTANTS
		export {NONE} all end
		
	SHARED_OBJECTS

feature -- Access

	document_text (a_doc: XM_DOCUMENT): STRING is
			-- Full text of `a_doc', including all tags and content.
		require
			doc_not_void: a_doc /= Void
		local
			retried: BOOLEAN
			l_formatter: XM_FORMATTER
			l_output: KL_STRING_OUTPUT_STREAM
		do				
			if not retried then
				create l_formatter.make
				create l_output.make_empty
				l_formatter.set_output (l_output)
				l_formatter.process_document (a_doc)
				Result := l_output.string
			end
		rescue
			retried := True
			io.putstring ("Unable to read file.")
			retry
		end

	pretty_xml (a_xml: STRING): STRING is
			-- Pretty formatted XML of `a_xml'
		require
			xml_not_void: a_xml /= Void
		local
			retried: BOOLEAN
			l_parser: XM_EIFFEL_PARSER
			l_file: KL_STRING_INPUT_STREAM
		do
			if not retried then		
				create Result.make_empty
				create l_parser.make
				create l_file.make (a_xml)
				pretty_formatter.format (Result)
				l_parser.set_callbacks (standard_callbacks_pipe (<<pretty_formatter>>))
				l_parser.parse_from_stream (l_file)
				check
					ok_parsing: l_parser.is_correct
				end
				if not l_parser.is_correct then
					Result := l_parser.last_error_extended_description
				else
					Result := pretty_formatter.last_output
				end
			end		
		rescue
			retried := True
			retry
		end	

	output_escaped (a_string: STRING): STRING is
			-- Escape and output content string.  The string "<>&" will become
			-- "&gt;&lt;&amp;"
		require
			a_string_not_void: a_string /= Void
		local
			last_escaped: INTEGER
			i: INTEGER
			cnt: INTEGER
			a_char: INTEGER
		do
			create Result.make_empty
			from
				last_escaped := 0
				i := 1
				cnt := a_string.count
			invariant
				last_escaped <= i
			until
				i > cnt
			loop
				a_char := a_string.item_code (i)
				if is_escaped (a_char) then
					if last_escaped < i - 1 then
						Result := Result + (a_string.substring (last_escaped + 1, i - 1))
					end
					Result := Result + (escaped_char (a_char))
					last_escaped := i
				end
				i := i + 1
			end
				-- At exit.
			if last_escaped = 0 then
				Result := Result + (a_string)
			elseif last_escaped < i - 1 then
				Result := Result + (a_string.substring (last_escaped + 1, i - 1))
			end
		end

	element_renamed: BOOLEAN
			-- Indicates if an element was renamed through last call to `set_element_name'

feature -- Error

	error_description: STRING
			-- Error string
			
	error_column: INTEGER
			-- Error column
	
	error_line: INTEGER
			-- Error line
			
	error_byte: INTEGER
			-- Error byte position

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
			l_element,
			l_element2: XM_ELEMENT
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
						l_element2 ?= l_attribute.parent
						l_element2.delete (l_attribute)
					elseif l_attribute /= Void and then not a_value.is_empty then						
						l_attribute.set_value (a_value)
					elseif l_attribute = Void and then not a_value.is_empty then						
						create l_attribute.make (a_attribute, create {XM_NAMESPACE}.make_default, a_value, l_element)
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
			l_element, l_child_element, l_element2: XM_ELEMENT
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
						create l_child_element.make (l_element, a_array_path.item (cnt + 1), create {XM_NAMESPACE}.make_default)
						l_element.put_first (l_child_element)
					end
					l_element := l_child_element
					cnt := cnt + 1
				end
				if l_element /= Void then
					l_child_element := l_element.element_by_name (a_element)
					if l_child_element = Void then
						create l_child_element.make (l_element, a_element, create {XM_NAMESPACE}.make_default)
						l_element.put_first (l_child_element)
					elseif l_child_element.count > 0 then					
						l_child_element.remove (1)
					end
					if a_value.is_empty then
						l_element2 ?= l_child_element.parent
						l_element2.delete (l_child_element)
					else
						l_child_element.put_first (create {XM_CHARACTER_DATA}.make (l_child_element, a_value))
					end					
				end
			end
		end
		
	clear_element (a_doc: XM_DOCUMENT; a_array_path: ARRAY [STRING]) is
			-- Remove all elements in the element found at the end of the array path.
		require
			a_doc_not_void: a_doc /= Void
			non_void_path: a_array_path /= Void
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
					l_element := l_child_element
					if l_child_element = Void then
						is_void_element := True
					end
					cnt := cnt + 1
				end
				if not is_void_element then
					l_child_element.wipe_out
				end
			end
		end

	set_element_name (composite: XM_COMPOSITE; old_element: ARRAYED_LIST [STRING]; new_name: STRING; start_index: INTEGER) is
			-- Rename all elements in `composite' conforming to `old_name' to `new_name'.  `start_index' indicates
			-- index to begin matching in `old_element'.  If an element was renamed set `element_renamed' to true.
			-- Result indicates if indeed an element in `composite' was renamed.
		require
			composite_not: composite /= Void			
			valid_index: start_index > 0
		local
			l_elem: XM_ELEMENT
		do
			from
				composite.start
			until
				composite.after
			loop
				l_elem ?= composite.item_for_iteration				
				if l_elem /= Void then
					if l_elem.name.is_equal (old_element.i_th (start_index)) then
						if start_index = old_element.count then
								-- Match found
							l_elem.set_name (new_name)
							set_element_renamed (True)
						else
							set_element_name (l_elem, old_element, new_name, start_index + 1)							
						end
					end				
					if not l_elem.elements.is_empty then
							-- Begin search with `l_elem' as root element
						set_element_name (l_elem, old_element, new_name, 1)
					end
				end
				composite.forth				
			end
		end

	wipe_out_elements (a_el: XM_ELEMENT) is
			-- Remove all elements from `a_el'.  Required because a simple `wipe_out'
			-- will remove attributes also in GOBO.
		require
			element_not_void: a_el /= Void
		local
			l_el: like a_el
		do
			from
				a_el.start
			until
				a_el.after
			loop
				l_el ?= a_el.item_for_iteration
				if l_el /= Void then
					a_el.delete (l_el)
				end
				a_el.forth
			end
		end		

	wipe_out_text (a_el: XM_ELEMENT) is
			-- Remove all text from `a_el'.
		require
			element_not_void: a_el /= Void
		local
			l_el: XM_CHARACTER_DATA
		do
			from
				a_el.start
			until
				a_el.after
			loop
				l_el ?= a_el.item_for_iteration
				if l_el /= Void then
					a_el.delete (l_el)
					wipe_out_text (a_el)
				else					
					a_el.forth	
				end
			end
		end	

	set_element_renamed (a_flag: BOOLEAN) is
			-- Set to indicate if element has been renamed through call to `set_element_name'
		do
			element_renamed := a_flag
		end		

feature -- Commands

	deserialize_text (a_text: STRING): XM_DOCUMENT is
			-- Retrieve xml document from content of `a_text'.
			-- If deserialization fails, return Void.
		require
			text_void: a_text /= Void
		local
			l_parser: XM_EIFFEL_PARSER
			l_tree_pipe: XM_TREE_CALLBACKS_PIPE
			l_xm_concatenator: XM_CALLBACKS_FILTER
			l_file: KL_STRING_INPUT_STREAM
		do
			create l_parser.make
			create l_tree_pipe.make
			create l_xm_concatenator.make_null
			create l_file.make (a_text)
			l_parser.set_callbacks (standard_callbacks_pipe (<<l_xm_concatenator, l_tree_pipe.start>>))			
			l_parser.parse_from_stream (l_file)
			if l_parser.is_correct then 
				if not l_tree_pipe.error.has_error then
					Result := l_tree_pipe.document
				else
					error_description := l_tree_pipe.last_error
				end
			else
				error_description := l_parser.last_error_extended_description
				error_column := l_parser.column
				error_line := l_parser.line
				error_byte := l_parser.byte_position
				Result := Void
			end
		end

	deserialize_document (a_doc_name: STRING): XM_DOCUMENT is
			-- Retrieve xml document associated to file with
			-- name 'a_doc_name'.  If deserialization fails, return Void and
			-- put error in `error_description'.
		require
			doc_name_not_void: a_doc_name /= Void
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make (a_doc_name)
			if l_file.exists then
				l_file.open_read
				l_file.read_stream (l_file.count)
				Result := deserialize_text (l_file.last_string)
				l_file.close
			end
		end

feature -- Query

	is_valid_xml (xml: STRING): BOOLEAN is
			-- Is `xml' valid xml?
		require
			xml_not_void: xml /= Void
		local
			l_xm_doc: XM_DOCUMENT
			l_error: ERROR
		do
			l_xm_doc := deserialize_text (xml)
			Result := l_xm_doc /= Void	
			if not Result then
				create l_error.make_with_line_information (error_description, error_line, error_column)
				l_error.set_action (agent (shared_error_reporter.actions).highlight_text_in_editor (error_line, error_column))
				shared_error_reporter.set_error (l_error)
			end
		end		

feature -- Storage

	save_xml_document (a_doc: XM_DOCUMENT; a_doc_name: STRING) is
			-- Save `a_doc'
		require
			doc_not_void: a_doc /= Void
			doc_name_not_void: a_doc_name /= Void
		local
			retried: BOOLEAN
--			l_formatter: XM_ESCAPED_FORMATTER
			l_formatter: XM_FORMATTER
			l_output_file: KL_TEXT_OUTPUT_FILE
		do
			if not retried then
					-- Write document
				create l_output_file.make (a_doc_name)
				create l_formatter.make
				l_formatter.set_output (l_output_file)												
				l_output_file.open_write
				if l_output_file.is_open_write then
					l_formatter.process_document (a_doc)
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
		
feature {NONE} -- Implementation

	is_escaped (a_char: INTEGER): BOOLEAN is
			-- Is this an escapable character? (<, >, &)
		do
			Result := a_char = Lt_char.code
				or a_char = Gt_char.code
				or a_char = Amp_char.code
				or a_char >= 128
		end

	escaped_char (a_char: INTEGER): STRING is
			-- Escape char.
		require
			is_escaped: is_escaped (a_char)
		do
			if a_char = Lt_char.code then
				Result := Lt_entity
			elseif a_char = Gt_char.code then
				Result := Gt_entity
			elseif a_char = Amp_char.code then
				Result := Amp_entity
			elseif a_char = Quot_char.code then
				Result := Quot_entity
			else
				Result := STRING_.concat ("&#", a_char.out)
				Result := STRING_.concat (Result, ";")
			end
		end

	pretty_formatter: XM_PRETTY_FORMATTER is
			-- Formatter for pretty XML
		once
			create Result
		end

	STRING_: KL_STRING_ROUTINES is
			-- Routines that ought to be in class STRING
		once
			create Result
		ensure
			string_routines_not_void: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end -- class XML_ROUTINES
