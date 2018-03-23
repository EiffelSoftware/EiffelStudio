note
	description: "Attributes related to condition on custom variables."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CONDITION_CUSTOM_ATTRIBUTES

feature -- Access

	inverted: BOOLEAN assign set_inverted

	is_case_sensitive: BOOLEAN
		do
			inspect match_kind
			when
				default_matching,
				case_sensitive_matching
			then
				Result := True
			else
				-- False otherwise.
			end
		end

	is_case_insensitive: BOOLEAN
		do
			Result := match_kind = case_insensitive_matching
		end

	is_regular_expression: BOOLEAN
		do
			Result := match_kind = regexp_matching
		end

	is_wildcard: BOOLEAN
		do
			Result := match_kind = wildcard_matching
		end

feature -- Status report

	is_known_match_kind (m: like match_kind): BOOLEAN
			-- Is match kind value `m` known?
		do
			inspect m
			when
				case_sensitive_matching,
				case_insensitive_matching,
				regexp_matching,
				wildcard_matching
			then
				Result := True
			else
				-- False otherwise.
			end
		ensure
			instance_free: class
		end

	is_match_set: BOOLEAN
			-- Has an explicit match value been set?
		do
			Result := is_known_match_kind (match_kind)
		end

feature -- Comparison type

	match_kind: NATURAL_8

	default_matching: NATURAL_8 = 0
	case_sensitive_matching: NATURAL_8 = 1
	case_insensitive_matching: NATURAL_8 = 2
	regexp_matching: NATURAL_8 = 3
	wildcard_matching: NATURAL_8 = 4

feature -- Element change

	set_inverted (b: like inverted)
		do
			inverted := b
		end

	set_match (m: like match_kind)
			-- Set `match_kind` to `m`.
		require
			is_known_match_kind: is_known_match_kind (m)
		do
			match_kind := m
		ensure
			match_kind_set: match_kind = m
		end

	unset_match
			-- Unset `match_kind`.
		do
			match_kind := default_matching
		ensure
			match_kind_unset: not is_match_set
		end

invariant
	single_match_value: 1 =
		is_case_sensitive.to_integer +
		is_case_insensitive.to_integer +
		is_regular_expression.to_integer +
		is_wildcard.to_integer

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
