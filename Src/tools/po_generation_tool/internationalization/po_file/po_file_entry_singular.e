note
	description: "[
					This is a .po file entry for a string that is only used in the singular.
					The translated string is stored in msgstr.
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class
	PO_FILE_ENTRY_SINGULAR

inherit
	PO_FILE_ENTRY
		redefine
			make,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	make (a_msgid:STRING_GENERAL)
			-- Initialize singular entry with `a_msgid' as message ID.
			--
			-- `a_msgid': Message ID for new entry
		do
			Precursor(a_msgid)
			create msgstr_lines.make
		ensure then
			msgstr_lines_created: msgstr_lines /= Void
		end

feature -- Element change

	set_msgstr (a_msgstr: STRING_GENERAL)
			-- Set translated value of entry to `a_msgstr'.
			--
			-- `a_msgstr': Translation corresponding to entry
		require
			a_mesgstr_not_void: a_msgstr /= Void
		do
			msgid_lines.wipe_out
			msgstr_lines := break_line (a_msgstr.to_string_32)
		ensure
			msgstr_set: msgstr.is_equal (a_msgstr.to_string_32)
		end

feature -- Access

	msgstr: STRING_32
			-- Translation for the entry
		do
			Result := unbreak_line (msgid_lines)
		ensure
			msgstr_not_void: Result /= Void
		end

feature -- Output

	to_string: STRING_32
			-- Entry as a unicode string
		do
			Result := Precursor
				--add the msgstr
			Result.append_string(prepare_string ("msgstr", msgstr_lines))
		end

feature {NONE} -- Implementation

	msgstr_lines: LINKED_LIST[STRING_32];

note
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
