indexing

	description:
			"Fundamental Motif Object.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_OBJECT

inherit

	MEL_OBJECT_RESOURCES
		export
			{NONE} all
		end;

	SHARED_MEL_DISPATCHER;

	MEL_XT_FUNCTIONS;

	MEL_XM_FUNCTIONS;

	MEL_EVENT_MASK_CONSTANTS

creation

feature -- Access

	parent: MEL_COMPOSITE;
			-- Parent of Current

	screen_object: POINTER;
			-- Screen object of Current

	is_valid_parent (a_screen_object: POINTER; 
			a_parent: MEL_COMPOSITE): BOOLEAN is
			-- Is `a_parent' a valid parent for `a_screen_object'?
		require
			valid_screen_object: a_screen_object /= default_pointer;
			valid_parent: a_parent /= Void
		do
			Result := xt_parent (a_screen_object) = a_parent.screen_object
		end;

	name: STRING is
			-- Name of Current
		require
			exists: not is_destroyed
		do
			!! Result.make (0);
			Result.from_c (xt_name (screen_object))
		ensure
			name_not_void: Result /= Void
		end;

	application_context: MEL_APPLICATION_CONTEXT is
			-- Associated application context.
		require
			exists: not is_destroyed
		do
			!! Result.make_from_existing 
					(xt_widget_to_application_context (screen_object))
		ensure
			application_context_is_valid: Result /= Void and Result.is_valid
		end;

	screen: MEL_SCREEN is
			-- Associated screen
		require
			exists: not is_destroyed
		do
			Result := parent.screen
		ensure
			screen_not_void: Result /= Void
		end;

	display: MEL_DISPLAY is
			-- Associated display
		require
			exists: not is_destroyed
		do
			Result := screen.display
		ensure
			display_is_valid: Result /= Void and then Result.is_valid
		end;

	hash_code: INTEGER is
			-- Hash code
		do
			Result := screen_object.hash_code
		end;

	current_time: INTEGER is
			-- Call `CurrentTime' from X
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CurrentTime"
		end;

	command_set (a_command_exec: MEL_COMMAND_EXEC;
			a_command: MEL_COMMAND; an_argument: ANY): BOOLEAN is
		require
			command_exec_not_void: a_command_exec /= Void
		do
			Result := a_command_exec.command = a_command and then
				a_command_exec.argument = an_argument
		ensure
			set_if_cmd_and_arg_equal: Result implies
				a_command_exec.command = a_command and then
					a_command_exec.argument = an_argument
		end;

	destroy_command: MEL_COMMAND_EXEC is
			-- Command set for the destroy callback
		do
			Result := motif_command (XmNdestroyCallback)
		end

feature -- Status report

	realized: BOOLEAN is
			-- Is Current realized?
		require
			exists: not is_destroyed
		do
			Result := xt_is_realized (screen_object);
		end;

	is_managed: BOOLEAN is
			-- Is Current managed?
		require
			exists: not is_destroyed
		do
			Result := xt_is_managed (screen_object);
		end;

	is_sensitive: BOOLEAN is
			-- Is Current sensitive?
		require
			exists: not is_destroyed
		do
			Result := xt_is_sensitive (screen_object);
		end;

	is_shown: BOOLEAN is
			-- Is Current shown on the screen?
		require
			exists: not is_destroyed;
			widget_realized: realized
		do
			Result := is_managed and then xt_is_visible (screen_object)
		end;

	is_destroyed: BOOLEAN is
			-- Is Current is_destroyed?
		do
			Result := screen_object = default_pointer
		end

feature -- Status setting

	manage is
			-- Enable geometry management.
		require
			exists: not is_destroyed
		do
			xt_manage_child (screen_object)
		ensure
			is_managed: parent /= Void implies is_managed
		end;

	unmanage is
			-- Disable geometry management.
		require
			exists: not is_destroyed
		do
			xt_unmanage_child (screen_object)
		ensure
			is_unmanaged: parent /= Void implies not is_managed
		end;

	set_sensitive is
			-- Set `is_sensitive' to True.
		require
			exists: not is_destroyed
		do
			xt_set_sensitive (screen_object, True)
		ensure
			is_sensitive: is_sensitive 
		end;

	set_insensitive is
			-- Set `is_sensitive' to False.
		require
			exists: not is_destroyed
		do
			xt_set_sensitive (screen_object, False)
		ensure
			not_sensitive: not is_sensitive 
		end;

	map, show is
			-- Show Current on the screen.
		require
			exists: not is_destroyed;
			widget_realized: realized
		do
			xt_map_widget (screen_object)
		ensure
			shown: (parent /= Void and then 
				parent.is_shown implies is_shown) or else
				(parent = Void implies is_shown)
		end;

	unmap, hide is
			-- Hide Current.
		require
			exists: not is_destroyed
			widget_realized: realized
		do
			xt_unmap_widget (screen_object)
		ensure
			widget_is_hidden: (parent /= Void and then
				parent.is_shown implies not is_shown) or else
				(parent = Void implies not is_shown)
		end;

	realize is
			-- Create Current's window and create recursively all the
			-- children's windows plus
			-- perform some extra initialization.
		require
			exists: not is_destroyed
		do
			xt_realize_widget (screen_object)
		ensure
			realized
		end;

	unrealize is
			-- Destroy Current's window and all children's windows.
		require
			exists: not is_destroyed
		do
			xt_unrealize_widget (screen_object)
		ensure
			not_realized: not realized
		end;

feature -- Update

	process_traversal (a_direction: INTEGER) is
			-- Traverse Current's hierarchy with direction `a_direction'.
			-- (Directions constants are in class MEL_TRAVERSAL_CONSTANTS)
		require
			exists: not is_destroyed
		do
			if xm_process_traversal (screen_object, a_direction) then
			end
		end;

	update_display is
			-- Update the display of Current widget by forcing all pending
			-- exposure events to be processed immediately.
		require
			exists: not is_destroyed
		do
			xm_update_display (screen_object)	
		end

feature -- Element change

	set_callback (a_callback_resource: POINTER; a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when callback of type 
			-- `a_callback_resource' is performed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not is_destroyed;
			a_callback_resource_not_void: a_callback_resource /= default_pointer;
			command_not_void: a_command /= Void
		local
			a_command_exec: MEL_COMMAND_EXEC;
			a_key: MEL_CALLBACK_KEY
		do
			!! a_key.make_motif (a_callback_resource);
			!! a_command_exec.make (a_command, an_argument);
			if add_to_callbacks (a_command_exec, a_key) then
				c_add_callback (screen_object, a_callback_resource)
			end
		end;

	set_destroy_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when an object is destroyed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void;
		do
			set_callback (XmNdestroyCallback, a_command, an_argument);
		ensure
			command_set: command_set (destroy_command, a_command, an_argument)
		end;

feature -- Removal

	remove_callback (a_callback_resource: POINTER) is
			-- Remove the command specified by callback type `a_callback_resource'.
		require
			exists: not is_destroyed;
			callback_resource_not_null: a_callback_resource /= default_pointer
		local
			a_key: MEL_CALLBACK_KEY
		do
			!! a_key.make_motif (a_callback_resource);
			if remove_from_callbacks (a_key) then
				c_remove_callback (screen_object, a_callback_resource)
			end;
		end;

	remove_destroy_callback is
			-- Remove the command for the destroy callback.
		do
			remove_callback (XmNdestroyCallback)
		end;

	destroy is
			-- Destroy the associated screen object.
		require
			exists: not is_destroyed
		local
			clean_up_callback: MEL_CLEAN_UP_CALLBACK;
			dc: like destroy_command;
			list: MEL_COMMAND_LIST
		do
debug ("MEL")
	io.error.putstring ("destroying widget: ");
	io.error.putstring (name);
	io.error.putstring (" type: ");
	io.error.putstring (generator);
	io.error.new_line;
end;
			check
				is_in_widget_manager: Mel_widgets.has (screen_object)
			end
			dc := destroy_command;
			if dc /= Void then
				!! list.make;
				list.add_command (dc.command, dc.argument);
				!! clean_up_callback;
				list.add_command (clean_up_callback, Void);
				set_destroy_callback (list, Void);
				xt_destroy_widget (screen_object)
			else
				xt_destroy_widget (screen_object);
				clean_up
			end
		end;

feature -- Miscellaneous

	set_default is
			-- Set the values to their defaults.
			-- (Default: Do nothing.)
		do
		end;

feature -- Initialization

	make_from_existing (a_screen_object: POINTER; a_parent: MEL_COMPOSITE) is
			-- Create a mel widget from existing widget `a_screen_object'.
		require
			screen_object_not_null: a_screen_object /= default_pointer;
			parent_not_void: a_parent /= Void;
			valid_parent: is_valid_parent (a_screen_object, a_parent)
		do
			screen_object := a_screen_object;
			parent := a_parent;
			Mel_widgets.add (Current)
		ensure
			exists: not is_destroyed;
			set: screen_object = a_screen_object and then parent = a_parent
		end

feature {MEL_DISPATCHER} -- Implementation

	create_callback_struct (a_callback_struct_ptr: POINTER;
				resource_name: POINTER): MEL_ANY_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		require
			exists: not is_destroyed;
			a_callback_struct_ptr_not_null: a_callback_struct_ptr /= default_pointer
		do
			check
				not_be_called: False
			end
		ensure
			result_not_void: Result /= Void
		end;

feature {MEL_OBJECT, MEL_CLEAN_UP_CALLBACK} -- Implementation

	clean_up, object_clean_up is
			-- Clean up object widget data structures.
		require
			exist: not is_destroyed
		do
debug ("MEL")
	io.error.putstring ("cleaning up widget: ");
	io.error.putstring (name);
	io.error.putstring (" type: ");
	io.error.putstring (generator);
	io.error.new_line;
end;
			Mel_widgets.remove (screen_object);
			screen_object := default_pointer;
			callbacks := Void;
			parent := Void
		ensure
			destroyed: is_destroyed;
			reset_callbacks: callbacks = Void;
			no_parent: parent = Void
		end;

feature {NONE} -- Implementation

	add_to_callbacks (a_command: MEL_COMMAND_EXEC; 
			a_key: MEL_CALLBACK_KEY): BOOLEAN is
			-- Add `a_command' with `a_key' to the callback table.
			-- Set Result to `True' if `a_key' did not exist (i.e callback
			-- was already registered)
		local
			cb: like callbacks
		do
			cb := callbacks;
			if cb = Void then
				Result := True;
				!! cb.make (1);
				callbacks := cb
				cb.put (a_command, a_key)
			elseif cb.has (a_key) then
				cb.force (a_command, a_key)
			else
				Result := True;
				cb.put (a_command, a_key)
			end;
		ensure
			command_set: callbacks.has (a_key)
		end;

	remove_from_callbacks (a_key: MEL_CALLBACK_KEY): BOOLEAN is
			-- Remove entry with `a_key'.
			-- Set Result to `True' if `a_key' existed (i.e callback
			-- was registered)
		local
			cb: like callbacks
		do
			cb := callbacks;
			if cb /= Void then
				cb.remove (a_key);
				Result := cb.removed
			end;
		ensure
			command_removed: callbacks /= Void implies not callbacks.has (a_key)
		end;

	motif_command (a_callback_resource: POINTER): MEL_COMMAND_EXEC is
			-- Command set for motif callback `a_callback_resource'
		local
			cb: like callbacks;
			a_key: MEL_CALLBACK_KEY
		do
			cb := callbacks;
			if cb /= Void then
				!! a_key.make_motif (a_callback_resource);
				Result := cb.item (a_key)
			end
		end;

feature {MEL_DISPATCHER} -- Implementation

	callbacks: HASH_TABLE [MEL_COMMAND_EXEC, MEL_CALLBACK_KEY];
			-- Table of command hashed on callback type

	execute_callback (
				a_key: MEL_CALLBACK_KEY;
				a_callback_struct: MEL_CALLBACK_STRUCT) is
		require
			has_callback: callbacks.has (a_key)
		do
			callbacks.item (a_key).execute (a_callback_struct)
		end

feature {NONE} -- Implementation

	c_add_callback (scr_obj: POINTER; resource_name: POINTER) is
		external
			"C"
		end;

	c_remove_callback (scr_obj: POINTER; resource_name: POINTER) is
		external
			"C"
		end;

	xm_process_traversal (a_target: POINTER; dir: INTEGER): BOOLEAN is
		external
			"C (Widget, XmTraversalDirection): EIF_BOOLEAN | <Xm/Xm.h>"
		alias
			"XmProcessTraversal"
		end;

	xm_update_display (a_target: POINTER) is
		external
			"C (Widget) | <Xm/Xm.h>"
		alias
			"XmUpdateDisplay"
		end;

invariant

	destroyed_implies_null_screen_object: is_destroyed 
			implies screen_object = default_pointer;
	destroyed_implies_void_parent: is_destroyed implies parent = Void

end -- class MEL_OBJECT


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

