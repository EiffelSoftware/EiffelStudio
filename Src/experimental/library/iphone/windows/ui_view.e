note
	description: "Ancestor to all UI elements"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UI_VIEW

inherit
	NS_OBJECT

feature -- Initialization

	init_with_frame (a_rect: CG_RECT)
			-- Initialize current to fit in `a_rect'
		require
			exists: exists
			a_rect_exists: a_rect.exists
		do
			{UI_VIEW_API}.init_with_frame (item, a_rect.item)
		end

feature -- Action sequences



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
		deferred
		ensure
			cocoa_class_name_not_empty: not Result.is_empty
		end

	allocate_object
			-- Register the associated class of current associated to `class_name'.
		local
			l_superclass: POINTER
			l_iphone_class_name, l_class_name: C_STRING
			l_class: POINTER
		do
			create l_class_name.make (class_name)
			l_class := {NS_OBJC_RUNTIME}.objc_get_class (l_class_name.item)
			if l_class = default_pointer then
					-- First build inheritance to the UIView descendant for the Current class.
				create l_iphone_class_name.make (iphone_class_name)
				l_superclass := {NS_OBJC_RUNTIME}.objc_get_class (l_iphone_class_name.item)
				l_class := {NS_OBJC_RUNTIME}.objc_allocate_class_pair (l_superclass, l_class_name.item, 0)
				if l_class /= default_pointer then
						-- Add the UIResponder event handlings
					redefine_method (l_class, "touchesBegan:withEvent:")
					redefine_method (l_class, "touchesMoved:withEvent:")
					redefine_method (l_class, "touchesEnded:withEvent:")
					redefine_method (l_class, "touchesCancelled:withEvent:")
					{NS_OBJC_RUNTIME}.objc_register_class_pair (l_class)
				end
			end
			if l_class /= default_pointer then
				make_from_pointer ({NS_OBJC_RUNTIME}.class_create_instance (l_class, 0))
			end
		end

	redefine_method (a_class: POINTER; a_routine_name: READABLE_STRING_GENERAL)
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
			l_class := {NS_OBJC_RUNTIME}.objc_get_class ((create {C_STRING}.make ("EiffelUIResponder")).item)
			check l_class_exists: l_class /= default_pointer end

				-- Create a selector for `a_routine_name'.
			l_selector := {NS_OBJC_RUNTIME}.sel_register_name ((create {C_STRING}.make (a_routine_name)).item)

				-- Get implementation of `a_routine_name' from `EiffelUIResponder'.
			old_imp := {NS_OBJC_RUNTIME}.class_get_method_implementation (l_class, l_selector)

				-- Because they all return void, this is our encoding
			l_types := (create {C_STRING}.make ("v@:")).item

				-- Replace the current implementation of `a_routine_name' of `a_class' by the one from
				-- `EiffelUIResponder'.
			l_imp := {NS_OBJC_RUNTIME}.class_replace_method (a_class, l_selector, old_imp, l_types)
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
