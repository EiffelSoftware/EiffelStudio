indexing
	description:
	"DIALOG_DEMO_WINDOW, demo window to test the common dialogs%
	% Belongs to EiffelVision example.";
	date: "$Date$";
	revision: "$Revision$"

class
	DIALOG_DEMO_WINDOW

inherit
	DEMO_WINDOW
		redefine
			main_widget,
			set_widgets,
			set_values
		end

creation
	make

feature -- Access

	main_widget: EV_DYNAMIC_TABLE is
			-- The main widget of the demo
		once
			!! Result.make (Current)
			Result.set_row_layout
			Result.set_finite_dimension (1)
		end
	
feature -- Access
	
	button: EV_BUTTON

feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		local
			info_cmd: MESSAGE_DIALOG_COMMAND
			error_cmd: ERROR_DIALOG_COMMAND
			question_cmd: QUESTION_DIALOG_COMMAND
			warning_cmd: WARNING_DIALOG_COMMAND
			arg: EV_ARGUMENT1 [EV_WIDGET]
		do
			!! arg.make(Current)
			!! button.make_with_text (main_widget, "EV_INFORMATION_DIALOG")
			!! info_cmd
			button.add_click_command (info_cmd, arg)
			!! button.make_with_text (main_widget, "EV_ERROR_DIALOG")
			!! error_cmd
			button.add_click_command (error_cmd, arg)
			!! button.make_with_text (main_widget, "EV_QUESTION_DIALOG")
			!! question_cmd
			button.add_click_command (question_cmd, arg)
			!! button.make_with_text (main_widget, "EV_WARNING_DIALOG")
			!! warning_cmd
			button.add_click_command (warning_cmd, arg)
		end
		
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Dialogs demo")
			main_widget.set_homogeneous (True)
			main_widget.set_row_spacing (5)
			main_widget.set_column_spacing (5)
			main_widget.set_finite_dimension (3)
		end

end -- class DIALOG_DEMO_WINDOW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

