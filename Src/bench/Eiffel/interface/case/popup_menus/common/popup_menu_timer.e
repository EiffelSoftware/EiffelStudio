indexing
	description: "Timer for the popup menus."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	POPUP_MENU_TIMER

inherit
	EV_COMMAND

creation
	make

feature -- Creation

	make (worka: WORKAREA) is 
			-- Creation
		require
			workarea_exists: worka /= Void
		do 
			workarea := worka
		end

feature -- Operations

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Popup contextual menu.
		local
			x1,y1: INTEGER
			class_data: GRAPH_CLASS
			relation_data: GRAPH_RELATION
			cluster_data: CLUSTER_DATA
		do
			x1 := x - move_x
			y1 := y - move_y
			timer.destroy
			if x1.abs<10 and y1.abs<10 then
				-- We have to popup a contextual menu.
				class_data ?= workarea.active_entity
				relation_data ?= workarea.active_entity
				if class_data /= Void then
					create class_menu.make_from_workarea (workarea)
					class_menu.show_at_position(x,y)
				elseif relation_data /= Void then
					create relation_menu.make_from_workarea (workarea)
					relation_menu.show_at_position(x,y)
				end
			end
			clear
		end

	initialize ( event: EV_BUTTON_EVENT_DATA) is
		require
			initialized: x=0 and y=0
			event_exists: event /= Void
		do
			x := event.x
			y := event.y
			!! timer.make(500,Current,Void)
		end

	update (event: EV_MOTION_EVENT_DATA ) is
		require
			event_exists: event /= Void
		do
			move_x := event.x
			move_y := event.y
		end

	clear is
		do
			x := 0
			y := 0
		end

feature -- Access

	x,y: INTEGER
		-- Coordinates.

	move_x,move_y: INTEGER

feature -- Implementation

	workarea: WORKAREA
		-- Associated workarea

	timer: EV_TIMEOUT
		-- Timer.

	class_menu: CLASS_POPUP_MENU

	relation_menu: RELATION_POPUP_MENU

invariant
	workarea_exists: workarea /= Void

end -- class POPUP_MENU_TIMER
