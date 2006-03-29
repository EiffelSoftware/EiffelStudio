indexing
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
			on_wm_theme_changed
		end

create
	make

feature {NONE} -- Initlixation

	make is
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

	on_wm_theme_changed is
			-- Redefine
		local
			l_env: EV_ENVIRONMENT
		do
			create l_env
			l_env.application.theme_changed_actions.call ([])
		end

end
