
class DRAWING_BOX 

inherit

	DRAWING_AREA
		rename
			make as drawing_area_create,
			set_size as set_drawing_area_size,
			width as drawing_area_width,
			height as drawing_area_height,
			real_x as old_real_x,
			real_y as old_real_y,
			set_foreground_color as old_set_foreground_color,
			set_background_color as old_set_background_color,
			set_background_pixmap as old_set_background_pixmap
		export
			{ANY} set_drawing_area_size, drawing_area_width, drawing_area_height
		redefine
			x, y, set_x_y, hide, show, realize, 
			set_managed, shown, unrealize, realized,
			managed, unmanage, manage, make_unmanaged
		end;

	DRAWING_AREA
		rename
			make as drawing_area_create
		redefine
			set_background_pixmap, set_background_color, 
			set_foreground_color, realize, show, hide, shown, set_size, 
			set_x_y, height, width, real_y, real_x, y, x, 
			set_managed, unrealize, realized,
			managed, unmanage, manage, make_unmanaged
		select
			set_background_pixmap, set_background_color, 
			set_foreground_color, set_size, height, width, real_y,
			real_x
		end

creation

	make, make_unmanaged

feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			!!scrolled_window.make (a_name, a_parent);
			drawing_area_create (a_name, scrolled_window);
			!!world.make;
			world.attach_drawing (Current);
			scrolled_window.set_working_area (Current);
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
		do
			!! scrolled_window.make_unmanaged (a_name, a_parent);
			drawing_area_create (a_name, scrolled_window);
			!!world.make;
			world.attach_drawing (Current);
			scrolled_window.set_working_area (Current);
		end;

	scrolled_window: SCROLLED_W;

	world: WORLD;

	set_world (a_world: WORLD) is
		do
			world := a_world;
			world.attach_drawing (Current);
		end;

	add_figure (a_figure: FIGURE) is
		do
			world.add (a_figure);
		end;

	remove_figure (a_figure: FIGURE) is
		do
			world.start;
			world.search (a_figure);
			if not world.after then
				world.remove (a_figure);
			end;
		end;

	current_point: COORD_XY_FIG is
		local
			x0, y0: INTEGER;
		do
			x0 := screen.x - old_real_x;
			y0 := screen.y - old_real_y;
			!!Result;
			Result.set (x0, y0);
		end;

	set_foreground_color (a_color: COLOR) is
		do
			old_set_foreground_color (a_color);
			scrolled_window.set_foreground_color (a_color);
		end;

	set_background_color (a_color: COLOR) is
		do
			old_set_background_color (a_color);
			scrolled_window.set_background_color (a_color);
		end;

	set_background_pixmap (a_pixmap: PIXMAP) is
		do
			old_set_background_pixmap (a_pixmap);
			scrolled_window.set_background_pixmap (a_pixmap);
		end;

	x: INTEGER is
		do
			Result := scrolled_window.x
		end;

	y: INTEGER is
		do
			Result := scrolled_window.y
		end;

	real_x: INTEGER is
		do
			Result := scrolled_window.real_x
		end;

	real_y: INTEGER is
		do
			Result := scrolled_window.real_y
		end;

	width: INTEGER is
		do
			Result := scrolled_window.width
		end;

	height: INTEGER is
		do
			Result := scrolled_window.height
		end;

	set_x_y (new_x, new_y: INTEGER) is
		do
			scrolled_window.set_x_y (new_x, new_y);
		end;

	set_size (new_width, new_height: INTEGER) is
		do
			scrolled_window.set_size (new_width, new_height);
		end;

	set_managed (flag: BOOLEAN) is
		do
			scrolled_window.set_managed (flag)
		end;

	hide is
		do
			scrolled_window.hide
		end;

	show is
		do
			scrolled_window.show
		end;


	shown: BOOLEAN is
		do
			Result := scrolled_window.shown;
		end;

	realize is
		do
			scrolled_window.realize;
		end;


	realized: BOOLEAN is
		do
			Result := scrolled_window.realized;
		end;

	unrealize is
		do
			scrolled_window.unrealize;
		end;

	manage is
		do
			scrolled_window.manage;
		end;

	unmanage is
		do
			scrolled_window.unmanage;
		end;

	managed: BOOLEAN is
		do
			Result := scrolled_window.managed;
		end;

end
