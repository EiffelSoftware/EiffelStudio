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
		undefine
			initialize_colors
		redefine
			add_child
		end
	
creation
	
	make, make_top_level
	
feature {NONE} -- Initialization
	
        make (par: EV_WINDOW) is
		do
			widget := gtk_window_new (GTK_WINDOW_TOPLEVEL)
			initialize
		end
	
	make_top_level is
		do
			widget := gtk_window_new (GTK_WINDOW_TOPLEVEL)
			initialize
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

feature -- Measurement

	maximum_width: INTEGER is
			-- Maximum width that application wishes widget
			-- instance to have
		do
		end	
	
	maximum_height: INTEGER is
			-- Maximum height that application wishes widget
			-- instance to have
		do
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

	set_maximize_state is
			-- Set start state of the application to be
			-- maximized.
		do
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


        set_icon_name (new_name: STRING) is
                        -- Set `icon_name' to `new_name'.
		do
			check
                                not_yet_implemented: False
                        end
                end

feature -- Resizing

	set_maximum_width (max_width: INTEGER) is
			-- Set `maximum_width' to `max_width'.
		do
		end 

	set_maximum_height (max_height: INTEGER) is
			-- Set `maximum_height' to `max_height'.
		do
		end


feature {NONE} -- Implementation
	
	initialize is
		local
			i: INTEGER
			a: ANY
			s: string
		do
			-- connect delete and destroy events to exit signals
			-- Temporary XXX!
			!!s.make (0)
			s := "destroy"
			a ?= s.to_c
						
			-- Connect the signal
			i := c_gtk_signal_connect (widget, $a, $window_closed, 
						   $Current, Default_pointer, 
						   Default_pointer, 
						   Default_pointer, 0, False)
			
			-- What about delete signal?
			s := "delete"
			a ?= s.to_c
			--			i := c_gtk_signal_connect (widget, $a, interface.routine_address($delete_window_action), Current, Default_pointer)

			vbox := gtk_vbox_new (False, 0)
			gtk_container_add (GTK_CONTAINER (widget), vbox)
		end

	vbox: POINTER
		-- Vertical_box to have a possibility for a menu on the
		-- top.

feature {EV_CONTAINER, EV_WIDGET} -- Element change
	
	add_child (child_i: EV_WIDGET_I) is
			-- Add child into composite
		do
			child ?= child_i
			gtk_box_pack_end (vbox, child.widget, True, True, 0)
		end

feature {EV_STATIC_MENU_BAR_IMP} -- Implementation

	add_static_menu (menu: EV_STATIC_MENU_BAR_IMP) is
			-- Add a static menu bar at the top of the window.
		do
			gtk_box_pack_start (vbox, menu.widget, False, True, 0)
		end

end -- class EV_WINDOW_IMP

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
