indexing
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
			string_representation
		end

create
	make

feature -- Status report

	is_folder_item: BOOLEAN is True
			-- Is current a folder item?

	is_valid: BOOLEAN is
			-- Does current represent a valid domain item?
		do
			update
			Result := folder_internal /= Void
		end

feature -- Access

	domain (a_scope: QL_SCOPE): QL_DOMAIN is
			-- New query lanaguage domain representing current item
		local
			l_class_domain_generator: QL_CLASS_DOMAIN_GENERATOR
			l_folder: EB_FOLDER
		do
			l_folder := folder_internal
			create l_class_domain_generator.make (create{QL_CLASS_PATH_IN_CRI}.make (l_folder.path), True)
			Result := query_group_item_from_conf_group (l_folder.cluster).wrapped_domain.new_domain (l_class_domain_generator)
		end

	string_representation: STRING is
			-- Text of current item
		do
			update
			Result := string_representation_internal
		end

	folder: EB_FOLDER is
			-- Folder item for current
		require
			valid: is_valid
		do
			update
			Result := folder_internal
		ensure
			result_attached: Result /= Void
		end

	query_language_item: QL_ITEM is
			-- Query language item representation of current domain item
		do
			update
			Result := query_language_item_internal
		end

	group: QL_GROUP is
			-- Group to which current domain item belongs
			-- Return the group where current folder is located.
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
				folder_internal := folder_of_id (id)
				if folder_internal /= Void then
					query_language_item_internal := query_group_item_from_conf_group (folder_internal.cluster)
					string_representation_internal := folder_internal.name
				else
					query_language_item_internal := Void
					if last_folder_name /= Void and then not last_folder_name.is_empty then
						string_representation_internal := last_folder_name.twin
					else
						string_representation_internal := interface_names.l_invalid_item
					end
				end
				update_last_compilation_count
			end
		end

	folder_internal: EB_FOLDER;
			-- Folder represented by `id'

	query_language_item_internal: like query_language_item;
			-- Implementation of `query_language_item'

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
