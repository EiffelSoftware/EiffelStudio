indexing
	description: "Structure which receives the data contained in a XML file."
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

end -- class RESOURCE_STRUCTURE_IMP
