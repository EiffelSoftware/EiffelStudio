indexing
	description: "Facade ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER

feature -- Access

	last_string_value_length: INTEGER

	string_value_from_string_class_object_value	(icd_string_instance: ICOR_DEBUG_OBJECT_VALUE; min,max: INTEGER): STRING is
		do
		end

	debug_output_value_from_object_value (
				a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; 
 				a_icd_obj: ICOR_DEBUG_OBJECT_VALUE; a_class_type: CLASS_TYPE;
				min, max: INTEGER): STRING is
		do
		end

end
