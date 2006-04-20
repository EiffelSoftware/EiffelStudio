indexing

	description: "SYSKIND values"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_SYS_KIND 

feature -- Access

	Sys_win16: INTEGER is
			-- Target operating system for the type 
			-- library is 16-bit Windows systems.
		external
			"C [macro <oaidl.h>]"
		alias
			"SYS_WIN16"
		end

	Sys_win32: INTEGER is
			-- Target operating system for the type 
			-- library is 32-bit Windows systems. 
		external
			"C [macro <oaidl.h>]"
		alias
			"SYS_WIN32"
		end

	Sys_mac: INTEGER is
			-- Target operating system for the type 
			-- library is Apple Macintosh.
		external
			"C [macro <oaidl.h>]"
		alias
			"SYS_MAC"
		end

	is_valid_sys_kind (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid SYSKIND value?
		do
			Result := flag = Sys_win16 or
						flag = Sys_win32 or
						flag = Sys_mac
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
end -- class ECOM_SYS_KIND

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

