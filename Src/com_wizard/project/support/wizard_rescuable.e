indexing
	description: "Log generation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RESCUABLE

inherit
	WIZARD_EXECUTION_ENVIRONMENT

feature -- Access

	failed_on_rescue: BOOLEAN is
			-- Should rescue clauses be ignored?
		local
			a_string: STRING
		once
			a_string := Env.get (Env_variable_name)
			if a_string /= Void then
				Result := a_string.is_equal (True_string)
			else
				Env.put (False_string, Env_variable_name)
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

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
