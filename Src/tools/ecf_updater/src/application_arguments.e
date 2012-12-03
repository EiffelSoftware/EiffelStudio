note
	description: "Summary description for {APPLICATION_ARGUMENTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	APPLICATION_ARGUMENTS

feature -- Access	

	files: LIST [PATH]
			-- List of libraries
		deferred
		end

	directories: LIST [PATH]
		deferred
		end

	replacements: detachable LIST [STRING_32]
		deferred
		end

	variable_expansions: detachable LIST [STRING_32]
		deferred
		end

	execution_forced: BOOLEAN
		deferred
		end

	backup_enabled: BOOLEAN
		deferred
		end

	simulation_enabled: BOOLEAN
		deferred
		end

	diff_enabled: BOOLEAN
		deferred
		end

	root_directory: PATH
		deferred
		end

	base_name: detachable STRING_32
		deferred
		end

	verbose: BOOLEAN
		deferred
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
