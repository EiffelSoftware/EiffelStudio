note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DISTRIBUTED_LOCK

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_path_,
	make

feature {NONE} -- Initialization

	make_with_path_ (a_path: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			make_with_pointer (objc_init_with_path_(allocate_object, a_path__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSDistributedLock Externals

	objc_init_with_path_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDistributedLock *)$an_item initWithPath:$a_path];
			 ]"
		end

	objc_try_lock (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDistributedLock *)$an_item tryLock];
			 ]"
		end

	objc_unlock (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDistributedLock *)$an_item unlock];
			 ]"
		end

	objc_break_lock (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDistributedLock *)$an_item breakLock];
			 ]"
		end

	objc_lock_date (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDistributedLock *)$an_item lockDate];
			 ]"
		end

feature -- NSDistributedLock

	try_lock: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_try_lock (item)
		end

	unlock
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_unlock (item)
		end

	break_lock
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_break_lock (item)
		end

	lock_date: detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_lock_date (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like lock_date} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like lock_date} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDistributedLock"
		end

end
