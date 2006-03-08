indexing
	description: "Wizard wrapper to EXECUTION_ENVIRONMENT"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EXECUTION_ENVIRONMENT

feature -- Access

	use_bcb: BOOLEAN is
			-- SHould wizard use Borland C compiler?
		once
			Result := Ise_c_compiler_value.is_equal ("bcb")
		end

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
			Result.append ("\studio\spec\")
			Result.append (Env.get ("ISE_PLATFORM"))
			Result.append ("\bin\ec.exe")
		end

	Ise_c_compiler: STRING is "ISE_C_COMPILER"
			-- ISE_C_COMPLIER environmnent variable.

feature {NONE} -- Implementation

	Env: EXECUTION_ENVIRONMENT is
			-- Execution environment
		once
			create Result
		end

end -- class WIZARD_EXECUTION_ENVIRONMENT

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
