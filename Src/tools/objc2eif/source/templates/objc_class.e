note
	description: "A class representing an Objective-C class."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_CLASS

inherit
	NS_OBJECT
		redefine
			make_with_pointer,
			is_subclass_instance,
			dispose
		end

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain,
	make_with_name

feature {NONE} -- Initialization

	make_with_pointer (a_pointer: POINTER)
			-- Initialize `Current' with `a_pointer'.
		local
			c_string: C_STRING
		do
			item := a_pointer
			create name.make_from_c (objc_class_get_name (item))
			create c_string.make (name)
			allocated := True
			registered := objc_get_class (c_string.item) /= default_pointer
		end

	make_with_name (a_name: STRING)
			-- Initialize `Current' with `a_class_name'
		require
			a_valid_name: not a_name.is_empty
		local
			c_string: C_STRING
		do
			name := a_name
			create c_string.make (name)
			item := objc_get_class (c_string.item)
			registered := item /= default_pointer
			allocated := registered
		ensure
			name_set: name = a_name
		end

feature -- Access

	name: STRING
			-- The name of the class represented by `Current'.

	superclass_objc: detachable OBJC_CLASS assign set_superclass_objc
			-- The superclass of this class. If the class is registered it is guaranteed to have a superclass.
		do
			if registered then
				create Result.make_with_pointer_and_retain (objc_class_get_superclass (item))
			else
				Result := internal_superclass_objc
			end
		ensure
			registered_implies_superclass_not_void: registered implies Result /= Void
		end

	registered: BOOLEAN
			-- Is the Objective-C class represented by `Current' registered in the Objective-C runtime?

	allocated: BOOLEAN
			-- Has the Objective-C class represented by `Current' have already been allocated?

feature -- Setters

	set_superclass_objc (a_superclass_objc: like superclass_objc)
			-- Set `superclass_objc' with `a_superclass_objc'.
		require
			not_registered: not registered
		do
			internal_superclass_objc := a_superclass_objc
		ensure
			superclass_objc_set: superclass_objc = a_superclass_objc
		end

feature -- Methods manipulation

	add_method (a_selector: OBJC_SELECTOR; an_implementation: POINTER; types: STRING): BOOLEAN
			-- Add a new method to this class with a given name and implementation.
			-- Return `True' if the method was added successfully.
		require
			allocated: allocated
			not_registered: not registered
		local
			c_string: C_STRING
		do
			create c_string.make (types)
			Result := objc_class_add_method (item, a_selector.item, an_implementation, c_string.item)
		end

feature -- Allocation and Registration

	allocate
			-- Creates a new Objective-C class and metaclass.
		require
			not_allocated: not allocated
			has_superclass_objc: superclass_objc /= Void
		do
			check attached superclass_objc as attached_superclass_objc then
				item := objc_allocate_class_pair (attached_superclass_objc.item, (create {C_STRING}.make (name)).item, 0)
			end
			allocated := True
		ensure
			allocated: allocated
		end

	register
			-- Register this class in the Objective-C runtime such that it can be used.
		require
			allocated: allocated
			not_registered: not registered
		do
			objc_register_class_pair (item)
			internal_superclass_objc := Void
			registered := True
		ensure
			registered: registered
		end

feature -- Removal

	dispose
			-- Do nothing
		do
			
		end

feature {NONE} -- Implementation

	internal_superclass_objc: detachable OBJC_CLASS
		-- If this class hasn't been registered in the Objective-C runtime, this
		-- is the attribute to store its superclass.

	is_subclass_instance: BOOLEAN
		do
			Result := False
		end

feature {NONE} -- Externals

	objc_class_get_name (a_pointer: POINTER): POINTER
			-- Return the name of a class.
		external
			"C inline use <objc/runtime.h>"
		alias
			"return (EIF_POINTER) class_getName($a_pointer)"
		end

	objc_get_class (a_pointer: POINTER): POINTER
			-- Return the class definition of a specified class.
		external
			"C inline use <objc/runtime.h>"
		alias
			"return objc_getClass($a_pointer)"
		end

	objc_class_add_method (a_class: POINTER; a_selector: POINTER; an_implementation: POINTER; types: POINTER): BOOLEAN
			-- Add a new method to a class with a given name and implementation.
		external
			"C inline use <objc/runtime.h>"
		alias
			"[
				return class_addMethod($a_class, $a_selector, $an_implementation, $types);
			]"
		end

	objc_allocate_class_pair (a_superclass_objc: POINTER; a_name: POINTER; extra_bytes: INTEGER_64): POINTER
			-- Create a new class and metaclass.
		external
			"C inline use <objc/runtime.h>"
		alias
			"objc_allocateClassPair($a_superclass_objc, $a_name, $extra_bytes)"
		end

	objc_register_class_pair (a_class: POINTER)
			-- Register a class that was allocated using `objc_allocate_class_pair'.
		external
			"C inline use <objc/runtime.h>"
		alias
			"objc_registerClassPair($a_class)"
		end

	objc_class_get_superclass (a_class: POINTER): POINTER
			-- Return the superclass of a class.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return [(id)$a_class superclass]"
		end

end
