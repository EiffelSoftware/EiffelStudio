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
			!! Result.make (cwel_hinstance)
		ensure
			result_not_void: Result /= Void
		end

	previous_instance: WEL_INSTANCE is
			-- Previous instance argument received in WinMain
		once
			!! Result.make (cwel_previous_hinstance)
		ensure
			result_not_void: Result /= Void
		end

	command_line: STRING is
			-- Command line argument received in WinMain
		once
			!! Result.make (0)
			Result.from_c (cwel_command_line)
		ensure
			result_not_void: Result /= Void
		end

	command_show: INTEGER is
			-- Command show argument received in WinMain
		once
			Result := cwel_command_show
		end

feature {NONE} -- Externals

	cwel_hinstance: POINTER is
		external
			"C [macro <mainarg.h>]: EIF_POINTER"
		end

	cwel_previous_hinstance: POINTER is
		external
			"C [macro <mainarg.h>]: EIF_POINTER"
		end

	cwel_command_line: POINTER is
		external
			"C [macro <mainarg.h>]: EIF_POINTER"
		end

	cwel_command_show: INTEGER is
		external
			"C [macro <mainarg.h>]: EIF_INTEGER"
		end

end -- class WEL_MAIN_ARGUMENTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
