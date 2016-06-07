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
		redefine
			create_implementation
		end

create
	make

feature {NONE}  -- Initlization

	make (a_widget: EV_WIDGET)
			-- Creation method
		require
			not_void: a_widget /= Void
		local
			l_env: EV_ENVIRONMENT
		do
			create internal_shared
			create {EV_VERTICAL_BOX} top_box
			make_with_shadow

			disable_user_resize

			top_box.set_border_width (internal_shared.border_width)
			top_box.set_background_color (internal_shared.border_color)
			extend (top_box)

			if attached a_widget.parent as l_parent then
				l_parent.prune (a_widget)
			end
			top_box.extend (a_widget)

			create l_env
			if attached l_env.application as l_app then
				l_app.focus_in_actions.extend (app_focus_in_agent)
			else
				check False end -- Implied by application is running
			end
		end

	create_implementation
		do
			Precursor
			app_focus_in_agent := agent app_focus_in
		end

	app_focus_in_agent: PROCEDURE [EV_WIDGET]
			-- Agent for destroy Current

	app_focus_in (a_widget: EV_WIDGET)
			-- Handle application focus in action to destroy Current if possible
		local
			l_env: EV_ENVIRONMENT
		do
			if a_widget /= Current and then not has_recursive (a_widget) then
				destroy
				create l_env
				if attached l_env.application as l_app then
					l_app.focus_in_actions.prune_all (app_focus_in_agent)
				else
					check False end -- Implied by application is running
				end
			end
		end

	top_box: EV_BOX
			-- Top level box

	internal_shared: SD_SHARED
			-- ALl singletons

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
