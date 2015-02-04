note
	description: "A web server mock class."
	author: "Florian Besser, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	WEBSERVER

feature -- Factories

	new_not_found: NOT_FOUND_EXCEPTION
		do create Result end

	new_timeout: TIMEOUT_EXCEPTION
		do create Result end

feature -- Basic operations

	simulate_request (type: INTEGER; exception_string: detachable separate STRING): BOOLEAN
			-- Simulate request serving with several exceptions.
			-- type 0: normal termination
			-- type 1: exception - not found
			-- type 2: exception - timeout
		local
			l_string: detachable STRING
			l_exception: EXCEPTION
		do
			if attached exception_string then
				create l_string.make_from_separate (exception_string)
			end

			if type = 1 then
				l_exception := new_not_found
				l_exception.set_description (l_string)
				l_exception.raise
			elseif type = 2 then
				l_exception := new_timeout
				l_exception.set_description (l_string)
				l_exception.raise
			else
				Result := True
			end
		end

end
