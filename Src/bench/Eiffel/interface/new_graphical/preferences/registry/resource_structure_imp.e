indexing
	description: "Structure which receives the data contained in a XML file."
	author: "Pascal Freund and Christophe Bonnard"

class
	RESOURCE_STRUCTURE_IMP

inherit
	RESOURCE_STRUCTURE
		redefine
			root_folder
		end

create
	make

feature -- Initialization

	make is
		local
			file_name: FILE_NAME
		do
			make_from_location ("HKEY_CURRENT_USER\Software\ISE\Eiffel46")
		end

	make_from_location (loc: STRING) is
				-- Initialize Current from file
				-- named `file_name'.
		local
			s: STRING
		do
			location := loc
			create table.make (100)
			create root_folder.make_root (loc, Current)
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
--			if Result = Void then
--				last_sep := resource_name.last_index_of ('/', resource_name.count)
--				f := folder (resource_name.substring (1, last_sep))
--				if f.loading_not_done then
--					f.load_attributes (Current)
--					Result := table.item (resource_name)
--				end
--			end
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
		do
			root_folder.root_save (location)
		end

feature -- Status report

	root_folder: RESOURCE_FOLDER_IMP

feature -- Implementation

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
