indexing
	description: "Structure which receives the data contained in a XML file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Pascal Freund and Christophe Bonnard"

class
	RESOURCE_STRUCTURE_IMP

inherit
	RESOURCE_STRUCTURE_I

create
	make

feature -- Initialization

	initialize (default_file: STRING; loc: STRING) is
		do
			if default_file /= Void then
				make_default (default_file)
			end
			if root_folder_i /= Void then
				update (loc)
			else
				make_from_location (loc)
			end
		end

	initialize_from_file (default_file: STRING; loc: STRING) is
		local
			file_name: FILE_NAME
		do
			if default_file /= Void then
				make_default_for_file (default_file)
			end
			if root_folder_i /= Void then
				update (loc)
			else
				create file_name.make_from_string (default_file)
				make_from_file_name (file_name)
			end
		end

	make_default_for_file (default_file: STRING) is
				-- Initialize Current from file
				-- named `default_file'.
		local
			file_name: FILE_NAME
		do
			create file_name.make_from_string (default_file)
			create table.make (100)
			create {RESOURCE_FOLDER_XML} root_folder_i.make_default_root (file_name, interface)
			root_folder_i.create_interface
		end

	make_from_location (loc: STRING) is
				-- Initialize Current from registry key `loc'.
		do
			location := loc
			create table.make (100)
			create {RESOURCE_FOLDER_IMP} root_folder_i.make_root (loc, interface)
			root_folder_i.create_interface
		end

	make_from_file_name (file_name: FILE_NAME) is
				-- Initialize Current from file
				-- named `file_name'.
		do
			location := file_name
			create table.make (100)
			create {RESOURCE_FOLDER_XML} root_folder_i.make_root (file_name, interface)
			root_folder_i.create_interface
		end

feature -- Update

	update (loc: STRING) is
				-- Initialize Current from registry key `loc'.
		do
			location := loc
			root_folder_i.update_root (loc)
		end

feature -- Access

	location: STRING

feature -- Saving

	save is
		do
			root_folder_i.root_save (location)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class RESOURCE_STRUCTURE_IMP
