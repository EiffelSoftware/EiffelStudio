indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MOTIF  

inherit

	TOOLKIT;

	G_ANY_M
		export
			{NONE} all
		end;

	MOTIF_1;

	ALL_CURS_X
		export
			{NONE} all
		end;

	EXCEPTIONS

creation

	make

feature

	app_class: STRING;
			-- Application class name of the application

	application_context: POINTER;
			-- Xt context of current application

feature 

	arrow_b (an_arrow_button: ARROW_B; managed: BOOLEAN): ARROW_B_M is
			-- Motif implementation of `an_arrow_button'
		do
			!! Result.make (an_arrow_button, managed)
		end; -- arrow_b

	base (a_base: BASE): BASE_M is
			-- Motif implementation of `a_base'
		do
			!! Result.make (a_base, app_class)
		end; -- base

	color (a_color: COLOR): COLOR_X is
			-- Motif implementation of `a_color'
		do
			!! Result.make (a_color)
		end;

	make (application_class: STRING) is
			-- Create the toolkit.
			-- `application_class' is used for the resource specifications.
		do
			application_context := xt_init;
			if not (application_class = Void) then
				app_class := clone (application_class)
			end
		end;

	name: STRING is "MOTIF";
			-- Toolkit implmentation name

	screen_cursor (a_cursor: SCREEN_CURSOR): SCREEN_CURSOR_X is
			-- Motif implementation of `a_cursor'
		do
			!! Result.make (a_cursor)
		end;

	draw_b (a_draw_b: DRAW_B; managed: BOOLEAN): DRAW_B_M is
			-- Motif implementation of `a_draw_b'
		do
			!! Result.make (a_draw_b, managed)
		end; -- draw_b

	drawing_area (a_drawing_area: DRAWING_AREA; managed: BOOLEAN): D_AREA_M is
			-- Motif implementation of `a_drawing_area'
		do
			!! Result.make (a_drawing_area, managed)
		end; -- drawing_area

	exit is
			-- Exit from the application
		do
			xt_destroy_application_context (application_context);
			new_die (0)
		end;

	font (a_font: FONT): FONT_X is
			-- Motif implementation of `a_font'
		do
			!! Result.make (a_font)
		end;

	font_box (a_font_box: FONT_BOX; managed: BOOLEAN): FONT_BOX_M is
			-- Motif implementation of `a_font_box'
		do
			!! Result.make (a_font_box, managed)
		end; -- font_box

	font_box_d (a_font_box_d: FONT_BOX_D): FONT_B_D_M is
			-- Motif implementation of `a_font_box_d'
		do
			!! Result.make (a_font_box_d)
		end; -- font_box_d

	io_handler (an_io_handler: IO_HANDLER): IO_HANDLER_X is
			-- Motif implementation of `an_io_handler'
		do
			!! Result.make (an_io_handler, application_context)
		end;

	iterate is
			-- Loop the application.
		do
			xt_app_main_loop (application_context)
		end;

	pict_color_b (a_picture_color_button: PICT_COLOR_B; managed: BOOLEAN): PICT_COL_B_M is
			-- Motif implementation of `a_picture_color_button'
		do
			!! Result.make (a_picture_color_button, managed)
		end;

	pixmap (a_pixmap: PIXMAP): PIXMAP_X is
			-- Motif implementation of `a_pixmap'
		do
			!! Result.make (a_pixmap)
		end;

	screen (a_screen: SCREEN): SCREEN_X is
			-- Motif implementation of `a_screen'
		do
			!! Result.make (a_screen, app_class)
		end;

	task (a_task: TASK): TASK_X is
			-- Motif implementation of `a_task'
		do
			!! Result.make (a_task, application_context)
		end;

	timer (a_timer: TIMER): TIMER_X is
			-- Motif implementation of `a_timer'
		do
			!! Result.make (a_timer, application_context)
		end;

	top_shell (a_top_shell: TOP_SHELL): TOP_SHELL_M is
			-- Motif implementation of `a_top_shell'
		do
			!! Result.make (a_top_shell, app_class)
		end

	widget_resource: WIDGET_RESOURCE_X is
			-- X widget resource object
		do
			!!Result.make;
		end;

	set_default_resources (a_list: ARRAY[WIDGET_RESOURCE]) is
			-- Set the default resource setting's
		local
			out_list: ARRAY[ANY];
			ext: ANY;
			counter, number: INTEGER;
		do
			if a_list /= Void then
				!!out_list.make (a_list.lower, a_list.upper);
				from counter := a_list.lower
				until counter > a_list.upper
				loop
					out_list.put (a_list.item (counter).resource_string.to_c, 
							counter);
					counter := counter + 1;
				end;
				number := a_list.count;
				ext := out_list.to_c;
			end;
			set_fallback_res (application_context, ext, number);
		end;

feature {NONE} -- External features

	xt_init: POINTER is
		external
			"C"
		end;

	xt_app_main_loop (app_contxt: POINTER) is
		external
			"C"
		end;

	xt_destroy_application_context (app_contxt: POINTER) is
		external
			"C"
		end;

	set_fallback_res (app_contxt: POINTER; resource_list: ANY; count: INTEGER) is
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
