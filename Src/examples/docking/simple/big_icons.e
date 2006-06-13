indexing
	description: "16 * 16 icons used by Smart Docking library."
	date: "$Date$"
	revision: "$Revision$"

class
	BIG_ICONS

inherit
	SHARED_PIXMAP_FACTORY

feature -- Access

	drag_pointer_up: EV_PIXMAP is
			--
		once
			Result := pixmap_file_content (drag_pointer_up_s)
		ensure
			not_void: Result /= Void
		end

	drag_pointer_down: EV_PIXMAP is
			--
		once
			Result := pixmap_file_content (drag_pointer_down_s)
		ensure
			not_void: Result /= Void
		end

	drag_pointer_left: EV_PIXMAP is
			--
		once
			Result := pixmap_file_content (drag_pointer_left_s)
		ensure
			not_void: Result /= Void
		end

	drag_pointer_right: EV_PIXMAP is
			--
		once
			Result := pixmap_file_content (drag_pointer_right_s)
		ensure
			not_void: Result /= Void
		end

	drag_pointer_center: EV_PIXMAP is
			--
		once
			Result := pixmap_file_content (drag_pointer_center_s)
		ensure
			not_void: Result /= Void
		end

	drag_pointer_float: EV_PIXMAP is
			--
		once
			Result := pixmap_file_content (drag_pointer_float_s)
		ensure
			not_void: Result /= Void
		end

	deafault_window_pixmap: EV_PIXMAP is
			--
		once
			Result := pixmap_file_content (default_icon_s)
		end

	close_context_tool_bar: EV_PIXMAP  is
			-- Redefine
		do
			Result := pixmap_file_content (close_context_tool_bar_s)
		end

	close_others: EV_PIXMAP is
			-- Redefine
		do
			Result := pixmap_file_content (close_others_s)
		end

	close_all: EV_PIXMAP is
			-- Redefine
		do
			Result := pixmap_file_content (close_all_s)
		end

feature {NONE}  -- Redefine

	pixmap_width: INTEGER is 16
			-- The width of the icons

	pixmap_height: INTEGER is 16
			-- The height of the icons

	pixmap_path: DIRECTORY_NAME is
			-- Path containing all of the Memory Analyzer icons
		once
			create Result.make_from_string ((create {EXECUTION_ENVIRONMENT}).current_working_directory)
			Result.extend ("images")
		ensure then
			path_valid: Result.is_valid
		end

	image_matrix: EV_PIXMAP is
			-- The pixmap contain all the icons
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("smart_docking_icon_matrix.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	pixmap_lookup: HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING] is
			--
		once
			create Result.make (1)
			Result.put ([1, 1], drag_pointer_left_s)
			Result.put ([1, 2], drag_pointer_up_s)
			Result.put ([1, 3], drag_pointer_down_s)
			Result.put ([1, 4], drag_pointer_right_s)
			Result.put ([1, 5], drag_pointer_center_s)
			Result.put ([2, 2], default_icon_s)
			Result.put ([2, 3], drag_pointer_float_s)
			Result.put ([2, 4], close_context_tool_bar_s)
			Result.put ([2, 5], close_others_s)
			Result.put ([3, 1], close_all_s)
			Result.compare_objects
		end

feature {NONE} -- Icons' Names

	drag_pointer_up_s: STRING is "drag_pointer_up"
			-- Icon name.
	drag_pointer_down_s: STRING is "drag_pointer_down"
			-- Icon name.
	drag_pointer_left_s: STRING is "drag_pointer_left"
			-- Icon name.
	drag_pointer_right_s: STRING is "drag_pointer_right"
			-- Icon name.
	drag_pointer_center_s: STRING is "drag_pointer_center"
			-- Icon name.
	drag_pointer_float_s: STRING is "drag_pointer_float"
			-- Icon name.
	default_icon_s: STRING is "default_window_icon"
			-- Icon name.
	close_context_tool_bar_s: STRING is "close_context_menu"
			-- Icon name.
	close_others_s: STRING is "close_others"
			-- Icon name.
	close_all_s: STRING is "close_all"
			-- Icon name.			
end
