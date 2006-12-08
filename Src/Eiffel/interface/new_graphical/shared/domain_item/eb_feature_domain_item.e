indexing
	description: "Feature domain item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_DOMAIN_ITEM

inherit
	EB_DOMAIN_ITEM
		redefine
			is_feature_item,
			is_valid,
			string_representation
		end

	QL_SHARED_SCOPES
		undefine
			is_equal
		end

	SHARED_TEXT_ITEMS
		undefine
			is_equal
		end

create
	make

feature -- Status report

	is_feature_item: BOOLEAN is True
			-- Is current a feature item?

	is_valid: BOOLEAN is
			-- Does current represent a valid domain item?
		do
			Result := feature_of_id (id) /= Void
		end

feature -- Access

	domain (a_scope: QL_SCOPE): QL_DOMAIN is
			-- New query lanaguage domain representing current item
		do
			Result := ql_feature.wrapped_domain
		end

	string_representation: STRING is
			-- Text of current item
		local
			l_feature_name: STRING
			l_class_name: STRING
		do
			if feature_of_id (id) /= Void then
				Result := ql_feature.name
			else
				l_feature_name := last_feature_name
				if l_feature_name /= Void and then not l_feature_name.is_empty then
					Result := l_feature_name.twin
					l_class_name := last_class_name
					if l_class_name /= Void and then not l_class_name.is_empty then
						Result.prepend (ti_l_curly + l_class_name.twin + ti_r_curly + ti_dot)
					end
				else
					Result := Precursor
				end
			end
		end

	ql_feature: QL_FEATURE is
			-- QL_FEATURE object representing current item
		require
			valid: is_valid
		local
			l_e_feature: E_FEATURE
		do
			l_e_feature := feature_of_id (id)
			check l_e_feature /= Void end
			Result := query_feature_item_from_e_feature (l_e_feature)
		ensure
			result_attached: Result /= Void
		end

	query_language_item: QL_ITEM is
			-- Query language item representation of current domain item
		do
			Result := ql_feature
		end

	group: QL_GROUP is
			-- Group to which current domain item belongs
			-- Return the group where current feature's associated is located.
		do
			check
				query_language_item.parent /= Void
				query_language_item.parent.parent /= Void
			end
			Result ?= query_language_item.parent.parent
		ensure then
			result_attached: Result /= Void
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
