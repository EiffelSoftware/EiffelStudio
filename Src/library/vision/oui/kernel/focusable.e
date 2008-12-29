note

	description:
		"Abstract notion of the ability for widget to show the explanation%
		%Your widget class should inherit from this class and redefine%
		%focus_label to return FOCUS_LABEL_I to be used with this widget."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class FOCUSABLE  

feature -- Initialization

	initialize_focus
			-- Add the focusable behavior to Current.
		require
			valid_focus_string: valid_focus_string
		do
			focus_label.initialize_widget (Current);
		end;

feature -- Properties

	focus_string: STRING

	focus_label: FOCUS_LABEL_I
		deferred
		end

feature -- Access

	valid_focus_string: BOOLEAN
		do
			Result := focus_string /= Void	
		end;

	destroyed: BOOLEAN
		deferred
		end

feature -- Setting

	set_focus_string (s: STRING)
			--set explanation text for current widget
		do
			focus_string := s
		end;

feature {FOCUS_LABEL} -- Implementation

	set_tool_info (a_tool_info: ANY)
			-- Set `tool_info'.
		do
			tool_info := a_tool_info
		end

	tool_info: ANY;
			-- Tool info for Current
			-- Used only in Windows implementation of FOCUS_LABEL

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




end -- class FOCUSABLE

