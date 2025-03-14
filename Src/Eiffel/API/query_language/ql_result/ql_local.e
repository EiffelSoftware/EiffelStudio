note
	description: "Object that represents a feature local variable used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	QL_LOCAL

inherit
	QL_FEATURE_VARIABLE

create
	make,
	make_with_ast

feature -- Access

	wrapped_domain: QL_LOCAL_DOMAIN
			-- A domain which has current as the only item
		do
			create Result.make
			Result.content.extend (current)
		end

	scope: QL_SCOPE
			-- Scope of current
		do
			Result := local_scope
		ensure then
			good_result: Result = local_scope
		end

	path_name_marker: QL_PATH_MARKER
			-- Marker for `path_name'
		do
			Result := argument_path_marker
		ensure then
			good_result: Result = argument_path_marker
		end

feature -- Status report

	is_visible: BOOLEAN
			-- Is current visible from source domain level?
		do
			if attached {QL_FEATURE} parent as l_feature then
				Result := l_feature.is_visible
			else
				check is_feature: False end
			end
		end

feature -- Visit

	process (a_visitor: QL_VISITOR)
			-- Process `a_visitor'.
		do
			a_visitor.process_local (Current)
		end

feature{NONE} -- Implementation

	path_name_opener: STRING
			-- Opener for `path_name'
		do
			Result := once "local "
		ensure then
			good_result: Result.is_equal ("local ")
		end

	retrieve_ast
			-- Retrieve `ast'.
		do
			internal_ast := type_dec_ast_with_name (name, e_feature.locals)
		end

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
