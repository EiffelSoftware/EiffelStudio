
class TRANSPORTER

inherit

	EB_TOP_SHELL
		rename
			make as base_create
		redefine
			set_geometry
		end;
	COMMAND;
	PAINTER;
	COMMAND_ARGS;
	WINDOWS;
	SHARED_LICENSE;
	SHARED_CONTEXT;

creation

	make

feature {NONE}

	x0, y0, x1, y1: INTEGER;

	stone: STONE;

feature 

	holes: LINKED_LIST [HOLE];
	
	register (h: HOLE) is
		require
			not_in_holes: not holes.has (h)
		do
			holes.put_front (h)
		ensure
			in_holes: holes.has (h)
		end;
	
	unregister (h: HOLE) is
		require
			in_holes: holes.has (h)
		do
			holes.start;
			holes.prune (h)
		ensure
			not_in_holes: not holes.has (h)
		end;
	
	transport (t: STONE; lx, ly:INTEGER) is
		do
			stone := t;
			x0 := lx;
			y0 := ly;
			x1 := x0;
			y1 := y0;
			draw_point (x0, y0);
			grab (t.stone_cursor);
			dropped := False;
		end;

feature {NONE}

	dropped: BOOLEAN;

	pointed_hole: HOLE is
			-- Hole at mouse position
		local
			wl: LINKED_LIST [WINDOW_C];
			display_pointer: POINTER;
			root_window_object: POINTER;
			temp, void_pointer: POINTER;
			c_pointer: POINTER;
			window_c: WINDOW_C;
			widget_pointed: WIDGET;
		do
			wl := Shared_window_list;
			widget_pointed := screen.widget_pointed;
			if widget_pointed /= Void then
				from
					wl.start
				until
					wl.after or else
					Result /= Void
				loop
					window_c := wl.item;
					Result := find_context (window_c, widget_pointed);
					wl.forth
				end;
				if Result = Void then
					from
						holes.start
					until
						holes.after or else
						Result /= Void
					loop
						if (widget_pointed = holes.item.target) then
							Result := holes.item
						end;
						holes.forth
					end
				end
			end;
		end;

	find_context (a_parent: CONTEXT; widget_pointed: WIDGET): CONTEXT is
		local
			a_group: GROUP_C;
			a_list: LINKED_LIST [CONTEXT]
		do
			if
				widget_pointed = a_parent.widget
			then
				Result := a_parent
			elseif
				a_parent.is_a_group
			then
				from
					a_group ?= a_parent;
					a_list := a_group.subtree;
					a_list.start
				until
					a_list.after or Result /= Void
				loop
					Result := find_context (a_list.item, widget_pointed);
					a_list.forth
				end;
			else
				from
					a_parent.child_start
				until
					a_parent.child_offright or
					not (Result = Void)
				loop
					Result := find_context (a_parent.child, widget_pointed);
					a_parent.child_forth
				end;
			end;
		end;

	execute (argument: ANY) is
		local
			target: HOLE;
		do
			if argument = First then
				if not dropped then
					draw_segment (x0, y0, x1, y1);	
					x1 := screen.x; y1 := screen.y;
					draw_segment (x0, y0, x1, y1);
				end;
			elseif argument = Second then
				dropped := True;
				ungrab;
				target := pointed_hole;
				draw_segment (x0, y0, x1, y1);
				if (target /= Void) and stone /= Void then
					target.receive (stone);
				end;
				stone := Void;
			elseif argument = Third then
				dropped := True;
				ungrab;
				draw_segment (x0, y0, x1, y1);
				stone := Void;
			elseif argument = Fifth then
				main_panel.popdown
			elseif argument = Sixth then
				main_panel.popup
			end;
		end;

feature -- Windows

	set_geometry is
		local
			tmp_x: INTEGER
		do
			set_size (Resources.main_panel_width,
					Resources.main_panel_height)
			tmp_x := Resources.main_panel_x;	
			if tmp_x = -1 then
				tmp_x := screen.width - width;
			end;
			set_x_y (tmp_x, Resources.main_panel_y);
		end;
	
feature 

	make (a_name: STRING; a_screen: SCREEN) is
			-- Create a transporter class which
			-- will control the drag and drop
			-- mechanism,
		do
			base_create (a_name, a_screen);
			set_drawing (screen);
			set_logical_mode (10); 
			set_subwindow_mode (1);
			add_pointer_motion_action (Current, First);
			add_button_press_action (3, Current, Second);
			set_action ("<Btn1Up>", Current, Third);
			set_action ("<Btn2Up>", Current, Third);
			set_action ("<Unmap>,<Prop>", Current, Fifth);
			set_action ("<Map>,<Prop>", Current, Sixth);
			!!holes.make
		end;

end
