indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.PolicyStatementAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	POLICY_STATEMENT_ATTRIBUTE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen all_: POLICY_STATEMENT_ATTRIBUTE is
		external
			"IL enum signature :System.Security.Policy.PolicyStatementAttribute use System.Security.Policy.PolicyStatementAttribute"
		alias
			"3"
		end

	frozen level_final: POLICY_STATEMENT_ATTRIBUTE is
		external
			"IL enum signature :System.Security.Policy.PolicyStatementAttribute use System.Security.Policy.PolicyStatementAttribute"
		alias
			"2"
		end

	frozen nothing: POLICY_STATEMENT_ATTRIBUTE is
		external
			"IL enum signature :System.Security.Policy.PolicyStatementAttribute use System.Security.Policy.PolicyStatementAttribute"
		alias
			"0"
		end

	frozen exclusive: POLICY_STATEMENT_ATTRIBUTE is
		external
			"IL enum signature :System.Security.Policy.PolicyStatementAttribute use System.Security.Policy.PolicyStatementAttribute"
		alias
			"1"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class POLICY_STATEMENT_ATTRIBUTE
