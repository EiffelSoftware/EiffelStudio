note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_POINTER_FUNCTIONS

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_options_,
	make

feature {NONE} -- Initialization

	make_with_options_ (a_options: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_options_(allocate_object, a_options))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSPointerFunctions Externals

	objc_init_with_options_ (an_item: POINTER; a_options: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPointerFunctions *)$an_item initWithOptions:$a_options];
			 ]"
		end

feature -- Properties

	uses_strong_write_barrier: BOOLEAN assign set_uses_strong_write_barrier
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_uses_strong_write_barrier (item)
		end

	set_uses_strong_write_barrier (an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_strong_write_barrier (item, an_arg)
		end

	uses_weak_read_and_write_barriers: BOOLEAN assign set_uses_weak_read_and_write_barriers
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_uses_weak_read_and_write_barriers (item)
		end

	set_uses_weak_read_and_write_barriers (an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_weak_read_and_write_barriers (item, an_arg)
		end

feature {NONE} -- Properties Externals

	objc_uses_strong_write_barrier (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSPointerFunctions *)$an_item usesStrongWriteBarrier];
			 ]"
		end

	objc_set_uses_strong_write_barrier (an_item: POINTER; an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSPointerFunctions *)$an_item setUsesStrongWriteBarrier:$an_arg]
			 ]"
		end

	objc_uses_weak_read_and_write_barriers (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSPointerFunctions *)$an_item usesWeakReadAndWriteBarriers];
			 ]"
		end

	objc_set_uses_weak_read_and_write_barriers (an_item: POINTER; an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSPointerFunctions *)$an_item setUsesWeakReadAndWriteBarriers:$an_arg]
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPointerFunctions"
		end

end
