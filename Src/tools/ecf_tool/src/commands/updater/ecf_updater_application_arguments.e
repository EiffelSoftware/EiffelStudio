note
	description: "Summary description for {ECF_UPDATER_APPLICATION_ARGUMENTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECF_UPDATER_APPLICATION_ARGUMENTS

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

	root_directory: detachable PATH
			-- Root directory, mainly used to resolve ISE_LIBRARY env variable and similar.
		deferred
		end

	included_directories: detachable LIST [PATH]
			-- Directories to scan for libraries ecf.
		deferred
		end

	avoided_directories: detachable LIST [PATH]
			-- When updater has multiple choice for new ecf location,
			-- the one inside avoided directories has lower priority.
		deferred
		end

	excluded_directories: detachable LIST [PATH]
			-- Excluded directories from known ecf.
		deferred
		end

	base_name: detachable STRING_32
		deferred
		end

	verbose: BOOLEAN
		deferred
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
