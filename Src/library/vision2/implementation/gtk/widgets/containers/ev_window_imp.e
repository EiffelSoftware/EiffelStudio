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
			set_default_colors,
			has_parent
		redefine
			add_child_ok,
			add_child,
			is_child,
			child_added,
			remove_child,
			x,
			y,
			set_parent,
			show
		end
	
creation
	make,
	make_with_owner

feature {NONE} -- Initialization
	
	make is
		do
			widget := gtk_window_new (GTK_WINDOW_TOPLEVEL)
			initialize
		end

        make_with_owner (par: EV_WINDOW) is
		do
			widget := gtk_window_new (GTK_WINDOW_TOPLEVEL)
			initialize
		end

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
			-- Before to remove the widget from the
			-- container, we increment the number of
			-- reference on the object otherwise gtk
			-- destroyed the object. And after having
			-- added the object to another container,
			-- we remove this supplementary reference.
		do
			if parent_imp /= Void then
				parent_imp := Void
			end
			if par /= Void then
				parent_imp ?= par.implementation
			end
		end

feature  -- Access

	x: INTEGER is
			-- Horizontal position relative to parent
		do
			Result := c_gtk_window_x (widget) 
		end

	y: INTEGER is
			-- Vertical position relative to parent
		do
			Result := c_gtk_window_y (widget) 
		end	

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

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		do
			check
                                not_yet_implemented: False
                        end
                end

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

feature -- Status report

        is_iconic_state: BOOLEAN is
                        -- Does application start in iconic state?
		do
			check
                                not_yet_implemented: False
                        end
                end

feature -- Status setting

	forbid_resize is
			-- Forbid the resize of the window.
		do
		end

	allow_resize is
			-- Allow the resize of the window.
		do
		end

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

	set_modal is
			-- Make the window modal
		do
			c_gtk_window_set_modal(widget, True)
		end

	show is
			-- Make widget visible on the screen. (default)
			-- redefined because a window can have no parent
		require else
			exists: not destroyed
		do
			gtk_widget_show (widget)
		end


feature -- Element change

	set_maximum_width (max_width: INTEGER) is
			-- Set `maximum_width' to `max_width'.
		do
		end 

	set_maximum_height (max_height: INTEGER) is
			-- Set `maximum_height' to `max_height'.
		do
		end

        set_title (new_title: STRING) is
                        -- Set `title' to `new_title'.
                local
                        a: ANY
		do
			a ?= new_title.to_c	
			gtk_window_set_title (widget, $a)
                end

        set_icon_name (new_name: STRING) is
                        -- Set `icon_name' to `new_name'.
		do
			check
                                not_yet_implemented: False
                        end
                end

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

        set_widget_group (group_widget: EV_WIDGET) is
                        -- Set `widget_group' to `group_widget'.
		do
			check
                                not_yet_implemented: False
                        end
		end

feature -- Event - command association

	add_close_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make-- temporary, craeta a correct object here XX
			add_command_with_event_data ("delete_event", cmd, arg, ev_data, 0, False)
			has_close_command := True
		end

	add_resize_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when the
			-- widget is resized.
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make  -- temporary, create a correct object here XX
			add_command_with_event_data ("configure_event", cmd, arg, ev_data, 2, False)
		end

	add_move_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when the
			-- widget is resized.
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make  -- temporary, create a correct object here XX
			add_command_with_event_data ("configure_event", cmd, arg, ev_data, 1, False)
		end

feature -- Event -- removing command association

	remove_close_commands is
			-- Empty the list of commands to be executed
			-- when the window is closed.
		do
			check False end
			has_close_command := False
		end

	remove_resize_commands is
			-- Empty the list of commands to be executed
			-- when the window is resized.
		do
			check False end
		end

	remove_move_commands is
			-- Empty the list of commands to be executed
			-- when the widget is resized.
		do
			check False end
		end

feature -- Assertion test

	add_child_ok: BOOLEAN is
			-- Used in the precondition of
			-- 'add_child'. True, if it is ok to add a
			-- child to the window by testing if its hbox has
			-- not child
		local
			le_result : INTEGER			
		do
			le_result:= c_gtk_container_nb_children (hbox)
			Result := c_gtk_container_nb_children (hbox)= 0
		end

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of the window?
			-- by testing if a_child is a child of its
			-- hbox
		do
			Result := c_gtk_container_has_child (hbox, a_child.widget)
		end

	child_added (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Has `a_child' been added properly?
		do
			Result := c_gtk_container_has_child (hbox, a_child.widget)
		end


feature {EV_APPLICATION_IMP} -- Implementation
	
	connect_to_application (exit_function, application: POINTER) is
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
			i := c_gtk_signal_connect (widget, $a, exit_function, 
						   application, Default_pointer, 
						   Default_pointer, Default_pointer,
						   Default_pointer, 0, False)
			
--			-- What about delete signal?
--			s := "delete"
--			a ?= s.to_c
--			i := c_gtk_signal_connect (widget, $a, interface.routine_address($delete_window_action), Current, Default_pointer)
		end

feature {NONE} -- Implementation

	initialize is
		do
			vbox := gtk_vbox_new (False, 0)
			gtk_widget_show (vbox)
			gtk_container_add (GTK_CONTAINER (widget), vbox)
			hbox := gtk_hbox_new (False, 0)
			gtk_widget_show (hbox)
			gtk_box_pack_end (vbox, hbox, True, True, 0)

		end

	vbox: POINTER
		-- Vertical_box to have a possibility for a menu on the
		-- top.

	hbox: POINTER
		-- Horizontal box for the child

feature {EV_CONTAINER, EV_WIDGET} -- Element change
	
	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add `child_imp' in the window.
		do
			gtk_box_pack_end (hbox, child_imp.widget, True, True, 0)
		end

	remove_child (child_imp: EV_WIDGET_IMP) is
			-- Remove `child_imp' from the window.
		do
			gtk_container_remove (hbox, child_imp.widget)
		end

feature {EV_STATIC_MENU_BAR_IMP} -- Implementation

	add_static_menu (menu: EV_STATIC_MENU_BAR_IMP) is
			-- Add a static menu bar at the top of the window.
		do
			gtk_box_pack_start (vbox, menu.widget, False, True, 0)
		end

feature {EV_APPLICATION_IMP} -- Implementation

	has_close_command: BOOLEAN
			-- Did the user added a close command to the window.

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
