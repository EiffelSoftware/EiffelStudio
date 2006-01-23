indexing
	description: "Entity corresponding to an element of a displayed line."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	ENTITY_LINE
	
create
	make,
	make_with_image_and_color,
	make_with_image_and_color_and_font

feature -- Initialization

	make is
			-- Initialize `image' and `font' with default value.
		do
			create image.make_empty
			create foreground_color.make_with_8_bit_rgb (0,0,0)
			create font
		ensure
			non_void_image: image /= Void
			non_void_font: font /= Void
		end
		
	make_with_image_and_color (an_image: STRING; a_foreground_color: EV_COLOR) is
			-- Initialiaze `image' and `foreground_color'.
		require
			non_void_an_image: an_image /= Void
			non_void_a_foreground_color: a_foreground_color /= Void
		do
			image := an_image
			foreground_color := a_foreground_color
			create font
		ensure
			non_void_image: image /= Void
			non_void_foreground_color: foreground_color /= Void
			non_void_font: font /= Void
		end

	make_with_image_and_color_and_font (an_image: STRING; a_foreground_color: EV_COLOR; a_font: EV_FONT) is
			-- Initialiaze `image' and `foreground_color' and `font'.
		require
			non_void_an_image: an_image /= Void
			non_void_a_foreground_color: a_foreground_color /= Void
			non_void_a_font: a_font /= Void
		do
			image := an_image
			foreground_color := a_foreground_color
			font := a_font
		ensure
			non_void_image: image /= Void
			non_void_foreground_color: foreground_color /= Void
			non_void_font: font /= Void
		end

feature -- Access

	image: STRING
			-- entity text.
	
	foreground_color: EV_COLOR
			-- foreground color of entity.		
	
	font: EV_FONT
			-- entity font.
	
	data: ANY
			-- data associated to entity.
			
feature -- Status Setting

	set_data (a_data: like data) is
			-- Set `data' with `a_data'.
		do
			data := a_data
		ensure
			data_set: data = a_data
		end
			
invariant
	non_void_image: image /= Void
	non_void_foreground_color: foreground_color /= Void
	non_void_font: font /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class ENTITY_LINE
