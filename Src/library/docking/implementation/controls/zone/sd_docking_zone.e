indexing
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
		select
			implementation
		end

	SD_SINGLE_CONTENT_ZONE
		rename
			internal_shared as internal_shared_not_used,
			extend_widget as extend_cell,
			has_widget as has_cell
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
	set_title (a_title: STRING) is
			--
		deferred
		end

	close is
			-- Redefine
		do
			internal_docking_manager.command.lock_update (Current, False)
			Precursor {SD_SINGLE_CONTENT_ZONE}
			internal_docking_manager.zones.prune_zone (Current)
			internal_docking_manager.command.unlock_update
		end

feature -- Query

	title: STRING is
			-- Title
		deferred
		end

	title_area: EV_RECTANGLE is
			-- Title area
		deferred
		ensure
			not_void: Result /= Void
		end

	is_parent_split: BOOLEAN is
			-- Is parent a split area?
		local
			l_split_area: EV_SPLIT_AREA
		do
			l_split_area ?= parent
			Result := l_split_area /= Void
		end

	parent_split_position: INTEGER is
			-- If parent is split area, get split position.
		local
			l_split_area: EV_SPLIT_AREA
		do
			l_split_area ?= parent
			Result := l_split_area.split_position
		end

feature {SD_DOCKING_STATE} -- Initlization

	set_widget_main_area (a_widget: EV_WIDGET; a_main_area: SD_MULTI_DOCK_AREA; a_parent: EV_CONTAINER; a_split_position: INTEGER) is
			-- Set widget and main area which used for normal window.
		require
			a_widget_not_void: a_widget /= Void
			a_main_area_not_void: a_main_area /= Void
			a_parent_not_void: a_parent /= Void
		do
			main_area_widget := a_widget
			main_area := a_main_area
			internal_parent := a_parent
			internal_parent_split_position := a_split_position
		ensure
			set: main_area_widget = a_widget and main_area = a_main_area and internal_parent = a_parent and internal_parent_split_position = a_split_position
		end

feature {NONE} -- For redocker.

	on_drag_started (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Create a SD_DOCKER_MEDIATOR, start hanlde pointer motion.
		do
			debug ("docking")
				io.put_string ("%N ******** draging window in SD_DOCKING_ZONE " + a_screen_x.out + " " + a_screen_y.out + "and window width height is: " + width.out + " " + height.out)
			end
			create docker_mediator.make (Current, internal_docking_manager)
			docker_mediator.cancel_actions.extend (agent on_cancel_dragging)
			docker_mediator.start_tracing_pointer (a_screen_x - screen_x, a_screen_y - screen_y)

			enable_capture
		end

	on_pointer_release (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Stop SD_DOCKER_MEDIATOR.
		do
			if docker_mediator /= Void then
				disable_capture
				docker_mediator.end_tracing_pointer (a_screen_x, a_screen_y)
				docker_mediator := Void
			end
		end

	on_pointer_motion (a_x, a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Forward pointer motion datas to SD_DOCKER_MEDIATOR.
		do
			if docker_mediator /= Void then
				docker_mediator.on_pointer_motion (a_screen_x,  a_screen_y)
			end
		end

	on_cancel_dragging is
			-- Handle cancel dragging from SD_DOCKER_MEDIATOR.
		do
			disable_capture
			docker_mediator := Void
		end

	docker_mediator: SD_DOCKER_MEDIATOR;
			-- Mediator perform dock.	

indexing
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
