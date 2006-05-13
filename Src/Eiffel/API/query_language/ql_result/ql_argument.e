indexing
	description: "Object that represents a feature local variable used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_ARGUMENT

inherit
	QL_FEATURE_VARIABLE
		redefine
			wrapped_domain
		end

create
	make,
	make_with_ast

feature -- Access

	wrapped_domain: QL_ARGUMENT_DOMAIN is
			-- A domain which has current as the only item
		do
			create Result.make
			Result.content.extend (current)
		end

	scope: QL_SCOPE is
			-- Scope of current
		do
			Result := local_scope
		ensure then
			good_result: Result = local_scope
		end

	path_name_marker: QL_PATH_MARKER is
			-- Marker for `path_name'
		do
			Result := argument_path_marker
		ensure then
			good_result: Result = argument_path_marker
		end

feature -- Visit

	process (a_visitor: QL_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_argument (Current)
		end

feature{NONE} -- Implementation

	retrieve_ast is
			-- Retrieve `ast'.
		local
			l_argus: EIFFEL_LIST [TYPE_DEC_AS]
			l_feat_body: BODY_AS
		do
			l_feat_body := e_feature.ast.body
			check l_feat_body /= Void end
			l_argus := l_feat_body.arguments
			internal_ast := type_dec_ast_with_name (name, l_argus)
		end

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
                        distributed in the hope that it will be useful,	but
                        WITHOUT ANY WARRANTY; without even the implied warranty
                        of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
                        See the	GNU General Public License for more details.
                        
                        You should have received a copy of the GNU General Public
                        License along with Eiffel Software's Eiffel Development
                        Environment; if not, write to the Free Software Foundation,
                        Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
                ]"
        source: "[
                         Eiffel Software
                         356 Storke Road, Goleta, CA 93117 USA
                         Telephone 805-685-1006, Fax 805-685-6869
                         Website http://www.eiffel.com
                         Customer support http://support.eiffel.com
                ]"


end
