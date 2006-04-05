indexing
	description: "Document Schema."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_SCHEMA

inherit
	SHARED_OBJECTS

	XML_ROUTINES
		rename
			is_valid_xml as is_valid_xml_text
		end

create
	make_from_schema_file
	
feature -- Initialization
	
	make_from_schema_file (a_filename: STRING) is
			-- Make from 'a_filename'
		require
			schema_file_not_void: a_filename /= Void
			is_file: (create {PLAIN_TEXT_FILE}.make (a_filename)).exists
		local
			reader: XML_XML_TEXT_READER
			event_handler: XML_VALIDATION_EVENT_HANDLER
			retried: BOOLEAN
		do
			if not retried then
				create validator			
				name := a_filename
				create reader.make_from_url (name)
				create event_handler.make (Current, $validation_callback)
				internal_schema := internal_schema.read_xml_reader_validation_event_handler (reader, event_handler)
				validator.validate_by_filename (name)
				if validator.is_valid then
					create elements.make
					create types.make
					initialize			
				end			
			end
		ensure
			internal_schema_set: is_valid_xml implies internal_schema /= Void
			elements_set: validator.is_valid implies elements /= Void
			types_set: validator.is_valid implies types /= Void
		rescue
			retried := True
			retry
		end			
		
	initialize is
			-- Initialize
		do
			initialize_elements
			initialize_types
		end

	initialize_elements is
			-- Initialize all schema level elements
		local
			cnt: INTEGER
			elem: XML_XML_SCHEMA_ELEMENT
			doc_elem: DOCUMENT_SCHEMA_ELEMENT
		do
			create doc_elem
			doc_elem.parent_type_names.wipe_out
			from
            	cnt := 0
            until
            	cnt = internal_schema.items.count            	
            loop
            	elem ?= internal_schema.items.item (cnt)
            	if elem /= Void then
            		create doc_elem.make_from_element (elem, Current)
            		elements.extend (doc_elem)
            	end
            	cnt := cnt + 1
			end
		end
		
	initialize_types is
			-- Initialize types
		local
			cnt: INTEGER
			type: XML_XML_SCHEMA_TYPE
			elem: DOCUMENT_SCHEMA_ELEMENT
		do
			from
            	cnt := 0
            until
            	cnt = internal_schema.items.count            	
            loop
            	type ?= internal_schema.items.item (cnt)
            	if type /= Void then
            		create elem.make_from_type (type, Current)
            		types.extend (elem)
            	end
            	cnt := cnt + 1
			end
		end

	initialize_attributes (element_list: ARRAYED_LIST [DOCUMENT_SCHEMA_ELEMENT]) is
			-- Initialize the attributes for known types and elements
		do
			from
				element_list.start
			until
				element_list.after
			loop
				element_list.item.process_attributes
				if element_list.item.children /= Void then
					initialize_attributes (element_list.item.children)
				end
				element_list.forth
			end
		end

feature -- Elements

	elements: LINKED_LIST [DOCUMENT_SCHEMA_ELEMENT]
			-- All schema elements (includes xml elements, complex types, simple types, etc)
			
	types: LINKED_LIST [DOCUMENT_SCHEMA_ELEMENT]
			-- Schema types

feature -- Access

	name: STRING
			-- Name od schema
			
	document: XM_DOCUMENT
			-- XML document structure

	text: STRING is
			-- Text of `document'
		do
			Result := document_text (document)	
		end		

	validator: SCHEMA_VALIDATOR
			-- Schema validation

feature -- Query	

	is_valid_xml: BOOLEAN is
			-- Is Current valid xml?
		do
			Result := document /= Void
		end

	is_valid: BOOLEAN is
			-- Is Current valid schema definition according to W3C?
		do
			create validator
			validator.validate_by_filename (name)
			Result := validator.is_valid	
		end
		
	get_element_by_name (el_name: STRING): DOCUMENT_SCHEMA_ELEMENT is
			-- Get a schema element with name `el_name', if exists.
		require
			el_name_not_void: el_name /= Void
		do
			if not el_name.is_empty then
				from
					elements.start
				until
					elements.after or Result /= Void
				loop
					Result ?= elements.item.name.is_equal (el_name)
					if Result = Void then
						Result ?= elements.item.child_element_by_name (el_name)
					end
					elements.forth
				end
			end			
		end	
		
feature {NONE} -- Implementation

	internal_schema: XML_XML_SCHEMA
			-- Schema object internal representation

feature {DOCUMENT_SCHEMA_ELEMENT} -- Element Query

	get_type_by_dotnet_type (a_type: XML_XML_SCHEMA_TYPE): DOCUMENT_SCHEMA_ELEMENT is
			-- Get schema element type associated with dotnet type `a_type'
		require
			a_type_not_void: a_type /= Void
		local
			l_name: STRING
		do
			from 
				types.start
			until
				types.after or Result /= Void
			loop
				l_name := a_type.name
				if l_name.is_equal (types.item.name) then
					Result := types.item					
				end
				types.forth
			end
		end

	get_type_by_name (type_name: STRING): XML_XML_SCHEMA_TYPE is
			-- Get a dotnet schema type from 'type_name'
		require
			type_name_not_void: type_name /= Void
			type_name_not_empty: not type_name.is_empty
			contains_type: has_type (type_name)
		local
			cnt: INTEGER
			found: BOOLEAN
			l_name: STRING
		do
			if has_type (type_name) then
				from
					cnt := 0
				until
					cnt = internal_schema.items.count or found
				loop
					Result ?= internal_schema.items.item (cnt)
					if Result /= Void then
						l_name :=  Result.name
						if l_name.is_equal (type_name) then
							found := True
						end
					end
					cnt := cnt + 1
				end
			end
		end

	has_type (type_name: STRING): BOOLEAN is
			-- Is there a type with `type_name' in Current
		require
			type_name_not_void: type_name /= Void
			type_name_not_empty: not type_name.is_empty
		local
			cnt: INTEGER
			l_name: STRING
			type: XML_XML_SCHEMA_TYPE
		do
			from
				cnt := 0
			until
				cnt = internal_schema.items.count or Result
			loop
				type ?= internal_schema.items.item (cnt)
				if type /= Void then
					l_name := type.name
					if l_name.is_equal (type_name) then
						Result := True
					end
				end
				cnt := cnt + 1
			end
		end		

feature {NONE} -- Implementation

	validation_callback (object: SYSTEM_OBJECT; args: XML_VALIDATION_EVENT_ARGS) is
			-- Validation callback handler
		do			
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
end -- class DOCUMENT_SCHEMA	