note
	description: "Attributes related to condition on custom variables."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CONDITION_CUSTOM_ATTRIBUTES

feature -- Access

	inverted: BOOLEAN assign set_inverted

	is_regular_expression: BOOLEAN assign set_is_regular_expression
		do
			Result := match_kind = regexp_matching
		end

	is_wildcard: BOOLEAN assign set_is_wildcard
		do
			Result := match_kind = wildcard_matching
		end

	is_case_sensitive: BOOLEAN assign set_is_case_sensitive
		do
			Result := match_kind = case_sensitive_matching
		end

	is_case_insensitive: BOOLEAN assign set_is_case_insensitive
		do
			Result := match_kind = case_insensitive_matching
		end

feature -- Comparison type

	match_kind: NATURAL_8

	case_sensitive_matching: NATURAL_8 = 0 -- Default
	case_insensitive_matching: NATURAL_8 = 1
	regexp_matching: NATURAL_8 = 2
	wildcard_matching: NATURAL_8 = 3

feature -- Element change

	set_inverted (b: like inverted)
		do
			inverted := b
		end

	set_is_regular_expression (b: like is_regular_expression)
		do
			if b then
				match_kind := regexp_matching
			elseif match_kind = regexp_matching then
				match_kind := 0
			end
		end

	set_is_wildcard (b: like is_wildcard)
		do
			if b then
				match_kind := wildcard_matching
			elseif match_kind = wildcard_matching then
				match_kind := 0
			end
		end

	set_is_case_sensitive (b: like is_case_sensitive)
		do
			if b then
				match_kind := case_sensitive_matching
			elseif match_kind = case_sensitive_matching then
				match_kind := 0
			end
		end

	set_is_case_insensitive (b: like is_case_insensitive)
		do
			if b then
				match_kind := case_insensitive_matching
			elseif match_kind = case_insensitive_matching then
				match_kind := 0
			end
		end

invariant
	(is_regular_expression xor is_case_sensitive xor is_case_insensitive)
note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
