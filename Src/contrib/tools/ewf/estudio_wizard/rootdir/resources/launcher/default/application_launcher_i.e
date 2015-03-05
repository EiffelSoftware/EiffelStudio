note
	description: "[
			Specific application launcher

			DO NOT EDIT THIS CLASS

			you can customize APPLICATION_LAUNCHER
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	APPLICATION_LAUNCHER_I

feature -- Execution

	launch (a_service: WSF_SERVICE; opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
			-- Launch Web Server Application using `a_service' and optionals `opts'.
		local
			launcher: WSF_SERVICE_LAUNCHER
		do
{literal}
			create {WSF_DEFAULT_SERVICE_LAUNCHER} launcher.make_and_launch (a_service, opts){/literal}
		end

	launcher_id: detachable READABLE_STRING_GENERAL
		do
			-- Not used for default connector selection.
		end

end

