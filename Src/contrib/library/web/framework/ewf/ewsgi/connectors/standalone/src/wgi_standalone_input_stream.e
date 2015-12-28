note
	description: "[
			Input stream for the Standalone Web Server connector.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_STANDALONE_INPUT_STREAM

inherit
	WGI_INPUT_STREAM

create
	make

feature {NONE} -- Initialization

	make (a_source: like source)
		do
			create last_string.make_empty
			set_source (a_source)
		end

feature {WGI_STANDALONE_CONNECTOR, WGI_SERVICE} -- Nino

	set_source (i: like source)
		do
			source := i
		end

	source: HTTPD_STREAM_SOCKET

feature -- Input

	read_character
			-- Read the next character in input stream.
			-- Make the result available in `last_character'.
		local
			src: like source
		do
			src := source
			if src.readable then
				src.read_character
				last_character := src.last_character
			else
				last_character := '%U'
			end
		end

	read_string (nb: INTEGER)
		local
			src: like source
		do
			src := source
			last_string.wipe_out
			if src.readable then
				src.read_stream_thread_aware (nb)
				last_string.append_string (src.last_string)
			end
		end

feature -- Access

	last_string: STRING_8
			-- Last string read
			-- (Note: this query *might* return the same object.
			-- Therefore a clone should be used if the result
			-- is to be kept beyond the next call to this feature.
			-- However `last_string' is not shared between input objects.)

	last_character: CHARACTER_8
			-- Last item read

feature -- Status report

	is_open_read: BOOLEAN
			-- Can items be read from input stream?
		do
			Result := source.is_open_read
		end

	end_of_input: BOOLEAN
			-- Has the end of input stream been reached?
		do
			Result := not source.readable
		end

;note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
