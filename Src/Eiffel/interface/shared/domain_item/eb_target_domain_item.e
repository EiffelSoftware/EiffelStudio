note
	description: "Target domain item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TARGET_DOMAIN_ITEM

inherit
	EB_DOMAIN_ITEM
		redefine
			is_target_item,
			is_valid,
			string_representation
		end

	QL_SHARED
		undefine
			is_equal
		end

create
	make

feature -- Status report

	is_target_item: BOOLEAN = True
			-- Is current an application target item?

	is_valid: BOOLEAN
			-- Does current represent a valid domain item?
		do
			update
			Result := id.is_empty or else conf_target /= Void
		end

feature -- Access

	domain (a_scope: QL_SCOPE): QL_DOMAIN
			-- New query lanaguage domain representing current item
		do
			if id.is_empty then
				Result := query_target_item_from_conf_target (universe.target).wrapped_domain
			else
				update
				Result := query_language_item.wrapped_domain
			end
		end

	string_representation: STRING
			-- Text of current item
		do
			update
			Result := string_representation_internal
		end

	query_language_item: QL_ITEM
			-- Query language item representation of current domain item
		do
			update
			Result := query_language_target
		end

	group: QL_GROUP
			-- Group to which current domain item belongs
		do
		ensure then
			result_not_attached: Result = Void
		end

	sorting_order_index: INTEGER
			-- Sorting order index
		do
			Result := target_index
		end

	item_type_name: STRING_GENERAL
			-- Name of type of current item
		do
			Result := names.l_target_domain_item
		end

feature{NONE} -- Implemenation

	update
			-- Update status of current item.			
		do
			if not is_up_to_date then
				query_language_target := Void
				if id.is_empty then
					string_representation_internal := names.l_application_target.twin
				else
					conf_target := target_of_id (id)
					if conf_target /= Void then
						string_representation_internal := conf_target.name
						query_language_target := query_target_item_from_conf_target (conf_target)
					else
						if last_target_name /= Void and then not last_target_name.is_empty then
							string_representation_internal := last_target_name.twin
						else
							string_representation_internal := names.l_invalid_item
						end
					end
				end
				update_last_compilation_count
			end
		end

	conf_target: CONF_TARGET
			-- Configuration target represented by Current

	query_language_target: QL_TARGET;
			-- Query language target represented by Current

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
