indexing
	description: "Structure which receives the data contained in a XML file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Pascal Freund and Christophe Bonnard"

deferred class
	RESOURCE_STRUCTURE_I

feature -- Initialization

	make (in: like interface) is
			-- Creation procedure.
		do
			interface := in
		end

	make_default (default_file: STRING) is
			-- Initialize Current from file
			-- named `default_file'.
		require
			default_file_exists: default_file /= Void
		local
			file_name: FILE_NAME
		do
			create file_name.make_from_string (default_file)
			create table.make (100)
			create {RESOURCE_FOLDER_IMP} root_folder_i.make_default_root (file_name, interface)
			if root_folder_i.child_list = Void then
				root_folder_i := Void
			else
				root_folder_i.create_interface
			end
		end

feature -- Access

	item, resource (resource_name: STRING): RESOURCE is
			-- Resource named `resource_name'.
			-- Name does not include path.
		do
			Result := table.item (resource_name)
		end

	folder (path: STRING): RESOURCE_FOLDER is
			-- Folder at location `path'
		local
			i, j: INTEGER
			s: STRING
			f: like root_folder_i
			loop_must_end: BOOLEAN
		do
			from
				i := 1
				j := 1
				s := path
				f := root_folder_i
				loop_must_end := s.is_empty
			until
				loop_must_end
			loop
				j := s.index_of ('/', i)
				if j > i then
					f := folder_child (f, s.substring (i, j - 1))
					i := j + 1
					loop_must_end := (f = Void) or else (i = s.count)
				end
				loop_must_end := loop_must_end or else (j < 1)
			end
			if i + 1 < s.count then
				f := folder_child (f, s.substring (i, s.count))
			end
			Result := f.interface
		end

	child_list (path: STRING): LINKED_LIST [like folder] is
			-- List of child folder of folder located at `path'.
		local
			f: like folder
		do
			f := folder (path)
			Result := f.child_list
		end

	resource_list (path: STRING): LINKED_LIST [RESOURCE] is
			-- List of resources of folder located at `path'.
		local
			f: like folder
		do
			f := folder (path)
			Result := f.resource_list
		end

feature -- Modification

	put_resource (r: RESOURCE) is
			-- Add `r' in resource hash table.
		do
			table.put_resource (r)
		end

	replace_resource (r: RESOURCE) is
			-- Replace `r' in resource hash table.
		do
			table.replace_resource (r)
		end

feature -- Save

	save is
			-- Save contents of structure.
		deferred
		end

feature -- Status report

	root_folder_i: RESOURCE_FOLDER_I
			-- Root of the folder hierarchy.

	has_folder (s: STRING): BOOLEAN is
			-- Does folder `s' exists?
		do
			Result := (folder (s) /= Void)
		end

feature -- Implementation

	interface: RESOURCE_STRUCTURE
		-- Interface of Current.

feature {NONE} -- Implementation

	folder_child (par: RESOURCE_FOLDER_I; child_name: STRING): RESOURCE_FOLDER_I is
			-- Child of `par' with name `child_name'
			-- Void if `par' has no child called `child_name'.
		local
			l: LINKED_LIST [RESOURCE_FOLDER_I]
			f: RESOURCE_FOLDER_I
		do
			l := par.child_list
			from
				l.start
			until
				(Result /= Void) or else l.after
			loop
				f := l.item
				if equal (f.name, child_name) then
					Result := f
				end
				l.forth
			end
		end

	table: RESOURCES_TABLE;
		-- Hash Table of Resources.
		-- The key used is their "short" name.

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

end -- class RESOURCE_STRUCTURE_I
