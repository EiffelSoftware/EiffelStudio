note
	description: "[
		{XP_EXTERNAL_RESOLVER}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_EXTERNAL_RESOLVER

inherit
	XM_EXTERNAL_RESOLVER

feature -- Action(s)

	resolve (a_system: STRING) is
			-- Fails.
		do

		ensure then
			stream_has_not_to_be_open: True
		end

feature -- Result

	has_error: BOOLEAN is
			-- Always False
		do
			Result := False
		end

	last_error: STRING is
			-- Error message.
		do
			Result := "this error message should not appear"
		end

	last_stream: KI_CHARACTER_INPUT_STREAM is
			-- Not used.
		local
			stream: KL_TEXT_INPUT_FILE
		do
			create stream.make ("./dtd.txt")
			stream.open_read
			Result := stream
		end
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
