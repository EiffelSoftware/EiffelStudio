indexing
	description: "Facade ..."
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
		

end
