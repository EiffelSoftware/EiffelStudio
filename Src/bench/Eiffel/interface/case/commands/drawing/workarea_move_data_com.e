indexing

	description: 
		"Draw an icon during the moving of graphical figures on workarea.";
	date: "$Date$";
	revision: "$Revision $"

deferred class WORKAREA_MOVE_DATA_COM 

inherit

	ONCES

	ALIGN_GRID

	BASIC_ROUTINES

	WORKAREA_MOVE_COM 

feature -- Execution

	execute_button_motion (notused: NONE; motnot_data: EV_MOTION_EVENT_DATA) is
			-- Called when the mouse is moved.
		local
			scrolled_window	: EV_SCROLLABLE_AREA
			scrolled_window_implementation	: EV_SCROLLABLE_AREA_IMP
		
			begin_min_x: INTEGER
			end_min_x: INTEGER
			begin_max_x: INTEGER
			end_max_x: INTEGER
			begin_min_y: INTEGER
			end_min_y: INTEGER
			begin_max_y: INTEGER
			end_max_y: INTEGER
		do

			if moving then
 				if not scrolled then
 					if not refresh then
 						erase
 					end
 				end
 			else
 				moving := abs (motnot_data.absolute_x-start_abs_x)>=3 or  
 					abs (motnot_data.absolute_y-start_abs_y)>=3
 			end 
 			absolute_x := motnot_data.absolute_x
 			absolute_y := motnot_data.absolute_y
 			relative_x := motnot_data.x
 			relative_y := motnot_data.y
 			if moving then
				-- This has to be reviewed, the automatic scrolling is not properly working with the new Vision.
 				--scrolled_window	:= workarea.scrollable_area			
 				--scrolled_window_implementation ?= scrolled_window.implementation
 				--if scrolled_window_implementation /= Void then
 				--	end_max_x := workarea.analysis_window.x + workarea.analysis_window.width 
 				--	begin_max_x := end_max_x - 100
 				--	end_min_x := workarea.analysis_window.x 
 				--	begin_min_x := end_min_x + 100 
 
 				--	end_max_y := workarea.analysis_window.y + workarea.analysis_window.height
 				--	begin_max_y := end_max_y - 50
 				--	end_min_y := workarea.analysis_window.y 
 				--	begin_min_y := end_min_y + 150 
 
 				--	if absolute_x > begin_max_x then --and absolute_x < end_max_x then
 				--		if scrolled_window_implementation.horizontal_position < scrolled_window_implementation.maximal_horizontal_position then
 				--			scrolled := true
 				--			scrolled_window_implementation.horizontal_update	( 0	, scrolled_window_implementation.horizontal_position + horizontal_incrementation	)
 				--		end
 				--	else
 				--		if absolute_x < begin_min_x then --and absolute_x > end_min_x then
 				--			if scrolled_window_implementation.horizontal_position > scrolled_window_implementation.minimal_horizontal_position then
 				--				scrolled := true
 				--				scrolled_window_implementation.horizontal_update	( 0	, scrolled_window_implementation.horizontal_position - horizontal_incrementation	)
 				--			end
 				--		else
 				--				if absolute_y > begin_max_y then --and absolute_y < end_max_y then
 				--					if scrolled_window_implementation.vertical_position < scrolled_window_implementation.maximal_vertical_position then
 				--						scrolled := true
 				--						scrolled_window_implementation.vertical_update	( 0	, scrolled_window_implementation.vertical_position + vertical_incrementation	)
 				--					end
 				--				else
 				--					if absolute_y < begin_min_y then --and absolute_y > end_min_y then
 				--						if scrolled_window_implementation.vertical_position > scrolled_window_implementation.minimal_vertical_position then
 				--							scrolled := true
 				--							scrolled_window_implementation.vertical_update	( 0	, scrolled_window_implementation.vertical_position - vertical_incrementation	)
 				--						end
 				--					else
 				--						if scrolled then
 				--							refresh := true
 				--						else
 				--							refresh := false
 				--						end
 				--						scrolled := false
 				--					end
 				--				end
 				--			end
 				--	end
 				--end
 				if not scrolled then
 					if not refresh then
 						draw
 					end
 				end
 			end
		end 

feature {NONE} -- Properties

	moving: BOOLEAN;
			-- Are we moving one or several figures ?
			-- True if the mouse has been moved for more than 3 pixels
	
	scrolled: BOOLEAN

	refresh: BOOLEAN

	start_abs_x, start_abs_y: INTEGER;
			-- First absolute position of mouse

	start_rel_x, start_rel_y: INTEGER;
			-- First relative position of mouse

	absolute_x, absolute_y: INTEGER;
			-- Last position of mouse

	relative_x, relative_y: INTEGER;
			-- Relative position of cursor (relative from the workarea)

	pointed_workarea: EC_DRAWING_AREA --WORKAREA
			-- Last hole pointed by mouse

	painter: PATCH_PAINTER is
			-- Once function to share a painter on root
		once
			!! Result
			Result.initialize_root_painter
		end

	horizontal_incrementation	: INTEGER	is 5

	vertical_incrementation	: INTEGER	is 5

feature {NONE} -- Implementation

	draw is
			-- Draw figures during the moving
		require
			moving
		deferred
		end

	erase is
			-- Erase figures during the moving
		require
			moving
		deferred
		end

feature {WORKAREA_SELECT_COM, WORKAREA_MULTISELECT_COM} -- Initialization

	init (button_data: EV_BUTTON_EVENT_DATA) is
			-- Initialize command.
		require
			has_data: button_data /= void
		do
			start_abs_x := button_data.absolute_x
			start_abs_y := button_data.absolute_y
			start_rel_x := button_data.x
			start_rel_y := button_data.y
			workareas.setup_inverted_painter
		end 

end -- class WORKAREA_MOVE_DATA_COM
