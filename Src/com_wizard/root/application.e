indexing
	description: "Root class of EiffelCOM Wizard"

class
	APPLICATION

inherit
	WEL_APPLICATION
		redefine
			init_application
		end

	WEL_SW_CONSTANTS
		export
			{NONE} all
		end

	WEL_ICC_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Access

	main_window: MAIN_WINDOW is
			-- Create the application's main window
		once
			create Result.make
		end

	common_ctl_dll_ex: WEL_INIT_COMMCTRL_EX
			-- Common controls dll

	rich_edit_dll: WEL_RICH_EDIT_DLL
			-- Rich edit dll
			
feature {NONE} -- Implementation

	init_application is
			-- Load common controls dlls
		do
			create common_ctl_dll_ex.make_with_flags (Icc_bar_classes + Icc_cool_classes)
			create rich_edit_dll.make
		end

end -- class APPLICATION

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
