note

deferred class XM_PARSER

inherit
	XML_PARSER
		rename
			parse_from_stream as parse_from_xml_stream
		end

feature

	parse_from_stream (a_stream: KI_CHARACTER_INPUT_STREAM)
			-- Parse XML document from input stream.
		require
			a_stream_not_void: a_stream /= Void
			is_open_read: a_stream.is_open_read
		local
			xis: XML_KI_CHARACTER_INPUT_STREAM
		do
			if attached {KI_CHARACTER_INPUT_STREAM} a_stream as l_ki then
				create xis.make (a_stream)
				if attached {KI_INPUT_FILE} a_stream as l_file then
					xis.compute_smart_chunk_size (l_file.count, 0x4000)
				else
				end
				parse_from_xml_stream (xis)
			end
		end

	set_string_mode_mixed
		do
			check not_supported: False end
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
