note
	description: "WrapC UI Application"

class
	WUI_APP

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			--<Precursor>
			-- A standard GUI application launcher.
		do
			create application
			create main_window.make_with_title ("WrapC")
			main_window.build_menu_bar

			main_window.set_size (800, 600)

			main_window.close_request_actions.force (agent application.destroy)
			application.post_launch_actions.force (agent main_window.show)

			application.launch
		end

feature {NONE} -- Application

	application: EV_APPLICATION
			-- An EV application.

	main_window: WUI_MAIN_WINDOW
			-- `application' `main_window'.

	ewg: detachable EWG
			-- Only here to bring EWG "in-system".
			-- This can be removed.

end
