note
	description: "[
					Same as EV_TITLED_WINDOW, and it works well with Ribbon
																			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_TITLED_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			implementation,
			create_implementation,
			initialize
		end

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		local
			l_res: EV_RIBBON_RESOURCES
		do
			Precursor
			create l_res
			l_res.ribbon_window_list.extend (Current)
		end

feature -- Access

	ribbon: detachable EV_RIBBON
			-- Associated ribbon if any
		deferred
		end

	application_menu: detachable EV_RIBBON_APPLICATION_MENU
			-- Associated application menu if any

	help_button: detachable EV_RIBBON_HELP_BUTTON
			-- Associated help button if any

feature {EV_ANY, EV_ANY_I, EV_ANY_HANDLER} -- Implementation

	implementation: EV_TITLED_WINDOW_I
			-- Responsible for interaction with native graphics toolkit

feature {NONE} -- Implementation

	create_implementation
			-- Responsible for interaction with native graphics toolkit.
		do
			create {EV_RIBBON_TITLED_WINDOW_IMP} implementation.make
		end

end
