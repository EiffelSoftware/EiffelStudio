indexing
	description:
	"DIALOG_DEMO_WINDOW, demo window to test the common dialogs%
	% Belongs to EiffelVision example."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

create
	make

feature -- Access

	main_widget: EV_DYNAMIC_TABLE is
			-- The main widget of the demo
		once
			create Result.make (Current)
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
			create arg.make(Current)
			create button.make_with_text (main_widget, "EV_INFORMATION_DIALOG")
			create info_cmd
			button.add_click_command (info_cmd, arg)
			create button.make_with_text (main_widget, "EV_ERROR_DIALOG")
			create error_cmd
			button.add_click_command (error_cmd, arg)
			create button.make_with_text (main_widget, "EV_QUESTION_DIALOG")
			create question_cmd
			button.add_click_command (question_cmd, arg)
			create button.make_with_text (main_widget, "EV_WARNING_DIALOG")
			create warning_cmd
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class DIALOG_DEMO_WINDOW

