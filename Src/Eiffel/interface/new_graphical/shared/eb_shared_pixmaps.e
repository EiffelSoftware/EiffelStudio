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

	stock_pixmaps: EV_STOCK_PIXMAPS
			-- EiffelVision2 OS pixmaps
		once
			create Result
		end

	mini_pixmaps: ES_MINI_ICONS
			-- Title bar pixmaps.
		local
			l_dpi: NATURAL
		do
			l_dpi := {EV_MONITOR_DPI_DETECTOR_IMP}.dpi
			if l_dpi <= 108 then
				create Result.make ("mini_10x10", 10, 10)
			elseif l_dpi <= 120 then
				Result := mini_pixmaps_12
			elseif l_dpi <= 144 then
				Result := mini_pixmaps_15
			else
				check l_dpi > 144 end
				Result := mini_pixmaps_20
			end
			if Result = Void or else Result.has_error then
				Result := mini_pixmaps_10
			end
		ensure
			is_class: class
		end

	mini_pixmaps_10: ES_MINI_ICONS
			-- Title bar pixmaps (10px)
		once
			create Result.make ("10x10", 10, 10)
		ensure
			is_class: class
		end

	mini_pixmaps_12: ES_MINI_ICONS
			-- Title bar pixmaps (12px)
		once
			create Result.make ("mini_12x12", 12, 12)
		ensure
			is_class: class
		end

	mini_pixmaps_15: ES_MINI_ICONS
			-- Title bar pixmaps (15px)	
		once
			create Result.make ("mini_15x15", 15, 15)
		ensure
			is_class: class
		end

	mini_pixmaps_20: ES_MINI_ICONS
			-- Title bar pixmaps (20px)
		once
			create Result.make ("mini_20x20", 20, 20)
		ensure
			is_class: class
		end

	small_pixmaps: ES_SMALL_ICONS
			-- Small icon pixmaps.
		local
			l_dpi: NATURAL
		do
			l_dpi := {EV_MONITOR_DPI_DETECTOR_IMP}.dpi
			if l_dpi <= 108 then
				create Result.make ("small_12x12", 12, 12)
			elseif l_dpi <= 120 then
				Result := small_pixmaps_12
			elseif l_dpi <= 144 then
				Result := small_pixmaps_18
			else
				check l_dpi > 144 end
				Result := small_pixmaps_24
			end
			if Result = Void or else Result.has_error then
				Result := small_pixmaps_12
			end
		ensure
			is_class: class
		end

	small_pixmaps_12: ES_SMALL_ICONS
			-- Small icon pixmaps (12px).
		once
			create Result.make ("12x12", 12, 12)
		ensure
			is_class: class
		end

	small_pixmaps_15: ES_SMALL_ICONS
			-- Small icon pixmaps (15px).
		once
			create Result.make ("small_15x15", 15, 15)
		ensure
			is_class: class
		end

	small_pixmaps_18: ES_SMALL_ICONS
			-- Small icon pixmaps (18px).
		once
			create Result.make ("small_18x18", 18, 18)
		ensure
			is_class: class
		end

	small_pixmaps_24: ES_SMALL_ICONS
			-- Small icon pixmaps (24px).
		once
			create Result.make ("small_24x24", 24, 24)
		ensure
			is_class: class
		end

	icon_pixmaps: ES_ICONS
			-- Normal sized icon pixmaps.
		local
			l_dpi: NATURAL
		do
			l_dpi := {EV_MONITOR_DPI_DETECTOR_IMP}.dpi
			if l_dpi <= 108 then
				create Result.make ("icons_16x16", 16, 16)
			elseif l_dpi <= 120 then
				Result := icon_pixmaps_20
			elseif l_dpi <= 144 then
				Result := icon_pixmaps_24
			else
				check l_dpi > 144 end
				Result := icon_pixmaps_32
			end
			if Result = Void or else Result.has_error then
				Result := icon_pixmaps_16
			end
		ensure
			is_class: class
		end

	icon_pixmaps_16: ES_ICONS
			-- Normal sized icon pixmaps (16px).
		once
			create Result.make ("16x16", 16, 16)
		ensure
			is_class: class
		end

	icon_pixmaps_20: ES_ICONS
			-- Normal sized icon pixmaps (20px).
		once
			create Result.make ("icons_20x20", 20, 20)
		ensure
			is_class: class
		end

	icon_pixmaps_24: ES_ICONS
			-- Normal sized icon pixmaps (24px).
		once
			create Result.make ("icons_24x24", 24, 24)
		ensure
			is_class: class
		end

	icon_pixmaps_32: ES_ICONS
			-- Normal sized icon pixmaps (32px).
		once
			create Result.make ("icons_32x32", 32, 32)
		ensure
			is_class: class
		end

	configuration_pixmaps: ES_CONFIGURATION_PIXMAPS
			-- Configuration system pixmaps.
		local
			l_dpi: NATURAL
		do
			l_dpi := {EV_MONITOR_DPI_DETECTOR_IMP}.dpi
			if l_dpi > 108 and then l_dpi <= 120 then
				Result := configuration_pixmaps_20
			elseif l_dpi > 132 and then l_dpi <= 144 then
				Result := configuration_pixmaps_24
			elseif l_dpi > 144 then
				Result := configuration_pixmaps_32
			else
				create Result.make ("icons_16x16", 16, 16)
			end
			if Result = Void or else Result.has_error then
				Result := configuration_pixmaps_16
			end
		ensure
			is_class: class
		end

	configuration_pixmaps_16: ES_CONFIGURATION_PIXMAPS
			-- Configuration system pixmaps 16px.
		once
			create Result.make ("16x16", 16, 16)
		ensure
			is_class: class
		end

	configuration_pixmaps_20: ES_CONFIGURATION_PIXMAPS
			-- Configuration system pixmaps 20px.
		once
			create Result.make ("icons_20x20", 20, 20)
		ensure
			is_class: class
		end

	configuration_pixmaps_24: ES_CONFIGURATION_PIXMAPS
			-- Configuration system pixmaps 24px.
		once
			create Result.make ("icons_24x24", 24, 24)
		ensure
			is_class: class
		end

	configuration_pixmaps_32: ES_CONFIGURATION_PIXMAPS
			-- Configuration system pixmaps 32px.
		once
			create Result.make ("icons_32x32", 32, 32)
		ensure
			is_class: class
		end

feature -- Helpers

	resource_handler: ES_PIXMAP_RESOURCE_HANDLER
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
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

end -- EB_SHARED_PIXMAPS

