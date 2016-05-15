note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RULER_VIEW_UTILS

inherit
	NS_VIEW_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSRulerView

	register_unit_with_name__abbreviation__unit_to_points_conversion_factor__step_up_cycle__step_down_cycle_ (a_unit_name: detachable NS_STRING; a_abbreviation: detachable NS_STRING; a_conversion_factor: REAL_64; a_step_up_cycle: detachable NS_ARRAY; a_step_down_cycle: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_unit_name__item: POINTER
			a_abbreviation__item: POINTER
			a_step_up_cycle__item: POINTER
			a_step_down_cycle__item: POINTER
		do
			if attached a_unit_name as a_unit_name_attached then
				a_unit_name__item := a_unit_name_attached.item
			end
			if attached a_abbreviation as a_abbreviation_attached then
				a_abbreviation__item := a_abbreviation_attached.item
			end
			if attached a_step_up_cycle as a_step_up_cycle_attached then
				a_step_up_cycle__item := a_step_up_cycle_attached.item
			end
			if attached a_step_down_cycle as a_step_down_cycle_attached then
				a_step_down_cycle__item := a_step_down_cycle_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_register_unit_with_name__abbreviation__unit_to_points_conversion_factor__step_up_cycle__step_down_cycle_ (l_objc_class.item, a_unit_name__item, a_abbreviation__item, a_conversion_factor, a_step_up_cycle__item, a_step_down_cycle__item)
		end

feature {NONE} -- NSRulerView Externals

	objc_register_unit_with_name__abbreviation__unit_to_points_conversion_factor__step_up_cycle__step_down_cycle_ (a_class_object: POINTER; a_unit_name: POINTER; a_abbreviation: POINTER; a_conversion_factor: REAL_64; a_step_up_cycle: POINTER; a_step_down_cycle: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object registerUnitWithName:$a_unit_name abbreviation:$a_abbreviation unitToPointsConversionFactor:$a_conversion_factor stepUpCycle:$a_step_up_cycle stepDownCycle:$a_step_down_cycle];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSRulerView"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
