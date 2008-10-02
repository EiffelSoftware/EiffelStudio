indexing
	description: "[
		Static class providing helper functions for tags
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_UTILITIES

feature -- Access

	valid_token_chars: !STRING = "_{}()[]:.-"
			-- Valid chars to be used in a token other than alpha numeric

	valid_tag_chars: !STRING
			-- Valid chars for tags other than alpha numeric
		once
			Result := valid_token_chars + split_char.out
		end

	split_char: CHARACTER = '/'
			-- Char used to split tokens in tag

feature -- Query

	is_valid_token (a_string: !STRING): BOOLEAN is
			-- Is given string a valid token?
			--
			-- `a_string': String for which is determined if it is a valid token.
			-- `Result': True if `a_string' represents a valid token, False otherwise.
		local
			i: INTEGER
			c: CHARACTER
		do
			if not a_string.is_empty then
				from
					Result := True
					i := 1
				until
					i > a_string.count or not Result
				loop
					c := a_string.item (i)
					Result := c.is_alpha_numeric or valid_token_chars.has (c)
					i := i + 1
				end
			end
		end

	is_valid_tag (a_string: !STRING): BOOLEAN is
			-- Does a given string represent a valid tag?
			--
			-- Note: an empty string is also considered a valid tag
			--
			-- `a_string': String for which is determined if it is a valid tag.
			-- `Result': True is `a_string' represents a valid tag, False otherwise.
		local
			i: INTEGER
			b: BOOLEAN
			c: CHARACTER
		do
			from
				Result := True
				i := 1
			until
				i > a_string.count or not Result
			loop
				c := a_string.item (i)
				if c.is_alpha_numeric or valid_token_chars.has (c) then
					b := False
				elseif c = split_char then
					if i = 1 or i = a_string.count or b then
						Result := False
					else
						b := True
					end
				else
					Result := False
				end
				i := i + 1
			end
		end

	is_prefix (a_prefix, a_tag: !STRING): BOOLEAN
			-- Does some tag begin with the same tokens as some other tag?
			--
			-- `a_prefix': A valid tag
			-- `a_tag': A valid tag
			-- `Result': True if `a_tag' starts with the tokens found in `a_prefix', False otherwise.
		require
			a_prefix_valid: is_valid_tag (a_prefix)
			a_tag_valid: is_valid_tag (a_tag)
		do
			if a_prefix.is_empty then
				Result := True
			elseif a_tag.count = a_prefix.count then
				Result := a_tag.is_equal (a_prefix)
			elseif a_tag.count > a_prefix.count then
				Result := a_tag.starts_with (a_prefix + split_char.out)
			end
		ensure
			result_correct: Result = (a_tag.is_equal (a_prefix) or
				a_tag.starts_with (a_prefix + split_char.out))
		end

	suffix (a_prefix, a_tag: !STRING): !STRING
			-- Tag containing tokens of `a_tag' whithout leading tokens contained in `a_prefix'
		require
			a_prefix_valid: is_valid_tag (a_prefix)
			a_tag_valid: is_valid_tag (a_tag)
			is_prefix_of_tag: is_prefix (a_prefix, a_tag)
		do
			if a_prefix.is_empty then
				Result := a_tag.twin
			elseif a_prefix.count = a_tag.count then
				create Result.make_empty
			else
				Result := a_tag.substring (a_prefix.count + 2, a_tag.count)
			end
		ensure
			result_valid: is_valid_tag (Result)
			result_correct: a_tag.is_equal (join_tags (a_prefix, Result))
		end

	first_token (a_tag: !STRING): !STRING
			-- First token of `a_tag'
		require
			a_tag_valid: is_valid_tag (a_tag)
			a_tag_not_empty: not a_tag.is_empty
		local
			i: INTEGER
		do
			i := a_tag.index_of (split_char, 1)
			if i > 0 then
				Result := a_tag.substring (1, i - 1)
			else
				create Result.make_from_string (a_tag)
			end
		ensure
			result_valid: is_valid_token (Result)
			result_correct: is_prefix (Result, a_tag)
		end

		-- TODO: add attachement mark for `a_item'
	tag_suffixes (a_list: DS_LINEAR [!STRING]; a_prefix: !STRING): !DS_HASH_SET [!STRING] is
			-- Computed list of all tags for some item, which have certain prefix
			--
			-- `a_item': Item which its tags will be parsed.
			-- `a_prefix': Prefix in form of a tag
			-- `Result': Remaining suffixes of all tags in item which start with prefix
		require
			a_list_valid: a_list.for_all (agent is_valid_tag)
			a_prefix_is_valid_tag: a_prefix.is_empty or else is_valid_tag (a_prefix)
		local
			l_cursor: !DS_LINEAR_CURSOR [!STRING]
			l_tag: !STRING
			l_result: !DS_HASH_SET [!STRING]
		do
			l_cursor ?= a_list.new_cursor
			create l_result.make_default
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_tag := l_cursor.item
				if a_prefix.is_empty then
					l_result.put (l_tag)
				elseif is_prefix (a_prefix, l_tag) then
					l_result.put (suffix (a_prefix, l_tag))
				end
				l_cursor.forth
			end
			Result := l_result
		end

feature -- Basic functionality

	join_tags (a_prefix, a_suffix: !STRING): !STRING
			-- Join `a_prefix' and `a_suffix' to a tag using `split_char'.
		require
			prefix_is_valid_tag: is_valid_tag (a_prefix)
			suffix_is_valid_tag: is_valid_tag (a_suffix)
		do
			if a_prefix.is_empty then
				Result := a_suffix.twin
			elseif a_suffix.is_empty then
				Result := a_prefix.twin
			else
				create Result.make (a_prefix.count + a_suffix.count + 1)
				Result.append (a_prefix)
				Result.append_character (split_char)
				Result.append (a_suffix)
			end
		ensure
			result_valid: is_valid_tag (Result)
			result_correct: suffix (a_prefix, Result).is_equal (a_suffix)
		end

	find_tags_in_string (a_string: !STRING; a_callback: !PROCEDURE [ANY, TUPLE [!STRING]]) is
			-- Extract tags defined in string.
			--
			-- `a_string': String to look for tags.
			-- `a_callback': Routine called once for every tag found in string.
		local
			l_start, l_end: INTEGER
			l_op: TUPLE [!STRING]
			l_char: CHARACTER
		do
			from
				l_start := 1
				l_end := 1
			until
				l_start > a_string.count
			loop
				l_char := a_string.item (l_end)
				if not (l_char.is_alpha_numeric or valid_tag_chars.has (l_char)) then
					if l_end > l_start then
						l_op := [a_string.substring (l_start, l_end-1)]
						if a_callback.valid_operands (l_op) then
							a_callback.call (l_op)
						end
					end
					l_start := l_end + 1
				end
				l_end := l_end + 1
			end
		end

feature -- Constants

	cluster_prefix: STRING = "0cluster:"
	class_prefix: STRING = "1class:"
	feature_prefix: STRING = "2feature:"
	library_prefix: STRING = "4library:"
			-- Eiffel prefixes used in tags

end
