indexing
	description: "Facade ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER

feature -- Access

	last_string_value_length: INTEGER is 0

	current_stack_icor_debug_frame: ICOR_DEBUG_FRAME

	string_value_from_string_class_value	(icd_red: ICOR_DEBUG_VALUE; icd_string_instance: ICOR_DEBUG_OBJECT_VALUE; min,max: INTEGER): STRING is
		do
		end

	string_value_from_system_string_class_value (icd_string_value: ICOR_DEBUG_STRING_VALUE; min, max: INTEGER): STRING is
		do
		end

	debug_output_value_from_object_value (
				a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; 
 				a_icd_obj: ICOR_DEBUG_OBJECT_VALUE; a_class_type: CLASS_TYPE;
				min, max: INTEGER): STRING is
		do
		end

 	generating_type_value_from_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; 
 				a_icd_obj: ICOR_DEBUG_OBJECT_VALUE; 
				a_class_type: CLASS_TYPE; a_feat: FEATURE_I): STRING is
		do
		end

	once_function_value (a_icd_frame: ICOR_DEBUG_FRAME; a_class_c: CLASS_C;
								a_feat: E_FEATURE): ICOR_DEBUG_VALUE is		
		do
		end
		
	last_once_failed,
	last_once_already_called,
	last_once_available: BOOLEAN is False;
	

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

end
