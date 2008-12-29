note
	description: "Delayed domain item"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DELAYED_DOMAIN_ITEM

inherit
	EB_DOMAIN_ITEM
		redefine
			is_delayed_item,
			is_valid,
			is_input_domain_item,
			is_real_delayed_item
		end

create
	make

feature -- Status report

	is_delayed_item: BOOLEAN = True
			-- Is current a delayed item?

	is_valid: BOOLEAN = True
			-- Does current represent a valid domain item?

	is_input_domain_item: BOOLEAN
			-- Does Current delayed item represents an input domain item?
		do
			Result := id.is_empty
		end

	is_real_delayed_item: BOOLEAN
			-- Does Current delayed item represents a real delayed domain item?
		do
			Result := not id.is_empty
		end

feature -- Access

	domain (a_scope: QL_SCOPE): QL_DOMAIN
			-- New query lanaguage domain representing current item
		do
			Result := a_scope.delayed_domain
		end

	query_language_item: QL_ITEM
			-- Query language item representation of current domain item
		do
		end

	group: QL_GROUP
			-- Group to which current domain item belongs
			-- Return Void for delayed item.
		do
		ensure then
			result_not_attached: Result = Void
		end

	string_representation: STRING
			-- Text of current item
		do
			Result := names.l_delayed_item
		end

	sorting_order_index: INTEGER
			-- Sorting order index
		do
			Result := delayed_index
		end

	item_type_name: STRING_GENERAL
			-- Name of type of current item
		do
			Result := names.l_delayed_domain_item
		end

feature{NONE} -- Implemenation

	update
			-- Update status of current item.			
		do
			update_last_compilation_count
		end

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
