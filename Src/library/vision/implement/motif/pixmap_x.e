
indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PIXMAP_X 

inherit

	PIXMAP_I;  

	RESOURCES_X [ANY]
		rename
			make as resources_x_make
		end;

	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end

creation

	make

feature 

	arx_pixmap: POINTER;
			-- Pointer to the C ArXpixmap structure

feature {NONE}

	bitmaps: BITMAPS_RES_X;
			-- List of bitmaps

feature 

	copy_from (a_widget: WIDGET_I; x, y, p_width, p_height: INTEGER) is
			-- Copy the area specified by `x', `y', `p_width', `p_height' of
			-- `a_widget' into the pixmap.
		require else
			a_widget_realized: a_widget.realized;
			left_edge_in_a_widget: x >= 0;
			top_edge_in_a_widget: y >= 0;
			width_positive: p_width > 0;
			height_positive: p_height > 0;
			right_edge_in_a_widget: x+p_width <= a_widget.width;
			bottom_edge_in_a_widget: y+p_height <= a_widget.height
		
		local
			new_arx_pixmap: POINTER;
			a_resource: RESOURCE_X;
			void_pointer: POINTER
		do
			new_arx_pixmap := c_copy_from (a_widget.screen_object, x, y, p_width, p_height);
			if new_arx_pixmap /= void_pointer then
				free_resources;
				arx_pixmap := new_arx_pixmap;
				last_operation_correct := true;
				update_widgets
			else
				last_operation_correct := false
			end
		ensure then
			last_operation_correct implies is_valid
		end; 

	make (a_pixmap: pixmap) is
			-- Create a pixmap.
		require
			a_pixmap_exists: not (a_pixmap = Void)
		do
			resources_x_make;
			!!bitmaps.make
		ensure
			not (bitmaps = Void)
		end; 

	depth: INTEGER is
			-- Depth of pixmap (Number of colors)
		
		do
			Result := c_pixmap_depth (arx_pixmap)
		ensure then
			Result >= 1
		end; 

	
feature {NONE}

	dispose is
			-- Called when the pixmap is garbaged
		do
			--if objects /= Void and then  not objects.empty then
			--	free_resources
			--end;
		end; 

	free_resources is
			-- Free all pixmap resources.
		local
			void_pointer: POINTER
		do
			from
				start
			until
				off
			loop
				c_free_xpixmap (item.identifier);
				forth
			end;
			wipe_out;
			from
				bitmaps.start
			until
				bitmaps.off
			loop
				x_free_pixmap (bitmaps.item.screen.screen_object, bitmaps.item.identifier);
				bitmaps.forth
			end;
			bitmaps.wipe_out;
			if arx_pixmap /= void_pointer then
				c_free_pixmap (arx_pixmap)
			end
		end;
	
feature 

	height: INTEGER is
			-- Height of pixmap
		
		do
			Result := c_pixmap_height (arx_pixmap)
		ensure then
			Result >= 1
		end;

	hot_x: INTEGER is
			-- Horizontal position of "hot" point
		
		do
			Result := c_pixmap_hot_x (arx_pixmap)
		ensure then
			Result >= 0
		end;

	hot_y: INTEGER is
			-- Vertical position of "hot" point
		
		do
			Result := c_pixmap_hot_y (arx_pixmap)
		ensure then
			Result >= 0
		end;

	
feature {NONE}

	is_used_by (a_widget: WIDGET): BOOLEAN is
			-- Is `a_widget' using this resource ?
		require else
			a_widget_exists: not (a_widget = Void)
		do
			Result := (not (a_widget.background_pixmap = Void)) and then (a_widget.background_pixmap.implementation = Current)
		ensure then
			(number_of_uses = 0) implies (not Result)
		end;

	
feature 

	is_valid: BOOLEAN is
			-- Is the pixmap valid and usable ?
		local
			void_pointer: POINTER
		do
			Result := arx_pixmap /= void_pointer
		end;

	last_operation_correct: BOOLEAN;
			-- Is the last operation correctly performed ?

	read_from_file (a_file_name: STRING) is
			-- Load the bitmap described in `a_file_name'.
			-- `a_file_name' must be a X11 bitmap file.
		require else
			a_file_name_exists: not (a_file_name = Void)
		
		local
			new_arx_pixmap: POINTER;
			ext_name: ANY;
			void_pointer: POINTER
		do
			ext_name := a_file_name.to_c;		
			new_arx_pixmap := pix_read_from_file ($ext_name);
			if new_arx_pixmap /= void_pointer then
				free_resources;
				arx_pixmap := new_arx_pixmap;
				last_operation_correct := true;
				update_widgets
			else
				last_operation_correct := false
			end
		ensure then
			last_operation_correct implies is_valid;
			last_operation_correct implies depth <= 2
		end;

	resource_bitmap (a_screen: SCREEN_I): POINTER is
			-- Number of resource with the window `screen_object'
			-- To be used as a bitmap
		require
			is_valid
		
		local
			a_resource: RESOURCE_X
		do
			a_resource := bitmaps.find_same_screen (a_screen);
			if (a_resource = Void) then
				Result := c_resource_bitmap (arx_pixmap, a_screen.screen_object);
				bitmaps.finish;
				!! a_resource.make (a_screen, Result, true);
				bitmaps.add_right (a_resource)
			else
				Result := a_resource.identifier
			end
		end;

	resource_pixmap (a_screen: SCREEN_I): POINTER is
			-- Number of resource with the window `screen_object'
			-- To be used as a pixmap
		require
			is_valid
		
		local
			pixmap_pointer: POINTER;
			a_resource: RESOURCE_X
		do
			a_resource := find_same_screen (a_screen);
			if (a_resource = Void) then
				Result := c_resource_pixmap (arx_pixmap, a_screen.screen_object);
				!! a_resource.make (a_screen, Result, true);
				finish;
				add_right (a_resource);
				Result := c_real_pixmap (Result)
			else
				Result := c_real_pixmap (a_resource.identifier)
			end
		end;

	retrieve (a_file_name: STRING) is
			-- Retreive the pixmap from a file named `a_file_name'.
			-- Set `last_operation_correct'.
		require else
			a_file_name_exists: not (a_file_name = Void)
		
		local
			new_arx_pixmap: POINTER;
			ext_name: ANY;
			void_pointer: POINTER
		do
			ext_name := a_file_name.to_c;		
			new_arx_pixmap := c_retrieve ($ext_name);
			if new_arx_pixmap /= void_pointer then
				free_resources;
				arx_pixmap := new_arx_pixmap;
				wipe_out;
				bitmaps.wipe_out;
				last_operation_correct := true;
				update_widgets
			else
				last_operation_correct := false
			end
		ensure then
			last_operation_correct implies is_valid
		end;

	store (a_file_name: STRING) is
			-- Store the pixmap into a file named `a_file_name'.
			-- Create the file if it doesn't exist and override else.
			-- Set `last_operation_correct'.
		require else
			a_file_name_exists: not (a_file_name = Void);
			is_valid: is_valid
		
		local
			ext_name: ANY;
		do
			ext_name := a_file_name.to_c;		
			last_operation_correct := c_store (arx_pixmap, $ext_name)
		end;

feature {NONE}

	update_widgets is
			-- Update widgets.
		local
			widgets_to_update: LIST [WIDGET_X]
		do
			from
				widgets_to_update ?= objects;
				widgets_to_update.start
			until
				widgets_to_update.off
			loop
				widgets_to_update.item.update_background_pixmap;
				widgets_to_update.forth
			end
		end;

feature 

	width: INTEGER is
			-- Width of pixmap
		
		do
			Result := c_pixmap_width (arx_pixmap)
		ensure then
			Result >= 1
		end

feature {NONE} -- External features

	c_copy_from (scr_obj: POINTER; x, y, a_width, a_height: INTEGER): POINTER is
		external
			"C"
		end; 

	c_pixmap_width (pix: POINTER): INTEGER is
		external
			"C"
		end; 

	c_store (pix: POINTER; file_name: ANY): BOOLEAN is
		external
			"C"
		end;

	c_retrieve (file_name: ANY): POINTER is
		external
			"C"
		end;

	c_real_pixmap (ident: POINTER): POINTER is
		external
			"C"
		end;

	c_resource_pixmap (pix, scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	c_resource_bitmap (pix, scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	pix_read_from_file (file_name: ANY): POINTER is
		external
			"C"
		end;

	c_pixmap_hot_y (pix: POINTER): INTEGER is
		external
			"C"
		end;

	c_pixmap_hot_x (pix: POINTER): INTEGER is
		external
			"C"
		end;

	c_pixmap_height (pix: POINTER): INTEGER is
		external
			"C"
		end; 

	c_free_xpixmap (ident: POINTER) is
		external
			"C"
		end;

	c_free_pixmap (pix: POINTER) is
		external
			"C"
		end;

	x_free_pixmap (scr_obj, ident: POINTER) is
		external
			"C"
		end;

	c_pixmap_depth (pix: POINTER): INTEGER is
		external
			"C"
		end;

invariant

	is_valid implies (width > 0);
	is_valid implies (height > 0);
	is_valid implies (depth > 0);
	is_valid implies ((hot_x >= 0) and (hot_x < width));
	is_valid implies ((hot_y >= 0) and (hot_x < height))

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
