indexing
	description: "Wizard wrapper to EXECUTION_ENVIRONMENT"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EXECUTION_ENVIRONMENT

feature -- Access

	Eiffel4_location: STRING is
			-- Location of Eiffel compiler.
		once
			Result := execution_environment.get (Eiffel4)
		end

feature {NONE} -- Implementation

	execution_environment: EXECUTION_ENVIRONMENT is
			-- Execution environment.
		once
			create Result
		end

	Eiffel4: STRING is "EIFFEL4"
			-- Eiffel4 environmnent variable

end -- class WIZARD_EXECUTION_ENVIRONMENT

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
