indexing
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	MS_WINDOWS

inherit
	TOOLKIT

	G_ANY_WINDOWS

	WINDOWS_1

	WEL_APPLICATION
		rename
			make as wel_make,
			main_window as wel_main_window
		redefine
			idle_action, run
		end

	MAIN_WINDOW_MANAGER_WINDOWS
		rename
			make as wel_make
		redefine
			idle_action
		select
			main_window
		end

	TASK_MANAGER_WINDOWS

	GLOBAL_CURSOR_MANAGER

creation

	make

feature {NONE} -- Initialization

	make (application_class: STRING) is
			-- Create the toolkit.
                        -- `application_class' is used for the resource specifications.
		do 
			if application_class /= Void then
				app_class := clone (application_class)
			end
			if application = Void then
			end
			create_dispatcher
                        init_instance
			init_application
		end;

feature 

	app_class: STRING;
			-- Application class name of the application

	color (a_color: COLOR): COLOR_WINDOWS is
                        -- MS-Windows implementation of `a_color'
		do
			!! Result.make (a_color)
		end;

	color_for_screen (a_color: COLOR; a_screen: SCREEN): COLOR_WINDOWS is
			-- Toolkit implementation of `a_color' for `a_screen'
		do
			!! Result.make (a_color)
		end;

	exit is
			-- Exit from the application.
		do
			application_main_window.destroy
		end;

	font (a_font: FONT): FONT_WINDOWS is
                        -- MS-Windows implementation of `a_font'
		do
			!! Result.make (a_font)
		end;

	font_for_screen (a_font: FONT; a_screen: SCREEN): FONT_WINDOWS is
			-- Toolkit implementation of `a_font' for `a_screen'
		do
			!! Result.make (a_font)
		end;

	iterate is
			-- Loop the application.
		do
			if application_main_window.exists then
				run
			end
		end;

	name: STRING is "MS_WINDOWS"
			-- MS-Windows implementation name

	pixmap (a_pixmap: PIXMAP): PIXMAP_WINDOWS is
                        -- MS-Windows implementation of `a_pixmap'
		do
			!! Result.make (a_pixmap)
		end;

	message (a_message: MESSAGE; managed: BOOLEAN;
		oui_parent: COMPOSITE): MESSAGE_WINDOWS is
			-- Toolkit implementation of `a_message'
		do
			!! Result.make (a_message, managed, oui_parent)
		end;

	pixmap_for_screen (a_pixmap: PIXMAP; a_screen: SCREEN): PIXMAP_WINDOWS is
			-- Toolkit implementation of `a_pixmap' for `a_screen'
		do
			!! Result.make (a_pixmap)
		end;

	screen (a_screen: SCREEN): SCREEN_WINDOWS is
                        -- MS-Windows implementation of `a_screen'
		do
			!! Result.make (a_screen)
		end;

	screen_cursor (a_cursor: SCREEN_CURSOR): SCREEN_CURSOR_WINDOWS is
                        -- MS-Windows implementation of `a_cursor'
		do
			!! Result.make (a_cursor)
		end;

	screen_cursor_for_screen (a_cursor: SCREEN_CURSOR; a_screen: SCREEN): SCREEN_CURSOR_WINDOWS is
			-- Toolkit implementation of `a_cursor'
		do
			!! Result.make (a_cursor)
		end;

	set_default_resources (a_list : ARRAY[WIDGET_RESOURCE]) is
			-- Resources for an application
			-- not used under Windows
		do
		end

	task (a_task: TASK): TASK_WINDOWS is
                        -- MS-Windows implementation of `a_task'
		do
			!! Result.make (a_task, Current)
			tasks.extend (Result)
		end;

	timer (a_timer: TIMER): TIMER_WINDOWS is
                        -- MS-Windows implementation of `a_timer'
		do
			!! Result.make (a_timer)
		end;

	wel_main_window: WEL_FRAME_WINDOW is
			-- Main window for WEL
		once
			Result := main_window
		end

	widget_resource: WIDGET_RESOURCE_I is
			-- Resource not used under Windows
		do
		end

	idle_action is
			-- Action to perform when the system is idle
		do
			from
				tasks.start
			variant
				tasks.count - tasks.index
			until
				tasks.after
			loop
				tasks.item.execute
				tasks.forth
			end
		end

end -- class MS_WINDOWS

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
