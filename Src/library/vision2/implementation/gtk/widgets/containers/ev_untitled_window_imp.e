indexing
	description: "EiffelVision untitled window. Window without the overlapped title."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UNTITLED_WINDOW_IMP

inherit
	EV_UNTITLED_WINDOW_I

	EV_CONTAINER_IMP
		undefine
			set_default_colors,
			x,
			y,
			add_child_ok,
			add_child,
			child_packing_changed,
			is_child,
			child_added,
			remove_child,
			set_parent,
			show
		end

creation
	make,
	make_root,
	make_with_owner

feature -- Initialization

	make is
			-- create the untitled window.
		do
			widget := gtk_window_new (GTK_WINDOW_POPUP)

			-- set the events to be handled by the window
			c_gtk_widget_set_all_events (widget)

			-- Make it appear where the mouse is.
			gtk_window_set_position (GTK_WINDOW (widget), 1)

			initialize
		end

	make_with_owner (par: EV_UNTITLED_WINDOW) is
			-- Create a window with `par' as parent.
			-- The life of the window will depend on
			-- the one of `par'.
		local
			par_imp: EV_UNTITLED_WINDOW_IMP
		do
			par_imp ?= par.implementation

			-- Create the window
			widget := gtk_window_new (GTK_WINDOW_POPUP)

			-- Attach the window to `par'.
			gtk_window_set_transient_for (widget, par_imp.widget)

			-- set the events to be handled by the window
			c_gtk_widget_set_all_events (widget)

			initialize
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
	
	connect_to_application (exit_function, the_application, the_untitled_window: POINTER) is
		local
			i: INTEGER
			a: ANY
			s: string
		do
			-- connect delete and destroy events to exit signals
			-- Temporary XXX!
			!!s.make (0)
			s := "destroy"
			a := s.to_c
					
			-- Connect the signal
			i := c_gtk_signal_connect (widget, $a, exit_function, 
						   the_application, the_untitled_window, 
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

	set_parent (par: EV_WINDOW) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
			if parent_imp /= Void then
				parent_imp := Void
			end
			if par /= Void then
				parent_imp ?= par.implementation

				-- Attach the window to `par'.
				gtk_window_set_transient_for (widget, parent_imp.widget)
			end
		end

feature {EV_STATIC_MENU_BAR_IMP} -- Implementation

	add_static_menu (menu: EV_STATIC_MENU_BAR_IMP) is
			-- Add a static menu bar at the top of the window.
		do
			gtk_box_pack_start (vbox, menu.widget, False, True, 0)
		end

feature {EV_STATUS_BAR_IMP} -- Implementation

	add_status_bar (status_bar: EV_STATUS_BAR_IMP) is
			-- Add a status bar at the bottom of the window.
		do
			gtk_object_ref (hbox)
			gtk_container_remove (vbox, hbox)
			gtk_box_pack_end (vbox, status_bar.widget, False, True, 0)
			gtk_box_pack_end (vbox, hbox, True, True, 0)
			gtk_object_unref (hbox)
		end

feature {EV_APPLICATION_IMP} -- Implementation

	has_close_command: BOOLEAN
			-- Did the user added a close command to the window.

feature {NONE} -- Implementation

	child_packing_changed (child_imp: EV_WIDGET_IMP) is
			-- changed the settings of his child `the_child'.
			-- Redefined because the child is placed in a hbox (see `add_child').
		do
			c_gtk_box_set_child_options (hbox, child_imp.widget, child_imp.expandable, False)
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
			Result := c_gtk_window_maximum_width (widget) 
		end	
	
	maximum_height: INTEGER is
			-- Maximum height that application wishes widget
			-- instance to have
		do
			Result := c_gtk_window_maximum_height (widget)
		end

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		local
			p : POINTER
		do
			p := c_gtk_window_title(widget)
			create Result.make (0)
			Result.from_c (p)
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

feature -- Status setting

	forbid_resize is
			-- Forbid the resize of the window.
		do
			gtk_window_set_policy (widget, False, False,False)
		end

	allow_resize is
			-- Allow the resize of the window.
		do
			gtk_window_set_policy (widget, True, True, False)
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
			-- to be tested
			gdk_window_set_hints(widget, x, y, 0, 0, max_width, maximum_height, True)
		end 

	set_maximum_height (max_height: INTEGER) is
			-- Set `maximum_height' to `max_height'.
		do
			-- to be tested
			gdk_window_set_hints(widget, x, y, 0, 0, maximum_width, max_height, True)
		end

	set_title (new_title: STRING) is
			-- Set `title' to `new_title'.
                local
                        a: ANY
		do
			a := new_title.to_c	
			gtk_window_set_title (widget, $a)
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
			!EV_EVENT_DATA!ev_data.make-- temporary, create a correct object here XX
			add_command_with_event_data (widget, "delete_event", cmd, arg, ev_data, 0, False)
			has_close_command := True
		end

	add_resize_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when the
			-- widget is resized.
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make  -- temporary, create a correct object here XX
			add_command_with_event_data (widget, "configure_event", cmd, arg, ev_data, 2, False)
		end

	add_move_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when the
			-- widget is moved.
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make  -- temporary, create a correct object here XX
			add_command_with_event_data (widget, "configure_event", cmd, arg, ev_data, 1, False)
		end

feature -- Event -- removing command association

	remove_close_commands is
			-- Empty the list of commands to be executed
			-- when the window is closed.
		do
			has_close_command := False
			remove_commands (widget, close_event_id)
		end

	remove_resize_commands is
			-- Empty the list of commands to be executed
			-- when the window is resized.
		do
			remove_commands (widget, resize_event_id)
		end

	remove_move_commands is
			-- Empty the list of commands to be executed
			-- when the widget is resized.
		do
			remove_commands (widget, move_event_id)
		end

end -- class EV_UNTITLED_WINDOW_IMP
