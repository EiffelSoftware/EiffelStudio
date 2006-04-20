indexing
	description: "Wizard wrapper to EXECUTION_ENVIRONMENT"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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
