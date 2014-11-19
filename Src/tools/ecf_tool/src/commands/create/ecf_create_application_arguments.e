note
	description: "Summary description for {ECF_INTEGRATION_APPLICATION_ARGUMENTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECF_CREATE_APPLICATION_ARGUMENTS

feature -- Status report

	is_successful: BOOLEAN
		deferred
		end

feature -- Access

	is_library_target: BOOLEAN
		deferred
		end

	is_application_target: BOOLEAN
		deferred
		end

	is_testing_target: BOOLEAN
		deferred
		end

	target_type: STRING
		do
			if is_library_target then
				Result := {ECF_BUILDER}.library_target_type
			elseif is_application_target then
				Result := {ECF_BUILDER}.application_target_type
			elseif is_testing_target then
				Result := {ECF_BUILDER}.testing_target_type
			else
					-- Default to library
				Result := {ECF_BUILDER}.library_target_type
			end
		end

	clusters: detachable LIST [STRING_32]
			-- List of clusters
		require
			is_successful: is_successful
		deferred
		end

	tests_clusters: detachable LIST [STRING_32]
			-- List of clusters
		require
			is_successful: is_successful
		deferred
		end

	libraries: detachable LIST [STRING_32]
			-- List of libraries
		require
			is_successful: is_successful
		deferred
		end

	target_name: STRING
		deferred
		end

	base_location: PATH
		deferred
		end

	uuid: STRING
		deferred
		end

	syntax_mode: STRING
		deferred
		end

	concurrency: detachable STRING
		deferred
		end

	executable_name: detachable STRING
		deferred
		end

	root_info: detachable TUPLE [cluster: detachable STRING; class_name: STRING; feature_name: STRING]
		deferred
		end

	is_console_application: BOOLEAN
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
