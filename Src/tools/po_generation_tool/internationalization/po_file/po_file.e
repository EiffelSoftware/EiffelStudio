note
	description: "[
				This class represents a .po file.
				.po files are collections of strings and (possibly) their localised translations for a given language.
				They consist of a collection of entries, each having an original  string in (what is assumed to be) English and
				its translation, or possibly its translation in several plural forms.
				Headers are stored in an entry for an empty original string.
				For more information about .po files, please consult 
						http://www.gnu.org/software/gettext/manual/
						and in particular
						http://www.gnu.org/software/gettext/manual/html_node/gettext_9.html#SEC9
				In typical GNU style, this is not entirely complete and rather badly organised, but we must live with it for now.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PO_FILE

create
	make_empty

feature	{NONE} -- Initialization

	make_empty
			-- Makes a new, empty representation of a .po file
		do
				--create headers.
			create headers.make
			create entries.make (20)

				-- We (should) do everything in UTF-8
		    headers.add_header ("Content-Type", "text/plain; charset=UTF-8")

			    -- According to gettext doc this "should always be set to 8" (what's the point of having it then?)
		    headers.add_header ("Content-Transfer-Encoding", "8bit")

		    headers.add_header ("Last-Translator", "YOUR NAME HERE")
		    headers.add_header ("Language-Team", "YOUR TEAM HERE")
		    headers.add_header ("Plural-Forms", "nplurals=2; plural=n>1;")
		    headers.add_header ("MIME-Version", "1.0")
		end

feature -- Access

	headers: PO_FILE_HEADERS
			-- Headers of po file

	entry (msgid: STRING_GENERAL): PO_FILE_ENTRY
			-- File entry for `msgid'
			--
			-- `msgid': Message ID which identifies entry
			-- `Result': File entry for `msgid'
		require
			key_not_void: msgid /= Void
			entry_exists: has_entry (msgid.to_string_32)
		do
			Result := entries.item (msgid.to_string_32)
		ensure
			valid_result: Result /= Void
		end

feature -- Element change

	add_entry (new: PO_FILE_ENTRY)
			-- Adds entry `new' to .po file.
			--
			-- Note: a .po file should not contain more then one entry with a given msgid
			--
			-- `new': File entry to add to .po file
		require
			new_not_void: new /= Void
			entry_not_already_present: not has_entry (new.msgid)
		do
			entries.put (new, new.msgid)
		ensure
			entry_added: has_entry (new.msgid)
		end

	has_entry (msgid: STRING_GENERAL):BOOLEAN
			-- Is an entry with message id `msgid' already in the .po file?
			--
			-- Note: msgid is a unique key for entries
			--
			-- `msgid': Message ID which identifies entry
			-- `Result': True if entry with message ID `msgid' exists, False otherwise
		require
			msgid_not_void: msgid /= Void
		do
			Result := entries.has (msgid.to_string_32)
		end

feature -- Output

	to_string: STRING_32
			-- Prints whole .po file as a string_32
		do
			create Result.make_empty
			Result.append_string(headers.to_string)
			Result.append ("%N")
			from
				entries.start
			until
				entries.after
			loop
				Result.append_string(entries.item_for_iteration.to_string)
				entries.forth
			end
		ensure
			valid_result: Result /= Void
		end

feature {NONE} --Implementation

	entries: HASH_TABLE [PO_FILE_ENTRY, STRING_32];
			-- Map of file entries identified by their message ID

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
