indexing
	description: "Structure which receives the data contained in a XML file."
	author: "Pascal Freund and Christophe Bonnard"

deferred class
	RESOURCE_STRUCTURE_I

feature -- Initialization

	make (in: like interface) is
		do
			interface := in
		end

	make_default (default_file: STRING) is
				-- Initialize Current from file
				-- named `default_file'.
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
			-- Name includes path.
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
				loop_must_end := s.empty
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
		local
			f: like folder
		do
			f := folder (path)
			Result := f.child_list
		end

	resource_list (path: STRING): LINKED_LIST [RESOURCE] is
		local
			f: like folder
		do
			f := folder (path)
			Result := f.resource_list
		end

feature -- Modification

	put_resource (r: RESOURCE) is
		do
			table.put_resource (r)
		end

	replace_resource (r: RESOURCE) is
		do
			table.replace_resource (r)
		end

feature -- Save

	save is
		deferred
		end

feature -- Status report

	root_folder_i: RESOURCE_FOLDER_I
			-- Root of the folder hierarchy.

	has_folder (s: STRING): BOOLEAN is
		do
			Result := (folder (s) /= Void)
		end

feature -- Implementation

	interface: RESOURCE_STRUCTURE

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

	table: RESOURCES_TABLE
		-- Hash Table of Resources.
		-- The key used is their "short" name.

end -- class RESOURCE_STRUCTURE_I
