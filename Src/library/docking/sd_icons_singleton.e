indexing
	description: "All icons used in the docking library. Client programmer should inherit this."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_ICONS_SINGLETON


feature -- Icons

	unstick: EV_PIXMAP is
				-- Unstick icon pixmap.
			deferred
			ensure
				not_void: Result /= Void
			end

	stick: 	EV_PIXMAP is
				-- Stick icon pixmap.
			deferred
			ensure
				not_void: Result /= Void
			end

	maximize: EV_PIXMAP is
				-- Maximize icon pixmap.
			deferred
			ensure
				not_void: Result /= Void
			end

	normal: EV_PIXMAP is
				-- Minimize icon pixmap.
			deferred
			ensure
				not_void: Result /= Void
			end

	close: EV_PIXMAP is
				-- Close icon pixmap.
			deferred
			ensure
				not_void: Result /= Void
			end

	default_icon: EV_PIXMAP is
				-- Default window icon.
			deferred
			ensure
				not_void: Result /= Void
			end

	pebble: EV_PIXMAP is
				-- Pebble.
			deferred
			ensure
				not_void: Result /= Void
			end

	arrow_indicator_up: EV_PIXMAP is
				-- Indicator draw on the screen when user dragging a window.
			deferred
			ensure
				not_void: Result /= Void
			end

	arrow_indicator_down: EV_PIXMAP is
				-- Indicator draw on the screen when user dragging a window.
			deferred
			ensure
				not_void: Result /= Void
			end

	arrow_indicator_left: EV_PIXMAP is
				-- Indicator draw on the screen when user dragging a window.
			deferred
			ensure
				not_void: Result /= Void
			end

	arrow_indicator_right: EV_PIXMAP is
				-- Indicator draw on the screen when user dragging a window.
			deferred
			ensure
				not_void: Result /= Void
			end

	arrow_indicator_center: EV_PIXMAP is
				-- Center indicator draw on the screen when user dragging a window.
			deferred
			ensure
				not_void: Result /= Void
			end
end
