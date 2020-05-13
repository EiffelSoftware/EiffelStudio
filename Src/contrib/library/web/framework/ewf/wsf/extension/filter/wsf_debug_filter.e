note
	description: "Filter implementing debug output in error stream, or `output' file."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_DEBUG_FILTER

inherit
	WSF_FILTER

create
	default_create,
	make

feature {NONE} -- Initialization

	make (a_output: FILE)
		do
			output := a_output
		end

	output: detachable FILE

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		local
			s: STRING_8
			dbg: WSF_DEBUG_INFORMATION
		do
			create s.make (2048)
			create dbg.make
			dbg.set_is_verbose (False)

			dbg.append_content_information_to (req, res, s)
			dbg.append_path_parameters_to (req, res, s)
			dbg.append_query_parameters_to (req, res, s)
			dbg.append_form_parameters_to (req, res, s)

			if not s.is_empty then
				s.prepend ("**DEBUG**%N")
				if attached output as o then
					o.put_string (s)
				else
					res.put_error (s)
				end
			end
			execute_next (req, res)
		end

	append_iterable_to (a_title: READABLE_STRING_8; it: detachable ITERABLE [WSF_VALUE]; s: STRING_8)
		local
			n: INTEGER
		do
			if it /= Void then
				across it as c loop
					n := n + 1
				end
				if n > 0 then
					s.append (a_title)
					s.append_character (':')
					s.append_character ('%N')
					across
						it as c
					loop
						s.append ("  - ")
						s.append (c.item.url_encoded_name)
						s.append_character (' ')
						s.append_character ('{')
						s.append (c.item.generating_type.name)
						s.append_character ('}')
						s.append_character ('=')
						s.append ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (c.item.debug_output))
						s.append_character ('%N')
					end
				end
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
