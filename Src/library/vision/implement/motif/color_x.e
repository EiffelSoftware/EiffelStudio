
-- X implementation of the notion of color.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class COLOR_X 

inherit

	COLOR_I;

	RESOURCES_X [ANY]
		rename
			make as resources_x_make
		end

creation

	make

feature {NONE}

	allocate (a_screen: SCREEN_I): POINTER is
			-- Pixel of current color on `a_screen'
		local
			ext_name: ANY;
		do
			is_real_allocated := false;
			if (n_ame = Void) then
				if not pixel_set then  -- rgb color
					if c_allocate_color (a_screen.screen_object, red, green, blue) then
						Result := c_pixel_allocated_color;
						is_real_allocated := true
					end;
				else  --  pixel color
					Result := the_pixel;
					is_real_allocated := true
				end;
			else  -- name color
				ext_name := n_ame.to_c;
				if c_parse_name_color (a_screen.screen_object, $ext_name) then
					if c_allocate_wanted_color (a_screen.screen_object) then
						Result := c_pixel_allocated_color;
						is_real_allocated := true
					end
				end
			end;
			if not is_real_allocated then
				if is_white_by_default then
					Result := white_pixel (a_screen.screen_object)
				else
					Result := black_pixel (a_screen.screen_object)
				end
			end
		end; 
	
feature 

	allocated_blue (a_widget: WIDGET_I): INTEGER is
			-- Allocated blue saturation level for `a_widget'
		require else
			a_widget_exists: not (a_widget = Void);
			a_widget_realized: a_widget.realized
		
		local
			a_screen_object: POINTER
		do
			a_screen_object := a_widget.screen_object;
			c_query_color (xt_display (a_screen_object), pixel (a_widget.screen));
			Result := c_blue_allocated_color
		end; 

	allocated_green (a_widget: WIDGET_I): INTEGER is
			-- Allocated green saturation level for `a_widget'
		require else
			a_widget_exists: not (a_widget = Void);
			a_widget_realized: a_widget.realized
		
		local
			a_screen_object: POINTER
		do
			a_screen_object := a_widget.screen_object;
			c_query_color (xt_display (a_screen_object), pixel (a_widget.screen));
			Result := c_green_allocated_color
		end; 

	allocated_red (a_widget: WIDGET_I): INTEGER is
			-- Allocated red saturation level for `a_widget'
		require else
			a_widget_exists: not (a_widget = Void);
			a_widget_realized: a_widget.realized
		
		local
			a_screen_object: POINTER
		do
			a_screen_object := a_widget.screen_object;
			c_query_color (xt_display (a_screen_object), pixel (a_widget.screen));
			Result := c_red_allocated_color
		end; 

feature {NONE}

	black_pixel (a_display_pointer: POINTER) : POINTER is
			-- Index of black color in `a_display_pointer'
		
		do
			Result := c_black_pixel (a_display_pointer)
		end; 
	
feature 

	blue: INTEGER;
			-- Blue saturation level

	make (a_color: COLOR) is
			-- Create a color
		require
			a_color_exists: not (a_color = Void)
		do
			resources_x_make
		end; 

	pixel_set: BOOLEAN;
	
feature {NONE}

	free_resources is
			-- Free all color resources.
		do
			from
				start
			until
				off
			loop
				if item.is_allocated then
					c_free_color (item.screen.screen_object, item.identifier)
				end;
				forth
			end;
			wipe_out
		end; 

feature 

	green: INTEGER;
			-- Green saturation level

feature {NONE}

	is_real_allocated: BOOLEAN;
			-- Is the color really allocated ?

	is_used_by (a_widget: WIDGET): BOOLEAN is
			-- Is `a_widget' using this resource ?
		require else
			a_widget_exists: not (a_widget = Void)
		local
			primitive: PRIMITIVE;
			manager: MANAGER
		do
			Result := (not (a_widget.background_color = Void)) and then (a_widget.background_color.implementation = Current);
			if not Result then
				primitive ?= a_widget;
				if not (primitive = Void) then
					Result := (not (primitive.foreground = Void)) and then (primitive.foreground.implementation = Current)
				else
					manager ?= a_widget;
					Result := (not (manager = Void)) and then ((not (manager.foreground = Void)) and then (manager.foreground.implementation = Current))
				end
			end
		ensure then
			(number_of_uses = 0) implies (not Result)
		end; 
	
feature 

	is_white_by_default: BOOLEAN;
			-- Default color used in case of failure
			-- to allocate desire color

	n_ame: STRING;
			-- name of desired color for current

	pixel (a_screen: SCREEN_I): POINTER is
			-- Pixel value of color for `a_screen'
		require
			a_screen_exists: not (a_screen = Void)
		local
			a_resource: RESOURCE_X
		do
			a_resource := find_same_screen (a_screen);
			if (a_resource = Void) then
				Result := allocate (a_screen);
				!!a_resource.make (a_screen, Result, is_real_allocated);
				finish;
				put_right (a_resource)
			else
				Result := a_resource.identifier
			end
		end; 

	red: INTEGER;
			-- Red saturation level

	set_black_default is
			-- Set black color to be used by default if
			-- it is impossible to allocate desire color.
		do
			is_white_by_default := false
		ensure then
			not is_white_by_default
		end; 

	set_blue (blue_value: INTEGER) is
			-- Set blue saturation level to `blue_value'.
		require else
			blue_value_small_enough: blue_value  <= 65535;
			blue_value_not_negative: blue_value >= 0
		do
			blue := blue_value;
			n_ame := Void;
			pixel_set := False;
			free_resources;
			update_widgets
		ensure then
			n_ame = Void;
			blue = blue_value
		end; 

	set_green (green_value: INTEGER) is
			-- Set green saturation level to `green_value'.
		require else
			green_value_small_enough: green_value  <= 65535;
			green_value_not_negative: green_value >= 0
		do
			green := green_value;
			n_ame := Void;
			pixel_set := False;
			free_resources;
			update_widgets
		ensure then
			n_ame = Void;
			green = green_value
		end; 

	set_name (a_name: STRING) is
			-- Set color name to `a_name'.
		require else
			a_name_not_void: not (a_name = Void)
		do
			n_ame := clone (a_name);
			pixel_set := False;
			free_resources;
			update_widgets
		ensure then
			not (n_ame = Void);
			n_ame.is_equal (a_name)
		end; 

	set_pixel (pixel_value: POINTER) is
			-- Set the Pixel color to `pixel_value'
		do
			the_pixel := pixel_value;
			n_ame := Void;
			free_resources;
			update_widgets;
			pixel_set := True
		ensure then
			n_ame = Void;
			the_pixel = pixel_value
		end;
			
	set_red (red_value: INTEGER) is
			-- Set red saturation level to `red_value'.
		require else
			red_value_small_enough: red_value  <= 65535;
			red_value_not_negative: red_value >= 0
		do
			red := red_value;
			n_ame := Void;
			pixel_set := False;
			free_resources;
			update_widgets
		ensure then
			n_ame = Void;
			red = red_value
		end; 

	set_rgb (red_value, green_value, blue_value: INTEGER) is
			-- Set red, green and blue saturation level respectivly to
			-- `red_value', `green_value' and `blue_value'.
		require else
			red_value_small_enough: red_value  <= 65535;
			red_value_not_negative: red_value >= 0;
			green_value_small_enough: green_value  <= 65535;
			green_value_not_negative: green_value >= 0;
			blue_value_small_enough: blue_value  <= 65535;
			blue_value_not_negative: blue_value >= 0
		do
			red := red_value;
			green := green_value;
			blue := blue_value;
			n_ame := Void;
			pixel_set := False;
			free_resources;
			update_widgets
		ensure then
			n_ame = Void;
			red = red_value;
			green = green_value;
			blue = blue_value
		end; 

	set_white_default is
			-- Set white color to be used by default if
			-- it is impossible to allocate desire color.
		do
			is_white_by_default := true
		ensure then
			is_white_by_default
		end; 

	the_pixel: POINTER;
			-- Pixel color 

feature {NONE}

	update_widgets is
			-- Update widgets.
		local
			widgets_to_update: LINKED_LIST [WIDGET_X];
			primitive: PRIMITIVE_I;
			manager: MANAGER_I;
			i: WIDGET_X;
			c: COLOR
		do
			from
				widgets_to_update ?= objects;
				widgets_to_update.start
			until
				widgets_to_update.off
			loop
				i := widgets_to_update.item;
				c := i.background_color;	
				if (not (widgets_to_update.item.background_color = Void)) 
					and then (widgets_to_update.item.background_color.implementation = Current) 
				then
					widgets_to_update.item.update_background_color;
				end;
				primitive ?= widgets_to_update.item;
				if not (primitive = Void) then
					if (not (primitive.foreground = Void)) and then (primitive.foreground.implementation = Current) then
						primitive.update_foreground;
					end
				else
					manager ?= widgets_to_update.item;
					if (not (manager = Void)) and then ((not (manager.foreground = Void)) 
					and then (manager.foreground.implementation = Current)) 
				then
						manager.update_foreground;
					end
				end;
				widgets_to_update.forth;
			end
		end; 

	white_pixel (a_display_pointer: POINTER): POINTER is
			-- Index of white color in current colormap
		
		do
			Result := c_white_pixel (a_display_pointer)
		end

feature {NONE} -- External features

	c_parse_name_color (scr_obj: POINTER; ext_name: ANY): BOOLEAN is
		external
			"C"
		end; 

	c_white_pixel (scr_obj: POINTER): POINTER is
		external
			"C"
		end; 

	c_free_color (scr_obj: POINTER; ident: POINTER) is
		external
			"C"
		end; 

	c_black_pixel (dsp_ptr: POINTER): POINTER is
		external
			"C"
		end; 

	c_red_allocated_color: INTEGER is
		external
			"C"
		end; 

	c_green_allocated_color: INTEGER is
		external
			"C"
		end; 

	c_blue_allocated_color: INTEGER is
		external
			"C"
		end; 

	c_query_color (dsp: POINTER; pix: POINTER) is
		external
			"C"
		end; 

	xt_display (scr_obj: POINTER): POINTER is
		external
			"C"
		end; 

	c_pixel_allocated_color: POINTER is
		external
			"C"
		end; 

	c_allocate_color (scr_obj: POINTER; r, g, b: INTEGER): BOOLEAN is
		external
			"C"
		end; 

	c_allocate_wanted_color (scr_obj: POINTER): BOOLEAN is
		external
			"C"
		end; 

end 


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
