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
end
