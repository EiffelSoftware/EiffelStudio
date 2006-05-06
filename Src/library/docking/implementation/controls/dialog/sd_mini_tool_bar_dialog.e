indexing
	description: "Dialog that contain mini tool bar when not enough space shown in SD_TITLE_BAR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MINI_TOOL_BAR_DIALOG

inherit
	EV_POPUP_WINDOW

create
	make

feature {NONE}  -- Initlization

	make (a_widget: EV_WIDGET) is
			-- Creation method.
		require
			not_void: a_widget /= Void
		do
			default_create
			focus_out_actions.extend (agent on_focus_out)

			if a_widget.parent /= Void then
				a_widget.parent.prune (a_widget)
			end
			extend (a_widget)
		end

	on_focus_out is
			-- Handle focus out actions.
		do
			destroy
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




end
