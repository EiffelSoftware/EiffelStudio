indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	MOTIF  

inherit

	TOOLKIT;

	MOTIF_1;

	ALL_CURS_X
		export
			{NONE} all
		end;

	EXCEPTIONS

creation
	make

feature {NONE} -- Inititalization

	make (application_class: STRING) is
			-- Create the toolkit.
			-- `application_class' is used for the resource specifications.
		do
			!! application_context.make;
			if application_class /= Void then
				app_class := clone (application_class)
			end
		end;

feature -- Access

	app_class: STRING;
			-- Application class name of the application

	application_context: MEL_APPLICATION_CONTEXT;
			-- Xt context of current application

	name: STRING is "MOTIF";
			-- Toolkit implmentation name

feature -- Widget Access

	arrow_b (an_arrow_button: ARROW_B; managed: BOOLEAN; 
				oui_parent: COMPOSITE): ARROW_B_M is
			-- Motif implementation of `an_arrow_button'
		do
			!! Result.make (an_arrow_button, managed, oui_parent)
		end; 

	base (a_base: BASE): BASE_M is
			-- Motif implementation of `a_base'
		do
			!! Result.make (a_base, app_class)
		end; 

	color (a_color: COLOR): COLOR_X is
			-- Motif implementation of `a_color'
		do
			!! Result.make (a_color)
		end;

	color_for_screen (a_color: COLOR; a_screen: SCREEN): COLOR_X is
			-- Motif implementation of `a_color'
		do
			!! Result.make_for_screen (a_color, a_screen)
		end;

	screen_cursor (a_cursor: SCREEN_CURSOR): SCREEN_CURSOR_X is
			-- Motif implementation of `a_cursor'
		do
			!! Result.make (a_cursor)
		end;

	screen_cursor_for_screen (a_cursor: SCREEN_CURSOR; a_screen: SCREEN): SCREEN_CURSOR_X is
			-- Motif implementation of `a_cursor'
		do
			!! Result.make_for_screen (a_cursor, a_screen)
		end;

	draw_b (a_draw_b: DRAW_B; managed: BOOLEAN; oui_parent: COMPOSITE): DRAW_B_M is
			-- Motif implementation of `a_draw_b'
		do
			!! Result.make (a_draw_b, managed, oui_parent)
		end; 

	drawing_area (a_drawing_area: DRAWING_AREA; managed: BOOLEAN; 
				oui_parent: COMPOSITE): D_AREA_M is
			-- Motif implementation of `a_drawing_area'
		do
			!! Result.make (a_drawing_area, managed, oui_parent)
		end; 

	exit is
			-- Exit from the application
		do
			application_context.exit
		end;

	font (a_font: FONT): FONT_X is
			
		do
			!! Result.make (a_font)
		end;

	font_for_screen (a_font: FONT; a_screen: SCREEN): FONT_X is
			-- Toolkit implementation of `a_font' for `a_screen'
		do
			!! Result.make_for_screen (a_font, a_screen)
		end;

	font_box (a_font_box: FONT_BOX; managed: BOOLEAN; 
				oui_parent: COMPOSITE): FONT_BOX_M is
			-- Motif implementation of `a_font_box'
		do
			!! Result.make (a_font_box, managed, oui_parent)
		end; 

	font_box_d (a_font_box_d: FONT_BOX_D; oui_parent: COMPOSITE): FONT_B_D_M is
			-- Motif implementation of `a_font_box_d'
		do
			!! Result.make (a_font_box_d, oui_parent)
		end; 

	pict_color_b (a_picture_color_button: PICT_COLOR_B; managed: BOOLEAN;
				oui_parent: COMPOSITE): PICT_COL_B_M is
			-- Motif implementation of `a_picture_color_button'
		do
			!! Result.make (a_picture_color_button, managed, oui_parent)
		end;

	pixmap (a_pixmap: PIXMAP): PIXMAP_X is
			-- Motif implementation of `a_pixmap'
		do
			!! Result.make (a_pixmap)
		end;

	pixmap_for_screen (a_pixmap: PIXMAP; a_screen: SCREEN): PIXMAP_X is
			-- Motif implementation of `a_pixmap' for `a_screen'
		do
			!! Result.make_for_screen (a_pixmap, a_screen)
		end;

	top_shell (a_top_shell: TOP_SHELL): TOP_SHELL_M is
			-- Motif implementation of `a_top_shell'
		do
			!! Result.make (a_top_shell, app_class)
		end

feature -- Screen access

	screen (a_screen: SCREEN): SCREEN_X is
			-- Motif implementation of `a_screen'
		do
			!! Result.make (application_context, a_screen, app_class)
		end;

feature -- Access

	task (a_task: TASK): TASK_X is
			-- Motif implementation of `a_task'
		do
			!! Result.make
		end;

	timer (a_timer: TIMER): TIMER_X is
			-- Motif implementation of `a_timer'
		do
			!! Result
		end;

	widget_resource: WIDGET_RESOURCE_X is
			-- X widget resource object
		do
			!! Result.make;
		end;

feature -- Iteration

	iterate is
			-- Loop the application.
		do
			application_context.main_loop
		end;

feature -- Status setting

	set_default_resources (a_list: ARRAY [WIDGET_RESOURCE]) is
			-- Set the default resource setting's
		local
			mel_list: ARRAY [MEL_WIDGET_RESOURCE];
			wr: MEL_WIDGET_RESOURCE;
			i: INTEGER
		do
			!! mel_list.make (a_list.lower, a_list.upper);
			from
				i := a_list.lower
			until
				i > a_list.upper
			loop
				wr ?= a_list.item (i);
				check
					valid_widget_resource: wr /= Void
				end;
				mel_list.put (wr, i);
				i := i + 1
			end;
			application_context.set_default_resources (mel_list)
		end;

invariant

	non_void_application: application_context /= Void

end -- class MOTIF

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

