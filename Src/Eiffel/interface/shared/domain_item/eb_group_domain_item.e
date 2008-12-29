note
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

	is_group_item: BOOLEAN = True
			-- Is current a group item?

	is_valid: BOOLEAN
			-- Does current represent a valid domain item?
		do
			update
			Result := conf_group /= Void
		end

feature -- Access

	domain (a_scope: QL_SCOPE): QL_DOMAIN
			-- New query lanaguage domain representing current item
		do
			Result := ql_group.wrapped_domain
		end

	string_representation: STRING
			-- Text of current item
		do
			update
			Result := string_representation_internal
		end

	ql_group: QL_GROUP
			-- Query language item of current
		require
			valid: is_valid
		do
			update
			Result := ql_group_internal
		ensure
			result_attached: Result /= Void
		end

	query_language_item: QL_ITEM
			-- Query language item representation of current domain item
		do
			Result := ql_group
		end

	group: QL_GROUP
			-- Group to which current domain item belongs
			-- Return group itself.
		do
			Result ?= query_language_item
		ensure then
			result_attached: Result /= Void
		end

	sorting_order_index: INTEGER
			-- Sorting order index
		do
			update
			if is_valid then
				if conf_group.is_cluster then
					Result := cluster_index
				elseif conf_group.is_library then
					Result := library_index
				elseif conf_group.is_assembly then
					Result := assembly_index
				end
			else
				Result := cluster_index
			end
		end

	item_type_name: STRING_GENERAL
			-- Name of type of current item
		do
			Result := names.l_group_domain_item
		end

feature{NONE} -- Implemenation

	update
			-- Update status of current item.			
		do
			if not is_up_to_date then
				conf_group := group_of_id (id)
				if conf_group /= Void and then conf_group.is_valid then
					ql_group_internal := query_group_item_from_conf_group (conf_group)
					string_representation_internal := conf_group.name
				else
					conf_group := Void
					if last_group_name /= Void and then not last_group_name.is_empty then
						string_representation_internal := last_group_name.twin
					else
						string_representation_internal := names.l_invalid_item
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

note
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
