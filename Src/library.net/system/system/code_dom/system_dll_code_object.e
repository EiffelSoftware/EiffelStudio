indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeObject"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_OBJECT

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.CodeDom.CodeObject"
		end

feature -- Access

	frozen get_user_data: IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.CodeDom.CodeObject"
		alias
			"get_UserData"
		end

end -- class SYSTEM_DLL_CODE_OBJECT
