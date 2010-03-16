note
	description: "Ancestor to all UI elements"
	date: "$Date$"
	revision: "$Revision$"

class
	UI_VIEW

inherit
	NS_OBJECT
		undefine
			copy
		redefine
			dispose, is_equal
		end

	IDENTIFIED
		rename
			object_id as internal_object_id
		redefine
			dispose, is_equal
		end

create
	share_from_pointer

create {NS_OBJECT, OBJC_CLASS, OBJC_CALLBACK_MARSHAL}
	make_from_pointer

feature -- Initialization

	init_with_frame (a_rect: CG_RECT)
			-- Initialize current to fit in `a_rect'
		require
			exists: exists
			a_rect_exists: a_rect.exists
		do
			{UI_VIEW_API}.init_with_frame (item, a_rect.item)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := item = other.item
		end

feature -- Status report

	is_extendible: BOOLEAN
			-- Can Current have children?
		do
			Result := True
		end

feature -- Element change

	extend (a_label: UI_VIEW)
			-- Add `a_label' as a child of Current.
		require
			exists: exists
			a_label_exists: a_label.exists
			is_extendible: is_extendible
		do
			c_add_subview (item, a_label.item)
		end

feature -- Action sequences

	touches_began_actions: ACTION_SEQUENCE [TUPLE [UI_EVENT]]
			-- Actions executed when a touch began
		do
			if attached touches_began_actions_internal as l_actions then
				Result := l_actions
			else
				create Result
				touches_began_actions_internal := Result
			end
		end

	touches_moved_actions: ACTION_SEQUENCE [TUPLE [UI_EVENT]]
			-- Actions executed when a touch moved
		do
			if attached touches_moved_actions_internal as l_actions then
				Result := l_actions
			else
				create Result
				touches_moved_actions_internal := Result
			end
		end

	touches_cancelled_actions: ACTION_SEQUENCE [TUPLE [UI_EVENT]]
			-- Actions executed when a touch is cancelled
		do
			if attached touches_cancelled_actions_internal as l_actions then
				Result := l_actions
			else
				create Result
				touches_cancelled_actions_internal := Result
			end
		end

	touches_ended_actions: ACTION_SEQUENCE [TUPLE [UI_EVENT]]
			-- Actions executed when a touch ended
		do
			if attached touches_ended_actions_internal as l_actions then
				Result := l_actions
			else
				create Result
				touches_ended_actions_internal := Result
			end
		end

feature -- Access

	object_id: INTEGER
			-- Associated identifier of `Current'.
		require
			exists: exists
		do
			Result := internal_id
			if Result = 0 then
				Result := internal_object_id
				{UI_VIEW_API}.set_eiffel_object_id (item, Result)
			else
				Result := internal_id
			end
		ensure
			valid_id: Result > 0 implies id_object (Result) = Current
		end

feature -- Settings

	set_center (a_point: CG_POINT)
			-- Set `a_point' as a center of Current.
		require
			exists: exists
			a_point_exists: a_point.exists
		do
			{UI_VIEW_API}.set_center (item, a_point.item)
		ensure
			center_set: -- center ~ a_point
		end

feature -- Disposal

	dispose
			-- <Precursor>
		do
			Precursor {NS_OBJECT}
			Precursor {IDENTIFIED}
		end

feature {NONE} -- Implementation

	touches_began_actions_internal: detachable like touches_began_actions note option: stable attribute end
	touches_moved_actions_internal: detachable like touches_moved_actions note option: stable attribute end
	touches_cancelled_actions_internal: detachable like touches_cancelled_actions note option: stable attribute end
	touches_ended_actions_internal: detachable like touches_ended_actions note option: stable attribute end
			-- Storage for action sequences.

feature {NONE} -- Implementation

	frozen class_name: IMMUTABLE_STRING_8
			-- Associated class name
		do
			create Result.make_from_string ("Eiffel" + iphone_class_name)
		ensure
			class_name_not_empty: not Result.is_empty
		end

	iphone_class_name: IMMUTABLE_STRING_8
			-- Name of iPhone class that Current is extending
		do
			create Result.make_from_string ("UIView")
		ensure
			cocoa_class_name_not_empty: not Result.is_empty
		end

	allocate_object
			-- Register the associated class of current associated to `class_name'.
		local
			l_superclass: POINTER
			l_iphone_class_name, l_class_name: C_STRING
			l_class: POINTER
			l_bool: BOOLEAN
		do
			create l_class_name.make (class_name)
			l_class := {NS_OBJC_RUNTIME}.objc_get_class (l_class_name.item)
			if l_class = default_pointer then
					-- First build inheritance to the UIView descendant for the Current class.
				create l_iphone_class_name.make (iphone_class_name)
				l_superclass := {NS_OBJC_RUNTIME}.objc_get_class (l_iphone_class_name.item)
				l_class := {NS_OBJC_RUNTIME}.objc_allocate_class_pair (l_superclass, l_class_name.item, 0)
				l_bool := {NS_OBJC_RUNTIME}.class_add_protocol (l_class, {UI_VIEW_API}.eiffel_identified_protocol)
				check protocol_did_not_already_exist: l_bool end
				if l_class /= default_pointer then
						-- Add the UIResponder event handlings
					redefine_method (l_class, "v@:", "touchesBegan:withEvent:")
					redefine_method (l_class, "v@:", "touchesMoved:withEvent:")
					redefine_method (l_class, "v@:", "touchesEnded:withEvent:")
					redefine_method (l_class, "v@:", "touchesCancelled:withEvent:")
					redefine_method (l_class, "i@:", "eiffel_object_id")
					{NS_OBJC_RUNTIME}.objc_register_class_pair (l_class)
				end
			end
			if l_class /= default_pointer then
				make_from_pointer ({NS_OBJC_RUNTIME}.class_create_instance (l_class, {PLATFORM}.integer_32_bytes))
					-- Compute and assign object_id to objective C side.
				object_id.do_nothing
			end
		end

	redefine_method (a_class: POINTER; a_routine_encoding, a_routine_name: READABLE_STRING_GENERAL)
			-- Replace a method in an objective-c class by a_agent
			-- This can be dangerous as the method is replaced for all objects which are instances of that class
			-- even those that were created before this call.
		require
			class_exists: a_class /= default_pointer
			a_routine_name_not_empty: not a_routine_name.is_empty
		local
			l_types: POINTER
			l_selector: POINTER
			l_imp: POINTER
			old_imp: POINTER
			l_class: POINTER
		do
				-- Get the associated class that has the actual imlementation for `a_routine_name'.
			l_class := {NS_OBJC_RUNTIME}.objc_get_class ((create {C_STRING}.make ("EiffelUIApplication")).item)
			check l_class_exists: l_class /= default_pointer end

				-- Create a selector for `a_routine_name'.
			l_selector := {NS_OBJC_RUNTIME}.sel_register_name ((create {C_STRING}.make (a_routine_name)).item)

				-- Get implementation of `a_routine_name' from `EiffelUIResponder'.
			old_imp := {NS_OBJC_RUNTIME}.class_get_method_implementation (l_class, l_selector)

				-- Because they all return void, this is our encoding
			l_types := (create {C_STRING}.make (a_routine_encoding)).item

				-- Replace the current implementation of `a_routine_name' of `a_class' by the one from
				-- `EiffelUIResponder'.
			l_imp := {NS_OBJC_RUNTIME}.class_replace_method (a_class, l_selector, old_imp, l_types)
		end

	mapping: UI_ROUTINES
			-- Mapping between objective C object and Eiffel UI_VIEWs
		once
			create Result
		end

feature {NONE} -- Externals

	c_add_subview (a_view_ptr, a_child_view_ptr: POINTER)
		require
			a_view_ptr_not_null: a_view_ptr /= default_pointer
			a_child_view_ptr_not_null: a_child_view_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"[((UIView *) $a_view_ptr) addSubview:((UIView *) $a_child_view_ptr)];"
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
