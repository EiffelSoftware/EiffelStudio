indexing

	description: "Maintains the drag-and-drop of a stone %
		%and terminates it when it is dropped.";
	date: "$Date$";
	revision: "$Revision $"

class TRANSPORTER 

inherit

	COMMAND
		redefine
			context_data_useful
		end;
	PAINTER;
	EB_CONSTANTS

creation

	make

feature {NONE} -- Initialization

	make (wid: WIDGET) is
			-- Initialize Current with widget `wid'.
		require
			non_void_wid: wid /= Void
		do
			widget := wid;
			set_drawing (wid.screen);
			set_logical_mode (10); 
			set_subwindow_mode (1);
			!! holes.make;
			wid.add_pointer_motion_action (Current, Mouse_pointer_action);
			wid.add_button_press_action (3, Current, Drop_action);
			wid.add_button_release_action (1, Current, Abort_action);
			wid.add_button_release_action (2, Current, Abort_action);
		end;

feature -- Initialization

	widget: WIDGET;
			-- Widget controlling transporting of holes

	holes: LINKED_LIST [HOLE];
			-- List of holes 

feature -- Access

	registered (h: HOLE): BOOLEAN is
			-- Is hole `h' registered?
		do
			Result := holes.has (h)
		ensure
			valid_result: Result implies holes.has (h)
		end;

	valid_holes: BOOLEAN is
			-- Are the holes valid?
			-- (Are the target of holes exist?)
		do
			from
				holes.start;
				Result := True;
			until	
				holes.after or else not Result
			loop
				Result := not holes.item.target.destroyed;
				holes.forth
			end
		end;

	pointed_hole: HOLE is
			-- Hole currently pointed by the mouse pointer
			-- (must be registered in list or inherited from widget)
		require
			valid_holes: valid_holes
		local
			wid_pt: WIDGET;
			hole: HOLE;
		do
			wid_pt := widget.screen.widget_pointed;
			if wid_pt /= Void then
				hole ?= wid_pt;
				if hole = Void then
					from
						holes.start
					until
						holes.after or else Result /= Void
					loop
						if holes.item.target = wid_pt then
							Result := holes.item
						end;
						holes.forth
					end
				elseif hole.registered then
					Result := hole
				end
			end;
		end;

feature -- Element change

	register (h: HOLE) is
		require
			not_registered: not registered (h)
		do
			holes.put_front (h)
		ensure
			registered: registered (h)
		end;

	unregister (h: HOLE) is
		require
			registered: registered (h)
		do
			holes.start;
			holes.prune (h)
		ensure
			not_registered: not registered (h)
		end;

feature -- Properties

	x0, y0, x1, y1: INTEGER;
			-- Coordinates for drawing

feature -- Update

	transport (s: DRAG_SOURCE; ix, iy: INTEGER) is
			-- First phase of the transport:
			--   Record the stone.
			--   Initialize drawing.
			--   Grab the cursor.
		require
			valid_s: s /= Void
		local
			target: HOLE
		do
			drag_source := s;
			stone := s.transported_stone;
			x0 := ix;
			y0 := iy;
			x1 := widget.screen.x;
			y1 := widget.screen.y;
			draw_segment (x0, y0, x1, y1);	
			target := pointed_hole;
			if target /= Void and then target.compatible (stone) then
				is_compatible_target := True;
				widget.grab (stone.stone_cursor)
			else
				is_compatible_target := False;
				widget.grab (stone.x_stone_cursor)
			end;
			dropped := False;
		end;

feature -- Execution

	context_data_useful: BOOLEAN is True;

	execute (argument: ANY) is
			-- Invoke the callbacks if the stone is not void.
		do
			if stone /= Void then	
				work (argument)
			end
		end;

	work (argument: ANY) is
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
			target: HOLE;
			button_data: BUTTON_DATA;
			scr: SCREEN
		do
			if argument = Mouse_pointer_action then
					-- Mouse pointer movement.
				if not dropped then
					draw_segment (x0, y0, x1, y1);	
					scr := widget.screen;
					x1 := scr.x; 
					y1 := scr.y;
					draw_segment (x0, y0, x1, y1);
					target := pointed_hole;
					if target /= Void and then target.compatible (stone) then
						if not is_compatible_target then
							is_compatible_target := True
							widget.ungrab;
							widget.grab (stone.stone_cursor)
						end
					elseif is_compatible_target then
						is_compatible_target := False;
						widget.ungrab;
						widget.grab (stone.x_stone_cursor)
					end
				end;
			elseif argument = Abort_action then
					-- Abort.
				dropped := True;
				button_data ?= context_data;
				check
					button_data /= Void
				end;
				draw_segment (x0, y0, x1, y1);
				widget.ungrab;
				if drag_source /= Void then
					drag_source.update_after_transport (button_data)
				end;
				stone := Void;
				drag_source := Void;
			elseif argument = Drop_action then
					-- After Dropped
				dropped := True;
				draw_segment (x0, y0, x1, y1);
				widget.ungrab;
				target := pointed_hole;
				button_data ?= context_data;
				if drag_source /= Void then
					drag_source.update_after_transport (button_data)
				end;
				if target /= Void then
					check
						button_data /= Void
					end;
					if stone /= Void then
						target.receive (stone)
					end;
				end;
				stone := Void;
				drag_source := Void;
			end;
		end;

feature {NONE} -- Implementation

	stone: STONE;
			-- Transported stone

	dropped: BOOLEAN;
			-- Is the stone dropped?
			--| Used to signify a dropped stone. This boolean
			--| is used to stop drawing the lines in the
			--| pointer motion action which may have accumulated
			--| in the event queue when a stone have been dropped

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

	is_compatible_target: BOOLEAN
			-- Is the target compatible with `stone' being dragged?

end -- class TRANSPORTER
