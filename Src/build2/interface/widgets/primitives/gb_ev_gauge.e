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

feature {GB_XML_STORE} -- Output

	
	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			gauge: EV_GAUGE
		do
			gauge ?= new_instance_of (dynamic_type_from_string (class_name (first)))
			gauge.default_create
			if gauge.value /= first.value then
				add_element_containing_integer (element, Value_string, objects.first.value)
			end
			if gauge.step /= first.step then
				add_element_containing_integer (element, Step_string, objects.first.step)
			end
			if gauge.leap /= first.leap then
				add_element_containing_integer (element, Leap_string, objects.first.leap)
			end
				-- We always store the lower and upper values for the value range, as it is much easier to
				-- restore them if we know they are always together. We need them in pairs for the
				-- restoration anyway.
			if gauge.value_range.lower /= first.value_range.lower or gauge.value_range.upper /= first.value_range.upper then
				add_element_containing_integer (element, Lower_string, objects.first.value_range.lower)
				add_element_containing_integer (element, Upper_string, objects.first.value_range.upper)
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			element_info2: ELEMENT_INFORMATION
			interval: INTEGER_INTERVAL
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
				create interval.make (element_info2.data.to_integer, element_info.data.to_integer)
				first.value_range.adapt (interval)
				(objects @ 2).value_range.adapt (interval)
			end
			
			element_info := full_information @ (Value_string)
			if element_info /= Void then
				for_all_objects (agent {EV_GAUGE}.set_value (element_info.data.to_integer))
			end
			
			element_info := full_information @ (Step_string)
			if element_info /= Void then
				for_all_objects (agent {EV_GAUGE}.set_step (element_info.data.to_integer))
			end
			
			element_info := full_information @ (Leap_string)
			if element_info /= Void then
				for_all_objects (agent {EV_GAUGE}.set_leap (element_info.data.to_integer))
			end
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info, element_info2: ELEMENT_INFORMATION
			lower, upper: STRING
		do
			Result := ""
			full_information := get_unique_full_info (element)
			
			element_info := full_information @ (Upper_string)
			if element_info /= Void then
				element_info2 := full_information @ (Lower_string)
				check
					info_not_void: element_info2 /= Void
				end
				lower := element_info2.data
				upper := element_info.data
				Result := info.name + ".value_range.adapt(create {INTEGER_INTERVAL}.make (" + lower + ", " + upper + "))"
			end
			
			element_info := full_information @ (Value_string)
			if element_info /= Void then
				Result := Result + indent + info.name + ".set_value (" + element_info.data + ")"
			end
			element_info := full_information @ (Step_string)
			if element_info /= Void then
				Result := Result + indent + info.name + ".set_step (" + element_info.data + ")"
			end
			element_info := full_information @ (Leap_string)
			if element_info /= Void then
				Result := Result + indent + info.name + ".set_leap (" + element_info.data + ")"
			end
			Result := strip_leading_indent (Result)
		end

end -- class GB_EV_WINDOW