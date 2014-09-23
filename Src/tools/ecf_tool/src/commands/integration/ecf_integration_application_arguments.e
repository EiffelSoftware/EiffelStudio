note
	description: "Summary description for {ECF_INTEGRATION_APPLICATION_ARGUMENTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECF_INTEGRATION_APPLICATION_ARGUMENTS

feature -- Access

	output_ecf: PATH
		deferred
		end

	root_directory: PATH
		deferred
		end

	directories: LIST [PATH]
		deferred
		end

	excluded_directories: detachable LIST [PATH]
		deferred
		end

	execution_forced: BOOLEAN
		deferred
		end

	verbose: BOOLEAN
		deferred
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
