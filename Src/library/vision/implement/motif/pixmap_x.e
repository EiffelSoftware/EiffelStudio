indexing

	description:
		"Implementation of an mult-plane pixmap.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	PIXMAP_X 

inherit

	PIXMAP_I
		undefine
			is_equal
		end;

	RESOURCE_X
		undefine
			is_equal
		end;

	MEL_PIXMAP
		rename
			make as old_make
		undefine
			has_valid_display
		redefine
			display
		end;

	MEMORY
		rename
			free as gc_free
		export
			{NONE} all
		undefine
			is_equal
		redefine
			dispose
		end;

	SHARED_MEL_DISPLAY
		undefine
			is_equal
		end

creation

	make, 
	make_for_screen

feature {NONE} -- Initialization

	make (a_pixmap: pixmap) is
			-- Create a pixmap.
		require
			last_open_display_not_null: last_open_display /= Void
		do
			display := last_open_display
		end; 

	make_for_screen (a_pixmap: PIXMAP; a_screen: SCREEN) is
			-- Create a font.
		require
			valid_screen: a_screen /= Void and then a_screen.is_valid
		local
			mel_display: MEL_DISPLAY
		do
			display ?= a_screen.implementation;
			check
				valid_display: display /= Void
			end
		end;

feature -- Access

	display: MEL_DISPLAY;
			-- Display where resource is allocated

	bitmap: BITMAP_RESOURCE_X
			-- Single plane bitmap 

	height: INTEGER;
			-- Height of pixmap

	hot_x: INTEGER;
			-- Horizontal position of "hot" point

	hot_y: INTEGER;
			-- Vertical position of "hot" point
	
	width: INTEGER 
			-- Width of pixmap

	last_operation_correct: BOOLEAN is
			-- Was the last operation correctly performed ?
		do
			Result := is_valid
		end;

feature -- Status setting

	set_default_pixmap (a_pixmap: MEL_PIXMAP) is
			-- Set default pixmap for widget's screen object `src_obj'.
		require
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid
		do
			identifier := a_pixmap.identifier;
			is_allocated := False;
			display_handle := a_pixmap.display_handle;
			height := 1;
			width := 1;
			depth := 2
		end;

feature -- Element change

	read_from_file (a_file_name: STRING) is
			-- Load the bitmap described in `a_file_name'.
			-- `a_file_name' must be a X11 bitmap file.
		local
			bitmap_format: MEL_BITMAP_FORMAT;
			pixmap: MEL_PIXMAP;
			gc: MEL_GC
		do
			free_resources;
			!! bitmap_format.make_from_file (display.default_screen, a_file_name);
			if bitmap_format.is_valid then
				is_allocated := True;
				height := bitmap_format.height;
				width := bitmap_format.width;
				hot_x := bitmap_format.x_hot;
				hot_y := bitmap_format.y_hot;
				if hot_x < 0 or else hot_x >= width then
					hot_x := width // 2
				end;
				if hot_y < 0 or else hot_y >= height then
					hot_y := height // 2
				end;
				!! gc.make (display.default_screen);
				pixmap := bitmap_format.to_pixmap (display.default_screen, gc);
				identifier := pixmap.identifier;
				display_handle := pixmap.display_handle;
				depth := 2; -- Black and white bitmap
				update_widgets;
				bitmap_format.bitmap.free
			end;
		end;

	copy_from (a_widget: WIDGET_I; x, y, p_width, p_height: INTEGER) is
			-- Copy the area specified by `x', `y', `p_width', `p_height' of
			-- `a_widget' into the pixmap.
		local
			mp: MEL_PIXMAP;
			mel_d: MEL_DISPLAY;
			mel_s: MEL_SCREEN;
			gc: MEL_GC;
			mel_widget: MEL_WIDGET
		do
			free_resources;
			mel_d := display;
			mel_s := mel_d.default_screen;
			!! mp.make (mel_s, 
					p_width, p_height, mel_s.default_depth);
			if mp.is_valid then
				mel_widget ?= a_widget;
				!! gc.make (mel_s);
				mp.copy_area (mel_widget, gc, x, y, p_width, p_height, 0, 0);
				is_allocated := True; 
				update_widgets;
			end
		end; 

	retrieve (a_file_name: STRING) is
			-- Retreive the pixmap from a file named `a_file_name'.
			-- Set `last_operation_correct'.
		local
			mel_scr: MEL_SCREEN
		do
			-- use display
			free_resources;
			is_allocated := True;
			update_widgets;
		end;

feature -- Output

	store (a_file_name: STRING) is
			-- Store the pixmap into a file named `a_file_name'.
			-- Create the file if it doesn't exist and override else.
			-- Set `last_operation_correct'.
		do
		end;

feature -- Element change

	allocate_bitmap is
			-- Allocate a single plane bitmap.
		require
			is_valid: is_valid
		local
			gc: MEL_GC
		do
			if bitmap = Void then
				!! bitmap.make (display.default_screen, width, height, 1)
				!! gc.make (bitmap);
				bitmap.copy_plane (Current, gc, 0, 0, width, height, 0, 0, 1)
			end;
		ensure
			valid_bitmap: bitmap /=  Void and then bitmap.is_valid
			bitmap_is_a_bitmap: bitmap.is_bitmap
		end;

feature {NONE} -- Implementation

	free_resources is
			-- Free the pixmap resources.
		do
			if bitmap /= Void then	
				bitmap.free;
				bitmap := Void
			end;
			dispose
		end;

	dispose is
			-- Called when the pixmap is garbaged
		do
			if is_allocated then
				free;
				is_allocated := False
			end
		end; 

	update_widget_resource (widget_m: WIDGET_M) is
			-- Update resource for `widget_m'.
		local
			a_pixmap: PIXMAP;
			pcb: PICT_COL_B_M;
			wms: WM_SHELL_M
		do
			a_pixmap := widget_m.private_background_pixmap;
			if (a_pixmap /= Void) and then 
				(a_pixmap.implementation = Current)
			then
				number_of_users := number_of_users + 1;
				widget_m.update_background_pixmap
			end;	
			pcb ?= widget_m;
			if pcb /= Void then
				a_pixmap := pcb.private_pixmap;
				if a_pixmap /= Void and then
					(a_pixmap.implementation = Current)
				then
					number_of_users := number_of_users + 1;
					pcb.update_pixmap
				end
			else
				wms ?= widget_m;
				if wms /= Void then
					a_pixmap := wms.private_icon_pixmap;
					if a_pixmap /= Void and then
						(a_pixmap.implementation = Current)
					then
						number_of_users := number_of_users + 1;
						wms.update_pixmap
					end
				end
			end
		end;
	
end -- class PIXMAP_X

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
