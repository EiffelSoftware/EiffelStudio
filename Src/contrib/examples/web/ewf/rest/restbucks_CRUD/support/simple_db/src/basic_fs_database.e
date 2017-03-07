note
	description: "Summary description for {BASIC_FS_DATABASE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BASIC_FS_DATABASE

inherit
	BASIC_DATABASE

feature {NONE} -- Initialization

	make (a_location: PATH)
		local
			d: DIRECTORY
		do
			location := a_location
			ensure_directory_exists (a_location)
		end

feature -- Access

	location: PATH

feature {NONE} -- Access	

	default_extension: detachable STRING_32
			-- Default file extension, if any.
		deferred
		end

feature -- Access

	count_of (a_entry_type: TYPE [detachable ANY]): INTEGER
		local
			d: DIRECTORY
			ext: like default_extension
		do
			create d.make_with_path (location.extended (entry_type_name (a_entry_type)))
			if d.exists then
				ext := default_extension
				across
					d.entries as ic
				loop
					if
						ext = Void or else
						attached ic.item.extension as e and then e.is_case_insensitive_equal (ext) then
						Result := Result + 1
					end
				end
			end
		end

	has (a_entry_type: TYPE [detachable ANY]; a_id: READABLE_STRING_GENERAL): BOOLEAN
			-- Has entry of type `a_entry_type` associated with id `a_id`?
		local
			fut: FILE_UTILITIES
		do
			Result := fut.file_path_exists (entry_path (a_entry_type, a_id))
		end

	item (a_entry_type: TYPE [detachable ANY]; a_id: READABLE_STRING_GENERAL): detachable ANY
		do
			Result := item_from_location (a_entry_type, entry_path (a_entry_type, a_id))
		end

	save (a_entry_type: TYPE [detachable ANY]; a_entry: detachable ANY; cl_entry_id: CELL [detachable READABLE_STRING_GENERAL])
		local
			f: RAW_FILE
			l_id: detachable READABLE_STRING_GENERAL
			p: PATH
		do
			l_id := cl_entry_id.item
			if l_id = Void then
				l_id := next_identifier (a_entry_type)
				cl_entry_id.replace (l_id)
			end
			p := entry_path (a_entry_type, l_id)
			ensure_directory_exists (p.parent)
			save_item_to_location (a_entry, p)
		end

	delete (a_entry_type: TYPE [detachable ANY]; a_id: READABLE_STRING_GENERAL)
		local
			f: RAW_FILE
		do
			create f.make_with_path (entry_path (a_entry_type, a_id))
			if f.exists and then f.is_access_writable then
				f.delete
			end
		end

	wipe_out
		local
			d: DIRECTORY
		do
			create d.make_with_path (location)
			if d.exists then
				d.recursive_delete
			end
		end

feature {NONE} -- Implementation

	item_from_location (a_entry_type: TYPE [detachable ANY]; p: PATH): like item
		deferred
		end

	save_item_to_location (a_entry: detachable ANY; p: PATH)
		deferred
		end

	ensure_directory_exists (dn: PATH)
		local
			d: DIRECTORY
		do
			create d.make_with_path (dn)
			if not d.exists then
				d.recursive_create_dir
			end
		end

	entry_path (a_entry_type: TYPE [detachable ANY]; a_id: READABLE_STRING_GENERAL): PATH
		do
			Result := location.extended (entry_type_name (a_entry_type)).extended (a_id).appended_with_extension ("json")
		end

	entry_type_name (a_entry_type: TYPE [detachable ANY]): STRING
		do
			Result := a_entry_type.name.as_lower
			Result.prune_all ('!')
		end

	last_id_file_path (a_entry_type: TYPE [detachable ANY]): PATH
		do
			Result := location.extended (entry_type_name (a_entry_type)).extended ("last-id")
		end

	next_identifier (a_entry_type: TYPE [detachable ANY]): STRING_8
		local
			i: NATURAL_64
			f: RAW_FILE
			s: STRING
		do
			create f.make_with_path (last_id_file_path (a_entry_type))
			ensure_directory_exists (f.path.parent)
			if f.exists then
				create s.make (f.count)
				f.open_read
				f.read_line
				s := f.last_string
				f.close
				if s.is_natural_64 then
					i := s.to_natural_64
				end
			end
			from
				i := i + 1
				Result := i.out
			until
				not has (a_entry_type, Result)
			loop
				i := i + 1
				Result := i.out
			end
			f.open_write
			f.put_string (Result)
			f.close
		end

invariant

note
	copyright: "2011-2017, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
