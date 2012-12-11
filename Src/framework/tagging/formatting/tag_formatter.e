note
	description: "Summary description for {TAG_FORMATTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAG_FORMATTER

inherit
	TAG_CONVERSION

feature -- Access

	validator: TAG_VALIDATOR
			-- Validator for checking tags
		deferred
		ensure
			result_attached: Result /= Void
		end

	item_prefix: IMMUTABLE_STRING_32
			-- Prefix for item tokens
		do
			create Result.make_from_string_32 (once {STRING_32}"item:")
		end

feature -- Query

	is_valid_token (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is given string a valid token?
			--
			-- `a_string': String for which is determined if it is a valid token.
			-- `Result': True if `a_string' represents a valid token, False otherwise.
		require
			a_string_attached: a_string /= Void
		do
			Result := not a_string.is_empty
		ensure
			result_implies_not_empty: Result implies not a_string.is_empty
			result_implies_valid_tag: Result implies validator.is_valid_tag (a_string)
		end

	is_prefix (a_prefix, a_tag: READABLE_STRING_GENERAL): BOOLEAN
			-- Does some tag begin with the same tokens as some other tag?
			--
			-- `a_prefix': A valid tag
			-- `a_tag': A valid tag
			-- `Result': True if `a_tag' starts with the tokens found in `a_prefix', False otherwise.
		require
			a_prefix_valid: a_prefix.is_empty or else validator.is_valid_tag (a_prefix)
			a_tag_valid: a_tag.is_empty or else validator.is_valid_tag (a_tag)
		deferred
		ensure
			result_implies_valid_count: Result implies a_prefix.count <= a_tag.count
			result_implies_starts_with: Result implies a_tag.substring (1, a_prefix.count).same_string (a_prefix)
		end

feature -- Basic operations

	suffix (a_prefix, a_tag: READABLE_STRING_GENERAL): STRING_32
			-- Tag containing tokens of `a_tag' whithout leading tokens contained in `a_prefix'
		require
			a_prefix_valid: a_prefix.is_empty or else validator.is_valid_tag (a_prefix)
			a_tag_valid: a_tag.is_empty or else validator.is_valid_tag (a_tag)
			is_prefix_of_tag: is_prefix (a_prefix, a_tag)
		deferred
		ensure
			result_valid: Result.is_empty or else validator.is_valid_tag (Result)
			result_correct: a_tag.same_string (join_tags (a_prefix, Result))
		end

	first_token (a_tag: READABLE_STRING_GENERAL): STRING_32
			-- First token of `a_tag'
		require
			a_tag_valid: validator.is_valid_tag (a_tag)
		deferred
		ensure
			result_valid: is_valid_token (Result)
			result_correct: is_prefix (Result, a_tag)
		end

	join_tags (a_prefix, a_suffix: READABLE_STRING_GENERAL): STRING_32
			-- Join `a_prefix' and `a_suffix' to a tag using `split_char'.
		require
			prefix_is_valid_tag: a_prefix.is_empty or else validator.is_valid_tag (a_prefix)
			suffix_is_valid_tag: a_suffix.is_empty or else validator.is_valid_tag (a_suffix)
		do
			if a_prefix.is_empty or a_suffix.is_empty then
				if a_prefix.is_empty then
					create Result.make_from_string_general (a_suffix)
				else
					create Result.make_from_string_general (a_prefix)
				end
			else
				create Result.make (a_prefix.count + a_suffix.count + 1)
				Result.append_string_general (a_prefix)
				append_tag (Result, a_suffix)
			end
		ensure
			result_valid: Result.is_empty or else validator.is_valid_tag (Result)
			result_correct: a_suffix.same_string (suffix (a_prefix, Result))
		end

	append_tag (a_prefix: STRING_GENERAL; a_suffix: READABLE_STRING_GENERAL)
			-- Append `a_suffix' to the end of `a_prefix' resulting in a valid tag.
		require
			prefix_is_valid_tag: validator.is_valid_tag (a_prefix)
			suffix_is_valid_tag: validator.is_valid_tag (a_suffix)
		deferred
		ensure
			a_prefix_valid: validator.is_valid_tag (a_prefix)
			a_prefix_has_valid_count: a_prefix.count >= old a_prefix.count + a_suffix.count
			a_prefix_starts_with_old_prefix: a_prefix.substring (1, old a_prefix.count).same_string (old immutable_string (a_prefix))
			a_prefix_ends_with_suffix: a_prefix.substring (a_prefix.count - a_suffix.count + 1, a_prefix.count).same_string (a_suffix)
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
