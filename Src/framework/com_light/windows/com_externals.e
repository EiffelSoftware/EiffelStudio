note
	description: "Light encapsulation of COM basics for Unmanaged MetaData and Debugger APIs."
	date: "$Date$"
	revision: "$Revision$"

class
	COM_EXTERNALS

feature -- High level

	initialize_com
			-- Call `com_initialize' only once as required
			-- per Windows documentation.
		local
			l_result: INTEGER
		once
			l_result := com_initialize_multithreaded
			check
				call_succeed: l_result = com_S_OK or else l_result = com_S_FALSE or else l_result = com_RPC_E_CHANGED_MODE
			end
		end

feature -- Disposal

	frozen release (a_pointer: POINTER): INTEGER
			-- Release COM objects represented by `a_pointer'.
		external
			"C++ IUnknown use %"unknwn.h%""
		alias
			"Release"
		ensure
			is_class: class
		end

feature -- AddRef

	frozen add_ref (a_pointer: POINTER): INTEGER
			-- AddRef COM objects represented by `a_pointer'.
		external
			"C++ IUnknown use %"unknwn.h%""
		alias
			"AddRef"
		ensure
			is_class: class
		end

feature -- Initialization

	frozen com_uninitialize
		external
			"C inline use %"unknwn.h%""
		alias
			"CoUninitialize()"
		ensure
			is_class: class
		end

	frozen com_initialize: INTEGER
		external
			"C inline use %"unknwn.h%""
		alias
			"CoInitialize(NULL)"
		ensure
			is_class: class
		end

	frozen com_initialize_multithreaded: INTEGER
		external
			"C++ inline use %"objbase.h%""
		alias
			"CoInitializeEx(NULL, COINIT_MULTITHREADED)"
		ensure
			is_class: class
		end

	frozen com_initialize_apartmentthreaded: INTEGER
		external
			"C++ inline use %"objbase.h%""
		alias
			"CoInitializeEx(NULL, COINIT_APARTMENTTHREADED)"
		ensure
			is_class: class
		end

	frozen com_S_OK, frozen s_ok: INTEGER
		external
			"C macro use %"objbase.h%""
		alias
			"S_OK"
		ensure
			is_class: class
		end

	frozen com_S_FALSE, frozen s_false: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"S_FALSE"
		ensure
			is_class: class
		end

	frozen com_RPC_E_CHANGED_MODE: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"RPC_E_CHANGED_MODE"
		ensure
			is_class: class
		end

feature -- HRESULT

	frozen com_REGDB_E_CLASSNOTREG: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"REGDB_E_CLASSNOTREG"
		ensure
			is_class: class
		end

	frozen com_CLASS_E_NOAGGREGATION: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"CLASS_E_NOAGGREGATION"
		ensure
			is_class: class
		end

	frozen com_E_NOINTERFACE: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"E_NOINTERFACE"
		end

	frozen com_E_POINTER: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"E_POINTER"
		ensure
			is_class: class
		end

	frozen com_DISP_E_BADPARAMCOUNT: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"DISP_E_BADPARAMCOUNT"
		ensure
			is_class: class
		end

	frozen com_DISP_E_BADVARTYPE: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"DISP_E_BADVARTYPE"
		ensure
			is_class: class
		end

	frozen com_DISP_E_EXCEPTION: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"DISP_E_EXCEPTION"
		ensure
			is_class: class
		end

	frozen com_DISP_E_MEMBERNOTFOUND: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"DISP_E_MEMBERNOTFOUND"
		ensure
			is_class: class
		end

	frozen com_DISP_E_NONAMEDARGS: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"DISP_E_NONAMEDARGS"
		ensure
			is_class: class
		end

	frozen com_DISP_E_OVERFLOW: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"DISP_E_OVERFLOW"
		ensure
			is_class: class
		end

	frozen com_DISP_E_PARAMNOTFOUND: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"DISP_E_PARAMNOTFOUND"
		ensure
			is_class: class
		end

	frozen com_DISP_E_TYPEMISMATCH: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"DISP_E_TYPEMISMATCH"
		ensure
			is_class: class
		end

	frozen com_DISP_E_UNKNOWNINTERFACE: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"DISP_E_UNKNOWNINTERFACE"
		ensure
			is_class: class
		end

	frozen com_DISP_E_UNKNOWNLCID: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"DISP_E_UNKNOWNLCID"
		ensure
			is_class: class
		end

	frozen com_DISP_E_PARAMNOTOPTIONAL: INTEGER
		external
			"C macro use %"unknwn.h%""
		alias
			"DISP_E_PARAMNOTOPTIONAL"
		ensure
			is_class: class
		end

feature -- VARTYPE constants

	vt_empty: NATURAL_16 = 0
	vt_null: NATURAL_16 = 1

	vt_i1: NATURAL_16 = 16
	vt_i2: NATURAL_16 = 2
	vt_i4: NATURAL_16 = 3
	vt_i8: NATURAL_16 = 20
			-- Constants for signed integers.

	vt_ui1: NATURAL_16 = 17
	vt_ui2: NATURAL_16 = 18
	vt_ui4: NATURAL_16 = 19
	vt_ui8: NATURAL_16 = 21
			-- Constant for unsigned integers.

	vt_ptr: NATURAL_16 = 26
			-- Constant for pointer.

	vt_variant: NATURAL_16 = 12
	vt_unknown: NATURAL_16 = 13

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
