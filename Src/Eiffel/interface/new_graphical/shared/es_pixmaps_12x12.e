indexing
	description: "[
		Automatically generated class for EiffelStudio 12x12 icons.
	]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_PIXMAPS_12X12

inherit
	ES_PIXMAPS

create
	make

feature -- Icons

	frozen bp_current_line_icon: !EV_PIXMAP is
			-- Access to 'current line' pixmap.
		once
			Result := ({!EV_PIXMAP}) #? raw_buffer.sub_pixmap (pixel_rectangle (1, 1))
		end

	frozen bp_current_line_icon_buffer: !EV_PIXEL_BUFFER is
			-- Access to 'current line' pixmap pixel buffer.
		once
			Result := ({!EV_PIXEL_BUFFER}) #? raw_buffer.sub_pixel_buffer (pixel_rectangle (1, 1))
		end

	frozen bp_slot_icon: !EV_PIXMAP is
			-- Access to 'slot' pixmap.
		once
			Result := ({!EV_PIXMAP}) #? raw_buffer.sub_pixmap (pixel_rectangle (2, 1))
		end

	frozen bp_slot_icon_buffer: !EV_PIXEL_BUFFER is
			-- Access to 'slot' pixmap pixel buffer.
		once
			Result := ({!EV_PIXEL_BUFFER}) #? raw_buffer.sub_pixel_buffer (pixel_rectangle (2, 1))
		end

	frozen bp_enabled_icon: !EV_PIXMAP is
			-- Access to 'enabled' pixmap.
		once
			Result := ({!EV_PIXMAP}) #? raw_buffer.sub_pixmap (pixel_rectangle (3, 1))
		end

	frozen bp_enabled_icon_buffer: !EV_PIXEL_BUFFER is
			-- Access to 'enabled' pixmap pixel buffer.
		once
			Result := ({!EV_PIXEL_BUFFER}) #? raw_buffer.sub_pixel_buffer (pixel_rectangle (3, 1))
		end

	frozen bp_disabled_icon: !EV_PIXMAP is
			-- Access to 'disabled' pixmap.
		once
			Result := ({!EV_PIXMAP}) #? raw_buffer.sub_pixmap (pixel_rectangle (4, 1))
		end

	frozen bp_disabled_icon_buffer: !EV_PIXEL_BUFFER is
			-- Access to 'disabled' pixmap pixel buffer.
		once
			Result := ({!EV_PIXEL_BUFFER}) #? raw_buffer.sub_pixel_buffer (pixel_rectangle (4, 1))
		end

	frozen bp_slot_current_line_icon: !EV_PIXMAP is
			-- Access to 'slot current line' pixmap.
		once
			Result := ({!EV_PIXMAP}) #? raw_buffer.sub_pixmap (pixel_rectangle (5, 1))
		end

	frozen bp_slot_current_line_icon_buffer: !EV_PIXEL_BUFFER is
			-- Access to 'slot current line' pixmap pixel buffer.
		once
			Result := ({!EV_PIXEL_BUFFER}) #? raw_buffer.sub_pixel_buffer (pixel_rectangle (5, 1))
		end

	frozen bp_enabled_current_line_icon: !EV_PIXMAP is
			-- Access to 'enabled current line' pixmap.
		once
			Result := ({!EV_PIXMAP}) #? raw_buffer.sub_pixmap (pixel_rectangle (6, 1))
		end

	frozen bp_enabled_current_line_icon_buffer: !EV_PIXEL_BUFFER is
			-- Access to 'enabled current line' pixmap pixel buffer.
		once
			Result := ({!EV_PIXEL_BUFFER}) #? raw_buffer.sub_pixel_buffer (pixel_rectangle (6, 1))
		end

	frozen bp_disabled_current_line_icon: !EV_PIXMAP is
			-- Access to 'disabled current line' pixmap.
		once
			Result := ({!EV_PIXMAP}) #? raw_buffer.sub_pixmap (pixel_rectangle (7, 1))
		end

	frozen bp_disabled_current_line_icon_buffer: !EV_PIXEL_BUFFER is
			-- Access to 'disabled current line' pixmap pixel buffer.
		once
			Result := ({!EV_PIXEL_BUFFER}) #? raw_buffer.sub_pixel_buffer (pixel_rectangle (7, 1))
		end

	frozen bp_slot_other_frame_icon: !EV_PIXMAP is
			-- Access to 'slot other frame' pixmap.
		once
			Result := ({!EV_PIXMAP}) #? raw_buffer.sub_pixmap (pixel_rectangle (8, 1))
		end

	frozen bp_slot_other_frame_icon_buffer: !EV_PIXEL_BUFFER is
			-- Access to 'slot other frame' pixmap pixel buffer.
		once
			Result := ({!EV_PIXEL_BUFFER}) #? raw_buffer.sub_pixel_buffer (pixel_rectangle (8, 1))
		end

	frozen bp_enabled_other_frame_icon: !EV_PIXMAP is
			-- Access to 'enabled other frame' pixmap.
		once
			Result := ({!EV_PIXMAP}) #? raw_buffer.sub_pixmap (pixel_rectangle (9, 1))
		end

	frozen bp_enabled_other_frame_icon_buffer: !EV_PIXEL_BUFFER is
			-- Access to 'enabled other frame' pixmap pixel buffer.
		once
			Result := ({!EV_PIXEL_BUFFER}) #? raw_buffer.sub_pixel_buffer (pixel_rectangle (9, 1))
		end

	frozen bp_disabled_other_frame_icon: !EV_PIXMAP is
			-- Access to 'disabled other frame' pixmap.
		once
			Result := ({!EV_PIXMAP}) #? raw_buffer.sub_pixmap (pixel_rectangle (10, 1))
		end

	frozen bp_disabled_other_frame_icon_buffer: !EV_PIXEL_BUFFER is
			-- Access to 'disabled other frame' pixmap pixel buffer.
		once
			Result := ({!EV_PIXEL_BUFFER}) #? raw_buffer.sub_pixel_buffer (pixel_rectangle (10, 1))
		end

	frozen bp_enabled_conditional_icon: !EV_PIXMAP is
			-- Access to 'enabled conditional' pixmap.
		once
			Result := ({!EV_PIXMAP}) #? raw_buffer.sub_pixmap (pixel_rectangle (11, 1))
		end

	frozen bp_enabled_conditional_icon_buffer: !EV_PIXEL_BUFFER is
			-- Access to 'enabled conditional' pixmap pixel buffer.
		once
			Result := ({!EV_PIXEL_BUFFER}) #? raw_buffer.sub_pixel_buffer (pixel_rectangle (11, 1))
		end

	frozen bp_disabled_conditional_icon: !EV_PIXMAP is
			-- Access to 'disabled conditional' pixmap.
		once
			Result := ({!EV_PIXMAP}) #? raw_buffer.sub_pixmap (pixel_rectangle (12, 1))
		end

	frozen bp_disabled_conditional_icon_buffer: !EV_PIXEL_BUFFER is
			-- Access to 'disabled conditional' pixmap pixel buffer.
		once
			Result := ({!EV_PIXEL_BUFFER}) #? raw_buffer.sub_pixel_buffer (pixel_rectangle (12, 1))
		end



feature -- Access

	pixel_width: INTEGER = 12
			-- Element width

	pixel_height: INTEGER = 12
			-- Element width

	width: INTEGER = 12
			-- Matrix width

	height: INTEGER = 1
			-- Matrix height

;indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
