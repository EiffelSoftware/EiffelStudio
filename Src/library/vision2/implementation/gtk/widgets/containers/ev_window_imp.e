indexing

	description: 
		"EiffelVision window, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_WINDOW_IMP
	
inherit
	EV_WINDOW_I	
	
	EV_CONTAINER_IMP


creation
	
	make
	
feature {NONE} -- Initialization
	
        make is
                        -- Create a window. Window does not have any
                        -- parents
		do
			widget := gtk_window_new (GTK_WINDOW_TOPLEVEL)
		end
	
		
feature  -- Access


        icon_name: STRING is
                        -- Short form of application name to be
                        -- displayed by the window manager when
                        -- application is iconified
		do
			check
                                not_yet_implemented: False
                        end	
                end

feature -- Status report

        is_iconic_state: BOOLEAN is
                        -- Does application start in iconic state?
		do
			check
                                not_yet_implemented: False
                        end
                end

feature -- Status setting

        set_iconic_state is
                        -- Set start state of the application to be iconic.
		do
			check
                                not_yet_implemented: False
                        end	
                end

        set_normal_state is
                        -- Set start state of the application to be normal.
		do
			check
                                not_yet_implemented: False
                        end
                end

feature -- Element change

        set_icon_name (a_name: STRING) is
                        -- Set `icon_name' to `a_name'.
		do
			check
                                not_yet_implemented: False
                        end
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
