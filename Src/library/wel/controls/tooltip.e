indexing
	description: "Small pop-up window that displays a single line of %
		%descriptive text giving the purpose of tools."
	note: "The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to %
		%be loaded to use this control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TOOLTIP

inherit
	WEL_CONTROL

	WEL_TTM_CONSTANTS
		export
			{NONE} all
		end

	WEL_TTS_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW; an_id: INTEGER) is
			-- Create a tooltip control with `a_parent' as parent
			-- and `an_id' as id.
		require
			a_parent_not_void: a_parent /= Void
		do
			internal_window_make (a_parent, Void, default_style,
				Cw_usedefault, Cw_usedefault, Cw_usedefault,
				Cw_usedefault, id, default_pointer)
			id := an_id
		ensure
			exists: exists
			parent_set: parent = a_parent
			id_set: id = an_id
		end

feature -- Basic operations

	add_tool (tool_info: WEL_TOOL_INFO) is
			-- Add a new `tool_info'.
		require
			exists: exists
			tool_info_not_void: tool_info /= Void
		do
			cwin_send_message (item, Ttm_addtool, 0,
				tool_info.to_integer)
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			!! Result.make (0)
			Result.from_c (cwin_tooltips_class)
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Tts_alwaystip
		end

feature {NONE} -- Externals

	cwin_tooltips_class: POINTER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TOOLTIPS_CLASS"
		end

end -- class WEL_WEL_TOOLTIP

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
