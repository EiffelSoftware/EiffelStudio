indexing

	description:
		"Implementation of an mult-plane pixmap.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	PIXMAP_IMP 

inherit

	PIXMAP_I
		rename
			depth as number_of_colors
		undefine
			is_equal
		end;

	RESOURCE_X
		undefine
			is_equal
		end;

	MEL_PIXMAP
		rename
			make as mel_pixmap_make
		undefine
			has_valid_display
		redefine
			display, dispose
		end;

	MEL_XPM_CONSTANTS
		undefine
			is_equal
		end;

creation

	make, 
	make_for_screen

feature {NONE} -- Initialization

	make (a_pixmap: pixmap) is
			-- Create a pixmap.
		require
			last_open_display_not_null: last_open_display /= Void
		do
			display := last_open_display;
			display_handle := display.handle;
		end; 

	make_for_screen (a_pixmap: PIXMAP; a_screen: SCREEN) is
			-- Create a font.
		require
			valid_screen: a_screen /= Void and then a_screen.is_valid
		local
			mel_display: MEL_DISPLAY
		do
			display ?= a_screen.implementation;
			display_handle := display.handle;
			check
				valid_display: display /= Void
			end
		end;

feature -- Access

	display: MEL_DISPLAY;
			-- Display where resource is allocated

	bitmap: MEL_PIXMAP
			-- Single plane bitmap 

	height: INTEGER;
			-- Height of pixmap

	hot_x: INTEGER;
			-- Horizontal position of "hot" point

	hot_y: INTEGER;
			-- Vertical position of "hot" point
	
	width: INTEGER 
			-- Width of pixmap

	number_of_colors: INTEGER;	
			-- Number of colors in the pixmap

	last_operation_correct: BOOLEAN is
			-- Was the last operation correctly performed ?
		do
			Result := last_operation_correct_ref.item
		end;

feature -- Status setting

	set_default_pixmap (a_pixmap: MEL_PIXMAP) is
			-- Set default pixmap for widget's screen object `src_obj'.
		require
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid
		do
			identifier := a_pixmap.identifier;
			depth := a_pixmap.depth;
			is_allocated := False;
			height := 1;
			width := 1;
			number_of_colors := 2
		end;

feature -- Element change

	read_from_file (a_file_name: STRING) is
			-- Load the bitmap described in `a_file_name'.
			-- `a_file_name' must be a X11 bitmap file.
		local
			bitmap_format: MEL_BITMAP_FORMAT;
			pixmap: MEL_PIXMAP;
			gc: MEL_GC;
			def_screen: MEL_SCREEN;
			xpm_format: MEL_XPM_FORMAT;
			attr: MEL_XPM_ATTRIBUTES
		do
			free_resources;
			def_screen := display.default_screen;
				-- True reading the file as a xpm format.
				-- If this fails then try to read it as bitmap format.
			!! attr.make;
			attr.set_valuemask (XpmSize+XpmInfos+XpmRGBCloseness);
			attr.set_red_closeness(65535);
			attr.set_blue_closeness(65535);
			attr.set_green_closeness(65535);
			!! xpm_format.make_from_file (def_screen, a_file_name, attr);
			if xpm_format.is_valid then
				is_allocated := True;
				identifier := xpm_format.pixmap.identifier;
				depth := xpm_format.pixmap.depth;
				number_of_colors := attr.number_of_colors;
				height := attr.height;
				width := attr.width;
				if xpm_format.shape_mask /= Void then
					xpm_format.shape_mask.destroy;
				end;
			else
				if xpm_format.error = XpmFileInvalid then
					!! bitmap_format.make_from_file (def_screen, a_file_name);
					if bitmap_format.is_valid then
						is_allocated := True;
						height := bitmap_format.height;
						width := bitmap_format.width;
						hot_x := bitmap_format.x_hot;
						hot_y := bitmap_format.y_hot;

						!! gc.make (def_screen);
						gc.set_background_color (def_screen.white_pixel);
						gc.set_foreground_color (def_screen.black_pixel);
						pixmap := bitmap_format.to_pixmap (def_screen, gc);
						gc.destroy;

						identifier := pixmap.identifier;
						depth := pixmap.depth;
						number_of_colors := 2; -- Black and white bitmap
						update_widgets;
						bitmap_format.bitmap.destroy
					end
				end
			end;
			attr.destroy;
			if is_allocated then
				if hot_x < 0 or else hot_x >= width then
					hot_x := width // 2
				end;
				if hot_y < 0 or else hot_y >= height then
					hot_y := height // 2
				end;
			end;
			last_operation_correct_ref.set_item (is_allocated)
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
				identifier := mp.identifier;
				depth := mp.depth;
				number_of_colors := 1;
				mel_widget ?= a_widget;
				!! gc.make (mel_s);
				copy_area (mel_widget, gc, x, y, p_width, p_height, 0, 0);
				gc.destroy;
				is_allocated := True; 
				width := p_width;
				height := p_height;
				hot_x := 0;
				hot_y := 0;
				update_widgets;
			end;
			last_operation_correct_ref.set_item (is_allocated)
		end; 

feature -- Output

	store (a_file_name: STRING) is
			-- Store the pixmap into a file named `a_file_name'.
			-- Create the file if it doesn't exist and override else.
			-- Set `last_operation_correct'.
		local
			xmp_format: MEL_XPM_FORMAT
		do
			!! xmp_format.write_to_file
				(display, a_file_name,
				Current, Void, Void);
			last_operation_correct_ref.set_item (xmp_format.is_valid)
		end;

feature -- Element change

	allocate_bitmap is
			-- Allocate a single plane bitmap.
		require
			is_valid: is_valid
		local
			gc: MEL_GC;
			def_screen: MEL_SCREEN
		do
			if bitmap = Void then
				def_screen := display.default_screen;
				!! bitmap.make (def_screen, width, height, 1)
				!! gc.make (bitmap);
				gc.set_background_color (def_screen.white_pixel);
				gc.set_foreground_color (def_screen.black_pixel);
				bitmap.copy_plane (Current, gc, 0, 0, width, height, 0, 0, 1);
				gc.destroy
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
				bitmap.destroy;
				bitmap := Void
			end;
			dispose
		end;

	dispose is
			-- Called when the pixmap is garbaged
		do
			if is_allocated then
				destroy;
				is_allocated := False
			end
		end; 

	update_widget_resource (widget_m: WIDGET_IMP) is
			-- Update resource for `widget_m'.
		local
			a_pixmap: PIXMAP;
			pcb: PICT_COLOR_B_IMP;
			wms: WM_SHELL_IMP
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

	last_operation_correct_ref: BOOLEAN_REF is
			-- Cell for storing the success of the last operation
		once
			!! Result
		end
	
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

