indexing
	description: "Main arguments received in the WinMain Windows function."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MAIN_ARGUMENTS

feature -- Access

	current_instance: WEL_INSTANCE is
			-- Current instance argument received in WinMain
		once
			create Result.make (cwel_get_module_handle (default_pointer))
		ensure
			result_not_void: Result /= Void
		end

	resource_instance: WEL_INSTANCE is
			-- Resource instance argument received in WinMain.
			-- Because resources are linked with the associated shared
			-- library and not to the assembly, we need to look up the resources
			-- into the associated shared library and not in the current application.
		local
			l_str: WEL_STRING
			l_name: STRING
			l_pos: INTEGER
		once
				-- Note: 
			l_name := current_instance.name
			l_pos := l_name.last_index_of (feature {PATH}.Directory_separator_char, l_name.count)
			l_name.remove_head (l_pos)
			l_name.prepend ("lib")
			l_name.remove_tail (4)
			l_name.append (".dll")
			create l_str.make (l_name)
			create Result.make (cwel_get_module_handle (l_str.item))
		ensure
			result_not_void: Result /= Void
		end

	previous_instance: WEL_INSTANCE is
			-- Previous instance argument received in WinMain
		once
			create Result.make (default_pointer)
		ensure
			result_not_void: Result /= Void
		end

	command_line: STRING is
			-- Command line argument received in WinMain
		once
			create Result.make_from_cil (feature {ENVIRONMENT}.command_line)
		ensure
			result_not_void: Result /= Void
		end

	command_show: INTEGER is
			-- Command show argument received in WinMain
		once
			Result := feature {WEL_SW_CONSTANTS}.Sw_show
		end

feature {NONE} -- Externals

	cwel_get_module_handle (name: POINTER): POINTER is
		external
			"C [macro <windows.h>] (LPCTSTR): HMODULE"
		alias
			"GetModuleHandle"
		end

end -- class WEL_MAIN_ARGUMENTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

