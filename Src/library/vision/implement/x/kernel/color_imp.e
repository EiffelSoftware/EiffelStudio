note

	description: "X implementation of the notion of color"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class COLOR_IMP 

inherit

	COLOR_I
		undefine
			is_equal
		end;

	RESOURCE_X
		undefine
			is_equal
		end;

	MEL_PIXEL
		rename
			red as mel_red,
			green as mel_green,
			blue as mel_blue
		undefine
			has_valid_display
		redefine
			display, dispose
		end;

create

	make, 
	make_for_screen

feature {NONE} -- Initialization

	make (a_color: COLOR)
			-- Create a color
		require
			last_open_display_not_null: last_open_display /= Void
		do
			display := last_open_display
		end; 

	make_for_screen (a_color: COLOR; a_screen: SCREEN)
			-- Create a font.
		require
			valid_screen: a_screen /= Void and then a_screen.is_valid
		do
			display ?= a_screen.implementation;
			check
				valid_display: display /= Void
			end
		end;

feature -- Access

	display: MEL_DISPLAY;
			-- Display where resource is allocated

	allocated_blue: INTEGER
			-- Allocated blue saturation level for `a_widget'
		do
			allocate_pixel;
			Result := red
		end; 

	allocated_green: INTEGER
			-- Allocated green saturation level for `a_widget'
		do
			allocate_pixel;
			Result := green
		end; 

	allocated_red: INTEGER
			-- Allocated red saturation level for `a_widget'
		do
			allocate_pixel;
			Result := red
		end; 

feature -- Status report

	blue: INTEGER;
			-- Blue saturation level

	green: INTEGER;
			-- Green saturation level

	is_white_by_default: BOOLEAN;
			-- Default color used in case of failure
			-- to allocate desire color

	name: STRING;
			-- name of desired color for current

	red: INTEGER;
			-- Red saturation level

feature -- Status setting

	set_black_default
			-- Set black color to be used by default if
			-- it is impossible to allocate desire color.
		do
			is_white_by_default := false
		end; 

	set_blue (blue_value: INTEGER)
			-- Set blue saturation level to `blue_value'.
		do
			blue := blue_value;
			name := Void;
			dispose;
			update_widgets
		end; 

	set_green (green_value: INTEGER)
			-- Set green saturation level to `green_value'.
		do
			green := green_value;
			name := Void;
			dispose;
			update_widgets
		end; 

	set_name (a_name: STRING)
			-- Set color name to `a_name'.
		do
			name := a_name.twin;
			dispose;
			update_widgets
		end; 

	set_default_pixel (a_pixel: MEL_PIXEL; cmap: MEL_COLORMAP)
			-- Set the default Pixel color to `pixel_value'
		require
			valid_pixel: a_pixel /= Void and then a_pixel.is_valid;
			cmap_value_not_void: cmap /= Void
		do
			identifier := a_pixel.identifier;
			colormap_identifier := cmap.identifier;	
			display_handle := a_pixel.display_handle;
			is_allocated := True;
			name := Void;
		end;
			
	set_red (red_value: INTEGER)
			-- Set red saturation level to `red_value'.
		do
			red := red_value;
			name := Void;
			dispose;
			update_widgets
		end; 

	set_rgb (red_value, green_value, blue_value: INTEGER)
			-- Set red, green and blue saturation level respectivly to
			-- `red_value', `green_value' and `blue_value'.
		do
			red := red_value;
			green := green_value;
			blue := blue_value;
			name := Void;
			dispose;
			update_widgets
		end; 

	set_white_default
			-- Set white color to be used by default if
			-- it is impossible to allocate desire color.
		do
			is_white_by_default := true
		end; 

feature -- Element change

	allocate_pixel
			-- Allocate Pixel of current color on `a_screen' if
			-- it has not been done.
		local
			cmap: MEL_COLORMAP;
			default_screen: MEL_SCREEN;
		do
			if not is_allocated then
				is_real_allocated := False;
					-- Means that color has not been allocated or tried
					-- to be allocated.
				default_screen := display.default_screen;
				cmap := default_screen.default_colormap;
				if (name = Void) then
						-- Use rgb values
					make_by_rgb_value (display, cmap, red, green, blue);
				else  
					make_by_name (display, cmap, name);
				end;
				if is_valid then
					is_real_allocated := True
				else
						-- Reset status 
					status := 0;
					if is_white_by_default then
						identifier := default_screen.white_pixel.identifier
					else
						identifier := default_screen.black_pixel.identifier
					end;
				end;
				is_allocated := True;
			end
		end

feature {NONE} -- Implementation

	is_real_allocated: BOOLEAN
			-- Was the X color structure allocated?

	dispose
			-- Free color resource.
		do
			if is_real_allocated then
				destroy
			end;
			is_allocated := False;
			is_real_allocated := False;
			identifier := default_pointer;
		end; 

	update_widget_resource (widget_m: WIDGET_IMP)
			-- Update resource for `widget_m'.
			-- Set `updated' to True if the resource was set.
		local
			primitive: PRIMITIVE_IMP;
			manager: MANAGER_IMP;
			c: COLOR;
		do
			c := widget_m.private_background_color;	
			if (c /= Void) and then (c.implementation = Current) then
				number_of_users := number_of_users + 1;
				widget_m.update_background_color;
			end;
			primitive ?= widget_m;
			if primitive /= Void then
				c := primitive.private_foreground_color;
				if (c /= Void) and then (c.implementation = Current) then
					number_of_users := number_of_users + 1;
					primitive.update_foreground_color;
				end
			else
				manager ?= widget_m;
				if manager /= Void then 
					c := manager.private_foreground_color;
					if (c /= Void) and then (c.implementation = Current) then
						number_of_users := number_of_users + 1;
						manager.update_foreground_color;
					end
				end
			end;
		end; 

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class COLOR_IMP


