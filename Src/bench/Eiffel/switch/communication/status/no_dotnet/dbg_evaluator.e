indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EVALUATOR

inherit
	SHARED_APPLICATION_EXECUTION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
		end

feature

	init is
		do
		end

feature -- Access

	dotnet_metamorphose_basic_to_ref (dmp: DUMP_VALUE): DUMP_VALUE is
			-- Metamorphose basic type into corresponding _REF type
		do
		end

	dotnet_evaluate_once_function (f: E_FEATURE): DUMP_VALUE is
			-- Evaluation of once function
		do
		end

	dotnet_evaluate_function (addr: STRING; dvalue: DUMP_VALUE; f: FEATURE_I; ctype: CLASS_TYPE; a_params: ARRAY [DUMP_VALUE]): DUMP_VALUE is
		require
			is_dotnet: application.is_dotnet
		do
		end

end -- class DBG_EVALUATOR
