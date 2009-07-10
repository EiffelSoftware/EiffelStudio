note
	description: "[
		An output pane specifically for the Eiffel compiler.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_COMPILER_OUTPUT_PANE

inherit
	ES_EDITOR_OUTPUT_PANE
		redefine
			make,
			on_unlocked,
			new_icon_animations,
			new_icon_pixmap_animations
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL)
			-- <Precursor>		
		do
			make_with_icon (a_name, stock_pixmaps.compile_animation_7_icon_buffer)
		end

feature {NONE} -- Event handlers

	on_unlocked
			-- <Precursor>
		do
			Precursor
			if workbench.successful then
				internal_icon_active := stock_pixmaps.compile_success_icon_buffer
				internal_icon_active_pixmap := stock_pixmaps.compile_success_icon
			else
				internal_icon_active := stock_pixmaps.compile_error_icon_buffer
				internal_icon_active_pixmap := stock_pixmaps.compile_error_icon
			end
		end

feature {NONE} -- Factory

	new_icon_animations: ARRAY [EV_PIXEL_BUFFER]
			-- <Precursor>
		do
			create Result.make_from_array (stock_pixmaps.compile_animation_buffer_anim)
			Result.force (Result[Result.upper], Result.upper + 1)
		end

	new_icon_pixmap_animations: ARRAY [EV_PIXMAP]
			-- <Precursor>
		do
			create Result.make_from_array (stock_pixmaps.compile_animation_anim)
			Result.force (Result[Result.upper], Result.upper + 1)
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
