note
	description: "[
			Platform specific implementation.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEXT_PANEL_I

feature -- Access

	is_initialized: BOOLEAN
			-- Is current text panel properly initialized? I.e. ready for use.
		deferred
		end

	editor_drawing_area: EV_DRAWING_AREA
		deferred
		end

	margin: detachable MARGIN_WIDGET
		deferred
		end

	editor_viewport: EV_VIEWPORT
		deferred
		end

feature -- Implementation

	refresh_now
		deferred
		end

	set_buffered_drawable_size (a_width, a_height: INTEGER)
		deferred
		end

feature {NONE} -- Implementation

	on_visible_area_resized (a_width, a_height: INTEGER)
		local
			w,h: INTEGER
		do
			if is_initialized then
				w := a_width + editor_viewport.x_offset
				h := a_height + editor_viewport.y_offset
				editor_drawing_area.set_minimum_size (w, h)
				set_buffered_drawable_size (w, h)
				if attached margin as l_margin then
					l_margin.update_size_with_panel
				end
			end
		end

	on_offset_changed
		local
			w,h, mw,mh: INTEGER
		do
			if is_initialized then
				w := editor_viewport.width + editor_viewport.x_offset
				h := editor_viewport.height --+ editor_viewport.y_offset
				mw := editor_drawing_area.minimum_width
				mh := editor_drawing_area.minimum_height
				if w > mw or h > mh then
					w := w + w // 4 -- add 25% to avoid resizing all the time when scrolling right.
					editor_drawing_area.set_minimum_size (w, h)
					set_buffered_drawable_size (w, h)
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
