indexing
	description: "Objects that manipulate objects of type EV_GAUGE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_GAUGE
	
	-- The following properties from EV_GAUGE are manipulated by `Current'.
	-- Step - Performed on the real object and the display_object.
	-- Value - Performed on the real object and the display_object.
	-- Leap - Performed on the real object and the display_object.

inherit
	
	GB_EV_ANY
		undefine
			attribute_editor,
			set_up_user_events
		redefine
			ev_type
		end
		
	GB_EV_GAUGE_EDITOR_CONSTRUCTOR
	
	DEFAULT_OBJECT_STATE_CHECKER
		undefine
			default_create
		end

feature {GB_XML_STORE} -- Output

	
	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			gauge: EV_GAUGE
		do
			gauge ?= default_object_by_type (class_name (first))
			
			if gauge.value /= first.value or uses_constant (Value_string) then
				add_integer_element (element, Value_string, objects.first.value)
			end
			if gauge.step /= first.step or uses_constant (Step_string) then
				add_integer_element (element, Step_string, objects.first.step)
			end
			if gauge.leap /= first.leap or uses_constant (Leap_string) then
				add_integer_element (element, Leap_string, objects.first.leap)
			end
				-- We always store the lower and upper values for the value range, as it is much easier to
				-- restore them if we know they are always together. We need them in pairs for the
				-- restoration anyway.
			if gauge.value_range.lower /= first.value_range.lower or gauge.value_range.upper /= first.value_range.upper
			or uses_constant (Lower_string) or uses_constant (Upper_string) then		
				add_integer_element (element, Lower_string, objects.first.value_range.lower)
				add_integer_element (element, Upper_string, objects.first.value_range.upper)
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info, element_info2: ELEMENT_INFORMATION
			interval: INTEGER_INTERVAL
			integer_constant: GB_INTEGER_CONSTANT
		do
			full_information := get_unique_full_info (element)
			
				-- We must set the upper and lower first as they affect the valid values that may
				-- be set.
			element_info := full_information @ (Upper_string)
			if element_info /= Void then
				element_info2 := full_information @ (Lower_string)
				check
					info_not_void: element_info2 /= Void
				end
				create interval.make (retrieve_and_set_integer_value (Lower_string), retrieve_and_set_integer_value (Upper_string))
				first.value_range.adapt (interval)
				(objects @ 2).value_range.adapt (interval)
			end

			if full_information @ Value_string /= Void then
				for_all_objects (agent {EV_GAUGE}.set_value (retrieve_and_set_integer_value (Value_string)))
			end
			if full_information @ Step_string /= Void then
				for_all_objects (agent {EV_GAUGE}.set_step (retrieve_and_set_integer_value (Step_string)))
			end
			if full_information @ Leap_string /= Void then
				for_all_objects (agent {EV_GAUGE}.set_leap (retrieve_and_set_integer_value (Leap_string)))
			end
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info, element_info2: ELEMENT_INFORMATION
			lower, upper: STRING
		do
			Result := ""
			full_information := get_unique_full_info (element)
			
			if attribute_set (Upper_string) then
				element_info2 := full_information @ (Lower_string)
				check
					both_upper_and_lower_set: attribute_set (Lower_string)
				end
				lower := retrieve_integer_setting (lower_string)
				upper := retrieve_integer_setting (upper_string)
				Result := info.name + ".value_range.adapt (create {INTEGER_INTERVAL}.make (" + lower + ", " + upper + "))"
			end
			
			if attribute_set (Value_string) then
				Result := Result + indent + info.name + ".set_value (" + retrieve_integer_setting (value_string) + ")"
			end
			
			if attribute_set (Step_string) then
				Result := Result + indent + info.name + ".set_step (" + retrieve_integer_setting (step_string) + ")"
			end
			if attribute_set (Leap_string) then
				Result := Result + indent + info.name + ".set_leap (" + retrieve_integer_setting (leap_string) + ")"
			end
			Result := strip_leading_indent (Result)
		end

end -- class GB_EV_WINDOW