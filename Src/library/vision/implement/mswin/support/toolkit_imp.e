indexing
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	TOOLKIT_IMP

inherit
	TOOLKIT

	G_ANY_IMP

	MAIN_WINDOW_MANAGER_WINDOWS
		rename
			make as wel_make
		undefine
			accelerators
		redefine
			idle_action,
			message_loop
		end

	TASK_MANAGER_WINDOWS

	GLOBAL_CURSOR_MANAGER

	ACCELERATOR_MANAGER_WINDOWS

creation

	make

feature {NONE} -- Initialization

	make (application_class: STRING) is
			-- Create the toolkit.
			-- `application_class' is used for the resource specifications.
		do
			set_application (Current)
			if application_class /= Void then
				app_class := clone (application_class)
			end
			create_dispatcher
			init_instance
			init_application
		end;

feature 

	app_class: STRING;
			-- Application class name of the application

	color (a_color: COLOR): COLOR_IMP is
                        -- MS-Windows implementation of `a_color'
		do
			!! Result.make (a_color)
		end;

	color_for_screen (a_color: COLOR; a_screen: SCREEN): COLOR_IMP is
			-- Toolkit implementation of `a_color' for `a_screen'
		do
			!! Result.make (a_color)
		end;

	exit is
			-- Exit from the application.
		do
			application_main_window.destroy
		end;

	font (a_font: FONT): FONT_IMP is
                        -- MS-Windows implementation of `a_font'
		do
			!! Result.make (a_font)
		end;

	font_for_screen (a_font: FONT; a_screen: SCREEN): FONT_IMP is
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

	pixmap (a_pixmap: PIXMAP): PIXMAP_IMP is
                        -- MS-Windows implementation of `a_pixmap'
		do
			!! Result.make (a_pixmap)
		end;

	pixmap_for_screen (a_pixmap: PIXMAP; a_screen: SCREEN): PIXMAP_IMP is
			-- Toolkit implementation of `a_pixmap' for `a_screen'
		do
			!! Result.make (a_pixmap)
		end;

	screen (a_screen: SCREEN): SCREEN_IMP is
                        -- MS-Windows implementation of `a_screen'
		do
			!! Result.make (a_screen)
		end;

	screen_cursor (a_cursor: SCREEN_CURSOR): SCREEN_CURSOR_IMP is
                        -- MS-Windows implementation of `a_cursor'
		do
			!! Result.make (a_cursor)
		end;

	screen_cursor_for_screen (a_cursor: SCREEN_CURSOR; a_screen: SCREEN): SCREEN_CURSOR_IMP is
			-- Toolkit implementation of `a_cursor'
		do
			!! Result.make (a_cursor)
		end;

	set_default_resources (a_list : ARRAY[WIDGET_RESOURCE]) is
			-- Resources for an application
			-- not used under Windows
		do
		end

-- 	task (a_task: TASK): TASK_IMP is
--                         -- MS-Windows implementation of `a_task'
-- 		do
-- 			!! Result.make (a_task, Current)
-- 			tasks.extend (Result)
-- 		end;

-- 	timer (a_timer: TIMER): TIMER_IMP is
--                         -- MS-Windows implementation of `a_timer'
-- 		do
-- 			!! Result.make (a_timer)
-- 		end;

	widget_resource: WIDGET_RESOURCE_I is
			-- Resource not used under Windows
		do
		end

feature {NONE} -- Implementation

	idle_action is
			-- Action to perform when the system is idle
		do
			from
				tasks.start
			variant
				tasks.count + 1 - tasks.index
			until
				tasks.after
			loop
				tasks.item.execute
				tasks.forth
			end
		end

	message_loop is
			-- Windows message loop
		local
			msg: WEL_MSG
			accel: WEL_ACCELERATORS
			main_w: WEL_WINDOW
			dlg: POINTER
			done: BOOLEAN
		do
			from
				accel := accelerators
				main_w := application_main_window
				!! msg.make
			until
				done
			loop
				msg.peek_all
				if msg.last_boolean_result then
					if msg.quit then
						done := True
					else
						dlg := cwin_get_last_active_popup (main_window.wel_item)
						if dlg /= main_window.wel_item or is_dialog (dlg) then
							msg.process_dialog_message (dlg)
							if not msg.last_boolean_result then
								msg.translate
								msg.dispatch
							end
						else
							if accel.exists then
								msg.translate_accelerator (main_w, accel)
							end
							if
								not msg.last_boolean_result or else
								not accel.exists
							then
								msg.translate
								msg.dispatch
							end
						end
					end
				else
					if idle_action_enabled then
						idle_action
					else
						msg.wait
					end
				end
			end
		end

end -- class TOOLKIT_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

