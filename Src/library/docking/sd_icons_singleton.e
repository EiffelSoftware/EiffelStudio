indexing
	description: "All icons used in the docking library. Client programmer should inherit this."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_ICONS_SINGLETON

feature -- Initlization

	init is
			-- Initlization
		local
			l_temp: EV_PIXMAP
		do
			l_temp := arrow_indicator_up
			l_temp := arrow_indicator_down
			l_temp := arrow_indicator_left
			l_temp := arrow_indicator_right
			l_temp := arrow_indicator_center

			l_temp := arrow_indicator_up_mask
			l_temp := arrow_indicator_down_mask
			l_temp := arrow_indicator_left_mask
			l_temp := arrow_indicator_right_mask
			l_temp := arrow_indicator_center_mask

			l_temp := arrow_indicator_up_lightening
			l_temp := arrow_indicator_down_lightening
			l_temp := arrow_indicator_left_lightening
			l_temp := arrow_indicator_right_lightening

			l_temp := arrow_indicator_center_lightening_up
			l_temp := arrow_indicator_center_lightening_down
			l_temp := arrow_indicator_center_lightening_left
			l_temp := arrow_indicator_center_lightening_right
			l_temp := arrow_indicator_center_lightening_center

		end

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

	hide_tab_indicator (a_hide_number: INTEGER): EV_PIXMAP is
			-- Hide tab indicator.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_indicator: EV_PIXMAP is
			-- Indicator for SD_TITLE_BAR, when there is nor enough space to show custom widget.
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Side indicators

	arrow_indicator_up: EV_PIXMAP is
			-- Feedback indicator which is at top.
		local
			l_temp: SD_SIDE_INDICATOR
		once
			create l_temp.make_top_to_bottom (Void)
			Result :=  l_temp
		end

	arrow_indicator_down: EV_PIXMAP is
			-- Feedback indicator which is at down.
		local
			l_temp: SD_SIDE_INDICATOR
		once
			create l_temp.make_bottom_to_top (Void)
			Result :=  l_temp
		end

	arrow_indicator_left: EV_PIXMAP is
			-- Feedback indicator which is at left.
		local
			l_temp: SD_SIDE_INDICATOR
		once
			create l_temp.make_left_to_right (Void)
			Result :=  l_temp
		end

	arrow_indicator_right: EV_PIXMAP is
			-- Feedback indicator which is at right.
		local
			l_temp: SD_SIDE_INDICATOR
		once
			create l_temp.make_right_to_left (Void)
			Result :=  l_temp
		end

	arrow_indicator_up_mask: EV_PIXMAP is
			-- Mask of `arrow_indicator_up'.
		local
			l_temp: SD_SIDE_MASK
		once
			create l_temp.make_top_to_bottom (Void)
			Result := l_temp
		end

	arrow_indicator_down_mask: EV_PIXMAP is
			-- Mask of `arrow_indicator_down'.
		local
			l_temp: SD_SIDE_MASK
		once
			create l_temp.make_bottom_to_top (Void)
			Result := l_temp
		end

	arrow_indicator_left_mask: EV_PIXMAP is
			-- Mask of `arrow_indicator_left'.
		local
			l_temp: SD_SIDE_MASK
		once
			create l_temp.make_left_to_right (Void)
			Result := l_temp
		end

	arrow_indicator_right_mask: EV_PIXMAP is
			-- Mask of `arrow_indicator_right'.
		local
			l_temp: SD_SIDE_MASK
		once
			create l_temp.make_right_to_left (Void)
			Result := l_temp
		end

	arrow_indicator_up_lightening: EV_PIXMAP is
			-- Lightening pixmap of `arrow_indicator_up'.
		local
			l_temp: SD_SIDE_INDICATOR_LIGHTENING
		once
			create l_temp.make_top_to_bottom (Void)
			Result := l_temp
		end

	arrow_indicator_down_lightening: EV_PIXMAP is
			-- Lightening pixmap of `arrow_indicator_down'.
		local
			l_temp: SD_SIDE_INDICATOR_LIGHTENING
		once
			create l_temp.make_bottom_to_top (Void)
			Result := l_temp
		end

	arrow_indicator_left_lightening: EV_PIXMAP is
			-- Lightening pixmap of `arrow_indicator_left'.
		local
			l_temp: SD_SIDE_INDICATOR_LIGHTENING
		once
			create l_temp.make_left_to_right (Void)
			Result := l_temp
		end

	arrow_indicator_right_lightening: EV_PIXMAP is
			-- Lightening pixmap of `arrow_indicator_right'.
		local
			l_temp: SD_SIDE_INDICATOR_LIGHTENING
		once
			create l_temp.make_right_to_left (Void)
			Result := l_temp
		end

feature -- Center indicators

	arrow_indicator_center: EV_PIXMAP is
			-- Feedback indicator which is at center.
		local
			l_temp: SD_CENTER_INDICATOR
		once
			create l_temp.make_top_to_bottom (Void)
			Result :=  l_temp
		end

	arrow_indicator_center_mask: EV_PIXMAP is
			-- Mask of `arrow_indicator_center'.
		local
			l_temp: SD_CENTER_MASK
		once
			create l_temp.make_top_to_bottom (Void)
			Result := l_temp
		end

	arrow_indicator_center_lightening_up: EV_PIXMAP is
			-- Top area lightening pixmap of `arrow_indicator_center'.
		local
			l_temp: SD_CENTER_INDICATOR_LIGHTENING_TOP
		once
			create l_temp.make_top_to_bottom (Void)
			Result :=  l_temp
		end

	arrow_indicator_center_lightening_down: EV_PIXMAP is
			-- Bottom area lightening pixmap of `arrow_indicator_center'.
		local
			l_temp: SD_CENTER_INDICATOR_LIGHTENING_BOTTOM
		once
			create l_temp.make_top_to_bottom (Void)
			Result :=  l_temp
		end

	arrow_indicator_center_lightening_left: EV_PIXMAP is
			-- Left area lightening pixmap of `arrow_indicator_center'.
		local
			l_temp: SD_CENTER_INDICATOR_LIGHTENING_LEFT
		once
			create l_temp.make_top_to_bottom (Void)
			Result :=  l_temp
		end

	arrow_indicator_center_lightening_right: EV_PIXMAP is
			-- Right area lightening pixmap of `arrow_indicator_center'.
		local
			l_temp: SD_CENTER_INDICATOR_LIGHTENING_RIGHT
		once
			create l_temp.make_top_to_bottom (Void)
			Result :=  l_temp
		end

	arrow_indicator_center_lightening_center: EV_PIXMAP is
			-- Center area lightening pixmap of `arrow_indicator_center'.
		local
			l_temp: SD_CENTER_INDICATOR_LIGHTENING_CENTER
		once
			create l_temp.make_top_to_bottom (Void)
			Result :=  l_temp
		end

feature -- Old half-tone style icons.

	drag_pointer_up: EV_CURSOR is
			-- When user drag a zone, pointer showed at top area.
		deferred
		ensure
			not_void: Result /= Void
		end

	drag_pointer_down: EV_CURSOR is
			-- When user drag a zone, pointer showed at top area.
		deferred
		ensure
			not_void: Result /= Void
		end

	drag_pointer_left: EV_CURSOR is
			-- When user drag a zone, pointer showed at top area.
		deferred
		ensure
			not_void: Result /= Void
		end

	drag_pointer_right: EV_CURSOR is
			-- When user drag a zone, pointer showed at top area.
		deferred
		ensure
			not_void: Result /= Void
		end

	drag_pointer_center: EV_CURSOR is
			-- When user drag a zone, pointer showed at top area.
		deferred
		ensure
			not_void: Result /= Void
		end

	drag_pointer_float: EV_CURSOR is
			-- When user drag a zone, pointer showed when should float.
		deferred
		ensure
			not_void: Result /= Void
		end

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
