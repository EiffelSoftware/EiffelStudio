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
			Result := execution_environment.get (Eiffel5)
			if Result = Void then
				Result := execution_environment.get (Eiffel4)
				Eiffel4_defined := True
			end
		ensure
			non_void_location: Result /= Void
		end

	eiffel_compiler: STRING is
			-- Name of Eiffel compiler executable.
		require
			non_void_eiffel_location: Eiffel4_location /= Void
			valid_location: not Eiffel4_location.empty
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
	
	Eiffel4_defined: BOOLEAN
			-- Is EIFFEL4 environment variable defined?
			
feature {NONE} -- Implementation

	execution_environment: EXECUTION_ENVIRONMENT is
			-- Execution environment.
		once
			create Result
		end

	Eiffel4: STRING is "EIFFEL4"
			-- Eiffel4 environmnent variable

	Eiffel5: STRING is "EIFFEL5"
			-- Eiffel5 environmnent variable

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
