note
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

	make (a_widget: EV_WIDGET)
			-- Creation method.
		require
			not_void: a_widget /= Void
		do
			create internal_shared
			create {EV_VERTICAL_BOX} top_box

			make_with_shadow
			disable_user_resize
			focus_out_actions.extend (agent on_focus_out)

			top_box.set_border_width (internal_shared.border_width)
			top_box.set_background_color (internal_shared.border_color)
			extend (top_box)

			if attached a_widget.parent as l_parent then
				l_parent.prune (a_widget)
			end
			top_box.extend (a_widget)
		end

	top_box: EV_BOX
			-- Top level box.

	on_focus_out
			-- Handle focus out actions.
		do
			destroy
		end

	internal_shared: SD_SHARED;
			-- ALl singletons.

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
