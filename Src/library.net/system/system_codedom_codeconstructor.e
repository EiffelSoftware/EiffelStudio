indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeConstructor"

external class
	SYSTEM_CODEDOM_CODECONSTRUCTOR

inherit
	SYSTEM_CODEDOM_CODEMEMBERMETHOD

create
	make_codeconstructor

feature {NONE} -- Initialization

	frozen make_codeconstructor is
		external
			"IL creator use System.CodeDom.CodeConstructor"
		end

feature -- Access

	frozen get_base_constructor_args: SYSTEM_CODEDOM_CODEEXPRESSIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeExpressionCollection use System.CodeDom.CodeConstructor"
		alias
			"get_BaseConstructorArgs"
		end

	frozen get_chained_constructor_args: SYSTEM_CODEDOM_CODEEXPRESSIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeExpressionCollection use System.CodeDom.CodeConstructor"
		alias
			"get_ChainedConstructorArgs"
		end

end -- class SYSTEM_CODEDOM_CODECONSTRUCTOR
