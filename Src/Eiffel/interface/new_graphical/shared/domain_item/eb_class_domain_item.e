indexing
	description: "Class domain item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_DOMAIN_ITEM

inherit
	EB_DOMAIN_ITEM
		redefine
			is_class_item,
			is_valid,
			string_representation
		end

create
	make

feature -- Status report

	is_class_item: BOOLEAN is True
			-- Is current a class item?

	is_valid: BOOLEAN is
			-- Does current represent a valid domain item?			
		do
			update
			Result := conf_class /= Void
		end

feature -- Access

	domain (a_scope: QL_SCOPE): QL_DOMAIN is
			-- New query lanaguage domain representing current item
		do
			Result := ql_class.wrapped_domain
		end

	string_representation: STRING is
			-- Text of current item
		do
			update
			Result := string_representation_internal
		end

	ql_class: QL_CLASS is
			-- QL_CLASS object representing current item
		require
			valid: is_valid
		do
			update
			Result := query_class_item
		end

	query_language_item: QL_ITEM is
			-- Query language item representation of current domain item
		do
			Result := ql_class
		end

	group: QL_GROUP is
			-- Group to which current domain item belongs
			-- Return the group where current class is located.
		do
			Result ?= query_language_item.parent
		ensure then
			result_attached: Result /= Void
		end

feature{NONE} -- Implemenation

	update is
			-- Update status of current item.			
		do
			if not is_up_to_date then
				conf_class := class_of_id (id)
				if conf_class /= Void then
					query_class_item := query_class_item_from_conf_class (conf_class)
					string_representation_internal := query_class_item.name
				else
					if last_class_name /= Void and then not last_class_name.is_empty then
						string_representation_internal := last_class_name.twin
					else
						string_representation_internal := interface_names.l_invalid_item
					end
					query_class_item := Void
				end
				update_last_compilation_count
			end
		end

	conf_class: CONF_CLASS
			-- Class represented by `id'

	query_class_item: QL_CLASS
			-- Query language class item represented by `id'

invariant
	class_exists: is_valid implies conf_class /= Void

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
