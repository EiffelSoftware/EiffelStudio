note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_ANIMATABLE_PROPERTY_CONTAINER_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

	animator: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_animator (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like animator} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like animator} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	animations: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_animations (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like animations} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like animations} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_animations_ (a_dict: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_dict__item: POINTER
		do
			if attached a_dict as a_dict_attached then
				a_dict__item := a_dict_attached.item
			end
			objc_set_animations_ (item, a_dict__item)
		end

	animation_for_key_ (a_key: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_animation_for_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like animation_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like animation_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Required Methods Externals

	objc_animator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSAnimatablePropertyContainer>)$an_item animator];
			 ]"
		end

	objc_animations (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSAnimatablePropertyContainer>)$an_item animations];
			 ]"
		end

	objc_set_animations_ (an_item: POINTER; a_dict: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSAnimatablePropertyContainer>)$an_item setAnimations:$a_dict];
			 ]"
		end

	objc_animation_for_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSAnimatablePropertyContainer>)$an_item animationForKey:$a_key];
			 ]"
		end

end
