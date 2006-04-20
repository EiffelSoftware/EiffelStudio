indexing
	description: "VARKIND contants"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_VAR_KIND

feature 

	Var_perinstance: INTEGER is
			-- Variable is field or member of type
			-- it exists at fixed offset within each instance of type.
		external
			"C [macro <oaidl.h>]"
		alias
			"VAR_PERINSTANCE"
		end

	Var_static: INTEGER is
			-- Only one instance of variable
		external
			"C [macro <oaidl.h>]"
		alias
			"VAR_STATIC"
		end

	Var_const: INTEGER is
			-- VARDESC describes symbolic constant
			-- There is no memory associated with it.
		external
			"C [macro <oaidl.h>]"
		alias
			"VAR_CONST"
		end

	Var_dispatch: INTEGER is
			-- Variable can only be accessed via feature
			-- `invoke' of class EOLE_DISPATCH.
		external
			"C [macro <oaidl.h>]"
		alias
			"VAR_DISPATCH"
		end

	is_valid_var_kind (kind: INTEGER): BOOLEAN is
			-- Is `kind' a valid variable kind?
		do
			Result := kind = Var_perinstance or
			kind = Var_static or
			kind = Var_const or
			kind = Var_dispatch
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
end -- class ECOM_VAR_KIND

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

