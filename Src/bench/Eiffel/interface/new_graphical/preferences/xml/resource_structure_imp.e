indexing
	description: "Structure which receives the data contained in a XML file."
	author: "Pascal Freund and Christophe Bonnard"

class
	RESOURCE_STRUCTURE_IMP

inherit
	RESOURCE_STRUCTURE
		redefine
			location, root_folder
		end

create
	make

feature -- Initialization

	make is
		local
			file_name: FILE_NAME
			environment: EXECUTION_ENVIRONMENT
		do
			create environment
			create file_name.make_from_string (environment.home_directory_name)
			file_name.set_file_name (".es4rc")
			make_from_file_name (file_name)
			if error_message /= Void then
				io.put_string (error_message)
			end
		end

	make_from_file_name (file_name: FILE_NAME) is
				-- Initialize Current from file
				-- named `file_name'.
		local
			file: RAW_FILE
			s: STRING
			p: XML_TREE_PARSER
		do
			location := file_name
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
					create root_folder.make_root (parser.root_element, Current)
				end
			else
				error_message := "does not exist%N"
				error_message.prepend (location)
			end
		end

feature -- Access

	item, resource (resource_name: STRING): RESOURCE is
			-- Resource named `resource_name'.
			-- Name includes path.
		local
			rl: LINKED_LIST [RESOURCE]
			last_sep, pos: INTEGER
			f: RESOURCE_FOLDER
		do
			Result := table.item (resource_name)
			if Result = Void then
				last_sep := resource_name.last_index_of ('/', resource_name.count)
				f := folder (resource_name.substring (1, last_sep))
				if f.loading_not_done then
					f.load_attributes
					Result := table.item (resource_name)
				end
			end
		end

	has_folder (s: STRING): BOOLEAN is
		do
			Result := (folder (s) /= Void)
		end

	folder (path: STRING): RESOURCE_FOLDER is
			-- Folder at location `path'
		local
			i, j: INTEGER
			s: STRING
			f: RESOURCE_FOLDER
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

	child_list (path: STRING): LINKED_LIST [RESOURCE_FOLDER] is
		local
			f: RESOURCE_FOLDER
		do
			f := folder (path)
			if f.loading_not_done then
				f.load_attributes
			end
			Result := f.child_list
		end

	resource_list (path: STRING): LINKED_LIST [RESOURCE] is
		local
			f: RESOURCE_FOLDER
		do
			f := folder (path)
			Result := f.resource_list
		end

feature -- Saving

	save is
		local
			file: RAW_FILE
			s: STRING
			l: LINKED_LIST [RESOURCE_FOLDER_IMP]
		do
			create file.make_open_write (location)
			if file.exists then
				s := "<EIFFEL_DOCUMENT>%N"
				from
					l := root_folder.child_list
					l.start
				until
					l.after
				loop
					s.append (l.item.xml_trace (""))
					l.forth
				end
				s.append ("</EIFFEL_DOCUMENT>%N")
				file.put_string (s)
				file.close
			end
		end

feature -- Status report

	location: FILE_NAME

	root_folder: RESOURCE_FOLDER_IMP

feature -- Implementation

	parser: XML_TREE_PARSER
		-- XML_PARSER

	add_error_message (s:STRING) is
		require
			not_void: s /= Void
		do
			error_message.append ("%N")
			error_message.append (s)
		end

feature {NONE} -- Implementation

	folder_child (par: RESOURCE_FOLDER; child_name: STRING): RESOURCE_FOLDER is
			-- Child of `par' with name `child_name'
			-- Void if `par' has no child called `child_name'.
		local
			l: linked_list [RESOURCE_FOLDER]
			f: RESOURCE_FOLDER
			s: STRING
		do
			if par.loading_not_done then
				par.load_attributes
			end
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

end -- class RESOURCE_STRUCTURE_IMP
