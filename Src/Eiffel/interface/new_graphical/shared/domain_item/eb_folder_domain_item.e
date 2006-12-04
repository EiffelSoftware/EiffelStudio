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
			Result := folder_of_id (id) /= Void
		end

feature -- Access

	domain (a_scope: QL_SCOPE): QL_DOMAIN is
			-- New query lanaguage domain representing current item
		local
			l_class_domain_generator: QL_CLASS_DOMAIN_GENERATOR
			l_folder: EB_FOLDER
		do
			l_folder := folder_of_id (id)
			check l_folder /= Void end
			create l_class_domain_generator.make (create{QL_CLASS_PATH_IN_CRI}.make (l_folder.path), True)
			Result := query_group_item_from_conf_group (l_folder.cluster).wrapped_domain.new_domain (l_class_domain_generator)
		end

	string_representation: STRING is
			-- Text of current item
		local
			l_folder: EB_FOLDER
			l_folder_name: STRING
		do
			if not is_valid then
				Result := Precursor
			else
				l_folder := folder_of_id (id)
			end

			l_folder := folder_of_id (id)
			if l_folder /= Void then
				Result := l_folder.name
			else
				l_folder_name := last_folder_name
				if l_folder_name /= Void and then not l_folder_name.is_empty then
					Result := l_folder_name.twin
				else
					Result := Precursor
				end
			end
		end

	folder: EB_FOLDER is
			-- Folder item for current
		require
			valid: is_valid
		do
			Result := folder_of_id (id)
		ensure
			result_attached: Result /= Void
		end

	query_language_item: QL_ITEM is
			-- Query language item representation of current domain item
		do
			Result := query_group_item_from_conf_group (folder.cluster)
		end

	group: QL_GROUP is
			-- Group to which current domain item belongs
			-- Return the group where current folder is located.
		do
			Result ?= query_language_item
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
