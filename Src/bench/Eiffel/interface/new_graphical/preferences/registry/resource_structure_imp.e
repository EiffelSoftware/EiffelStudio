indexing
	description: "Structure which receives the data contained in a XML file."
	author: "Pascal Freund and Christophe Bonnard"

class
	RESOURCE_STRUCTURE_IMP

inherit
	RESOURCE_STRUCTURE_I
		rename
			root_folder_i as root_folder_imp
		redefine
			root_folder_imp
		end

create
	make

feature -- Initialization

	make (in: like interface) is
		do
			interface := in
		end

	initialize (default_file: STRING) is
		local
			file_name: FILE_NAME
		do
			make_default (default_file)
			if root_folder /= Void then
				update_from_location ("HKEY_CURRENT_USER\Software\ISE\Eiffel46")
			else
				make_from_location ("HKEY_CURRENT_USER\Software\ISE\Eiffel46")
			end
		end

	make_from_location (loc: STRING) is
				-- Initialize Current from registry key `loc'.
		local
			s: STRING
		do
			location := loc
			create table.make (100)
			create root_folder_imp.make_root (loc, interface)
			root_folder_imp.create_interface
			root_folder := root_folder_imp.interface
		end

	update_from_location (loc: STRING) is
				-- Initialize Current from registry key `loc'.
		local
			s: STRING
			folder_imp: RESOURCE_FOLDER_IMP
		do
			location := loc
--			folder_imp ?= root_folder.implementation
			root_folder_imp.update_root (loc)
		end

feature -- Access

	location: STRING

	root_folder_imp: RESOURCE_FOLDER_IMP

feature -- Saving

	save is
		do
			root_folder_imp.root_save (location)
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
