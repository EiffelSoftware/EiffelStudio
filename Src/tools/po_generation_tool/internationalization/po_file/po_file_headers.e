indexing
	description: "[
					This class models the header entry of a .po file. 
					A header entry is a singular entry with the empty string as msgid. The msgstr contains the headers;
					each line normally contains one header. The headers are used to contain such things as copyright information, 
					the names of the people responsible for producing it etc. etc.
					From a technical standpoint the important headers are:
					1. Content-Type  (for syntax please see gettext documentation or make in PO_FILE)
					2. Content-Transfer-Encoding ("should always be se to 8", unless presumably you want to use 7 bit encoding :) )
					3. Pural-Forms  (this describes the number of separate forms for plurals. For syntax see either the gettext documentation
									or FIXME: the eiffel wiki at ETH)
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PO_FILE_HEADERS

inherit
	PO_FILE_ENTRY_SINGULAR
		rename
			make as make_old
		export
				-- This is not a nice or elegant thing to do, I know.
			{NONE} make_old
		redefine
			msgstr, to_string
		end

create
	make

feature -- Creation

	make is
			-- makes new headers entry
		do
			make_old ("")
			create headers.make (10) --10 headers should be enough for anybody
		end

feature --Access

	has_header(key:STRING_GENERAL):BOOLEAN is
			-- does this header exist?
		require
			argument_not_void: key /= Void
		do
			Result := headers.has (key.to_string_32)
		end

	get_header(key:STRING_GENERAL):STRING_32 is
			-- get the content of this header
		require
			argument_not_void: key /= Void
			key_valid: has_header(key)
		do
			Result := headers.item (key.to_string_32)
		end

	msgstr: STRING_32 is
			-- Return the msgstr.
		do
				-- In this case the msgstr is _not_ stored in msgstr_lines like a normal entry,
				-- because the msgtr is a multi-line string where each line is a header. We keep them in a
				-- hash table to be able to access them individually by key
			from
				headers.start
			until
				headers.after
			loop
				create Result.make_empty
				Result.append (headers.key_for_iteration)
				Result.append (": ")
				Result.append (headers.item_for_iteration)
				Result.append ("%N")
				headers.forth
			end
		end

feature --Modification

	add_header(key:STRING_GENERAL; value:STRING_GENERAL) is
		require
			arguments_not_void: key /= Void and value /= Void
			header_is_not_already_present: not has_header (key)
		do
			headers.put (value.to_string_32, key.to_string_32)
		ensure
			header_set: has_header (key) and then get_header (key).is_equal(value.to_string_32)
		end

	modify_header(key:STRING_GENERAL; value: STRING_GENERAL) is
		require
			arguments_not_void: key /= Void and value /= Void
			header_is_already_present: has_header(key)
		do
			headers.replace (value.as_string_32, key.as_string_32)
		ensure
			header_changed: get_header (key).is_equal(value.to_string_32)
		end


feature -- Output

	to_string:STRING_32 is
			-- prints header entry as string_32
		local
			counter: INTEGER
			accumulator: STRING_32
		do
				---put header lines into msgstr for Precursor
			msgstr_lines.wipe_out
			from
				headers.start
				msgstr_lines.start
				create accumulator.make_empty
			until
				headers.after
			loop
				accumulator.wipe_out
				accumulator.append_string (headers.key_for_iteration)
				accumulator.append_string (": ")
				accumulator.append_string (headers.item_for_iteration)
				accumulator.append_string ("\n")
				msgstr_lines.extend (accumulator.twin)
				headers.forth
			end
			Result := Precursor
		end

feature {NONE} -- Implementation

	headers: HASH_TABLE[STRING_32, STRING_32];

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
