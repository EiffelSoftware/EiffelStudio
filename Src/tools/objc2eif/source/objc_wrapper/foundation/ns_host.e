note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_HOST

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

feature -- NSHost

	is_equal_to_host_ (a_host: detachable NS_HOST): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_host__item: POINTER
		do
			if attached a_host as a_host_attached then
				a_host__item := a_host_attached.item
			end
			Result := objc_is_equal_to_host_ (item, a_host__item)
		end

	name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	names: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_names (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like names} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like names} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	address: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_address (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like address} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like address} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	addresses: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_addresses (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like addresses} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like addresses} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	localized_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localized_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSHost Externals

	objc_is_equal_to_host_ (an_item: POINTER; a_host: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSHost *)$an_item isEqualToHost:$a_host];
			 ]"
		end

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHost *)$an_item name];
			 ]"
		end

	objc_names (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHost *)$an_item names];
			 ]"
		end

	objc_address (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHost *)$an_item address];
			 ]"
		end

	objc_addresses (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHost *)$an_item addresses];
			 ]"
		end

	objc_localized_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHost *)$an_item localizedName];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSHost"
		end

end
