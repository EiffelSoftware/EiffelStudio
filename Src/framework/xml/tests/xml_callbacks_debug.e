note
	description: "Summary description for {XML_CALLBACKS}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_CALLBACKS_DEBUG

inherit
	XML_CALLBACKS

feature {NONE} -- Initialization

	initialize
			-- <Precursor>.
		do
		end
		
feature -- Document

	on_start
			-- Called when parsing starts.
		do
			print ("[debug] on_start%N")
		end

	on_finish
			-- Called when parsing finished.
		do
			print ("[debug] on_finish%N")
		end

	on_xml_declaration (a_version: STRING; a_encoding: detachable STRING; a_standalone: BOOLEAN)
			-- XML declaration.
		do
			print ("[debug] on_xml_declaration: version=" + a_version + " encoding=" + text (a_encoding, "") + " standalone=" + a_standalone.out + "%N")
		end

feature -- Errors

	on_error (a_message: STRING)
			-- Event producer detected an error.
		do
			print ("[debug] on_error: message=" + a_message + "%N")
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING)
			-- Processing instruction.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
			print ("[debug] on_processing_instruction: name=" + a_name + " content=" + a_content + "%N")
		end

	on_comment (a_content: STRING)
			-- Processing a comment.
			-- Atomic: single comment produces single event
		do
			print ("[debug] on_comment=" + single_line (a_content) + "%N")
		end

feature -- Tag

	on_start_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- Start of start tag.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		local
			s: STRING
		do
			create s.make_empty
			if a_namespace /= Void and then not a_namespace.is_empty then
				s.append_string (" namespace=" + a_namespace)
			end
			if a_prefix /= Void then
				s.append_string (" prefix=" + a_prefix)
			end

			print ("[debug] on_start_tag:" + s + " local=" + a_local_part + "%N")
		end

	on_attribute (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING; a_value: STRING)
			-- Start of attribute.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		local
			s: STRING
		do
			create s.make_empty
			if a_namespace /= Void and then not a_namespace.is_empty then
				s.append_string (" namespace=" + a_namespace)
			end
			if a_prefix /= Void then
				s.append_string (" prefix=" + a_prefix)
			end

			print ("[debug] on_attribute:" + s + " local=" + a_local_part)
			if a_value /= Void then
				print (" value=%"" + a_value + "%"")
			end
			print ("%N")
		end

	on_start_tag_finish
			-- End of start tag.
		do
			print ("[debug] on_start_tag_finish%N")
		end

	on_end_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- End tag.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		local
			s: STRING
		do
			create s.make_empty
			if a_namespace /= Void and then not a_namespace.is_empty then
				s.append_string (" namespace=" + a_namespace)
			end
			if a_prefix /= Void then
				s.append_string (" prefix=" + a_prefix)
			end

			print ("[debug] on_end_tag:" + s + " local=" + a_local_part + "%N")
		end

feature -- Content

	on_content (a_content: STRING)
			-- Text content.
			-- NOT atomic: two on_content events may follow each other
			-- without a markup event in between.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
			print ("[debug] on_content=" + single_line (a_content) + "%N")
		end

feature -- Helpers

	single_line (s: STRING): STRING
		do
			create Result.make_from_string (s)
			Result.prepend ("(count=" + s.count.out + ") [")
			Result.replace_substring_all ("%R%N", "%%N")
			Result.replace_substring_all ("%N", "%%N")
			Result.append_character (']')
		end

	text (s: detachable STRING; dft: STRING): STRING
		do
			if s = Void then
				Result := dft
			else
				Result := s
			end
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
