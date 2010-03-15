note
	description: "[
					Windows that used for notify EV_APPLICATION_IMP theme change actions.
					This is a invisible window.
																						]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_THEME_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_wm_theme_changed,
			on_wm_syscolor_change
		end

	EV_ANY_HANDLER

create
	make

feature {NONE} -- Initlixation

	make
			-- Creation method
		do
			register_class
			internal_window_make (Void, "",
				default_style,
				0, 0,
				0, 0,
				0, default_pointer)
		end

feature -- Implementation

	on_wm_theme_changed
			-- Redefine
		local
			l_env: EV_ENVIRONMENT
		do
			create l_env
			l_env.application.theme_changed_actions.call (Void)
		end

	on_wm_syscolor_change
			-- Redefine
		local
			l_env: EV_ENVIRONMENT
			l_app_i: EV_APPLICATION_I
		do
			Precursor {WEL_FRAME_WINDOW}

			create l_env
			-- We use EV_APPLICATION_I instead of EV_APPLICATION since
			-- system_color_change_actions not implementated on GTK.
			l_app_i := l_env.application.implementation
			l_app_i.system_color_change_actions.call (Void)
		end

end
