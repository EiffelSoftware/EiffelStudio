note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PICT_IMAGE_REP

inherit
	NS_IMAGE_REP
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_data_,
	make

feature {NONE} -- Initialization

	make_with_data_ (a_pict_data: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_pict_data__item: POINTER
		do
			if attached a_pict_data as a_pict_data_attached then
				a_pict_data__item := a_pict_data_attached.item
			end
			make_with_pointer (objc_init_with_data_(allocate_object, a_pict_data__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSPICTImageRep Externals

	objc_init_with_data_ (an_item: POINTER; a_pict_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPICTImageRep *)$an_item initWithData:$a_pict_data];
			 ]"
		end

	objc_pict_representation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPICTImageRep *)$an_item PICTRepresentation];
			 ]"
		end

	objc_bounding_box (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSPICTImageRep *)$an_item boundingBox];
			 ]"
		end

feature -- NSPICTImageRep

	pict_representation: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_pict_representation (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pict_representation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pict_representation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bounding_box: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_bounding_box (item, Result.item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPICTImageRep"
		end

end