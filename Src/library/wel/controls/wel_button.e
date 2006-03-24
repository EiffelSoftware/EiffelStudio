indexing
	description: "Ancestor to all buttons (check, push, etc.)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_BUTTON

inherit
	WEL_CONTROL
		redefine
			process_notification
		end

	WEL_COLOR_CONTROL

	WEL_BN_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_name: STRING_GENERAL;
			a_x, a_y, a_width, a_height, an_id: INTEGER) is
			-- Make a button.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			a_name_not_void: a_name /= Void
		do
			internal_window_make (a_parent, a_name,
				default_style, a_x, a_y, a_width, a_height,
				an_id, default_pointer)
			id := an_id
		ensure
			parent_set: parent = a_parent
			exists: exists
			name_set: text.is_equal (a_name)
			id_set: id = an_id
		end

feature -- Color

	foreground_color: WEL_COLOR_REF is
			-- Foreground color has no effect with SCROLL_BAR.
			-- Cannot be Void.
		do
			create Result.make_system (Color_windowtext)
		end

	background_color: WEL_COLOR_REF is
			-- Background color used for the background of the
			-- control
			-- Can be redefined by the user
		do
			create Result.make_system (color_scrollbar)
		end

feature -- Notifications

	on_bn_clicked is
			-- Called when the button is clicked
		require
			exists: exists
		do
		end

feature {NONE} -- Implementation

	process_notification (notification_code: INTEGER) is
		do
			if notification_code = Bn_clicked then
				on_bn_clicked
			else
				default_process_notification (notification_code)
			end
		end

	class_name: STRING_32 is
			-- Window class name to create
		once
			Result := "Button"
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




end -- class WEL_BUTTON

