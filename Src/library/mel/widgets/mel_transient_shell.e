indexing

	description:
			"Popup shell that interacts with the window manager."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TRANSIENT_SHELL

inherit

	MEL_TRANSIENT_SHELL_RESOURCES
		export
			{NONE} all
		end;

	MEL_VENDOR_SHELL

create
	make

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a transient shell.
		require
			name_exists: a_name /= Void;
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			check
				same_display_as_parent: screen.display = parent.screen.display
			end;
			screen_object := xt_create_transient_shell (a_parent.screen_object, $widget_name);
			Mel_widgets.add_popup_shell (Current);
			set_default
		ensure
			exists: not is_destroyed;
			parent_set: parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

feature -- Status report

	transient_for: MEL_WIDGET is
			-- The widget from which Current will popup
		require
			exists: not is_destroyed
		do
			Result ?= get_xt_widget (screen_object, XmNtransientFor)
		end;

feature -- Status setting

	set_transient_for (a_widget: MEL_WIDGET) is
			-- Set `transient_for' to `a_widget'.
		require
			exists: not is_destroyed;
			a_widget_exists: a_widget /= Void and then not a_widget.is_destroyed
		do
			set_xt_widget (screen_object, XmNtransientFor, a_widget.screen_object)
		ensure
			transient_for_set: transient_for.is_equal (a_widget)
		end;

feature {NONE} -- Implementation

	xt_create_transient_shell (a_parent, a_name: POINTER): POINTER is
		external
			"C"
		end;

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




end -- class MEL_TRANSIENT_SHELL


