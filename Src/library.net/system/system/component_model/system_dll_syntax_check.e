indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.SyntaxCheck"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_SYNTAX_CHECK

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen check_rooted_path (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.ComponentModel.SyntaxCheck"
		alias
			"CheckRootedPath"
		end

	frozen check_path (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.ComponentModel.SyntaxCheck"
		alias
			"CheckPath"
		end

	frozen check_machine_name (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.ComponentModel.SyntaxCheck"
		alias
			"CheckMachineName"
		end

end -- class SYSTEM_DLL_SYNTAX_CHECK
