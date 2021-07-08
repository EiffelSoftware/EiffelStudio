note
	description: "Summary description for {SCM_DIFF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_DIFF

create
	make

feature	{NONE} -- Initialization

	make (nb: INTEGER)
		do
			create unified_diffs.make_equal (nb)
		end

feature -- Operation

	put_string_diff (a_location: READABLE_STRING_GENERAL; s: READABLE_STRING_GENERAL)
		do
			unified_diffs [a_location] := create {IMMUTABLE_STRING_32}.make_from_string_general (s)
		end

	put_string_8_diff (a_location: READABLE_STRING_GENERAL; s: READABLE_STRING_8)
		local
			utf: UTF_CONVERTER
		do
			put_string_diff (a_location, utf.utf_8_string_8_to_string_32 (s))
		end

	append_diff (d: SCM_DIFF)
		do
			across
				d.unified_diffs as ic
			loop
				put_string_diff (ic.key, ic.item)
			end
		end

feature -- Access: error

	has_error: BOOLEAN

	error_message: detachable IMMUTABLE_STRING_32

	report_error (a_mesg: READABLE_STRING_GENERAL)
		do
			create error_message.make_from_string_general (a_mesg)
			has_error := True
		end

	reset_error
		do
			has_error := False
			error_message := Void
		end

feature -- Access	

	unified_diffs: STRING_TABLE [IMMUTABLE_STRING_32]

	full_text: STRING_32
		local
			nb: INTEGER
			l_unified_diffs: like unified_diffs
		do
			l_unified_diffs := unified_diffs
			create Result.make_empty
			nb := l_unified_diffs.count
			across
				l_unified_diffs as ic
			loop
				if nb > 1 then
					Result.append_string ("[Location: ")
					Result.append_string (ic.key)
					Result.append_character (']')
					Result.append_character ('%N')
				end
				Result.append_string (ic.item)
				Result.append_character ('%N')
			end
		end

feature -- Access: source

	changelist: detachable SCM_CHANGELIST

	set_changelist (cl: like changelist)
		do
			changelist := cl
		end

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
