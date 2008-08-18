indexing
	description: "Advance splash displayer for Windows platform."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ADVANCED_SPLASH_DISPLAYER

inherit
	EV_ADVANCED_SPLASH_DISPLAYER_I

	EIFFEL_LAYOUT

create
	make

feature{NONE} -- Initlization

	make is
			-- Creation method.
		do
		end

feature -- Command

	show is
			-- Redefine
		local
			l_pixel_buffer: EV_PIXEL_BUFFER
			l_screen: EV_SCREEN
		do
			create l_pixel_buffer
			l_pixel_buffer.set_with_named_file (image_file_name)
			create layered_window.make_for_splash (l_pixel_buffer)

			create l_screen
			layered_window.set_position ((l_screen.width - l_pixel_buffer.width) // 2, (l_screen.height - l_pixel_buffer.height) // 2)

			layered_window.show
		end

	close is
			-- Redefine
		do
			layered_window.clear
		end

feature -- Query

	is_executable: BOOLEAN
			-- Redefine
		local
			l_win_ver: WEL_WINDOWS_VERSION
			l_gdip_starter: WEL_GDIP_STARTER
			l_file: RAW_FILE
		do
			create l_win_ver
			if l_win_ver.is_windows_2000_compatible then
				create l_gdip_starter
				if l_gdip_starter.is_gdi_plus_installed then
					create l_file.make (image_file_name)
					if l_file.exists then
						Result := True
					end
				end
			end
		end

feature{NONE} -- Implementation

	layered_window: SD_FEEDBACK_INDICATOR
			-- Windows which show the splash

	image_file_name: FILE_NAME is
			-- Image file name.
		do
			create Result.make_from_string (eiffel_layout.bitmaps_path)
			Result.extend ("png")
			Result.set_file_name ("splash_shadow.png")
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end


