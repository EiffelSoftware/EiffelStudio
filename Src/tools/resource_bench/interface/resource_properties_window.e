indexing
	description: "Resource properties Window of the Resource Bench's main window"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_PROPERTIES_WINDOW

inherit
	WEL_CONTROL_WINDOW
		rename
			make_with_coordinates as old_make
		redefine
			class_background,
			class_name,
			on_paint
		end

	INTERFACE_MANAGER

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

	WEL_WS_CONSTANTS
		export
			{NONE} all
		end

	WEL_DT_CONSTANTS
		export
			{NONE} all
		end

creation
	make_with_coordinates

feature

	make_with_coordinates (a_parent: WEL_COMPOSITE_WINDOW; a_name: STRING; a_x, a_y, a_width, a_height: INTEGER) is
			-- Make the window as a child of `a_parent' and
			-- `a_name' as a title.
		do
			old_make (a_parent , a_name, a_x, a_y, a_width, a_height)
			parent_window ?= a_parent
		ensure
			parent_window_set: parent_window = a_parent
		end

feature -- Access

	current_resource: TDS_RESOURCE
			-- The current selected resource in the tree view control of the client window.

feature -- Element change

	set_current_resource (a_resource: TDS_RESOURCE) is
			-- Set `current_resource' to `a_resource'.
		do
			current_resource := a_resource
		ensure
			current_resource_set: current_resource = a_resource
		end

feature -- Behavior

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Paint the bitmap
		local
			bitmap: WEL_BITMAP
			cursor: WEL_CURSOR
			icon: WEL_ICON
			bitmap_resource: TDS_BITMAP
			cursor_resource: TDS_CURSOR
			icon_resource: TDS_icon
			dib: WEL_DIB
			file: RAW_FILE
			filename: FILE_NAME
		do
			bitmap_resource ?= current_resource
			cursor_resource ?= current_resource
			icon_resource ?= current_resource

			if bitmap_resource /= Void then
				!! file.make (bitmap_resource.filename)
				if file.exists then
					!! file.make_open_read (bitmap_resource.filename)
					!! dib.make_by_file (file)
					!! bitmap.make_by_dib (paint_dc, dib, Dib_rgb_colors)
					paint_dc.draw_bitmap (bitmap, 1, 3, bitmap.width, bitmap.height)
				else
					error_message.wipe_out
					error_message.append ("Can't open the bitmap file %"")
					error_message.append (bitmap_resource.filename)
					error_message.extend ('%"')
					paint_dc.select_font (ansi_font)
					paint_dc.set_background_transparent
					paint_dc.text_out (1, 3, error_message)
				end
			end

			if cursor_resource /= Void then
				!! filename.make_from_string (cursor_resource.filename)
				!! cursor.make_by_file (filename)
				if cursor.exists then
					paint_dc.draw_cursor (cursor, 1, 3)
				else
					error_message.wipe_out
					error_message.append ("Can't open the cursor file %"")
					error_message.append (cursor_resource.filename)
					error_message.extend ('%"')
					paint_dc.select_font (ansi_font)
					paint_dc.set_background_transparent
					paint_dc.text_out (1, 3, error_message)
				end
			end

			if icon_resource /= Void then
				!! filename.make_from_string (icon_resource.filename)
				!! icon.make_by_file (filename)
				if icon.exists then
					paint_dc.draw_icon (icon, 1, 3)
				else
					error_message.wipe_out
					error_message.append ("Can't open the icon file %"")
					error_message.append (icon_resource.filename)
					error_message.extend ('%"')
					paint_dc.select_font (ansi_font)
					paint_dc.set_background_transparent
					paint_dc.text_out (1, 3, error_message)
				end
			end
		end

	class_background: WEL_LIGHT_GRAY_BRUSH is
			-- Standard window background color
		once
			!! Result.make
		end

	ansi_font: WEL_ANSI_VARIABLE_FONT is
		once
			!! Result.make
		end

	class_name: STRING_32 is
		once
			Result := "Properties window"
		end

feature {NONE} -- Implementation

	parent_window: MAIN_WINDOW
			-- Parent of the client.

	error_message: STRING is
			-- Error string message.
		once
			!! Result.make (30)
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
end -- class CLIENT_WINDOW
