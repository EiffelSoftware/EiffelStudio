note
	description: "Summary description for {FILE_SYSTEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_SYSTEM


feature -- Access

	current_working_directory: STRING
		do
			Result := execution_environment.current_working_directory
		end

	names (a_dir: DIRECTORY): TUPLE [files: LIST [READABLE_STRING_32]; dirs: LIST [READABLE_STRING_32]]
		local
			s: READABLE_STRING_8
			fn: FILE_NAME
			l_files, l_dirs: ARRAYED_LIST [READABLE_STRING_32]
		do
			create {ARRAYED_LIST [READABLE_STRING_32]} l_dirs.make (0)
			create {ARRAYED_LIST [READABLE_STRING_32]} l_files.make (0)
			if attached a_dir.linear_representation as lst then
				from
					create fn.make_from_string (a_dir.name)
					lst.start
				until
					lst.after
				loop
					s := lst.item
					fn.make_from_string (a_dir.name)
					fn.set_file_name (s)
					if is_file (fn.string) then
						l_files.force (s.as_string_32)
					elseif s.same_string_general (".") or s.same_string_general ("..") then
					else
						if is_directory (fn.string) then
							l_dirs.force (s.as_string_32)
						else
							l_files.force (s.as_string_32) --?
						end
					end
					lst.forth
				end
			end
			Result := [l_files, l_dirs]
		end

	directory_names (a_dir: DIRECTORY): LIST [READABLE_STRING_32]
		local
			s: STRING
			dn: DIRECTORY_NAME
		do
			if attached a_dir.linear_representation as lst then
				create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (0)
				from
					create dn.make_from_string (a_dir.name)
					lst.start
				until
					lst.after
				loop
					s := lst.item
					if s.same_string_general (".") or s.same_string_general ("..") then
					else
						dn.make_from_string (a_dir.name)
						dn.extend (s)

						if is_directory (dn.string) then
							Result.force (s.as_string_32)
						end
					end
					lst.forth
				end
			else
				create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (0)
			end
		end

	file_names (a_dir: DIRECTORY): LIST [READABLE_STRING_32]
		local
			fn: FILE_NAME
		do
			if attached a_dir.linear_representation as lst then
				create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (0)
				from
					create fn.make_from_string (a_dir.name)
					lst.start
				until
					lst.after
				loop
					fn.make_from_string (a_dir.name)
					fn.set_file_name (lst.item)
					if is_file (fn.string) then
						Result.force (lst.item.as_string_32)
					end
					lst.forth
				end
			else
				create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (0)
			end
		end

	is_directory (d: STRING): BOOLEAN
		do
			tmp_file.make (d)
			Result := tmp_file.exists and then tmp_file.is_directory
		end

	is_file (f: STRING): BOOLEAN
		do
			tmp_file.make (f)
			Result := tmp_file.exists and then not tmp_file.is_directory
		end

	file_exists (f: READABLE_STRING_GENERAL): BOOLEAN
		do
			tmp_file.make (f.as_string_8)
			Result := tmp_file.exists
		end

	directory_exists (f: READABLE_STRING_GENERAL): BOOLEAN
		do
			tmp_directory.make (f.as_string_8)
			Result := tmp_directory.exists
		end

	is_file_writable (f: READABLE_STRING_GENERAL): BOOLEAN
		do
			tmp_file.make (f.as_string_8)
			Result := not tmp_file.exists or else tmp_file.is_writable
		end

	is_file_readable (f: STRING): BOOLEAN
		do
			tmp_file.make (f)
			Result := tmp_file.exists and then not tmp_file.is_directory and then tmp_file.is_readable
		end

	tmp_file: RAW_FILE
		once
			create Result.make ("temp-file")
		end

	is_directory_readable (d: STRING): BOOLEAN
		do
			tmp_directory.make (d)
			Result := tmp_directory.exists and then tmp_directory.is_readable
		end

	tmp_directory: DIRECTORY
		once
			create Result.make ("temp-dir")
		end

	execution_environment: EXECUTION_ENVIRONMENT
		once
			create Result
		end


	absolute_directory_path (dn: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
		local
			cwd: READABLE_STRING_8
		do
			cwd := current_working_directory
			if directory_exists (dn) then
				execution_environment.change_working_directory (dn.as_string_8)
				Result := current_working_directory
			else
				Result := dn
			end
			execution_environment.change_working_directory (cwd)
		ensure
			same_cwd: current_working_directory ~ old current_working_directory
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
