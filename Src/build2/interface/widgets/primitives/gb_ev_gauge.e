indexing
	description: "Objects that manipulate objects of type EV_GAUGE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			set_up_user_events,
			has_user_events
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

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info2: ELEMENT_INFORMATION
			lower, upper: STRING
		do
			create Result.make (4)
			full_information := get_unique_full_info (element)
			
			if attribute_set (Upper_string) then
				element_info2 := full_information @ (Lower_string)
				check
					both_upper_and_lower_set: attribute_set (Lower_string)
				end
				if is_type_a_constant (lower_string) then
					if is_type_a_constant (upper_string) then
						Result.extend (integer_interval_constant_set_procedures_string + ".extend (agent (" + info.actual_name_for_feature_call + "value_range).adapt (?))")
						Result.extend (integer_interval_constant_retrieval_functions_string + ".extend (agent " + retrieve_integer_setting (lower_string) + ")")
						Result.extend (integer_interval_constant_retrieval_functions_string + ".extend (agent " + retrieve_integer_setting (upper_string) + ")")
					else	
						Result.extend (integer_interval_constant_set_procedures_string + ".extend (agent (" + info.actual_name_for_feature_call + "value_range).adapt (?))")
						Result.extend (integer_interval_constant_retrieval_functions_string + ".extend (agent " + retrieve_integer_setting (lower_string) + ")")
						Result.extend (integer_interval_constant_retrieval_functions_string + ".extend (agent " + "integer_from_integer (" + retrieve_integer_setting (upper_string) + "))")
					end
				else	
					if is_type_a_constant (upper_string) then
						Result.extend (integer_interval_constant_set_procedures_string + ".extend (agent (" + info.actual_name_for_feature_call + "value_range).adapt (?))")
						Result.extend (integer_interval_constant_retrieval_functions_string + ".extend (agent " + "integer_from_integer (" + retrieve_integer_setting (upper_string) + "))")
						Result.extend (integer_interval_constant_retrieval_functions_string + ".extend (agent " + retrieve_integer_setting (upper_string) + ")")
					else
						lower := retrieve_integer_setting (lower_string)
						upper := retrieve_integer_setting (upper_string)
						Result.extend (info.actual_name_for_feature_call + "value_range.adapt (create {INTEGER_INTERVAL}.make (" + lower + ", " + upper + "))")
					end
				end		
			end			
			
			if attribute_set (Value_string) then
				Result.append (build_set_code_for_integer (value_string, info.actual_name_for_feature_call, "set_value ("))
			end
			
			if attribute_set (Step_string) then
				Result.append (build_set_code_for_integer (step_string, info.actual_name_for_feature_call, "set_step ("))
			end
			if attribute_set (Leap_string) then
				Result.append (build_set_code_for_integer (leap_string, info.actual_name_for_feature_call, "set_leap ("))
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_EV_WINDOW
