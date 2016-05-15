note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TIMER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_fire_date__interval__target__selector__user_info__repeats_,
	make

feature {NONE} -- Initialization

	make_with_fire_date__interval__target__selector__user_info__repeats_ (a_date: detachable NS_DATE; a_ti: REAL_64; a_t: detachable NS_OBJECT; a_s: detachable OBJC_SELECTOR; a_ui: detachable NS_OBJECT; a_rep: BOOLEAN)
			-- Initialize `Current'.
		local
			a_date__item: POINTER
			a_t__item: POINTER
			a_s__item: POINTER
			a_ui__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			if attached a_t as a_t_attached then
				a_t__item := a_t_attached.item
			end
			if attached a_s as a_s_attached then
				a_s__item := a_s_attached.item
			end
			if attached a_ui as a_ui_attached then
				a_ui__item := a_ui_attached.item
			end
			make_with_pointer (objc_init_with_fire_date__interval__target__selector__user_info__repeats_(allocate_object, a_date__item, a_ti, a_t__item, a_s__item, a_ui__item, a_rep))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSTimer Externals

	objc_init_with_fire_date__interval__target__selector__user_info__repeats_ (an_item: POINTER; a_date: POINTER; a_ti: REAL_64; a_t: POINTER; a_s: POINTER; a_ui: POINTER; a_rep: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTimer *)$an_item initWithFireDate:$a_date interval:$a_ti target:$a_t selector:$a_s userInfo:$a_ui repeats:$a_rep];
			 ]"
		end

	objc_fire (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSTimer *)$an_item fire];
			 ]"
		end

	objc_fire_date (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTimer *)$an_item fireDate];
			 ]"
		end

	objc_set_fire_date_ (an_item: POINTER; a_date: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSTimer *)$an_item setFireDate:$a_date];
			 ]"
		end

	objc_time_interval (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTimer *)$an_item timeInterval];
			 ]"
		end

	objc_invalidate (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSTimer *)$an_item invalidate];
			 ]"
		end

	objc_is_valid (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTimer *)$an_item isValid];
			 ]"
		end

	objc_user_info (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTimer *)$an_item userInfo];
			 ]"
		end

feature -- NSTimer

	fire
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_fire (item)
		end

	fire_date: detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_fire_date (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like fire_date} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like fire_date} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_fire_date_ (a_date: detachable NS_DATE)
			-- Auto generated Objective-C wrapper.
		local
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			objc_set_fire_date_ (item, a_date__item)
		end

	time_interval: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_time_interval (item)
		end

	invalidate
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_invalidate (item)
		end

	is_valid: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_valid (item)
		end

	user_info: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_user_info (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like user_info} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like user_info} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTimer"
		end

end
