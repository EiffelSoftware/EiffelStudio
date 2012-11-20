note
	description: "Same as {EXECUTION_ENVIRONMENT} with names in {STRING_32}."
	date: "$Date$"
	revision: "$Revision$"

class
	EXECUTION_ENVIRONMENT_32

inherit
	EXECUTION_ENVIRONMENT
		rename
			current_working_directory as current_working_directory_8,
			get as get_8,
			item as get,
			home_directory_name as home_directory_name_8,
			user_directory_name as user_directory_name_8
		end

feature -- Access

	current_working_directory: STRING_32
			-- Directory of current execution
			-- Execution of this query on concurrent threads will result in
			-- an unspecified behavior.
		obsolete
			"Use `current_working_path' instead."
		local
			l_count, l_nbytes: INTEGER
			l_managed: MANAGED_POINTER
		do
			l_count := 50
			create l_managed.make (l_count)
			l_nbytes := eif_dir_current (l_managed.item, l_count)
			if l_nbytes = -1 then
					-- The underlying OS could not retrieve the current working directory. Most likely
					-- a case where it has been deleted under our feet. We simply return that the current
					-- directory is `.' the symbol for the current working directory.
				Result := "."
			else
				if l_nbytes > l_count then
						-- We need more space.
					l_count := l_nbytes
					l_managed.resize (l_count)
					l_nbytes := eif_dir_current (l_managed.item, l_count)
				end
				if l_nbytes > 0 and l_nbytes <= l_count then
					Result := file_info.pointer_to_file_name_32 (l_managed.item)
				else
						-- Something went wrong.
					Result := "."
					check False end
				end
			end
		ensure
			result_not_void: Result /= Void
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
