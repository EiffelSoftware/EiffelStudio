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

	add_callback (a_callback_resource: POINTER; a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callback list of the widget called when
			-- `a_callback_resource' is triggered.
		require
			exists: not is_destroyed;
			a_callback_resource_not_void: a_callback_resource /= default_pointer;
			non_void_a_callback: a_callback /= Void
		local
			a_callback_exec: MEL_CALLBACK_EXEC
		do
			!! a_callback_exec.make (a_callback, an_argument);
			Mel_dispatcher.add_callback 
					(screen_object, a_callback_resource, a_callback_exec);
		end;

	add_destroy_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the object is is_destroyed.
		require
			a_callback_not_void: a_callback /= Void;
		do
			add_callback (XmNdestroyCallback, a_callback, an_argument);
		end;

feature -- Removal

	remove_callback (a_callback_resource: POINTER; a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callback list of the widget called when `a_callback_resource' 
			-- is triggered. 
		require
			exists: not is_destroyed;
			a_callback_resource_not_null: a_callback_resource /= default_pointer;
			non_void_a_callback: a_callback  /= Void
		local
			a_callback_exec: MEL_CALLBACK_EXEC
		do
			!! a_callback_exec.make (a_callback, an_argument);
			Mel_dispatcher.remove_callback 
					(screen_object, a_callback_resource, a_callback_exec);
		end;

	remove_destroy_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the object is is_destroyed.
		require
			a_callback_not_void: a_callback /= Void;
		do
			remove_callback (XmNdestroyCallback, a_callback, an_argument);
		end;

	destroy is
			-- Destroy the associated screen object.
		require
			exists: not is_destroyed
		local
			clean_up_callback: MEL_CLEAN_UP_CALLBACK
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
			if Mel_dispatcher.has_callback (screen_object, XmNdestroyCallback) then
				!! clean_up_callback;
				add_destroy_callback (clean_up_callback, Void);
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

feature {MEL_COMPOSITE, MEL_CLEAN_UP_CALLBACK} -- Basic operations

	clean_up_callbacks is
			-- Remove callback structures associated with Current.
		do
			Mel_dispatcher.clean_up_object (Current)
		ensure
			cleaned_up: Mel_dispatcher.cleaned_up (Current)
		end;

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
			clean_up_callbacks;
			screen_object := default_pointer;
			parent := Void
		ensure
			destroyed: is_destroyed;
			no_parent: parent = Void
		end;

feature {NONE} -- Implementation

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

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
