note

	description:

		"Environment variables defined and used in ISE's tools."

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2010, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_ISE_VARIABLES

inherit

	ANY

	KL_SHARED_EXECUTION_ENVIRONMENT
		export {NONE} all end

feature -- Access

	ise_eiffel_variable: STRING = "ISE_EIFFEL"
			-- Name of environment variable "$ISE_EIFFEL"

	ise_eiffel_value: detachable STRING
			-- Value of environment variable "$ISE_EIFFEL"
		do
			Result := Execution_environment.variable_value (ise_eiffel_variable)
		end

	ise_library_variable: STRING = "ISE_LIBRARY"
			-- Name of environment variable "$ISE_LIBRARY"

	ise_library_value: detachable STRING
			-- Value of environment variable "$ISE_LIBRARY"
		do
			Result := Execution_environment.variable_value (ise_library_variable)
		end

feature -- Setting

	set_ise_library_variable
			-- Set environment variable $ISE_LIBRARY to $ISE_EIFFEL if not set yet.
		local
			l_ise_eiffel: detachable STRING
			l_ise_library: detachable STRING
		do
			l_ise_library := ise_library_value
			if l_ise_library = Void or else l_ise_library.is_empty then
				l_ise_eiffel := ise_eiffel_value
				if l_ise_eiffel /= Void and then not l_ise_eiffel.is_empty then
					Execution_environment.set_variable_value (ise_library_variable, l_ise_eiffel)
				end
			end
		end

end
