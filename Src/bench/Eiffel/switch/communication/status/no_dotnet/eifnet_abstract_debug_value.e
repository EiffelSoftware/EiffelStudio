indexing
	description: "Abstract notion of value during the execution of the application in the dotnet world."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFNET_ABSTRACT_DEBUG_VALUE

inherit
	ABSTRACT_DEBUG_VALUE

--feature {NONE} -- Init
--
--	init_dotnet_data (a_referenced_value: like icd_referenced_value; a_prepared_value: like icd_value; f: like icd_frame) is
--
--		do
--		end

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
