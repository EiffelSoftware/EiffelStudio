indexing

	description: 
		"Maintains the drag-and-drop of a stone %
		% and terminates it when it is dropped.";
	date: "$Date$";
	revision: "$Revision $"

class TRANSPORTER 

inherit

	EC_COMMAND
		redefine
		--	context_data_useful,
			stone
		end;
	PATCH_PAINTER
		
	CONSTANTS

creation

	make

feature {NONE} -- Initialization

	make (wid: EV_WIDGET) is
			-- Initialize Current with name `a_name' and 
			-- screen `a_s'.
		do
-- 			widget := wid
-- 		--	set_drawing (wid.screen);
-- 			set_logical_mode (10); 
-- 			set_subwindow_mode (1);
-- 			wid.add_pointer_motion_action (Current, Mouse_pointer_action);
-- 			wid.add_button_press_action (3, Current, Drop_action);
-- 			wid.add_button_release_action (1, Current, Abort_action);
-- 			wid.add_button_release_action (2, Current, Abort_action);
-- 		
-- 			dropped	:= true
		end;

feature -- Initialization

	initialize_window_attributes (closeable: CLOSEABLE) is
			-- Initialize the geometry and color of current window.
			--| Set the command to call if current window is destroyed.
		local
			del_com: CLOSE_WINDOW_COM
		do
			set_default_color
			!! del_com
			del_com.set_default_execute_arg (closeable)
			-- pascalf heute set_delete_command (del_com)
		end

feature -- Properties

	x0, y0, x1, y1: INTEGER;
			-- Coordinates for drawing

	old_x0: INTEGER
	old_y0: INTEGER

	interior: BOOLEAN

	horizontal_incrementation: INTEGER is 5
	vertical_incrementation: INTEGER is 5
feature -- Initialization                                                                                       
                                                                                                                
    widget: EV_WIDGET;                                                                                             
            -- Widget controlling transporting of holes                                                         
                                                                                                                
feature -- Setting

	set_initial_x_y (ix, iy: INTEGER) is
			-- Set `x0' and `y0'.
		local
			min_x: INTEGER
			max_x: INTEGER
			min_y: INTEGER
			max_y: INTEGER
			cluster_window: MAIN_WINDOW
		do
			x0 := ix;
			y0 := iy
			old_x0 := ix
			old_y0 := iy

			cluster_window ?= widget

			if cluster_window /= Void then
				min_x := cluster_window.x
				min_y := cluster_window.y
				max_x := cluster_window.x + cluster_window.width
				max_y := cluster_window.y + cluster_window.height

				interior := ix < max_x and ix > min_x and iy < max_y and iy > min_y 
			end
		end;

	set_default_color is
			-- Set the default color to window.
		local
			--win_att: WIDGET_ATTRIBUTES
		do
			-- pascalfheute !! win_att.set_composite (Current);
		end;

feature -- Update

	transport (s: DRAG_SOURCE) is
			-- First phase of the transport:
			--   Record the stone.
			--   Initialize drawing.
			--   Grab the cursor.
		do
-- 			drag_source := s;
-- 			stone := drag_source.stone;
-- 			-- pascalf, the two following lines are ridiculous ...
-- 			--x1 := x0;
-- 			--y1 := y0;
-- 			x1 := widget.screen.x;
-- 			y1 := widget.screen.y;
-- 
-- 			draw_segment (x0, y0, x1, y1);	
-- 			widget.grab (stone.stone_cursor);
-- 
-- 			dropped	:= false
		end;

feature -- Execution

	context_data_useful: BOOLEAN is
		do
			Result := True
		end

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Callbacks associated with Current.
			-- 1) Mouse pointer movement:
			--	  Refresh segment.
			-- 2) Drop:
			--	  Ungrab.
			--	  Erase segment.
			--	  Determine hole.
			--	  Send stone to hole.
			-- 3) Abort:
			--	  Ungrab.
			--	  Erase segment.
		local
--			target: HOLE;
--			pointed_widget: WIDGET;
--			button_data: BUTTON_DATA
--			cl : CLASS_STONE
--
--			begin_min_x: INTEGER
--			end_min_x: INTEGER
--			begin_max_x: INTEGER
--			end_max_x: INTEGER
--			begin_min_y: INTEGER
--			end_min_y: INTEGER
--			begin_max_y: INTEGER
--			end_max_y: INTEGER
--
--			old_x: INTEGER
--			old_y: INTEGER
--			new_x: INTEGER
--			new_y: INTEGER
--
--			cluster_window: MAIN_WINDOW
--			scrolled_window	: EC_SCROLLED_W
--			scrolled_window_implementation	: EC_SCROLLED_W_IMP

		do
--			if argument = Mouse_pointer_action then
--					-- Mouse pointer movement.
--				if	not dropped
--				then
--
--					if not scrolled then
--						if not refresh then
--							draw_segment (old_x0, old_y0, x1, y1);	
--						end
--					end
--
--					x1 := widget.screen.x; 
--					y1 := widget.screen.y;
--					-- pascalf, temporary
--					-- avoid that the cursor is detached
--					cl ?= stone
--					if cl /= Void then
--						x1 := ( x1+5)
--						y1 := ( y1+5)
--					end
--
--					cluster_window ?= widget
--
--					if cluster_window /= Void then
--
--						end_max_x := cluster_window.x + cluster_window.width 
--						begin_max_x := end_max_x - 50
--						end_min_x := cluster_window.x
--						begin_min_x := end_min_x + 50 
--
--						end_max_y := cluster_window.y + cluster_window.height 
--						begin_max_y := end_max_y - 50
--						end_min_y := cluster_window.y + 75
--						begin_min_y := end_min_y + 100 
--
--					--	if interior then
--					--		scrolled_window	:= cluster_window.scrolled_window			
--					--		scrolled_window_implementation ?= scrolled_window.implementation
--		
--					--		if x1 > begin_max_x and x1 < end_max_x then
					--			if scrolled_window_implementation.wel_horizontal_position < scrolled_window_implementation.maximum_x then
					--				scrolled := true
					--				scrolled_window_implementation.horizontal_update	( 0	, scrolled_window_implementation.wel_horizontal_position + horizontal_incrementation	)
					--				x0 := x0 - horizontal_incrementation
					--			end
					--		else
					--			if x1 < begin_min_x and x1 > end_min_x then
					--				if scrolled_window_implementation.wel_horizontal_position > scrolled_window_implementation.minimum_x then
					--					scrolled := true
					--					scrolled_window_implementation.horizontal_update	( 0	, scrolled_window_implementation.wel_horizontal_position - horizontal_incrementation	)
					--					x0 := x0 + horizontal_incrementation
					--				end
					--			else
					--				if y1 > begin_max_y and y1 < end_max_y then
					--					if scrolled_window_implementation.wel_vertical_position < scrolled_window_implementation.maximum_y then
					--						scrolled := true
					--						scrolled_window_implementation.vertical_update	( 0	, scrolled_window_implementation.wel_vertical_position + vertical_incrementation	)
					---						y0 := y0 - vertical_incrementation
					--					end
					--				else
					--					if y1 < begin_min_y and y1 > end_min_y then
					--						if scrolled_window_implementation.wel_vertical_position > scrolled_window_implementation.minimum_y then
					--								scrolled := true												
					--								scrolled_window_implementation.vertical_update	( 0	, scrolled_window_implementation.wel_vertical_position - vertical_incrementation	)
					--								y0 := y0 + vertical_incrementation
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
					--		end
					--	end
--					end
--
--					if not scrolled then
--						if not refresh then
--							draw_segment (x0, y0, x1, y1);
--							old_x0 := x0
--							old_y0 := y0
--						end
--					end
				end
				
--			elseif argument = Abort_action then
--					-- Abort.
--				dropped	:= true
--				--pointed_widget.ungrab;
--				widget.ungrab
--				draw_segment (old_x0, old_y0, x1, y1);
--				button_data ?= context_data;
--				check
--					button_data /= Void
--				end;
--				if drag_source /= Void then
--					drag_source.update_after_transport (button_data);
--					drag_source := Void;
--				end
--				stone := Void;
--
--			elseif argument = Drop_action then
--
--				dropped	:= true
--
--				draw_segment (old_x0, old_y0, x1, y1);
--						-- After Dropped
--					button_data ?= context_data; 
--					check
--						button_data /= Void
--					end;	  
--					widget.ungrab;
--				--	target := Windows.screen.pointed_hole;
--					if target /= Void then
--						target.set_button_data (button_data);
--						if stone /= Void then
--							target.receive (stone);
--						end
--						target.set_button_data (Void);
--					end;
--					drag_source.update_after_transport (button_data);
--					stone := Void;
--					drag_source := Void;
--			end;

--		end;

feature
	--Communication

	dropped: BOOLEAN
			-- To Know if the Stone have to be dropped

	scrolled: BOOLEAN

	refresh: BOOLEAN

feature {NONE} -- Implementation

	stone: STONE;
			-- Transported stone

	drag_source: DRAG_SOURCE;

	Mouse_pointer_action: ANY is
		once
			!! Result
		end;

	Drop_action: ANY is
		once
			!! Result
		end;

	Abort_action: ANY is
		once
			!! Result
		end;

	Set_data_action: ANY is
		once
			!! Result
		end;

end -- class TRANSPORTER













