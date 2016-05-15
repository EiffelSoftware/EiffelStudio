note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_INVOCATION_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSInvocation

	invocation_with_method_signature_ (a_sig: detachable NS_METHOD_SIGNATURE): detachable NS_INVOCATION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_sig__item: POINTER
		do
			if attached a_sig as a_sig_attached then
				a_sig__item := a_sig_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_invocation_with_method_signature_ (l_objc_class.item, a_sig__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like invocation_with_method_signature_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like invocation_with_method_signature_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSInvocation Externals

	objc_invocation_with_method_signature_ (a_class_object: POINTER; a_sig: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object invocationWithMethodSignature:$a_sig];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSInvocation"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
