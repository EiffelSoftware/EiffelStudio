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
			Result := execution_environment.get (Ise_c_compiler)
			if Result = Void then
				Result := "msc"
				execution_environment.put ("msc", Ise_c_compiler)
			end
		ensure
			non_void_compiler: Result /= Void
			valid_compiler: Result.is_equal ("msc") or 
						Result.is_equal ("bcb")
		end
		
	Eiffel4_location: STRING is
			-- Location of Eiffel compiler.
		once
			Result := execution_environment.get (Ise_eiffel)
			if Result = Void then
				Result := execution_environment.get (Eiffel4)
				if Result /= Void then				
					Eiffel4_defined_cell.set_item (True)
				else
					Result := execution_environment.get (Eiffel5)
					if Result /= Void then
						Eiffel5_defined_cell.set_item (True)
					end
				end
			end
		ensure
			non_void_location: Result /= Void
		end

	eiffel_compiler: STRING is
			-- Name of Eiffel compiler executable.
		require
			non_void_eiffel_location: Eiffel4_location /= Void
			valid_location: not Eiffel4_location.is_empty
		local
			directory: DIRECTORY
		once
			create directory.make (Eiffel4_location + "\bench\spec\windows\bin")
			if directory.exists then
				if directory.has_entry ("ec.exe") then
					Result := Eiffel4_location + "\bench\spec\windows\bin\" + "ec.exe"
				elseif directory.has_entry ("es4.exe") then
					Result :=  Eiffel4_location + "\bench\spec\windows\bin\" + "es4.exe"
				end
			end
		ensure
			non_void_compiler: Result /= Void
		end
	
	Eiffel4_defined: BOOLEAN is
			-- Is EIFFEL4 environment variable defined?
		do
			Result := Eiffel4_defined_cell.item
		end

	Eiffel5_defined: BOOLEAN is
			-- Is EIFFEL5 environment variable defined?
		do
			Result := Eiffel5_defined_cell.item
		end
			
feature {NONE} -- Implementation

	Eiffel4_defined_cell: BOOLEAN_REF is
		once
			create Result
		end

	Eiffel5_defined_cell: BOOLEAN_REF is
		once
			create Result
		end
		
	execution_environment: EXECUTION_ENVIRONMENT is
			-- Execution environment.
		once
			create Result
		end

	Eiffel4: STRING is "EIFFEL4"
			-- Eiffel4 environmnent variable.

	Eiffel5: STRING is "EIFFEL5"
			-- Eiffel5 environmnent variable.

	Ise_eiffel: STRING is "ISE_EIFFEL"
			-- Ise_eiffel environmnent variable.

	Ise_c_compiler: STRING is "ISE_C_COMPLIER"
			-- ISE_C_COMPLIER environmnent variable.

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
