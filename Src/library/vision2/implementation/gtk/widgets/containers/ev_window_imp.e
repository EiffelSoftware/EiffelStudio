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
	
        make (interf: EV_WINDOW) is
                        -- Create a window. Window does not have any
                        -- parents
		local
			i: INTEGER
			a: ANY
			s: string
		do
			widget := gtk_window_new (GTK_WINDOW_TOPLEVEL)
			
			-- connect delete and destroy events to exit signals
			-- Temporary XXX!
			!!s.make (0)
			s := "destroy"
			a ?= s.to_c
			interface := interf
			
			-- Connect the signal
			i := c_gtk_signal_connect (widget, $a, routine_address ($delete_window_action), 
						   $Current, Default_pointer, Default_pointer, Default_pointer, 0)
			s := "delete"
			a ?= s.to_c
--			i := c_gtk_signal_connect (widget, $a, interface.routine_address($delete_window_action), Current, Default_pointer)
			
		end

feature  -- Implementation XX
	
	delete_window_action is
		do
			interface.delete_window_action
		end
	
	interface: EV_WINDOW
	
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

        icon_mask: EV_PIXMAP is
                        -- Bitmap that could be used by window manager
                        -- to clip `icon_pixmap' bitmap to make the
                        -- icon nonrectangular 
		do
			check
                                not_yet_implemented: False
                        end
                end

        icon_pixmap: EV_PIXMAP is
                        -- Bitmap that could be used by the window manager
                        -- as the application's icon
		do
			check
                                not_yet_implemented: False
                        end
		end
	
        title: STRING is
                        -- Application name to be displayed by
                        -- the window manager
		do
			check
                                not_yet_implemented: False
                        end
                end

        widget_group: EV_WIDGET is
                        -- Widget with wich current widget is associated.
                        -- By convention this widget is the "leader" of a group
                        -- widgets. Window manager will treat all widgets in
                        -- a group in some way; for example, it may move or
                        -- iconify them together
		do
			check
                                not_yet_implemented: False
                        end
                end 

feature -- Element change

        set_icon_mask (mask: EV_PIXMAP) is
                        -- Set `icon_mask' to `mask'.
		do
			check
                                not_yet_implemented: False
                        end
                end

        set_icon_pixmap (pixmap: EV_PIXMAP) is
                        -- Set `icon_pixmap' to `pixmap'.
		do
			check
                                not_yet_implemented: False
                        end
                end

        set_title (new_title: STRING) is
                        -- Set `title' to `new_title'.
                local
                        a: ANY
		do
			a ?= new_title.to_c	
			gtk_window_set_title (widget, $a)
                end

        set_widget_group (group_widget: EV_WIDGET) is
                        -- Set `widget_group' to `group_widget'.
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

        set_icon_name (new_name: STRING) is
                        -- Set `icon_name' to `new_name'.
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
