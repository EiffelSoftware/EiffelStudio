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
			make_default (default_file)
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
			make_default_for_file (default_file)
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

	save_resource (res: RESOURCE) is
			-- save `res' at the position `path')
		do
--			root_folder.save_resource (res, location, path)
		end

feature -- Modification

--	put (res: RESOURCE; path: STRING) is
--			-- Put `res' in Current.
--		local
--			f: like folder
--		do
--			table.put_resource (res)
--			put_folder (path)
--			f := folder (path)
--			if f = Void then
--				check
--					Folder_not_created: false
--				end
--			end
--			f.resource_list.extend (res)
--		end

--	put_folder (path: STRING) is
--			-- Make sure a folder exists at location `path',
--			-- creating folders iteratively if needed.
--		local
--			i, j: INTEGER
--			s: STRING
--			f, f_child: like folder
--			terra_incognita: BOOLEAN
--		do
--			from
--				i := 1
--				j := 1
--				s := path
--				if s.empty then j := 0 end
--				f := root_folder
--			until
--				j < 1
--			loop
--				j := s.index_of ('/', i)
--				if j > i then
--					if not terra_incognita then
--						f_child := folder_child (f, s.substring (i, j - 1))
--						if (f_child = Void) then
--								-- no folders anymore: from now on, we'll have
--								-- to create them.
--							terra_incognita := True
--							create f_child.make_from_scratch (s.substring (i, j - 1), Current)
--							f.child_list.extend (f_child)
--						end
--					else
--						create f_child.make_from_scratch (s.substring (i, j - 1), Current)
--						f.child_list.extend (f_child)
--					end
--					i := j + 1
--					f := f_child
--				end
--			end
--			if i + 1 < s.count then
--				if not terra_incognita then
--					f_child := folder_child (f, s.substring (i, s.count))
--					if f_child = Void then
--						create f_child.make_from_scratch (s.substring (i, s.count), Current)
--						f.child_list.extend (f_child)
--					end
--				else
--					create f_child.make_from_scratch (s.substring (i, s.count), Current)
--					f.child_list.extend (f_child)
--				end
--			end
--		end

end -- class RESOURCE_STRUCTURE_IMP
