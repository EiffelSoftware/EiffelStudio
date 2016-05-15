note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FETCHED_PROPERTY_DESCRIPTION

inherit
	NS_PROPERTY_DESCRIPTION
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSFetchedPropertyDescription

	fetch_request: detachable NS_FETCH_REQUEST
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_fetch_request (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like fetch_request} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like fetch_request} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_fetch_request_ (a_fetch_request: detachable NS_FETCH_REQUEST)
			-- Auto generated Objective-C wrapper.
		local
			a_fetch_request__item: POINTER
		do
			if attached a_fetch_request as a_fetch_request_attached then
				a_fetch_request__item := a_fetch_request_attached.item
			end
			objc_set_fetch_request_ (item, a_fetch_request__item)
		end

feature {NONE} -- NSFetchedPropertyDescription Externals

	objc_fetch_request (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFetchedPropertyDescription *)$an_item fetchRequest];
			 ]"
		end

	objc_set_fetch_request_ (an_item: POINTER; a_fetch_request: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSFetchedPropertyDescription *)$an_item setFetchRequest:$a_fetch_request];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSFetchedPropertyDescription"
		end

end
