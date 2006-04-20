indexing
	description: "Light encapsulation of COM basics for Unmanaged MetaData and Debugger APIs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_COM

feature -- High level

	initialize_com is
			-- Call `com_initialize' only once as required
			-- per Windows documentation.
		local
			l_result: INTEGER
		once
			l_result := com_initialize_multithreaded
			check
				call_succeed: l_result = com_S_OK or else l_result = com_S_FALSE
			end
		end

feature -- Disposal

	frozen release (a_pointer: POINTER): INTEGER is
			-- Release COM objects represented by `a_pointer'.
		external
			"C++ IUnknown use %"unknwn.h%""
		alias
			"Release"
		end
		
feature -- AddRef

	frozen add_ref (a_pointer: POINTER): INTEGER is
			-- AddRef COM objects represented by `a_pointer'.
		external
			"C++ IUnknown use %"unknwn.h%""
		alias
			"AddRef"
		end
		
feature {NONE} -- Initialization

	frozen com_uninitialize is
		external
			"C inline use %"unknwn.h%""
		alias
			"CoUninitialize()"
		end

	frozen com_initialize: INTEGER is
		external
			"C inline use %"unknwn.h%""
		alias
			"CoInitialize(NULL)"
		end

	frozen com_initialize_multithreaded: INTEGER is
		external
			"C++ inline use %"objbase.h%""
		alias
			"CoInitializeEx(NULL, COINIT_MULTITHREADED)"
		end

	frozen com_initialize_apartmentthreaded: INTEGER is
		external
			"C++ inline use %"objbase.h%""
		alias
			"CoInitializeEx(NULL, COINIT_APARTMENTTHREADED)"
		end	

	frozen com_S_OK: INTEGER is
		external
			"C macro use %"objbase.h%""
		alias
			"S_OK"
		end

	frozen com_S_FALSE: INTEGER is
		external
			"C macro use %"unknwn.h%""
		alias
			"S_FALSE"
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

end -- class CLI_COM
