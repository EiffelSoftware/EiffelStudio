indexing
	description: "This class represents a MS_WINDOWS pixmap";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"
 
class
	PIXMAP_IMP

inherit
	PIXMAP_I

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

creation
	make, make_for_screen

feature -- Initialization

	make (a_pixmap: PIXMAP) is
		do
		end

	make_for_screen (a_pixmap: PIXMAP; a_screen: SCREEN) is
		do
		end

feature -- Access

	depth: INTEGER
			-- Depth of pixmap (Number of colors)

	height: INTEGER
			-- Height of pixmap

	hot_x: INTEGER 
			-- X position of hot spot if this is a cursor

	hot_y: INTEGER 
			-- Y position of hot spot if this is a cursor

	is_valid: BOOLEAN
			-- Is this a valid pixmap?

	last_operation_correct: BOOLEAN
			-- Did the last operation suceed?

	width: INTEGER
			-- Width of pixmap

feature -- Element change

	copy_from (a_widget: WIDGET_I; x, y, p_width, p_height: INTEGER) is
			-- Copy the area specified by `x', `y', `p_width', `p_height' of
			-- `a_widget' into the pixmap.
		do
		end

feature -- Input

	read_from_file (a_file_name: STRING) is 
			-- Read a bitmap (X11 bitmap or Windows) from `a_file_name'
		local
			file: RAW_FILE
			xbm: X_BITMAP_WINDOWS
			msg_temp: STRING
			msg_box: WEL_MSG_BOX
		do
			!! file.make (a_file_name)
			is_valid := false
			if file.exists then
				if file.count > 2 then
					file.open_read
					file.readstream (2)
					file.close
					check
						two_characters_read: file.last_string.count = 2
					end
					if file.laststring.is_equal ("BM") then
						!! file.make_open_read (a_file_name)
						!! dib.make_by_file (file)
						is_valid := dib.exists
						depth := dib.color_count
						height := dib.height
						width := dib.width
						hot_x := 0
						hot_y := 0
					elseif file.laststring.is_equal ("#d") then
						!! xbm.read_from_xbm_file (a_file_name)
						dib := xbm
						is_valid := xbm.is_valid
						depth := 2
						height := xbm.height
						width := xbm.width
						hot_x := xbm.hot_x
						hot_y := xbm.hot_y
					elseif
						(file.laststring.item (1) = '%U'
						and then file.laststring.item (2) = '%U')
						or file.laststring.is_equal ("RI") then
							-- Icon, cursor or ANI cursor
					else
						!! msg_temp.make (0)
						msg_temp.append ("Unable to determine type for pixmap is file ")
						msg_temp.append (a_file_name)
						msg_temp.append (".%N")
						!! msg_box.make
						msg_box.error_message_box (Void, msg_temp, "Error") 
					end
				else
					!! msg_temp.make (0)
					msg_temp.append ("Unable to read pixmap ")
					msg_temp.append (a_file_name)
					msg_temp.append (".%N")
					!! msg_box.make
					msg_box.error_message_box (Void, msg_temp, "Error") 
				end
				if hot_x = 0 and then hot_y = 0 then
					hot_x := width // 2
					hot_y := height // 2
				end
			else
				!! msg_temp.make (0)
				msg_temp.append ("Pixmap file ")
				msg_temp.append (a_file_name)
				msg_temp.append (" doesn't exist.%N")
				!! msg_box.make
				msg_box.warning_message_box (Void, msg_temp, "Warning") 
			end
			last_operation_correct := is_valid
		end

	retrieve (a_file_name: STRING) is
			-- Read a bitmap (X11 pixmap or Windows bitmap) from `a_file_name'
		do
			read_from_file (a_file_name)
		end

feature -- Output

	store (a_file_name: STRING) is
			-- Store the pixmap into a file named `a_file_name'.
			-- Create the file if it doesn't exist and override else.
			-- Set `last_operation_correct'.
		require else
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			dib_not_void: dib /= Void
			dib_exists: dib.exists
		local
			dc: WEL_SCREEN_DC
			bitmap: WEL_BITMAP
			file_name: FILE_NAME
		do
			!! file_name.make_from_string (a_file_name)
			if file_name.is_valid then
				!! dc
				dc.get
				!! bitmap.make_by_dib (dc, dib, Dib_rgb_colors)
				dc.save_bitmap (bitmap, file_name)
				dc.release
			end
		end

feature -- Implementation

	cursor: WEL_CURSOR
			-- WEL_CURSOR for cursors (ANI and CUR)

	dib: WEL_DIB
			-- WEL_DIB for bitmaps

	icon: WEL_ICON
			-- WEL_ICON for icons

end -- class PIXMAP_IMP
 

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

