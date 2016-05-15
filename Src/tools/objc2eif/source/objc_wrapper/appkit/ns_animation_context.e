note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ANIMATION_CONTEXT

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSAnimationContext

	set_duration_ (a_duration: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_duration_ (item, a_duration)
		end

	duration: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_duration (item)
		end

feature {NONE} -- NSAnimationContext Externals

	objc_set_duration_ (an_item: POINTER; a_duration: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimationContext *)$an_item setDuration:$a_duration];
			 ]"
		end

	objc_duration (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAnimationContext *)$an_item duration];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSAnimationContext"
		end

end
