note
	description: "Pixmaps used in interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_PIXMAPS

inherit
	ANY

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature -- Access

	stock_pixmaps: attached EV_STOCK_PIXMAPS
			-- EiffelVision2 OS pixmaps
		once
			create Result
		end

	mini_pixmaps: attached ES_PIXMAPS_10X10
			-- Title bar pixmaps (10px)
		once
			create Result.make ("10x10")
		end

	small_pixmaps: attached ES_PIXMAPS_12X12
			-- Small icon pixmaps (12px)
		once
			create Result.make ("12x12")
		end

	icon_pixmaps: attached ES_PIXMAPS_16X16
			-- Normal sized icon pixmaps (16px)
		once
			create Result.make ("16x16")
		end

	configuration_pixmaps: attached ES_CONFIGURATION_PIXMAPS
			-- Configuration system pixmaps (16px)
		once
			create Result.make ("16x16")
		end

feature -- Helpers

	resource_handler: attached ES_PIXMAP_RESOURCE_HANDLER
			-- Shared access to an icon resource handled
		once
			create Result.make
		end

feature -- Pngs

	bm_About: EV_PIXMAP
			-- Bitmap for the "About Dialog"
		local
			l_buffer: EV_PIXEL_BUFFER
		once
			l_buffer := resource_handler.retrieve_matrix ("bm_About")
			Result := l_buffer.to_pixmap
		end

	bm_Wizard_blue: EV_PIXMAP
			-- Bitmap for the wizards
		local
			l_buffer: EV_PIXEL_BUFFER
		once
			l_buffer := resource_handler.retrieve_matrix ("bm_wizard_blue")
			Result := l_buffer.to_pixmap
		end

	bm_Wizard_profiler_icon: EV_PIXMAP
			-- Icon Bitmap for the wizards
		local
			l_buffer: EV_PIXEL_BUFFER
		once
			l_buffer := resource_handler.retrieve_matrix ("bm_wizard_profiler_icon")
			Result := l_buffer.to_pixmap
		end

	bm_Wizard_testing_icon: EV_PIXMAP
			-- Icon Bitmap for the wizards
		local
			l_buffer: EV_PIXEL_BUFFER
		once
			l_buffer := resource_handler.retrieve_matrix ("bm_wizard_testing_icon")
			Result := l_buffer.to_pixmap
		end

note
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- EB_SHARED_PIXMAPS

