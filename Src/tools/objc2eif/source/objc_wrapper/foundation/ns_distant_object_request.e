note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DISTANT_OBJECT_REQUEST

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

feature -- NSDistantObjectRequest

	invocation: detachable NS_INVOCATION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_invocation (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like invocation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like invocation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	connection: detachable NS_CONNECTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_connection (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like connection} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like connection} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	conversation: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_conversation (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like conversation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like conversation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	reply_with_exception_ (a_exception: detachable NS_EXCEPTION)
			-- Auto generated Objective-C wrapper.
		local
			a_exception__item: POINTER
		do
			if attached a_exception as a_exception_attached then
				a_exception__item := a_exception_attached.item
			end
			objc_reply_with_exception_ (item, a_exception__item)
		end

feature {NONE} -- NSDistantObjectRequest Externals

	objc_invocation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDistantObjectRequest *)$an_item invocation];
			 ]"
		end

	objc_connection (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDistantObjectRequest *)$an_item connection];
			 ]"
		end

	objc_conversation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDistantObjectRequest *)$an_item conversation];
			 ]"
		end

	objc_reply_with_exception_ (an_item: POINTER; a_exception: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDistantObjectRequest *)$an_item replyWithException:$a_exception];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDistantObjectRequest"
		end

end
