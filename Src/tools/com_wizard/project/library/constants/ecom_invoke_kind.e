indexing
	description: "INVOKEKIND constants"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_INVOKE_KIND

inherit
	ECOM_FLAGS

feature -- Access

	frozen Invoke_func: INTEGER is
			-- Member is called using normal function invocation syntax
		external
			"C [macro <oaidl.h>]"
		alias
			"INVOKE_FUNC"
		end
		
	frozen Invoke_propertyget: INTEGER is
			-- Function is invoked using normal property-access syntax
		external
			"C [macro <oaidl.h>]"
		alias
			"INVOKE_PROPERTYGET"
		end
		
	frozen Invoke_propertyput: INTEGER is
			-- Function is invoked using a property value assignment syntax
		external
			"C [macro <oaidl.h>]"
		alias
			"INVOKE_PROPERTYPUT"
		end	
		
	frozen Invoke_propertyputref: INTEGER is
			-- Function is invoked using property reference assignment syntax
		external
			"C [macro <oaidl.h>]"
		alias
			"INVOKE_PROPERTYPUTREF"
		end

feature -- Status report

	is_func (flag: INTEGER): BOOLEAN is
			-- Is normal function invocation syntax?
		do
			Result := binary_and (flag, Invoke_func) = Invoke_func
		end

	is_propertyget (flag: INTEGER): BOOLEAN is
			-- Is normal property-access syntax?
		do
			Result := binary_and (flag, Invoke_propertyget) = Invoke_propertyget
		end

	is_propertyput (flag: INTEGER): BOOLEAN is
			-- Is property value assignment syntax?
		do
			Result := binary_and (flag, Invoke_propertyput) = Invoke_propertyput
		end

	is_propertyputref (flag: INTEGER): BOOLEAN is
			-- Is property reference assignment syntax?
		do
			Result := binary_and (flag, Invoke_propertyputref) = Invoke_propertyputref
		end

	is_valid_invoke_kind (kind: INTEGER): BOOLEAN is
			-- Is `kind' a valid invoke kind?
		do
			Result := is_func (kind) or
			is_propertyget (kind) or
			is_propertyput (kind) or
			is_propertyputref (kind)
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
end -- class EOLE_INVOKEKIND

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

