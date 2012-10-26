note
	description: "Summary description for {XML_NODE_PRINTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML_NODE_PRINTER

inherit
	XML_NODE_ITERATOR
		redefine
			process_element,
			process_character_data,
			process_processing_instruction,
			process_document,
			process_comment,
			process_attribute
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create a new XML formatter.
		do
			create {XML_NULL_OUTPUT_STREAM} output.make
		end

feature -- Access

	output: XML_OUTPUT_STREAM
			-- Output stream

	set_output (an_output: like output)
			-- Set output stream.
		require
			not_void: an_output /= Void
		do
			output := an_output
		end

feature -- Processing

	process_element (e: XML_ELEMENT)
			-- Process element `e'.
		local
			t: STRING_32
			n: INTEGER
		do
			output.put_character_8 ('<')
			create t.make_from_string (e.name)
			if attached e.ns_prefix as p and then not p.is_empty then
				t.prepend_character (':')
				t.prepend_string (p)
			end
			output.put_string_32 (t)
			n := e.count
			if attached e.attributes as attrs and then attrs.count > 0 then
				n := n - attrs.count
				process_nodes (attrs)
			end
			if n = 0 then
				output.put_character_8 ('/')
				output.put_character_8 ('>')
			else
				output.put_character_8 ('>')
				process_non_attribute_nodes (e)
				output.put_character_8 ('<')
				output.put_character_8 ('/')
				output.put_string_32 (t)
				output.put_character_8 ('>')
			end
		end

	process_character_data (c: XML_CHARACTER_DATA)
			-- Process character data `c'.
		do
			output.put_string_32_escaped (c.content)
		end

	process_processing_instruction (a_pi: XML_PROCESSING_INSTRUCTION)
			-- Process processing instruction `a_pi'.
		do
			output.put_character_8 ('<')
			output.put_character_8 ('?')
			output.put_string_32 (a_pi.target)
			output.put_character_8 (' ')
			output.put_string_32 (a_pi.data)
			output.put_character_8 ('?')
			output.put_character_8 ('>')
		end

	process_document (doc: XML_DOCUMENT)
			-- Process document `doc'.
		do
			process_nodes (doc)
			output.flush
		end

	process_comment (com: XML_COMMENT)
			-- Process comment `com'.
		do
			output.put_character_8 ('<')
			output.put_character_8 ('!')
			output.put_character_8 ('-')
			output.put_character_8 ('-')
			output.put_string_32_escaped (com.data)
			output.put_character_8 ('-')
			output.put_character_8 ('-')
			output.put_character_8 ('>')
		end

	process_attribute (att: XML_ATTRIBUTE)
			-- Process attribute `att'.
		local
			t: STRING_32
		do
			create t.make_from_string (att.name)
			if attached att.ns_prefix as p and then not p.is_empty then
				t.prepend_character (':')
				t.prepend (p)
			end
			output.put_character_8 (' ')
			output.put_string_32 (t)
			output.put_character_8 ('=')
			output.put_character_8 ('%"')
			output.put_string_32_escaped (att.value)
			output.put_character_8 ('%"')
		end

invariant
	output_not_void: output /= Void

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
