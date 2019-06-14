note
	description: "Summary description for {ECF_FOREACH_ARGUMENTS}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECF_FOREACH_ARGUMENTS

feature -- Access

	execution_forced: BOOLEAN
		deferred
		end

	simulation_enabled: BOOLEAN
		deferred
		end

	included_paths: detachable LIST [PATH]
			-- Path of ecf file or directories to scan for ecf.
		deferred
		end

	excluded_directories: detachable LIST [PATH]
			-- Excluded directories from known ecf.
		deferred
		end

	regexp_pattern: detachable READABLE_STRING_32
			-- Pattern matching ecf file name.
		deferred
		end

	expression: READABLE_STRING_32
		deferred
		end

	verbose: BOOLEAN
		deferred
		end

	only_application: BOOLEAN
			-- Process only application ecf
		deferred
		end

	only_testing: BOOLEAN
			-- Process only target with testing
		deferred
		end

	only_library: BOOLEAN
			-- Process only library targets
		deferred
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
