indexing
	description: "Wizard wrapper to EXECUTION_ENVIRONMENT"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EXECUTION_ENVIRONMENT

feature -- Access

	Ise_c_compiler_value: STRING is
			-- ISE_C_COMPILER value
		once
			Result := Env.get (Ise_c_compiler)
			if Result = Void then
				Result := "msc"
				Env.put ("msc", Ise_c_compiler)
			end
		ensure
			non_void_compiler: Result /= Void
			valid_compiler: Result.is_equal ("msc") or Result.is_equal ("bcb")
		end

	Eiffel_installation_dir_name: STRING is
			-- Path to Installation directory of ISE Eiffel
		once
			Result := Env.get ("ISE_EIFFEL")
		end
		
	eiffel_compiler: STRING is
			-- Path to Eiffel compiler executable.
		require
			valid_installation: Eiffel_installation_dir_name /= Void
		once
			create Result.make (256)
			Result.append (Eiffel_installation_dir_name)
			Result.append ("\studio\spec\windows\bin\ec.exe")
		end
	
	Ise_c_compiler: STRING is "ISE_C_COMPLIER"
			-- ISE_C_COMPLIER environmnent variable.

feature {NONE} -- Implementation

	Env: EXECUTION_ENVIRONMENT is
			-- Execution environment
		once
			create Result
		end
		
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
