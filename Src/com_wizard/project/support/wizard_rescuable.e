indexing
	description: "Log generation"
	status: "See notice at end of class"
	date: "$$"
	revision: "$$"

class
	WIZARD_RESCUABLE

inherit
	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

feature -- Access

	failed_on_rescue: BOOLEAN is
			-- Should rescue clauses be ignored?
		local
			a_string: STRING
		once
			a_string := get (Env_variable_name)
			if a_string /= Void then
				Result := a_string.is_equal (True_string)
			else
				put (False_string, Env_variable_name)
			end
		end

feature {NONE} -- Implementation
	
	True_string: STRING is "True"
			-- True string

	False_string: STRING is "False"
			-- False string
	
	Env_variable_name: STRING is "ECOM_FAILED_ON_RESCUE"
			-- Environmnent variable name

end
