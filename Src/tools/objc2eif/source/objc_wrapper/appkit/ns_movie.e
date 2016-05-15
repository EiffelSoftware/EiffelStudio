note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MOVIE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature {NONE} -- Initialization

--	make_with_movie_ (a_movie: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--		do
--			make_with_pointer (objc_init_with_movie_(allocate_object))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSMovie Externals

--	objc_init_with_movie_ (an_item: POINTER; a_movie: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSMovie *)$an_item initWithMovie:$a_movie];
--			 ]"
--		end

--	objc_qt_movie (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSMovie *)$an_item QTMovie];
--			 ]"
--		end

feature -- NSMovie

--	qt_movie: detachable UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_qt_movie (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like qt_movie} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like qt_movie} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMovie"
		end

end
