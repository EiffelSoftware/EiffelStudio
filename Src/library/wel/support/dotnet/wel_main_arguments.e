note
	description: "Main arguments received in the WinMain Windows function."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MAIN_ARGUMENTS

feature -- Access

	current_instance: WEL_INSTANCE
			-- Current instance argument received in WinMain
		once
			create Result.make (cwel_get_module_handle (default_pointer))
		ensure
			result_not_void: Result /= Void
		end

	resource_instance: WEL_INSTANCE
			-- Resource instance argument received in WinMain.
			-- Because resources are linked with the associated shared
			-- library and not to the assembly, we need to look up the resources
			-- into the associated shared library and not in the current application.
		local
			l_str: WEL_STRING
			l_name: STRING_32
			l_path, l_parent_path: PATH
		once
				-- Note:
			create l_path.make_from_string (current_instance.name)
			l_parent_path := l_path.parent
			if attached l_path.entry as l_entry then
				create l_name.make_from_string_general (l_entry.name)
				l_name.insert_string ("lib", 1)
				if attached l_entry.extension as l_ext then
					l_name.remove_tail (l_ext.count + 1)
				end
				l_name.append (".dll")
				create l_str.make (l_parent_path.extended (l_name).name)
			else
				check not_possible: False end
				create l_str.make ("Invalid_path.dll")
			end
			create Result.make (cwel_load_library (l_str.item))
		ensure
			result_not_void: Result /= Void
		end

	previous_instance: WEL_INSTANCE
			-- Previous instance argument received in WinMain
		once
			create Result.make (default_pointer)
		ensure
			result_not_void: Result /= Void
		end

	command_line: STRING_32
			-- Command line argument received in WinMain
		once
			create Result.make_from_cil ({ENVIRONMENT}.command_line)
		ensure
			result_not_void: Result /= Void
		end

	command_show: INTEGER
			-- Command show argument received in WinMain
		once
			Result := {WEL_SW_CONSTANTS}.Sw_show
		end

feature {NONE} -- Externals

	cwel_get_module_handle (name: POINTER): POINTER
		external
			"C [macro <windows.h>] (LPCTSTR): HMODULE"
		alias
			"GetModuleHandle"
		end

	cwel_load_library (name: POINTER): POINTER
		external
			"C [macro <windows.h>] (LPCTSTR): HMODULE"
		alias
			"LoadLibrary"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class WEL_MAIN_ARGUMENTS

