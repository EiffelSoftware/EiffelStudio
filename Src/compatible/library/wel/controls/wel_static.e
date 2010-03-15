note
	description: "Control with a text."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STATIC

inherit
	WEL_CONTROL
		redefine
			class_name
		end

	WEL_SS_CONSTANTS
		export
			{NONE} all
		end

	WEL_COLOR_CONTROL

create
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_name: STRING_GENERAL;
			a_x, a_y, a_width, a_height, an_id: INTEGER)
			-- Make a static control
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

feature -- Access

	foreground_color: WEL_COLOR_REF
			-- foreground color used for the text of the
			-- control
			-- Can be redefined by the user
		do
			create Result.make_system (Color_windowtext)
		end

	background_color: WEL_COLOR_REF
			-- Background color used for the background of the
			-- control
			-- Can be redefined by the user
		do
			create Result.make_system (Color_btnface)
		end

feature -- Basic operations

	clear
			-- Clear the text
		require
			exists: exists
		do
			set_text (create {STRING_32}.make_empty)
		ensure
			text_empty: text.is_empty
		end

feature {NONE} -- Implementation

	class_name: STRING_32
			-- Window class name to create
		once
			Result := "Static"
		end

	default_style: INTEGER
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ss_left
		end

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




end -- class WEL_STATIC

