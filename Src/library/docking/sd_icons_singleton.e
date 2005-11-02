indexing
	description: "All the icons used in the docking library. Client programmer should inherit this."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_ICONS_SINGLETON


feature -- Icons

	unstick: EV_PIXMAP is
				-- Unstick icon pixmap.
			deferred
			end
	
	stick: 	EV_PIXMAP is
				-- Stick icon pixmap.
			deferred
			end
		
	maximize: EV_PIXMAP is
				-- Maximize icon pixmap.
			deferred
			end
		
	minimize: EV_PIXMAP is
				-- Minimize icon pixmap.
			deferred
			end
	
	close: EV_PIXMAP is
				-- close icon pixmap.
			deferred
			end
	default_icon: EV_PIXMAP is
				-- default window icon.
			deferred
			end
			
	pebble: EV_PIXMAP is
				-- The pebble.
			deferred
			end
	
	arrow_indicator_up: EV_PIXMAP is
				-- The indicator draw on the screen when user dragging a window.
			deferred
			end
	arrow_indicator_down: EV_PIXMAP is
				-- The indicator draw on the screen when user dragging a window.
			deferred
			end	
	arrow_indicator_left: EV_PIXMAP is
				-- The indicator draw on the screen when user dragging a window.
			deferred
			end
	arrow_indicator_right: EV_PIXMAP is
				-- The indicator draw on the screen when user dragging a window.
			deferred
			end 
	arrow_indicator_center: EV_PIXMAP is
				-- The center indicator draw on the screen when user dragging a window.
			deferred
			end
end
