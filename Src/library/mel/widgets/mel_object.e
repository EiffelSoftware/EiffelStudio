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

	MEL_X_FUNCTIONS;

	MEL_XT_FUNCTIONS;

	MEL_XM_FUNCTIONS;

	MEL_EVENT_MASK_CONSTANTS

feature -- Access

	parent: MEL_COMPOSITE;
			-- Parent of Current

	screen_object: POINTER;
			-- Screen object of Current

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

	window: INTEGER is
			-- Associated window
		require
			exists: not is_destroyed;
			realized: realized
		do
			Result := xt_window (screen_object)
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

feature -- Status report

	realized: BOOLEAN is
			-- Is Current realized?
		require
			exists: not is_destroyed
		do
			Result := xt_is_realized (screen_object);
		end;

	managed: BOOLEAN is
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
			Result := xt_is_visible (screen_object)
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
			managed: parent /= Void implies managed
		end;

	unmanage is
			-- Disable geometry management.
		require
			exists: not is_destroyed
		do
			xt_unmanage_child (screen_object)
		ensure
			unmanaged: parent /= Void implies not managed
		end;

	set_sensitive (b: BOOLEAN) is
			-- Set `is_sensitive' to `b'.
		require
			exists: not is_destroyed
		do
			xt_set_sensitive (screen_object, b)
		ensure
			is_sensitive: is_sensitive = b
		end;

	map, show is
			-- Show Current on the screen.
		require
			exists: not is_destroyed;
			widget_realized: realized
		do
			xt_map_widget (screen_object)
		ensure
			widget_is_shown: is_shown
		end;

	unmap, hide is
			-- Hide Current.
		require
			exists: not is_destroyed
			widget_realized: realized
		do
			xt_unmap_widget (screen_object)
		ensure
			widget_is_hidden: not is_shown
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
			if Mel_dispatcher.has_callback (screen_object, XmNdestroyCallback) then
				!! clean_up_callback;
				add_destroy_callback (clean_up_callback, Void);
				xt_destroy_widget (screen_object)
			else
				xt_destroy_widget (screen_object);
				clean_up
			end
debug ("MEL")
	io.error.putstring ("destroying widget: ");
	io.error.putstring (name);
	io.error.putstring (" type: ");
	io.error.putstring (generator);
	io.error.new_line;
end;
		ensure
			is_destroyed: is_destroyed
		end;

feature -- Miscellaneous

	set_default is
			-- Set the values to their defaults.
			-- (Default: Do nothing.)
		do
		end;

feature {NONE} -- Initialization

	make_from_existing (a_screen_object: POINTER) is
			-- Create a mel widget from existing widget `a_screen_object'.
		require
			a_screen_object_exists: a_screen_object /= default_pointer
		do
			screen_object := a_screen_object;
			check
				parent_exists: Mel_widgets.item (xt_parent (screen_object)) /= Void
			end;
			parent ?= Mel_widgets.item (xt_parent (screen_object));
			Mel_widgets.put (Current, screen_object)
		ensure
			exists: not is_destroyed
		end

feature {MEL_COMPOSITE, MEL_CLEAN_UP_CALLBACK} -- Basic operations

	clean_up is
			-- Clean up the object.
		do
			object_clean_up
		ensure
			not_in_manager: not Mel_widgets.has (screen_object);
		end;

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

feature {MEL_OBJECT} -- Convienence

	object_clean_up is
			-- Clean up object widget.
		do
debug ("MEL")
	io.error.putstring ("cleaning up widget: ");
	io.error.putstring (name);
	io.error.putstring (" type: ");
	io.error.putstring (generator);
	io.error.new_line;
end;
			Mel_widgets.remove (screen_object);
			parent := Void;
			clean_up_callbacks;
			screen_object := default_pointer
		ensure
			not_in_manager: not Mel_widgets.has (screen_object);
		end;

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
