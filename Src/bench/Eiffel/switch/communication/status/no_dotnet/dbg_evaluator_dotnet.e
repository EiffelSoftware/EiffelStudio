indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EVALUATOR_DOTNET

create
	make

feature {NONE} -- Initialization

	make is
		do
		end

feature

	init is
		do
		end

feature -- Access

	last_once_available: BOOLEAN is False
	last_once_failed: BOOLEAN is False
	evaluation_aborted: BOOLEAN is False
	error_occurred: BOOLEAN is False
	error_message: STRING is do end
	
	dotnet_metamorphose_basic_to_reference_value (dmp: DUMP_VALUE): DUMP_VALUE is
		do
		end

	dotnet_metamorphose_basic_to_value (dmp: DUMP_VALUE): DUMP_VALUE is
		do
		end

	dotnet_evaluate_once_function (addr: STRING;  dvalue: DUMP_VALUE; f: E_FEATURE; params: LIST [DUMP_VALUE]): DUMP_VALUE is
		do
		end
		
	dotnet_evaluate_static_function (f: FEATURE_I; ctype: CLASS_TYPE; a_params: ARRAY [DUMP_VALUE]): DUMP_VALUE is
		do
		end
		
	dotnet_evaluate_function (addr: STRING; dvalue: DUMP_VALUE; f: FEATURE_I; ctype: CLASS_TYPE; a_params: ARRAY [DUMP_VALUE]): DUMP_VALUE is
		do
		end

	dotnet_evaluate_function_with_name (addr: STRING; dvalue: DUMP_VALUE; a_feature_name, a_external_name: STRING; a_params: ARRAY [DUMP_VALUE]): DUMP_VALUE is
		do
		end

end 
