indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EVALUATOR_DOTNET
	
inherit
	
	DBG_EVALUATOR_IMP

create
	make

feature -- Access

	last_once_available: BOOLEAN is False
	last_once_failed: BOOLEAN is False
	
--	dotnet_metamorphose_basic_to_reference_value (dmp: DUMP_VALUE): DUMP_VALUE is
--		do
--		end
--
--	dotnet_metamorphose_basic_to_value (dmp: DUMP_VALUE): DUMP_VALUE is
--		do
--		end
--
--	dotnet_evaluate_once_function (addr: STRING;  dvalue: DUMP_VALUE; f: E_FEATURE; params: LIST [DUMP_VALUE]): DUMP_VALUE is
--		do
--		end
--		
--	dotnet_evaluate_static_function (f: FEATURE_I; ctype: CLASS_TYPE; a_params: ARRAY [DUMP_VALUE]): DUMP_VALUE is
--		do
--		end
--		
--	dotnet_evaluate_function (addr: STRING; dvalue: DUMP_VALUE; f: FEATURE_I; ctype: CLASS_TYPE; a_params: ARRAY [DUMP_VALUE]): DUMP_VALUE is
--		do
--		end
--
--	dotnet_evaluate_function_with_name (addr: STRING; dvalue: DUMP_VALUE; a_feature_name, a_external_name: STRING; a_params: ARRAY [DUMP_VALUE]): DUMP_VALUE is
--		do
--		end

	effective_evaluate_function (a_addr: STRING; a_target: DUMP_VALUE; f, realf: E_FEATURE; ctype: CLASS_TYPE; params: LIST [DUMP_VALUE]) is
		do
		end
	effective_evaluate_once (a_addr: STRING; a_target: DUMP_VALUE; f: E_FEATURE; params: LIST [DUMP_VALUE]) is		
		do
		end
		
	parameters_push (dmp: DUMP_VALUE) is
			-- (export status {DBG_EVALUATOR})
		do
		end
	parameters_push_and_metamorphose (dmp: DUMP_VALUE) is		
		do
		end

	associated_reference_basic_class_type (cl: CLASS_C): CLASS_TYPE is
			-- Associated _REF classtype for type `cl'
			-- (export status {DBG_EVALUATOR})
		do
		end
		
	dump_value_at_address (addr: STRING): DUMP_VALUE is		
		do
		end
		
	current_object_from_callstack (cse: EIFFEL_CALL_STACK_ELEMENT): DUMP_VALUE is		
		do
		end
		
end 
