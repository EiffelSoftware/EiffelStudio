indexing

	description: 
	"DEMO_WINDOW, base class for all demo windows. Belongs to EiffelVision example test_all_widgets."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	DEMO_WINDOW

inherit

	EV_WINDOW
		rename
			make as parent_make
		end
	
	EV_WINDOW
		redefine	
			make
		select 
			make
		end
	
	EV_COMMAND

feature --Access

	main_widget: EV_WIDGET is
		deferred
		end
	
	actions_window: ACTIONS_WINDOW
	
feature -- Initialization
	
	make is
		do
		end
	
feature -- Status setting
        
	set_widgets is
                deferred
                end
	
	set_values is
 		deferred
 		end

-- 	set_commands is
-- 		deferred
-- 		end
	
feature -- Command executing
	
	execute (argument: EV_ARGUMENT1[MAIN_WINDOW]) is
		do
			parent_make
			set_widgets
			set_values
			show
			!!actions_window.make_with_main_widget (main_widget)
			actions_window.show
			argument.first.set_insensitive (True)
			set_delete_command (argument.first)
		end
end
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
