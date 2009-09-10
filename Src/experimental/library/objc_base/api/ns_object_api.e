note
	description: "Summary description for {NS_OBJECT_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OBJECT_API

inherit
	ANY
		rename
			copy as any_copy
		end

feature -- Creating, Copying, and Deallocating Objects

	frozen copy (a_object: POINTER): POINTER
		external
			"C inline use <Foundation/NSObject.h>"
		alias
			"return [(NSObject*)$a_object copy];"
		end

feature -- Identifying classes

	frozen class_ (a_object: POINTER): POINTER
		external
			"C inline use <Foundation/NSObject.h>"
		alias
			"return [(NSObject*)$a_object class];"
		end

feature -- Initializing Objects

	frozen init (a_item_ptr: POINTER): POINTER
		external
			"C inline use <Foundation/NSObject.h>"
		alias
			"return [(NSObject *) $a_item_ptr init];"
		end

feature -- Managing Reference Counts

	frozen retain_count (a_item_ptr: POINTER):  NATURAL_64
--		require
--			a_item_ptr_not_null: a_item_ptr /= default_pointer
		external
			"C inline use <Foundation/NSObject.h>"
		alias
			"return [(NSObject *) $a_item_ptr retainCount];"
		end

	frozen release (a_item_ptr: POINTER)
--		require
--			a_item_ptr_not_null: a_item_ptr /= default_pointer
		external
			"C inline use <Foundation/NSObject.h>"
		alias
			"[(NSObject *) $a_item_ptr release];"
		end

	frozen retain (a_item_ptr: POINTER)
--		require
--			a_item_ptr_not_null: a_item_ptr /= default_pointer
		external
			"C inline use <Foundation/NSObject.h>"
		alias
			"[(NSObject *) $a_item_ptr retain];"
		end

feature -- Describing Objects

	frozen description (a_item_ptr: POINTER): POINTER
		external
			"C inline use <Foundation/NSObject.h>"
		alias
			"return [(NSObject *) $a_item_ptr description];"
		end

end
