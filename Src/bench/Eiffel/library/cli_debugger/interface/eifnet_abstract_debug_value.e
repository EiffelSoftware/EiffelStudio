indexing
	description: "Abstract notion of value during the execution of the application in the dotnet world."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFNET_ABSTRACT_DEBUG_VALUE

inherit
	ABSTRACT_DEBUG_VALUE

	DEBUG_VALUE_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end

	ICOR_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end	
		
	EIFNET_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end			

	SHARED_EIFNET_DEBUG_VALUE_FACTORY
		export
			{NONE} all
		undefine
			is_equal			
		end		

	SHARED_EIFNET_DEBUG_VALUE_FORMATTER		
		export
			{NONE} all
		undefine
			is_equal
		end	

	SHARED_IL_DEBUG_INFO_RECORDER
		export
			{NONE} all
		undefine
			is_equal			
		end	

feature {NONE} -- Init

	init_dotnet_data (a_referenced_value: like icd_referenced_value; a_prepared_value: like icd_value; f: like icd_frame) is

		do
			icd_referenced_value := a_referenced_value
			icd_value := a_prepared_value
			icd_frame := f
			create icd_value_info.make_from_prepared_value (icd_value, a_prepared_value)
		end

feature -- Properties

	icd_frame: ICOR_DEBUG_FRAME


	icd_referenced_value: ICOR_DEBUG_VALUE
			-- Original ICorDebugValue from Debugger
			-- not dereferenced !
			-- may be useful to ICorDebugEval::CallFunction ...
			
	icd_value: ICOR_DEBUG_VALUE
			-- Value of object.
			-- unreferenced, unboxed ...

	icd_value_info: EIFNET_DEBUG_VALUE_INFO
			-- Value info of object.
	
end
