indexing
	description: "Objects that provide access to a shared EV_GRID"
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

	light_red: EV_COLOR is
			--
		once
			create Result.make_with_8_bit_rgb (255, 230, 230)
		end

	light_blue: EV_COLOR is
			--
		once
			create Result.make_with_8_bit_rgb (230, 230, 255)
		end

	light_green: EV_COLOR is
			--
		once
			create Result.make_with_8_bit_rgb (230, 255, 230)
		end

end
