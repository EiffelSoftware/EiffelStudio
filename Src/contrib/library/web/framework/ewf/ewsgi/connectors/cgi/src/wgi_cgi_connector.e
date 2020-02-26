note
	description: "CGI connector, see CGI interface, and CGI scripts."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_CGI_CONNECTOR [G -> WGI_EXECUTION create make end]

inherit
	WGI_CONNECTOR

	SHARED_HTML_ENCODER

	SHARED_EXECUTION_ENVIRONMENT

feature -- Access

	Name: STRING_8 = "CGI"
			-- Name of Current connector

	Version: STRING_8 = "0.1"
			-- Version of Current connector	

feature -- Execution

	launch
			-- Launch execution of CGI application.
		local
			req: WGI_REQUEST_FROM_TABLE
			res: detachable WGI_RESPONSE_STREAM
			exec: detachable WGI_EXECUTION
			rescued: BOOLEAN
		do
			if not rescued then
				create req.make (execution_environment.starting_environment, create {WGI_CGI_INPUT_STREAM}.make, Current)
				create res.make (create {WGI_CGI_OUTPUT_STREAM}.make, create {WGI_CGI_ERROR_STREAM}.make)
				create {G} exec.make (req, res)
				exec.execute
				res.push
				exec.clean
			elseif exec /= Void then
				exec.execute_rescue ((create {EXCEPTION_MANAGER}).last_exception)
				exec.clean
			else
				(create {WGI_RESCUE_EXECUTION}).execute (req, res, (create {EXCEPTION_MANAGER}).last_exception)
			end				
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

note
	copyright: "2011-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
