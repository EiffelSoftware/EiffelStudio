note
	description: "Folder doman item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FOLDER_DOMAIN_ITEM

inherit
	EB_DOMAIN_ITEM
		redefine
			is_folder_item,
			is_valid,
			string_representation,
			make
		end

create
	make

feature{NONE} -- Initialization

	make (a_id: STRING)
			-- Initialize `id' with `a_id'.
		do
			Precursor (a_id)
			is_recursive_internal := True
		ensure then
			is_recursive_internal_set: is_recursive_internal
		end

feature -- Status report

	is_folder_item: BOOLEAN = True
			-- Is current a folder item?

	is_valid: BOOLEAN
			-- Does current represent a valid domain item?
		do
			update
			Result := folder_internal /= Void
		end

	is_recursive: BOOLEAN
			-- Is search for classes in current folder recursive?
		do
			Result := is_recursive_internal
		ensure
			good_result: Result = is_recursive_internal
		end

feature -- Access

	domain (a_scope: QL_SCOPE): QL_DOMAIN
			-- New query lanaguage domain representing current item
		local
			l_class_domain_generator: QL_CLASS_DOMAIN_GENERATOR
			l_folder: EB_FOLDER
		do
			l_folder := folder_internal
			create l_class_domain_generator.make (create{QL_CLASS_PATH_IN_CRI}.make_with_flag (l_folder.path, is_recursive), True)
			Result := query_group_item_from_conf_group (l_folder.cluster).wrapped_domain.new_domain (l_class_domain_generator)
		end

	string_representation: STRING
			-- Text of current item
		do
			update
			Result := string_representation_internal
		end

	folder: EB_FOLDER
			-- Folder item for current
		require
			valid: is_valid
		do
			update
			Result := folder_internal
		ensure
			result_attached: Result /= Void
		end

	query_language_item: QL_ITEM
			-- Query language item representation of current domain item
		do
			update
			Result := query_language_item_internal
		end

	group: QL_GROUP
			-- Group to which current domain item belongs
			-- Return the group where current folder is located.
		do
			Result ?= query_language_item
		ensure then
			result_attached: Result /= Void
		end

	sorting_order_index: INTEGER
			-- Sorting order index
		do
			Result := folder_index
		end

	item_type_name: STRING_GENERAL
			-- Name of type of current item
		do
			Result := names.l_folder_domain_item
		end

feature -- Setting

	enable_search_for_class_recursive
			-- Enable that search for classes in current folder is recursive.
		do
			is_recursive_internal := True
		ensure
			recursive_search_enabled: is_recursive
		end

	disable_search_for_class_recursive
			-- Disable that search for classes in current folder is recursive.
		do
			is_recursive_internal := False
		ensure
			recursive_search_disabled: not is_recursive
		end

feature{NONE} -- Implemenation

	update
			-- Update status of current item.			
		do
			if not is_up_to_date then
				folder_internal := folder_of_id (id)
				if folder_internal /= Void then
					query_language_item_internal := query_group_item_from_conf_group (folder_internal.cluster)
					string_representation_internal := folder_internal.name
				else
					query_language_item_internal := Void
					if last_folder_name /= Void and then not last_folder_name.is_empty then
						string_representation_internal := last_folder_name.twin
					else
						string_representation_internal := names.l_invalid_item
					end
				end
				update_last_compilation_count
			end
		end

	folder_internal: EB_FOLDER;
			-- Folder represented by `id'

	is_recursive_internal: BOOLEAN
			-- Implementation of `is_recursive'

	query_language_item_internal: like query_language_item;
			-- Implementation of `query_language_item'

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
