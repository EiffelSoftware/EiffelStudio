indexing
	description: "[
			Common routines for XML extraction
			
		FIXME: inheritance of XM_EIFFEL_PARSER is here only because
		XM_ELEMENT.`add_attribute' is not exported to ANY in gobo 3.1
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_XML_ROUTINES

inherit
	EXCEPTIONS
    	rename
    		tag_name as exceptions_tag_name,
    		class_name as exceptions_class_names
    	end

	XM_CALLBACKS_FILTER_FACTORY
		export {NONE} all end

	XM_EIFFEL_PARSER
		rename
			make as make_xm_eiffel_parser,
			name as name_xm_eiffel_parser,
			clear_all as clear_all_xm_eiffel_parser,
			reset as reset_xm_eiffel_parser,
			source as source_xm_eiffel_parser,
			line as line_xm_eiffel_parser,
			eq as eq_xm_eiffel_parser
		export
			{NONE} all
		end

feature {SHARED_XML_ROUTINES} -- Status report

	valid_tags: INTEGER
			-- Number of valid tags read.

feature {SHARED_XML_ROUTINES} -- Status setting
	
	reset_valid_tags is
			-- Reset `valid_tags'.
		do
			valid_tags := 0
		ensure
			valid_tags_is_nul: valid_tags = 0
		end

	valid_tags_read is
			-- A valid tag was just read.
		do
			valid_tags := valid_tags + 1
		ensure
			valid_tags_incremented: valid_tags = old valid_tags + 1
		end

feature -- Processing

	xml_integer (elem: XM_ELEMENT; a_name: STRING): INTEGER is
			-- Find in sub-elememt of `elem' integer item with tag `a_name'.
		local
			e: XM_ELEMENT
			cd: XM_CHARACTER_DATA
		do
			e := element_by_name (elem, a_name)
			if e /= Void then
				if not e.is_empty then
					cd ?= e.first
					if cd /= Void then
						if cd.content.is_integer then
							Result := cd.content.to_integer
							valid_tags_read
						end
					end
				end
			end
		end

	xml_boolean (elem: XM_ELEMENT; a_name: STRING): BOOLEAN is
			-- Find in sub-elememt of `elem' boolean item with tag `a_name'.
		local
			e: XM_ELEMENT
			cd: XM_CHARACTER_DATA
		do
			e := element_by_name (elem, a_name)
			if e /= Void then
				if not e.is_empty then
					cd ?= e.first
					if cd /= Void then
						if cd.content.is_boolean then
							Result := cd.content.to_boolean
							valid_tags_read
						end
					end
				end
			end
		end

	xml_double (elem: XM_ELEMENT; a_name: STRING): DOUBLE is
			-- Find in sub-elememt of `elem' integer item with tag `a_name'.
		local
			e: XM_ELEMENT
			cd: XM_CHARACTER_DATA
		do
			e := element_by_name (elem, a_name)
			if e /= Void then
				if not e.is_empty then
					cd ?= e.first
					if cd /= Void then
						if cd.content.is_double then
							Result := cd.content.to_double
							valid_tags_read
						end
					end
				end
			end
		end

	xml_string (elem: XM_ELEMENT; a_name: STRING): STRING is
			-- Find in sub-elememt of `elem' string item with tag `a_name'.
		local
			e: XM_ELEMENT
			cd: XM_CHARACTER_DATA
		do
			e := element_by_name (elem, a_name)
			if e /= Void then
				if not e.is_empty then
					cd ?= e.first
					if cd /= Void then
						Result := cd.content
						valid_tags_read
					end
				end
			end
		end

	xml_color (elem: XM_ELEMENT; a_name: STRING): EV_COLOR is
			-- Find in sub-elememt of `elem' color item with tag `a_name'.
		local
			e: XM_ELEMENT
			cd: XM_CHARACTER_DATA
			s: STRING
			sc1, sc2: INTEGER
			r, g, b: INTEGER
		do
			e := element_by_name (elem, a_name)
			if e /= Void then
				cd ?= e.first
				if cd /= Void then
					s := cd.content
				end
			end
			if s /= Void then
				check
					two_semicolons: s.occurrences (';') = 2
				end
				sc1 := s.index_of (';', 1)
				r := s.substring (1, sc1 - 1).to_integer
				sc2 := s.index_of (';', sc1 + 1)
				g := s.substring (sc1 + 1, sc2 - 1).to_integer
				b := s.substring (sc2 + 1, s.count).to_integer
				create Result.make_with_8_bit_rgb (r, g, b)
				valid_tags_read
			end
		end

	element_by_name (e: XM_ELEMENT; n: STRING): XM_ELEMENT is
			-- Find in sub-elemement of `e' an element with tag `n'.
		require
			e_not_void: e /= Void
		local
			i: INTEGER
			f: XM_ELEMENT
		do
			from
				i := 1
			until
				Result /= Void or i > e.count
			loop
				f ?= e.item (i)
				if f /= Void and then f.name.is_equal (n) then
					Result := f
				end
				i := i + 1
			end
		end

	xml_string_node (a_parent: XM_ELEMENT; s: STRING): XM_CHARACTER_DATA is
			-- New node with `s' as content.
		do
			create Result.make (a_parent, s)
		end

	xml_node (a_parent: XM_ELEMENT; tag_name, content: STRING): XM_ELEMENT is
			-- New node with `s' as content and named `tag_name'.
		local
			l_namespace: XM_NAMESPACE
		do
			create l_namespace.make ("", "")
			create Result.make_child (a_parent, tag_name, l_namespace)
			Result.put_last (xml_string_node (Result, content))
		end

feature {NONE} -- Saving

	save_xml_document (ptf: FILE; a_doc: XM_DOCUMENT) is
			-- Save `a_doc' in `ptf'
		require
			file_not_void: ptf /= Void
			file_exists: ptf /= Void
			valid_document: a_doc /= Void and then a_doc.root_element.name.is_equal ("CLUSTER_DIAGRAM")
		local
			retried: BOOLEAN
			l_formatter: XM_FORMATTER
			l_output_file: KL_TEXT_OUTPUT_FILE
		do
			if not retried then
					-- Write document
				create l_formatter.make
				l_formatter.process_document (a_doc)
				create l_output_file.make (ptf.name)
				l_output_file.open_write
				if l_output_file.is_open_write then
					l_output_file.put_string (l_formatter.last_string)
					l_output_file.flush
					l_output_file.close
				end
			end
		rescue
			retried := True
			create error_window
			if ptf /= Void then
				error_window.set_text ("Unable to write file: " + ptf.name)
			else
				error_window.set_text ("Unable to write file.")
			end
			error_window.show
			retry
		end

feature {NONE} -- Implementation

	error_window: EV_WARNING_DIALOG
			-- Window that warns user of wrong ".ead" file.

end -- class SHARED_XML_ROUTINES
