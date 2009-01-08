note
	description: "Objects that represent the zone when docking in SD_MULTI_DOCK_AREA."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_DOCKING_ZONE

inherit
	EV_CELL
		rename
			has as has_cell,
			extend as extend_cell
		end

	SD_SINGLE_CONTENT_ZONE
		rename
			internal_shared as internal_shared_not_used
		redefine
			close
		end

	SD_DOCKER_SOURCE
		undefine
			copy, is_equal, default_create
		end

	SD_TITLE_BAR_REMOVEABLE
		undefine
			copy, is_equal, default_create
		end

feature -- Command

	set_title (a_title: STRING_GENERAL)
			-- Set title
		require
			not_void: a_title /= Void
		deferred
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Set pixmap
		require
			not_void: a_pixmap /= Void
		do
		end

	close
			-- Redefine
		do
			internal_docking_manager.command.lock_update (Current, False)
			Precursor {SD_SINGLE_CONTENT_ZONE}
			internal_docking_manager.zones.prune_zone (Current)
			internal_docking_manager.command.unlock_update
		end

	update_user_widget
			-- If `content''s user_widget changed, we update containers.
		do
		end

feature -- Query

	title: STRING_32
			-- Title
		deferred
		end

	title_area: EV_RECTANGLE
			-- Title area
		deferred
		ensure
			not_void: Result /= Void
		end

	is_parent_split: BOOLEAN
			-- Is parent a split area?
		local
			l_split_area: EV_SPLIT_AREA
		do
			l_split_area ?= parent
			Result := l_split_area /= Void
		end

	parent_split_position: INTEGER
			-- If parent is split area, get split position.
		local
			l_split_area: EV_SPLIT_AREA
		do
			l_split_area ?= parent
			Result := l_split_area.split_position
		end

feature {NONE} -- For redocker.

	on_drag_started (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Create a SD_DOCKER_MEDIATOR, start hanlde pointer motion.
		do
			debug ("docking")
				io.put_string ("%N ******** draging window in SD_DOCKING_ZONE " + a_screen_x.out + " " + a_screen_y.out + "and window width height is: " + width.out + " " + height.out)
			end
			-- We should check if `docker_mediator' is void since `on_drag_started' will be called multi times when starting dragging on GTK
			if docker_mediator = Void then
				docker_mediator := internal_docking_manager.query.docker_mediator (Current, internal_docking_manager)
				docker_mediator.cancel_actions.extend (agent on_cancel_dragging)
				docker_mediator.start_tracing_pointer (a_screen_x - screen_x, a_screen_y - screen_y)
				internal_shared.setter.before_enable_capture
				enable_capture
			end
		end

	on_pointer_release (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Stop SD_DOCKER_MEDIATOR.
		do
			if docker_mediator /= Void then
				disable_capture
				internal_shared.setter.after_disable_capture
				docker_mediator.end_tracing_pointer (a_screen_x, a_screen_y)
				docker_mediator := Void
			end
		end

	on_pointer_motion (a_x, a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Forward pointer motion data to SD_DOCKER_MEDIATOR.
		do
			if docker_mediator /= Void then
				docker_mediator.on_pointer_motion (a_screen_x,  a_screen_y)
			end
		end

	on_cancel_dragging
			-- Handle cancel dragging from SD_DOCKER_MEDIATOR.
		do
			disable_capture
			internal_shared.setter.after_disable_capture
			docker_mediator := Void
		end

	docker_mediator: SD_DOCKER_MEDIATOR;
			-- Mediator perform dock.	

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
