indexing
	description:
		"Strings represented as a list of words."
	author: "brendel"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_STRING

inherit
	STRING
		select
			is_equal, out, copy, has,
			changeable_comparison_criterion, object_comparison,
			linear_representation, empty
		end

	LINEAR [EB_STRING]
		rename
			item as word_item,
			has as has_word,
			linear_representation as word_list,
			occurrences as word_occurrences,
			index_of as index_of_word,
			empty as old_empty,
			out as old_out,
			copy as old_copy,
			changeable_comparison_criterion as old_changeable_comparison_criterion,
			is_equal as old_is_equal,
			object_comparison as old_object_comparison
		undefine
			compare_references,
			compare_objects
		end

create
	make,
	make_from_string

feature -- Access

	word_item: EB_STRING
			-- Item at current position

	trailing_phrase: EB_STRING
			-- Characters not part of current `word_item' immediately
			-- following it. Could be whitespace or a dot or quotes,
			-- parentheses, etc.

	leading_phrase: EB_STRING
			-- Characters not part of current `word_item' immediately
			-- preceding it.

	index: INTEGER
			-- Index of current character.
			-- Used to iterate over characters when iterating over words.

feature -- Status report

	after: BOOLEAN
			-- Is there no valid position to the right of current one?

	is_email_address: BOOLEAN is
			-- Is `Current' an e-mail address?
		local
			i: INTEGER
		do
			if count >= 3 then
				i := index_of ('@', 2)
				if i > 0 and then i < count - 2 then
					i := index_of ('.', i + 2)
					if i > 0 then
						Result := count > i
					end
				end
			end
		end

	is_url: BOOLEAN is
			-- Is `Current' an URL?
		local
			first_four, first_five: STRING
		do
			first_four := substring (1, 4)
			first_five := substring (1, 5)
			Result := first_four.is_equal ("www.")
				or else first_five.is_equal ("http:")
				or else first_four.is_equal ("ftp:")
				or else first_five.is_equal ("file:")
		end

	is_class_name: BOOLEAN is
			-- Could `Current' be the name of a class?
			-- i.e. Does `Current' consist of only underscores, uppercases and digits.
		local
			i: INTEGER
			c: CHARACTER
		do
			Result := True
			from i := 1 until not Result or else i > count loop
				c := item (i)
				i := i + 1
				Result := c = '_' or else c.is_upper or else c.is_digit
			end
		end

	is_plural_class: BOOLEAN is
			-- Is `Current' be the name of a class followed by `s'?
		do
			if not is_empty and then item (count) = 's' then
				Result := (create {EB_STRING}.make_from_string (substring (1, count - 1))).is_class_name
			end
		end

	is_feature_name: BOOLEAN is
			-- Could `Current' be the name of a feature?
		local
			i: INTEGER
			c: CHARACTER
		do
			Result := True
			from i := 1 until not Result or else i > count loop
				c := item (i)
				i := i + 1
				Result := c = '_' or else c.is_alpha or else c.is_digit
			end
		end

	is_dot_feature_name: BOOLEAN is
			-- Could `Current' be the name of a feature leaded by a dot?
			-- i.e. is the first character a dot and do the rest of
			-- the characters consist of only underscores, alphanumericals and digits?
		do
			if not is_empty and then item (1) = '.' then
				Result := (create {EB_STRING}.make_from_string (substring (2, count))).is_feature_name
			end
		end

	is_class_dot_feature_name: BOOLEAN is
			-- Could `Current' be the name of a class and feature separated by a dot?
		local
			i: INTEGER
			cs, fs: EB_STRING
		do
			if count >= 3 then
				i := index_of ('.', 2)
				if i > 0 then
					create cs.make_from_string (substring (1, i - 1))
					create fs.make_from_string (substring (i + 1, count))
					Result := cs.is_class_name and then fs.is_feature_name
				end
			end
		end

	is_item_delimited_by (sd, ed: CHARACTER): BOOLEAN is
			-- Does leading phrase end with `sd' and does trailing phrase start with `ed'.
		require
			leading_phrase_not_void: leading_phrase /= Void
			trailing_phrase_not_void: trailing_phrase /= Void
		do
			Result :=
				not leading_phrase.is_empty
				and then leading_phrase @ leading_phrase.count = sd
				and then not trailing_phrase.is_empty
				and then trailing_phrase @ 1 = ed
		end

feature -- Removal

	remove_item_delimiters is
			-- Remove last character of `leading_phrase' and first character of `trailing_phrase'.
		require
			leading_phrase_has_char: leading_phrase /= Void and then not leading_phrase.is_empty
			trailing_phrase_has_char: trailing_phrase /= Void and then not trailing_phrase.is_empty
		do
			leading_phrase.head (leading_phrase.count - 1)
			trailing_phrase.tail (trailing_phrase.count - 1)
		end

feature -- Cursor movement

	start is
			-- Move to first position if any.
		local
			c: CHARACTER
		do
			index := 1
			after := False
			create leading_phrase.make (2)
			create word_item.make (5)
			create trailing_phrase.make (2)
			from
				c := item (index)
			until
				index > count or else not phrase_characters.has (c)
			loop
				trailing_phrase.extend (c)
				index := index + 1
				if index <= count then
					c := item (index)
				end
			end
			forth
		end

	finish is
			-- Move to last position.
		do
			from until index > count loop forth end
		end

	forth is
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		local
			c: CHARACTER
		do
			leading_phrase := trailing_phrase
			if index > count then
				after := True
			else
				c := item (index)
				from
					word_item.wipe_out
				until
					index > count or else phrase_characters.has (c)
				loop
					word_item.extend (c)
					index := index + 1
					if index <= count then
						c := item (index)
					end
				end
				from
					create trailing_phrase.make (3)
				until
					index > count or else not phrase_characters.has (c)
				loop
					trailing_phrase.extend (c)
					index := index + 1
					if index <= count then
						c := item (index)
					end
				end
				from
				until
					word_item.is_empty or else word_item.item (word_item.count) /= '.'
				loop
					trailing_phrase.precede ('.')
					word_item.head (word_item.count - 1)
				end
			end
		end

feature {NONE} -- Implementation

	phrase_characters: LINKED_LIST [CHARACTER] is
			-- List of characters that should be considered separators of words.
			-- Please note that a dot is not part of this set since it is a part
			-- of a number, URL or email address. Trailing dots at the end of a word
			-- are NOT part of the word, though.
		once
			create Result.make
			Result.extend (' ')
			Result.extend ('%N')
			Result.extend ('%T')
			Result.extend ('"')
			Result.extend ('`')
			Result.extend ('%'')
			Result.extend ('<')
			Result.extend ('>')
			Result.extend ('(')
			Result.extend (')')
			Result.extend ('[')
			Result.extend (']')
			Result.extend ('{')
			Result.extend ('}')
			Result.extend (',')
		end

invariant
	index_within_bounds: index >= 0 and then index <= count + 1

end -- class EB_STRING
