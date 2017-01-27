note
	description: "Routines to manipulate files, directories, ..."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FILE_SYSTEM_UTILITIES

feature -- Files

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

	safe_copy_file (src,dst: PATH): BOOLEAN
			-- Copy file from `src` to `dst'
			-- and return True on success, False on failure.
		local
			retried: BOOLEAN
			f_src, f_dst: RAW_FILE
			d: DIRECTORY
		do
			Result := False
			if retried then
				Result := False
			else
				create f_src.make_with_path (src)
				if f_src.exists and then f_src.is_access_readable then
					if attached dst.parent as l_parent then
						create d.make_with_path (l_parent)
						if not d.exists then
							d.recursive_create_dir
						end
					end
					create f_dst.make_with_path (dst)
					if not f_dst.exists or else f_dst.is_access_writable then
						f_src.open_read
						f_dst.open_write
						f_src.copy_to (f_dst)
						f_dst.close
						f_src.close
						Result := True -- Succeed!
					end
				end
			end
		rescue
			retried := True
			retry
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
