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

	initialize, initialize_from_file (default_file: STRING; normal_file: STRING) is
			-- Initialize Current from `default_file', and update it with
			-- `normal_file'.
		local
			file_name: FILE_NAME
		do
			if default_file /= Void then
				make_default (default_file)
			end
			create file_name.make_from_string (normal_file)
			if root_folder_i /= Void then
				update (file_name)
			else
				make_from_file_name (file_name)
			end
		end

	make_from_file_name (file_name: FILE_NAME) is
				-- Initialize Current from file
				-- named `file_name'.
		do
			location := file_name
			create table.make (100)
			create {RESOURCE_FOLDER_IMP} root_folder_i.make_root (location, interface)
			root_folder_i.create_interface
		end

feature -- Update

	update (file_name: FILE_NAME) is
				-- Initialize Current from file
				-- named `file_name'.
		do
			location := file_name
			root_folder_i.update_root (file_name)
		end

feature -- Saving

	save is
			-- Save structure in `location'.
		do
			root_folder_i.root_save (location)
		end

feature -- Status report

	location: FILE_NAME
		-- Current location of structure backup.

end -- class RESOURCE_STRUCTURE_IMP
