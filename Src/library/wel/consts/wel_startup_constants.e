indexing
	description: "Process creation flags."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STARTUP_CONSTANTS

inherit
	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

feature -- Access

	Startf_use_show_window: INTEGER is
			-- Attribute `show_command' from WEL_STARTUP_INFO is meaningful
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_USESHOWWINDOW"
		end

	Startf_use_position: INTEGER is
			-- Attributes `x_offset' and `y_offset' from WEL_STARTUP_INFO are meaningful
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_USEPOSITION"
		end
	
	Startf_use_size: INTEGER is
			-- Attributes `width' and `height' from WEL_STARTUP_INFO are meaningful
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_USESIZE"
		end

	Startf_use_count_chars: INTEGER is
			-- Attributes `x_character_count' and `y_character_count' from WEL_STARTUP_INFO are meaningful
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_USECOUNTCHARS"
		end

	Startf_use_fill_attributes: INTEGER is
			-- Attribute `fill_attributes' from WEL_STARTUP_INFO is meaningful
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_USEFILLATTRIBUTE"
		end

	Startf_force_on_feedback: INTEGER is
			-- Cursor set to feedback until window intialization is done
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_FORCEONFEEDBACK"
		end

	Startf_force_off_feedback: INTEGER is
			-- Feedback cursor forced off
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_FORCEOFFFEEDBACK"
		end

	Startf_use_std_handles: INTEGER is
			-- Attributes `std_input', `std_output' and `std_error' from WEL_STARTUP_INFO are meaningful
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_USESTDHANDLES"
		end

	is_valid_startup_flag (a_flag: INTEGER): BOOLEAN is
			-- Is `a_flag' a valid startup flag?
		do
			Result := a_flag = Startf_use_show_window or
				a_flag = Startf_use_position or
				a_flag = Startf_use_size or
				a_flag = Startf_use_count_chars or
				a_flag = Startf_use_fill_attributes or
				a_flag = Startf_force_on_feedback or
				a_flag = Startf_force_off_feedback or
				a_flag = Startf_use_std_handles
		end

	is_valid_startup_flags (a_flags: INTEGER): BOOLEAN is
			-- Is `a_flags' a valid startup flags combination?
		do
			Result := flag_set (Startf_use_show_window +
				Startf_use_position +
				Startf_use_size +
				Startf_use_count_chars +
				Startf_use_fill_attributes +
				Startf_force_on_feedback +
				Startf_force_off_feedback +
				Startf_use_std_handles, a_flags)
		end

end -- class WEL_STARTUP_CONSTANTS


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

