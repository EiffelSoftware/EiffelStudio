indexing

	description: "Motif implementation of a focus label."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class FOCUS_LABEL

inherit
	FOCUS_LABEL_I;
	OVERRIDE_S;

create
	initialize
	
feature -- Constants

	Label_color: STRING is "LightYellow"

feature -- Initialization

	initialize (a_parent: COMPOSITE) is
			-- Initialize Current.
		do
			make ("Focus_Label", a_parent);
			create label.make ("", Current)
			allow_resize
		end;

	initialize_widget (a_focusable: FOCUSABLE) is
			-- Platform specific initialization of the focusable widget.
		local
			widget: WIDGET;
			button: PUSH_B_IMP;
			list: VISION_COMMAND_LIST
		do
			widget ?= a_focusable;
			check 
				widget /= void
			end
			widget.add_enter_action (focus_command, a_focusable);
			widget.add_leave_action (focus_command, Void);
			button ?= widget.implementation;
			if button /= Void then
				if button.activate_command /= Void then
					list ?= button.activate_command.command;
				end;
				if list = Void then
					create list.make;
					button.set_activate_callback (list, Void)
				end
				list.insert_command (focus_command, Void)
			end;
		end;

	initialize_focusables (a_parent: TOOLTIP_INITIALIZER) is
			-- Initialize focusables.
		local 
			color: COLOR
		once
			create color.make
			color.set_name (Label_color)
			label.set_background_color (color)
		end;

	focus_command: FOCUS_COMMAND is
			-- Command called when entering and leaving a focusable widget
		once
			create Result.make (Current)
		end;

feature -- Properties

	text: STRING is
			-- Text displayed in Current.
		do
			Result := label.text
		end;

feature -- Setting

	set_text (new_text: STRING) is
			-- Set `text' to `new_text'.
		require
			non_void_text: new_text /= Void;
		local
			s: like screen
		do
			s := screen;
			set_x_y (s.x + 12, s.y + 12);
			label.set_text (new_text);
			popup
		end;

	reset is
			-- Reset `text'.
		do
			popdown;
			label.set_text ("")
		end;

feature {NONE} -- Implementation

	label: LABEL;
			-- widget label

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




end -- class FOCUS_LABEL

