note
	description: "Summary description for {FILE_SYSTEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_SYSTEM

inherit
	SHARED_EXECUTION_ENVIRONMENT

feature -- Access

	current_working_directory: PATH
		do
			Result := execution_environment.current_working_path
		end

	directory_names (a_dir: DIRECTORY): LIST [PATH]
		local
			p, dp: PATH
		do
			create {ARRAYED_LIST [PATH]} Result.make (0)
			dp := a_dir.path
			across
				a_dir.entries as ic
			loop
				p := ic.item
				if p.is_current_symbol or p.is_parent_symbol then
				else
					if is_directory (dp.extended_path (p)) then
						Result.force (p)
					end
				end
			end
		end

	filenames (a_dir: DIRECTORY): LIST [PATH]
		local
			p, dp: PATH
		do
			create {ARRAYED_LIST [PATH]} Result.make (0)
			dp := a_dir.path
			across
				a_dir.entries as ic
			loop
				p := ic.item
				if is_file (p) then
					Result.force (p)
				end
			end
		end

	is_directory (d: PATH): BOOLEAN
		do
			tmp_file.make_with_path (d)
			Result := tmp_file.exists and then tmp_file.is_directory
		end

	is_file (f: PATH): BOOLEAN
		do
			tmp_file.make_with_path (f)
			Result := tmp_file.exists and then not tmp_file.is_directory
		end

	is_file_readable (f: PATH): BOOLEAN
		do
			tmp_file.make_with_path (f)
			Result := tmp_file.exists and then not tmp_file.is_directory and then tmp_file.is_readable
		end

	tmp_file: RAW_FILE
		once
			create Result.make ("temp-file")
		end

	is_directory_readable (d: PATH): BOOLEAN
		do
			tmp_directory.make_with_path (d)
			Result := tmp_directory.exists and then tmp_directory.is_readable
		end

	tmp_directory: DIRECTORY
		once
			create Result.make ("temp-dir")
		end
note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
