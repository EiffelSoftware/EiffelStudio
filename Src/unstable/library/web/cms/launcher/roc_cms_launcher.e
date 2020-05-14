note
	description: "[
				Reusable ROC CMS launcher.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ROC_CMS_LAUNCHER [G -> CMS_EXECUTION create make end]

inherit
	WSF_LAUNCHABLE_SERVICE
		rename
			make_and_launch as make_and_launch_service
		redefine
			initialize
		end

	REFACTORING_HELPER

	SHARED_EXECUTION_ENVIRONMENT

	SHARED_LOGGER

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
		do
			create launcher
			make_and_launch_service
		end

	initialize
			-- Initialize current service.
		local
			env: CMS_ENVIRONMENT
			l_app_name: detachable READABLE_STRING_32
		do
			Precursor
			create env.make_default
			l_app_name := optional_application_name
			if l_app_name = Void then
				l_app_name := env.name
			end
			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} service_options.make_from_file (l_app_name + ".ini")
			initialize_logger (env)
		end

	optional_application_name: detachable READABLE_STRING_32
			-- Optional application name.
			--| Redefine if needed.
		do
		end

feature {NONE} -- Launch operation

	launcher: APPLICATION_LAUNCHER [G]

	launch (opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			l_retry: BOOLEAN
			l_message: STRING_32
		do
			if not l_retry then
				launcher.launch (opts)
			else
					-- error hanling.
				create l_message.make (1024)
				if attached ((create {EXCEPTION_MANAGER}).last_exception) as l_exception then
					if attached l_exception.description as l_description then
						l_message.append (l_description.as_string_32)
						l_message.append ("%N%N")
					elseif attached l_exception.trace as l_trace then
						l_message.append (l_trace)
						l_message.append ("%N%N")
					else
						l_message.append (l_exception.out)
						l_message.append ("%N%N")
					end
				else
					l_message.append ("The application crashed without information.")
					l_message.append ("%N%N")
				end
				-- send email shutdown
				-- TODO: to implement!
			end
		rescue
			l_retry :=  True
			retry
		end

end

