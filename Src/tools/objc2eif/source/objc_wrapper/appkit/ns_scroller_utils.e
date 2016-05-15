note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCROLLER_UTILS

inherit
	NS_CONTROL_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSScroller

	scroller_width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_scroller_width (l_objc_class.item)
		end

	scroller_width_for_control_size_ (a_control_size: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_scroller_width_for_control_size_ (l_objc_class.item, a_control_size)
		end

feature {NONE} -- NSScroller Externals

	objc_scroller_width (a_class_object: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object scrollerWidth];
			 ]"
		end

	objc_scroller_width_for_control_size_ (a_class_object: POINTER; a_control_size: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object scrollerWidthForControlSize:$a_control_size];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScroller"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
