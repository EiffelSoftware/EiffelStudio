note
	description: "Summary description for {SD_FEEDBACK_RECT_IMP}."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FEEDBACK_RECT_IMP

inherit
	EV_POPUP_WINDOW_IMP
		redefine
			class_name,
			default_ex_style,
			interface
		end

	SD_FEEDBACK_RECT_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			lock_update,
			unlock_update,
			disconnect_from_window_manager
		redefine
			interface
		end

create
	make

feature {NONE}  -- Implementation

	class_name: STRING_32
			-- <Precursor>
		do
			Result := "SD_FEEDBACK_RECT_IMP"
		end

	default_ex_style: INTEGER
			-- <Precursor>
		do
			Result := Precursor {EV_POPUP_WINDOW_IMP} | {WEL_WS_CONSTANTS}.Ws_ex_noactivate
		end

feature {EV_ANY_I} -- Implementation

	interface: SD_FEEDBACK_RECT
			-- <Precursor>

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
