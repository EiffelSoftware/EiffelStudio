indexing
	description: "Objects that provide access to a shared EV_GRID"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_ACCESSOR
	
inherit
	REFACTORING_HELPER

	EXECUTION_ENVIRONMENT
		rename
			put as execution_environment_put
		end

feature -- Access

	grid: EV_GRID is
			-- Once access to EV_GRID.
		once
			create Result
		end
		
	main_window: MAIN_WINDOW is
			-- Once access to MAIN_WINDOW
		once
			create Result
		end
		
	profile_cell: CELL [BOOLEAN] is
			--
		once
			create Result
		end
		
	status_bar: EV_LABEL is
			--
		once
			create Result
			Result.align_text_left
		end
		
	set_status_message (a_message: STRING) is
			--
		local
			timer: EV_TIMEOUT
		do
			status_bar.set_text (a_message)
			if timer_cell.item /= Void then
				timer_cell.item.destroy
			end
			create timer.make_with_interval (4000)
			timer.actions.extend (agent status_bar.remove_text)
			timer_cell.replace (timer)
		end
		
	timer_cell: CELL [EV_TIMEOUT] is
		once
			create Result
		end
		

	profile: BOOLEAN is
			--
		do
			Result := profile_cell.item
		end
		
	
	enable_profile is
			--
		do
			profile_cell.put (True)
		end
		
	disable_profile is
			-- 
		do
			profile_cell.put (False)
		end

	image1: EV_PIXMAP is
			--
		local
			f_name: FILE_NAME
		once
			create f_name.make_from_string (current_working_directory)
			f_name.extend ("image1.png")
			create Result
			Result.set_with_named_file (f_name.out)
		end

	image2: EV_PIXMAP is
			--
		local
			f_name: FILE_NAME
		once
			create f_name.make_from_string (current_working_directory)
			f_name.extend ("image2.png")
			create Result
			Result.set_with_named_file (f_name.out)
		end

	image3: EV_PIXMAP is
			--
		local
			f_name: FILE_NAME
		once
			create f_name.make_from_string (current_working_directory)
			f_name.extend ("image3.png")
			create Result
			Result.set_with_named_file (f_name.out)
		end

	image4: EV_PIXMAP is
			--
		local
			f_name: FILE_NAME
		once
			create f_name.make_from_string (current_working_directory)
			f_name.extend ("image4.png")
			create Result
			Result.set_with_named_file (f_name.out)
		end

	image5: EV_PIXMAP is
			--
		local
			f_name: FILE_NAME
		once
			create f_name.make_from_string (current_working_directory)
			f_name.extend ("image5.png")
			create Result
			Result.set_with_named_file (f_name.out)
		end

	marble: EV_PIXMAP is
			--
		local
			f_name: FILE_NAME
		once
			create f_name.make_from_string (current_working_directory)
			f_name.extend ("marble.png")
			create Result
			Result.set_with_named_file (f_name.out)
		end

	add_color_to_combo (a_color: EV_COLOR; a_combo: EV_COMBO_BOX) is
			-- Add `a_color' to `background_color_combo'.
		require
			a_color_not_void: a_color /= Void
			a_combo_not_void: a_combo /= Void
		local
			pixmap: EV_PIXMAP
			list_item: EV_LIST_ITEM
		do
			create pixmap
			pixmap.set_size (16, 16)
			pixmap.set_foreground_color (a_color)
			pixmap.fill_rectangle (0, 0, 16, 16)
			pixmap.set_foreground_color ((create {EV_STOCK_COLORS}).black)
			pixmap.draw_rectangle (0, 0, 16, 16)
			create list_item
			list_item.set_pixmap (pixmap)
			list_item.set_data (a_color)
			a_combo.extend (list_item)
		ensure
			count_increased: a_combo.count = old a_combo.count + 1
		end

	add_default_colors_to_combo (a_combo: EV_COMBO_BOX) is
			-- Add a set of default colors to `a_combo'.
		require
			a_combo_not_void: a_combo /= Void
		local
			list_item: EV_LIST_ITEM
		do
			create list_item.make_with_text ("Void")
			a_combo.extend (list_item)
			add_color_to_combo (light_green, a_combo)
			add_color_to_combo (light_red, a_combo)
			add_color_to_combo (light_blue, a_combo)
			add_color_to_combo ((create {EV_STOCK_COLORS}).red, a_combo)
			add_color_to_combo ((create {EV_STOCK_COLORS}).green, a_combo)
			add_color_to_combo ((create {EV_STOCK_COLORS}).white, a_combo)
			add_color_to_combo ((create {EV_STOCK_COLORS}).yellow, a_combo)
			add_color_to_combo ((create {EV_STOCK_COLORS}).gray, a_combo)
			add_color_to_combo ((create {EV_STOCK_COLORS}).black, a_combo)
			add_color_to_combo ((create {EV_STOCK_COLORS}).blue, a_combo)
		end

	add_default_pixmaps_to_combo (a_combo: EV_COMBO_BOX) is
			-- Add a set of default pixmaps to `a_combo'.
		require
			a_combo_not_void: a_combo /= Void
		local
			list_item: EV_LIST_ITEM
		do
			create list_item.make_with_text ("None")
			a_combo.extend (list_item)
			create list_item
			list_item.set_pixmap (image1)
			list_item.set_data (image1)
			a_combo.extend (list_item)
			create list_item
			list_item.set_pixmap (image2)
			list_item.set_data (image2)
			a_combo.extend (list_item)
			create list_item
			list_item.set_pixmap (image3)
			list_item.set_data (image3)
			a_combo.extend (list_item)
			create list_item
			list_item.set_pixmap (image4)
			list_item.set_data (image4)
			a_combo.extend (list_item)
			create list_item
			list_item.set_pixmap (image5)
			list_item.set_data (image5)
			a_combo.extend (list_item)
		end

	select_pixmap_from_combo (a_combo: EV_COMBO_BOX; a_pixmap: EV_PIXMAP) is
			-- Select the item in `a_combo' which has a pixmap matching `a_pixmap'.
		do
			a_combo.select_actions.block
			if a_pixmap = Void then
				a_combo.first.enable_select
			elseif a_pixmap = image1 then
				a_combo.i_th (2).enable_select
			elseif a_pixmap = image2 then
				a_combo.i_th (3).enable_select
			elseif a_pixmap = image3 then
				a_combo.i_th (4).enable_select
			elseif a_pixmap = image4 then
				a_combo.i_th (5).enable_select
			elseif a_pixmap = image5 then
				a_combo.i_th (6).enable_select
			end
			a_combo.select_actions.resume
		end

	select_color_from_combo (a_combo: EV_COMBO_BOX; a_color: EV_COLOR) is
			-- Select the item in `a_combo' which has data matching `a_color'.
		local
			l_color: EV_COLOR
		do
			a_combo.select_actions.block
			if a_color = Void then
				a_combo.first.enable_select
			else
				from
					a_combo.start
				until
					a_combo.off
				loop
					l_color ?= a_combo.item.data		
					if l_color /= Void and then l_color.is_equal (a_color) then
						a_combo.item.enable_select
						a_combo.go_i_th (a_combo.count)
					end
					a_combo.forth
				end
			end
			a_combo.select_actions.resume
		end

	stock_colors: EV_STOCK_COLORS is
			-- Once access to EiffelVision2 stock colors
		once
			create Result
		end
		

	light_red: EV_COLOR is
			-- Color light red.
		once
			create Result.make_with_8_bit_rgb (255, 230, 230)
		end

	light_blue: EV_COLOR is
			-- Color light blue.
		once
			create Result.make_with_8_bit_rgb (230, 230, 255)
		end

	light_green: EV_COLOR is
			-- Color light green.
		once
			create Result.make_with_8_bit_rgb (230, 255, 230)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
