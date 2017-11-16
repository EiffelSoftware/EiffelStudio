note
	description: "Simple Compilation index for eiffel script tool."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SCRIPT_COMPILATION_INDEX

create
	make,
	make_from_path

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create tmp_file.make_with_path (create {PATH}.make_current)
			create items.make (nb)
		end

	make_from_path (a_path: PATH)
		do
			make (30)
			load_from (a_path)
		end

feature -- Access

	items: ARRAYED_LIST [TUPLE [date: INTEGER_32; path: PATH]]

feature -- Status report

	is_project_more_recent_than (ref: PATH): BOOLEAN
		local
			d, l_ref_date: like file_path_modified_date
		do
			l_ref_date := file_path_modified_date (ref)
			Result := items.is_empty
			across
				items as ic
			until
				Result
			loop
				d := file_path_modified_date (ic.item.path)
				Result := l_ref_date <= d
			end
		end

feature -- Change

	wipe_out
		do
			items.wipe_out
		end

	record_class (a_path: PATH)
		do
			record (file_path_modified_date (a_path), a_path)
		end

	record_library (a_path: PATH)
		do
			record (file_path_modified_date (a_path), a_path)
		end

feature {NONE} -- Change		

	record (a_date: INTEGER; a_path: PATH)
		do
			items.force (a_date, a_path)
		end

feature {NONE} -- Implementation

	file_path_modified_date (a_file_name: PATH): INTEGER_32
			-- Get last modified timestamp of `a_path`.
			-- (from CONF_FILE_DATE)
		require
			a_path_set: a_file_name /= Void and then not a_file_name.is_empty
		local
			f: RAW_FILE
		do
			f := tmp_file
			f.make_with_path (a_file_name)
			if f.exists then
				Result := f.date
			else
				Result := -1
			end
		ensure
			file_modified_date_valid: Result >= -1
		end

	tmp_file: RAW_FILE

feature -- Persistence

	save_to (fn: PATH)
		local
			f: RAW_FILE
			fut: FILE_UTILITIES
		do
			fut.create_directory_path (fn.parent)
			create f.make_with_path (fn)
			if not f.exists or else f.is_access_writable then
				f.open_write
				across
					items as ic
				loop
					f.put_string (ic.item.date.out)
					f.put_character (',')
					f.put_string (ic.item.path.utf_8_name)
					f.put_new_line
				end
				f.close
			end
		end

	load_from (fn: PATH)
		local
			utf: UTF_CONVERTER
			f: RAW_FILE
			i: INTEGER
			s: STRING
		do
			create f.make_with_path (fn)
			if f.exists and then f.is_access_readable then
				f.open_read
				from
				until
					f.exhausted or f.end_of_file
				loop
					f.read_line
					s := f.last_string
					i := s.index_of (',', 1)
					if i > 0 then
						record (s.head (i - 1).to_integer,
								create {PATH}.make_from_string (utf.escaped_utf_32_string_to_utf_8_string_8 (s.substring (i + 1, s.count)))
								)
					else
						-- Ignore ...
						check expected_line: False end
					end
				end
				f.close
			end
		end

end
