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

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

