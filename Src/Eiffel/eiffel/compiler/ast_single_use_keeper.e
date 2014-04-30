note
	description: "Keeper for a single use of an expression with location."

class AST_SINGLE_USE_KEEPER

inherit
	AST_STACKED_SCOPE_KEEPER [TUPLE [is_used: BOOLEAN; location: detachable LOCATION_AS; written_feature: detachable FEATURE_I]]
		rename
			has_unset as has_unused,
			is_attached as is_used_n,
			start_scope as use_n,
			stop_scope as unuse_n,
			set_all as use_all
		end

create
	make

feature -- Access

	is_used: BOOLEAN
		do
			Result := scope.is_used
		end

	is_used_n (index: like count): BOOLEAN
			-- Is a variable with the given `index' is used?
		do
			Result := is_used
		end

	has_unused: BOOLEAN
			-- Are there any unused variables?
		do
			Result := not is_used
		end

	has_unset_index (min_index, max_index: like count): BOOLEAN
			-- <Precursor>
		do
			Result := not is_used
		end

	location: detachable LOCATION_AS
			-- Location of a used expression.
		do
			if attached scope as s then
				Result := s.location
			end
		end

	written_feature: detachable FEATURE_I
			-- Feature where an expression is used.
		do
			if attached scope as s then
				Result := s.written_feature
			end
		end

feature -- Status report: variables

	max_count: INTEGER = 1
			-- <Precursor>

feature {NONE} -- Status report

	is_dominating: BOOLEAN
			-- <Precursor>
		do
			Result := scope.is_used implies inner_scopes.item.is_used
		end

feature -- Modification: variables

	use (l: LOCATION_AS; f: FEATURE_I)
			-- Mark that an expression is used at location `l' in feature `f'.
		do
			scope.is_used := True
			scope.location := l
			scope.written_feature := f
		end

	use_n (index: like count)
			-- Mark that an expression is used.
		do
			scope.is_used := True
		end

	unuse
			-- Mark that an expression is unused.
		do
			scope.is_used := False
		end

	unuse_n (index: like count)
			-- Mark that an expression is unused.
		do
			unuse
		end

	use_all
			-- Mark that an expression is used.
		do
			use_n (1)
		end

feature {NONE} -- Modification: nesting

	merge_siblings
			-- Merge sibling scope information from `scope'
			-- into `inner_scopes.item'.
		do
			if not inner_scopes.item.is_used then
				inner_scopes.replace (scope)
			end
		end

feature {NONE} -- Initialization

	new_scope (n: like count): like scope
		local
			l: detachable LOCATION_AS
			f: detachable FEATURE_I
		do
			Result := [False, l, f]
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
