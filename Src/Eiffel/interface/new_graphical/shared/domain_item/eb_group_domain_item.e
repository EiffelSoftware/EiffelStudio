indexing
	description: "Group domain item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GROUP_DOMAIN_ITEM

inherit
	EB_DOMAIN_ITEM
		redefine
			is_group_item,
			is_valid,
			string_representation
		end

create
	make

feature -- Status report

	is_group_item: BOOLEAN is True
			-- Is current a group item?

	is_valid: BOOLEAN is
			-- Does current represent a valid domain item?
		do
			update
			Result := conf_group /= Void
		end

feature -- Access

	domain (a_scope: QL_SCOPE): QL_DOMAIN is
			-- New query lanaguage domain representing current item
		do
			Result := ql_group.wrapped_domain
		end

	string_representation: STRING is
			-- Text of current item
		do
			update
			Result := string_representation_internal
		end

	ql_group: QL_GROUP is
			-- Query language item of current
		require
			valid: is_valid
		do
			update
			Result := ql_group_internal
		ensure
			result_attached: Result /= Void
		end

	query_language_item: QL_ITEM is
			-- Query language item representation of current domain item
		do
			Result := ql_group
		end

	group: QL_GROUP is
			-- Group to which current domain item belongs
			-- Return group itself.
		do
			Result ?= query_language_item
		ensure then
			result_attached: Result /= Void
		end

feature{NONE} -- Implemenation

	update is
			-- Update status of current item.			
		do
			if not is_up_to_date then
				conf_group := group_of_id (id)
				if conf_group /= Void then
					ql_group_internal := query_group_item_from_conf_group (conf_group)
					string_representation_internal := conf_group.name
				else
					if last_group_name /= Void and then not last_group_name.is_empty then
						string_representation_internal := last_group_name.twin
					else
						string_representation_internal := interface_names.l_invalid_item
					end
					ql_group_internal := Void
				end
				update_last_compilation_count
			end
		end

	conf_group: CONF_GROUP
			-- Configuration group represented by Current

	ql_group_internal: QL_GROUP;
			-- Query language group represented by Current

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
