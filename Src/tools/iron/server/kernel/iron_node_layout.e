note
	description: "Summary description for {IRON_NODE_LAYOUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_LAYOUT

create
	make_default,
	make_with_path

feature {NONE} -- Initialization

	make_default
		local
			p: PATH
		do
			create p.make_current
			p := p.extended ("_iron")
			make_with_path (p)
		end

	make_with_path (p: PATH)
		do
			path := p.absolute_path.canonical_path
		end

feature -- Access

	path: PATH

feature -- Access: database	

	repo_path: PATH
			-- Root of the file system database
		once
			Result := path.extended ("repo")
		end

	repo_versions_path: PATH
			-- Folder containing the versions data
		once
			Result := repo_path.extended ("versions")
		end

	repo_users_path: PATH
			-- Folder containing the users data
		once
			Result := repo_path.extended ("users")
		end

	repo_packages_path: PATH
			-- Folder containing the items for version `a_version'
		do
			Result := repo_path.extended ("packages")
		end

	repo_trash: PATH
			-- Folder containing the trashed items for version `a_version'
		do
			Result := repo_versions_path.extended ("trash")
		end

	repo_version_items (a_version: IRON_NODE_VERSION): PATH
			-- Folder containing the items for version `a_version'
		do
			Result := repo_versions_path.extended (a_version.value).extended ("items")
		end

	repo_version_index (a_version: IRON_NODE_VERSION): PATH
			-- Folder containing the indexes for version `a_version'
		do
			Result := repo_versions_path.extended (a_version.value).extended ("index")
		end

	repo_version_index_map (a_version: IRON_NODE_VERSION): PATH
			-- File containing the indexes map for version `a_version'
		do
			Result := repo_versions_path.extended (a_version.value).extended ("index.db")
		end

	repo_version_trash (a_version: IRON_NODE_VERSION): PATH
			-- Folder containing the trashed items for version `a_version'
		do
			Result := repo_versions_path.extended (a_version.value).extended ("trash")
		end

feature -- Access: internal

	config_path: PATH
			-- Configuration file path.
		once
			Result := path.extended ("config")
		end

	binaries_path: PATH
		once
			Result := path.extended ("bin")
		end

	logs_path: PATH
		once
			Result := path.extended ("logs")
		end

	documentation_path: PATH
			-- directory for iron documentation	
		once
			Result := path.extended ("doc")
		end

	www_path: PATH
		once
			Result := path.extended ("html")
		end

	html_template_path: PATH
		once
			Result := path.extended ("template").extended ("html")
		end

	tmp_path: PATH
		once
			Result := path.extended ("tmp")
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

