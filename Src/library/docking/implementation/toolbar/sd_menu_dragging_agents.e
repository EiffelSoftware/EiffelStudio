indexing
	description: "Agents for SD_MENU_ZONE dragging issues."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_DRAGGING_AGENTS

create
	make

feature {NONE}  -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER; a_menu_zone: SD_MENU_ZONE) is
			-- Creation method.
		require
			not_void: a_docking_manager /= Void
			not_void: a_menu_zone /= Void
		do
			default_create
			create internal_shared
			internal_docking_manager := a_docking_manager
			internal_menu_zone := a_menu_zone

			init_actions
		ensure
			set: internal_docking_manager = a_docking_manager
			set: internal_menu_zone = a_menu_zone
		end

	init_actions is
			-- Initialize actions.
		do
			internal_menu_zone.pointer_motion_actions.extend (agent on_pointer_motion)
			internal_menu_zone.pointer_button_release_actions.extend (agent on_pointer_release)
		end

feature -- Agents

	on_drag_area_pressed (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle drag area pressed.
		do
			if a_button = 1 then
				internal_pointer_pressed := True
				internal_docker_mediator := Void
			end
		ensure
			pointer_press_set: a_button = 1 implies internal_pointer_pressed = True
			docker_mediaot_void: a_button = 1 implies internal_docker_mediator = Void
		end

	on_drag_area_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle drag area release.
		do
			if a_button = 1 then
				internal_pointer_pressed := False
				internal_docker_mediator := Void
			end
		ensure
			pointer_press_set: a_button = 1 implies internal_pointer_pressed = False
			docker_mediaot_void: a_button = 1 implies internal_docker_mediator = Void
		end

	on_drag_area_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle drag area motion.
		local
			l_pixmaps: EV_STOCK_PIXMAPS
			l_offset_x, l_offset_y: INTEGER
		do
			if internal_pointer_pressed then
				create l_pixmaps
				internal_menu_zone.enable_capture
				internal_menu_zone.set_pointer_style (l_pixmaps.sizeall_cursor)
				create internal_docker_mediator.make (internal_menu_zone, internal_docking_manager)
				if internal_menu_zone.is_floating then
					l_offset_x := a_screen_x - internal_menu_zone.floating_menu.screen_x
					l_offset_y := a_screen_y - internal_menu_zone.floating_menu.screen_y
				else
					l_offset_x := a_screen_x - internal_menu_zone.drag_area.screen_x
					l_offset_y := a_screen_y - internal_menu_zone.drag_area.screen_y
				end
				internal_docker_mediator.set_offset (internal_menu_zone.is_floating, l_offset_x, l_offset_y)
			end
		ensure
			capture_enable: internal_pointer_pressed implies internal_menu_zone.has_capture and internal_docker_mediator /= Void
		end

feature {NONE} -- Implementation functions

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer motion.
		do
			internal_docker_mediator.on_pointer_motion (a_screen_x, a_screen_y)
		ensure
			pointer_motion_forwarded:
		end

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer release.
		local
			l_pixmaps: EV_STOCK_PIXMAPS
		do
			internal_menu_zone.disable_capture
			internal_pointer_pressed := False
			internal_shared.set_menu_docker_mediator (Void)
			create l_pixmaps
			internal_menu_zone.set_pointer_style (l_pixmaps.standard_cursor)
		ensure
			disable_capture: not internal_menu_zone.has_capture
			not_pointer_pressed: not internal_pointer_pressed
			cleared: internal_shared.menu_docker_mediator_cell.item = Void
		end

feature {NONE} -- Implementation attributes

	internal_shared: SD_SHARED
			-- All singletons.

	internal_menu_zone: SD_MENU_ZONE
			-- Menu zone current belong to.		

	internal_docker_mediator: SD_MENU_DOCKER_MEDIATOR
			-- Docker mediator.

	internal_pointer_pressed: BOOLEAN
			-- If pointer pressed?

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager Current belong to.

invariant
	not_void: internal_shared /= Void
	not_void: internal_menu_zone /= Void
	not_void: internal_docking_manager /= Void

end
