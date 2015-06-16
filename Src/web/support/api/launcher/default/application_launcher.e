note
	description: "[
				Effective class for APPLICATION_LAUNCHER_I

				You can put modification in this class
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_LAUNCHER [G -> WSF_EXECUTION create make end]

inherit
	APPLICATION_LAUNCHER_I [G]

	SHARED_EXECUTION_ENVIRONMENT


feature -- Status Report

	is_console_output_supported: BOOLEAN
		do
			Result := launcher_nature = nature_nino
		end

	feature {NONE} -- Initialization

	launcher_nature: detachable READABLE_STRING_8
			-- Initialize the launcher nature
			-- either cgi, libfcgi, or nino.
			--| We could extend with more connector if needed.
			--| and we could use WSF_DEFAULT_SERVICE_LAUNCHER to configure this at compilation time.
		local
			p: PATH
			ext: detachable READABLE_STRING_32
		do
			create p.make_from_string (execution_environment.arguments.command_name)
			if attached p.entry as l_entry then
				ext := l_entry.extension
			end
			if ext /= Void then
				if ext.same_string (nature_nino) then
					Result := nature_nino
				end
			end
		end

feature {NONE} -- nino		

	nature_nino: STRING = "nino"


end

