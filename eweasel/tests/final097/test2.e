deferred class
	TEST2

inherit
	USABLE

feature -- Initialization

	bind_help_shortcut (a_window: STRING)
		local
			l_action: PROCEDURE [ANY, TUPLE]
		do
			l_action := agent (ia_accel: STRING; ia_window: STRING)
				require
					ia_accel_attached: attached ia_accel
					ia_window_attached: attached ia_window
				do
					if is_interface_usable and then attached ia_window and then not ia_window.is_empty then
								-- Rebind
						bind_help_shortcut (ia_window)
					end
				end ("", a_window)
		end

end
