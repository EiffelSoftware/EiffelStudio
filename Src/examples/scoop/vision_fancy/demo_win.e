note
	description: "Ancestor to windows that draw figures."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DEMO_WIN

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects
		end

feature {NONE} -- Initialization

	make
		do
			default_create
			set_size (200, 200)
			extend (drawing_area)
			close_request_actions.extend (agent on_close)
			launch_demo (fig_demo_cmd)
		end

	create_interface_objects
			-- <Precursor>
		do
			create drawing_area
			create stop_controller
		end

feature -- Deferred

	launch_demo (a_cmd: like fig_demo_cmd)
			-- Launch
		do
			a_cmd.execute
		end

	fig_demo_cmd: separate DEMO_CMD
		deferred
		end

	window_title: STRING
			-- Title of the window.
		deferred
		end

feature -- Access

	drawing_area: CLIENT_AREA
			-- Area to draw

	stop_controller: STOP_CONTROLLER
			-- Stop controller

feature -- Element Change

    stop_demo
			-- Tell the `fig_demo_cmd' processor to stop.
		do
			stop_controller.set_is_stopped (True)
		end

feature -- Redefined features

	on_close
			-- On close window
		do
			stop_demo
			destroy_and_exit_if_last
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end

