note
	description: "Routines to manipulate files, directories, ..."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FILE_SYSTEM_UTILITIES

feature -- File path

	relative_path_inside (a_path: PATH; a_root_path: PATH): detachable PATH
			-- Relative path from `a_root_path` to `a_path`, or Void if `a_path` is not inside `a_root_path`.
		local
			lst,root_lst: LIST [PATH]
			err: BOOLEAN
		do
			lst := a_path.components
			root_lst := a_root_path.components
			if lst.count >= root_lst.count then
				from
					lst.start
					root_lst.start
				until
					root_lst.after or err
				loop
					if lst.item.same_as (root_lst.item) then
						lst.forth
						root_lst.forth
					else
						err := True
					end
				end
				if not err then
					from
						create Result.make_empty
					until
						lst.after
					loop
						Result := Result.extended_path (lst.item)
						lst.forth
					end
				end
			end
		end

feature -- Read

	file_content (a_loc: PATH): detachable STRING
			-- Content of file located at `a_loc`.
		local
			f: PLAIN_TEXT_FILE
			rescued: BOOLEAN
			c: INTEGER
			done: BOOLEAN
		do
			if not rescued then
				create f.make_with_path (a_loc)
				if f.exists and then f.is_access_readable then
					c := f.count
					if c > 0 then
						f.open_read
						from
							create Result.make (c)
						until
							done
						loop
							f.read_stream (1_024)
							Result.append (f.last_string)
							done := f.last_string.count < 1_024 or f.exhausted
						end
						f.close
					end
				end
			end
		rescue
			rescued := True
			retry
		end

	unicode_file_content (a_loc: PATH): detachable STRING_32
			-- Unicode content of file located at `a_loc` (utf-8 encoded).
		local
			utf: UTF_CONVERTER
		do
			if attached file_content (a_loc) as s then
				Result := utf.utf_8_string_8_to_string_32 (s)
			end
		end

	files_from_location (a_loc: PATH; is_recursive: BOOLEAN): detachable LIST [PATH]
		local
			d: DIRECTORY
			f: RAW_FILE
			p: PATH
			retried: BOOLEAN
		do
			if not retried then
				create {ARRAYED_LIST [PATH]} Result.make (0)
				create d.make_with_path (a_loc)
				if d.exists then
					across
						d.entries as ic
					loop
						if ic.item.is_current_symbol or ic.item.is_parent_symbol then
								-- Ignore
						else
							p := a_loc.extended_path (ic.item)
							create f.make_with_path (p)
							if f.is_directory then
								if is_recursive and then attached files_from_location (p, is_recursive) as lst then
									across
										lst as lst_ic
									loop
										Result.force (lst_ic.item)
									end
								end
							elseif f.exists then
								Result.force (p)
							end
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Read/Write		

	safe_copy_file (src,dst: PATH): BOOLEAN
			-- Copy file from `src` to `dst'
			-- and return True on success, False on failure.
		local
			retried: BOOLEAN
			f_src, f_dst: RAW_FILE
		do
			Result := False
			if retried then
				Result := False
			else
				create f_src.make_with_path (src)
				if f_src.exists and then f_src.is_access_readable then
					if safe_create_parent_directory (dst) then
						create f_dst.make_with_path (dst)
						if not f_dst.exists or else f_dst.is_access_writable then
							f_src.open_read
							f_dst.open_write
							f_src.copy_to (f_dst)
							f_dst.close
							f_src.close
							Result := True -- Succeed!
						end
					else
						Result := False -- No parent directory!
					end
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Create

	safe_create_raw_file (p: PATH): BOOLEAN
			-- Create file at `p`
			-- and return True on success or if file already exists, False on failure.
		local
			retried: BOOLEAN
			f: RAW_FILE
		do
			Result := False
			if not retried then
				if safe_create_parent_directory (p) then
					create f.make_with_path (p)
					if f.exists then
						Result := True
					else
						f.create_read_write
						f.close
						Result := f.exists
					end
				end
			end
		rescue
			retried := True
			retry
		end

	safe_create_parent_directory (p: PATH): BOOLEAN
			-- Create parent directory of `p`
			-- and return True on success or if parent already exists, False on failure.
		local
			retried: BOOLEAN
			d: DIRECTORY
		do
			Result := False
			if not retried then
				create d.make_with_path (p.parent)
				if d.exists then
					Result := True
				else
					d.recursive_create_dir
					Result := d.exists
				end
			end
		rescue
			retried := True
			retry
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
