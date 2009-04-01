note
	description: "[
		Automatically generated class for EiffelStudio 16 x16  tool icons.
	]"
	generator: "Eiffel Matrix Generator"
	command_line: "emcgen.exe \work\64dev\Delivery\studio\tools\twitter_feed\icons.ini -f \work\64dev\tools\eiffel_matrix_code_generator\frames\tool.e.frame"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TWITTER_FEED_TOOL_ICONS

inherit
	ES_TOOL_PIXMAPS
		redefine
			matrix_pixel_border
		end

create
	make

feature -- Access

	icon_width: NATURAL_8 = 16
			-- <Precursor>

	icon_height: NATURAL_8 = 16
			-- <Precursor>

	width: NATURAL_8 = 1
			-- <Precursor>

	height: NATURAL_8 = 1
			-- <Precursor>

feature {NONE} -- Access

	matrix_pixel_border: NATURAL_8 = 1
			-- <Precursor>

feature -- Icons

	frozen tool_twitter_feed_icon: EV_PIXMAP
			-- Access to 'twitter_feed' pixmap.
		require
			has_named_icon: has_named_icon (tool_twitter_feed_name)
		once
			Result := named_icon (tool_twitter_feed_name)
		ensure
			test_tool_twitter_feed_icon_attached: Result /= Void
		end

	frozen tool_twitter_feed_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'twitter_feed' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (tool_twitter_feed_name)
		once
			Result := named_icon_buffer (tool_twitter_feed_name)
		ensure
			test_tool_twitter_feed_icon_buffer_attached: Result /= Void
		end

feature -- Icons: Animations

	-- No animation frames detected.

feature -- Constants: Icon names

	tool_twitter_feed_name: STRING = "tool twitter feed"

feature {NONE} -- Basic operations

	populate_coordinates_table (a_table: HASH_TABLE [TUPLE [x: NATURAL_8; y: NATURAL_8], STRING])
			-- <Precursor>
		do
			a_table.put ([{NATURAL_8} 1, {NATURAL_8} 1], tool_twitter_feed_name)
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
