indexing
	description: "Structure which receives the data contained in a XML file."
	author: "Pascal Freund and Christophe Bonnard"

deferred class
	RESOURCE_STRUCTURE_I

feature -- Initialization

	make_default (default_file: STRING) is
				-- Initialize Current from file
				-- named `default_file'.
		local
			file_name: FILE_NAME
			file: RAW_FILE
			s: STRING
			p: XML_TREE_PARSER
			error_message: STRING
--			folder_i: RESOURCE_FOLDER_I
		do
			create file_name.make_from_string (default_file)
			create table.make (100)
			create p.make
			create file.make (file_name)
			if file.exists then
				file.open_read
				file.read_stream (file.count)
				s := file.last_string
				p.parse_string (s)
				p.set_end_of_file
				file.close
				parser := p
				if not p.root_element.name.is_equal ("EIFFEL_DOCUMENT") then
					error_message := "EIFFEL_DOCUMENT TAG missing%N"
				else
					create {RESOURCE_FOLDER_IMP} root_folder_i.make_default_root (parser.root_element, interface)
					root_folder_i.create_interface
					root_folder := root_folder_i.interface
				end
			else
				error_message := "does not exist%N"
				error_message.prepend (file_name)
			end
			if error_message /= Void then
				io.put_string (error_message)
			end
		end

feature -- Access

	item, resource (resource_name: STRING): RESOURCE is
			-- Resource named `resource_name'.
			-- Name includes path.
		local
			rl: LINKED_LIST [RESOURCE]
			last_sep, pos: INTEGER
		do
			Result := table.item (resource_name)
		end

	folder (path: STRING): like root_folder is
			-- Folder at location `path'
		local
			i, j: INTEGER
			s: STRING
			f: like folder
			loop_must_end: BOOLEAN
		do
			from
				i := 1
				j := 1
				s := path
				f := root_folder
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
			Result := f
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

	save_resource (res: RESOURCE) is
			-- save `res' at the position `path')
		deferred
		end


feature -- Status report

	root_folder: RESOURCE_FOLDER
			-- Root of the folder hierarchy.
			--| `folder' type accords to it, but other
			--| features should accord with `folder' type
			--| because it's more intuitive.

	root_folder_i: RESOURCE_FOLDER_I

	has_folder (s: STRING): BOOLEAN is
		do
			Result := (folder (s) /= Void)
		end

feature -- Implementation

	parser: XML_TREE_PARSER
		-- XML_PARSER

	interface: RESOURCE_STRUCTURE

feature {NONE} -- Implementation

	folder_child (par: RESOURCE_FOLDER; child_name: STRING): like folder is
			-- Child of `par' with name `child_name'
			-- Void if `par' has no child called `child_name'.
		local
			l: linked_list [like folder]
			f: like folder
			s: STRING
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
