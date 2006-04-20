indexing
	description: "FUNCKIND constants"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_FUNC_KIND

feature -- Access

	Func_purevirtual: INTEGER is
			-- Function is accessed via virtual function table
			-- and takes implicit 'this' pointer.	
			-- 1	
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNC_PUREVIRTUAL"
		end
		
	Func_virtual: INTEGER is
			-- Function is accessed same as PUREVIRTUAL,
			-- except function has implementation.
			-- 0
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNC_VIRTUAL"
		end
		
	Func_nonvirtual: INTEGER is
			-- Function is accessed by static address and takes
			-- implicit 'this' pointer.
			-- 2	
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNC_NONVIRTUAL"
		end
		
	Func_static: INTEGER is
			-- Function is accessed by static address
			-- and does not take implicit 'this' pointer.
			-- 3
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNC_STATIC"
		end
		
	Func_dispatch: INTEGER is
			-- Function can be accessed only via IDispatch.
			-- 4
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNC_DISPATCH"
		end

feature -- Status Report

	to_string (kind: INTEGER): STRING is
			-- String representation.
		do
			if kind = Func_purevirtual then
				Result := "Pure virtual"
			elseif kind = Func_virtual then
				Result := "Virtual"
			elseif kind = Func_nonvirtual then
				Result := "Nonvirtual"
			elseif kind = Func_static then
				Result := "Static"
			elseif kind = Func_dispatch then
				Result := "Dispatch"
			end
		end

feature -- Status setting
		
	is_valid_func_kind (kind: INTEGER): BOOLEAN is
			-- Is `kind' a valid function kind?
		do
			Result := kind = Func_purevirtual or
			kind = Func_virtual or
			kind = Func_nonvirtual or
			kind = Func_static or
			kind = Func_dispatch
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
end -- class ECOM_FUNC_KIND

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

