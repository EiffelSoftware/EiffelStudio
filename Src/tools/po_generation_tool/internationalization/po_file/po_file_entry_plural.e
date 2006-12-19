indexing
	description: "[
					Represents a .po file entry where the string should have its plural forms translated
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PO_FILE_ENTRY_PLURAL

inherit
	PO_FILE_ENTRY
		redefine
			make, to_string
		end

create
	make

feature -- creation

	make(a_msgid:STRING_GENERAL) is
		do
			Precursor(a_msgid)
			create msgstr_n_lines.make (0, 2) --reasonable default values
			msgstr_n_lines.force (break_line (""),0) --ensure at least one msgstr. Otherwise some .po editors get fussy.
			create msgid_plural_lines.make
		ensure then
			msgstr_n_lines_created: msgstr_n_lines /= Void
		end

feature -- Modification

	set_msgid_plural(a_plural:STRING_GENERAL) is
			-- set the untranslated plural string
		require
			argument_not_void: a_plural /= Void
		do
			msgid_plural_lines.wipe_out
			msgid_plural_lines := break_line (a_plural.as_string_32)
		ensure
			msgid_plural_set: msgid_plural.is_equal(a_plural.as_string_32)
		end

	set_msgstr_n(n:INTEGER; translation:STRING_GENERAL) is
			-- set the nth plural form translation
		require
			n_correct: n >= 0
			translation_non_void: translation /= Void
		do
			msgstr_n_lines.force (break_line (translation.as_string_32), n)
		ensure
			nth_plural_set: msgstr_n (n).is_equal(translation.as_string_32)
		end

feature --Access

	msgid_plural: STRING_32 is
		do
			Result := unbreak_line (msgid_plural_lines)
		end

	 has_msgstr_n (n: INTEGER):BOOLEAN is
	 		-- Does this entry have a translation for the nth plural of msgid_plural?
 		require
 			n_not_negative:  n>=0
 		do
 			Result := (msgstr_n_lines.valid_index (n) and then msgstr_n_lines.item (n) /= Void)
 		end

	 msgstr_n (n:INTEGER):STRING_32 is
	 		-- get the translation for the nth plural form
 		require
 			translation_exists: has_msgstr_n(n)
 		do
			Result := unbreak_line (msgstr_n_lines.item(n))
 		end

feature -- output

	to_string:STRING_32 is
			-- output the entry
		local
			counter: INTEGER
		do
			Result := Precursor
			Result.append_string(prepare_string ("msgid_plural", msgid_plural_lines))

			from
				counter := msgstr_n_lines.lower
			until
				counter > msgstr_n_lines.upper
			loop
				if msgstr_n_lines.valid_index (counter) and then msgstr_n_lines.item (counter) /= Void
					and then not msgstr_n_lines.item (counter).is_empty then

					Result.append_string (prepare_string ("msgstr["+counter.out+"]", msgstr_n_lines.item (counter)))
				end
				counter := counter + 1
			end
		end

feature {NONE} -- Implementation
	msgstr_n_lines: ARRAY[LINKED_LIST[STRING_32]]
	msgid_plural_lines: LINKED_LIST[STRING_32];

indexing
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
