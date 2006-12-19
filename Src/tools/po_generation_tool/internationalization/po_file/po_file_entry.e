indexing
	description: "[
				A representation of the parts common to all types of entry in a .po file - comments and msgid (original string in singular form)
				When inheriting from this class, call initialize_datastructures in your creation procedure!
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PO_FILE_ENTRY

feature --Creation

	make(a_msgid:STRING_GENERAL) is
		require
			argument_not_void: a_msgid /= Void
		do
			initialize_datastructures
			set_msgid (a_msgid)
		ensure
			msgid_set: a_msgid.as_string_32.is_equal(msgid)
		end

feature {NONE} --Set msgid

	set_msgid(a_msgid:STRING_GENERAL) is
			-- Create a new PO_FILE_ENTRY with given msgid
		require
			a_msgid_not_void: a_msgid /= Void
		do
			create msgid_lines.make
			msgid_lines.append (break_line (a_msgid.as_string_32))
		ensure
			a_msgid_set: msgid.is_equal (a_msgid.as_string_32)
		end

feature	-- Modification

	add_user_comment(a_comment:STRING_GENERAL) is
			-- add a user comment line (this will be wrapped onto several comment lines if it is too long)
			-- these comments are intended to be used for communication between translators
		require
			comment_not_void: a_comment /= Void
		local
			lines: LINKED_LIST[STRING_32]
			temporary: STRING_32
		do
			lines := break_line (a_comment.as_string_32)
			from
				lines.start
			until
				lines.after
			loop
				temporary := lines.item
				temporary.prepend_string ("# ")
				lines.replace (temporary)
				lines.forth
			end
			user_comments.append (lines)
		end

	add_reference_comment(a_comment:STRING_GENERAL) is
			-- add a reference comment line (this will be not be wrapped)
			-- This should give the location of the string
			--  ideally in FILENAME:linenumber form
			-- optional and ignored by msgfmt
		require
			comment_not_void: a_comment /= Void
		local
			temporary: STRING_32
		do
			temporary := "#: "
			temporary.append_string (a_comment.to_string_32)
			reference_comments.extend (temporary)
		end

	add_automatic_comment(a_comment:STRING_GENERAL) is
			-- add a automatic comment line (this will be not be wrapped)
			-- fantastic GNU documentation does not say anything about this
			-- type of header apart from the fact that "GNU tools" create and
			-- maintain them. Use at own risk.
		require
			comment_not_void: a_comment /= Void
		local
			temporary: STRING_32
		do
			temporary := a_comment.to_string_32
			temporary.prepend_string ("#. ")
			automatic_comments.extend (temporary)
		end


	set_fuzzy(new:BOOLEAN) is
			-- sets the "fuzzy" flag (this indicates doubts about the translation)
		do
			fuzzy := new
		ensure
			fuzzy_set: new = fuzzy
		end

	set_c_format(new:BOOLEAN) is
			-- sets the "c-format" flag (this indicates a string that is used as an argument for
			-- a 'printf'-type function and causes msgfmt to do some extra checks on the string)
		do
			c_format := new
		ensure
			c_format_set: c_format = new
		end

feature --Indexes

	msgid: STRING_32 is
		do
			Result := unbreak_line(msgid_lines)
		end

feature	-- Output

	to_string:STRING_32 is
				-- Output the entry as a unicode string
		do
			create Result.make_empty
 				--start with 2 lines of whitespace
 			Result.prepend_string("%N%N")
 				--first we must print the translator comments
 			Result.append_string (prepare_headers (user_comments))
 			Result.append_string (prepare_headers (automatic_comments))
 			Result.append_string (prepare_headers (reference_comments))
				-- now the msgid
			Result.append_string(prepare_string("msgid", msgid_lines))
		end

feature --Flags

	fuzzy: BOOLEAN
	c_format: BOOLEAN

feature {NONE} -- Internal formatting

	wrap_line(line:STRING_32):LINKED_LIST[STRING_32] is
			-- wraps a line into more sensible chunks
		require
			line_not_void: line /= Void
		local
			words: ARRAY[TUPLE[INTEGER, INTEGER]]
		do
				--  simple algorithm:
				--	1: break line into words
				--		implementation: array holding integers representing start & length of word
				--		We wish to keep spaces, as they are part of the string, so a "word" for our purposes
				--		contains all whitespace until the next real word
				--	2: place words in line on a greedy basis. It is also possible to do this with dynamic programming

				--parse line and fill words array
			 create words.make (1, 20)
		end

	break_line(line:STRING_32):LINKED_LIST[STRING_32] is
			-- breaks a line into 78-character chunks and returns them in a list
			-- NOTE: this will break in the middle of words.
		local
			linear : LINEAR[WIDE_CHARACTER]
			counter: INTEGER
			accumulator: STRING_32
		do
			accumulator := ""
			create Result.make
			if line.count <= 78 then
				Result.extend (line.as_string_32)
			else
				linear :=	line.linear_representation
				from
					linear.start
					counter := 1
				until
					linear.after
				loop
					accumulator.extend (linear.item)
					if counter >= 78 then
						Result.extend (accumulator)
						accumulator := ""
						counter := 1
					end
					linear.forth
					counter := counter + 1
				end
				if not accumulator.is_empty then
					Result.extend(accumulator)
				end
			end
		end

	unbreak_line( list: LINEAR[STRING_GENERAL]):STRING_32 is
			-- undo effects of break_line
		require
			argument_not_void: list /= Void
		do
			from
				list.start
				Result := ""
			until
				list.after
			loop
				Result.append (list.item.as_string_32)
				list.forth
			end
		end


	prepare_headers (headers:LINKED_LIST[STRING_32]):STRING_32 is
		require
			argument_not_void: headers /=Void
		do
			create Result.make_empty
			from
				headers.start
			until
				headers.after
			loop
				Result.append_string(headers.item)
				Result.append_string("%N")
				headers.forth
			end
		end

	prepare_string (key: STRING_32; string: LINKED_LIST[STRING_32]):STRING_32 is
		require
			argument_not_void: string /= Void
			key_not_void: key /= Void
		do
			create Result.make_empty
				-- can we fit all on one line?
			if string.count = 1 and (string.first.count + key.count +3) <= 80 then
				Result.append_string(key)
				Result.append_string(" %"")
				Result.append_string(string.first)
				Result.append_string("%"%N")
			else
				Result.append_string(key)
				Result.append_string(" %"%"%N")
				from
					string.start
				until
					string.after
				loop
					Result.append_string("%"")
					Result.append_string(string.item)
					Result.append_string("%"%N")
					string.forth
				end
			end
		end

feature  {NONE} -- Implementation datastructures

	user_comments: LINKED_LIST[STRING_32]
	automatic_comments: LINKED_LIST[STRING_32]
	reference_comments: LINKED_LIST[STRING_32]
	msgid_lines: LINKED_LIST[STRING_32]

	initialize_datastructures is
			-- creates the various lists
		do
			create user_comments.make
			create automatic_comments.make
			create reference_comments.make
			create msgid_lines.make
		end

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
