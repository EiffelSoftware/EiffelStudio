indexing

	description: "COM component instantiation context constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	ECOM_CLSCTX

feature -- Access

	Clsctx_inproc_server: INTEGER is
			-- The code that creates and manages objects of 
			-- descendant class runs in the same process as the 
			-- caller of the function specifying the class context. 
		external
			"C [macro <wtypes.h>]"
		alias
			"CLSCTX_INPROC_SERVER"
		end
		
	Clsctx_inproc_handler: INTEGER is
			-- The code that manages objects of descendant class
			-- is an in-process handler. This is a DLL that runs 
			-- in the client process and implements client-side 
			-- structures of this class when instances of the 
			-- class are accessed remotely. 
		external
			"C [macro <wtypes.h>]"
		alias
			"CLSCTX_INPROC_SERVER"
		end			
		
	Clsctx_local_server: INTEGER is
			-- The EXE code that creates and manages objects of
			-- descendant class is loaded in a separate process space
			-- (runs on same machine but in a different process).
		external
			"C [macro <wtypes.h>]"
		alias
			"CLSCTX_LOCAL_SERVER"
		end
		
	Clsctx_server: INTEGER is
			-- Indicates server code, whether in-process or local.
		external
			"C [macro <objbase.h>]"
		alias
			"CLSCTX_SERVER"
		end
		
	Clsctx_all: INTEGER is
			-- Indicates all class contexts.
		external
			"C [macro <objbase.h>]"
		alias
			"CLSCTX_ALL"
		end
		
	is_valid_clsctx (context: INTEGER): BOOLEAN is
			-- Is `context' a valid class context?
		do
			Result := context = Clsctx_inproc_server or
						context = Clsctx_inproc_handler or
						context = Clsctx_local_server or
						context = Clsctx_server or
						context = Clsctx_all
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
end -- class EOLE_CLSCTX

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

