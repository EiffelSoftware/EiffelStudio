indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ArgIterator"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	ARG_ITERATOR

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals
		end

feature -- Initialization

	frozen make_arg_iterator (arglist: RUNTIME_ARGUMENT_HANDLE) is
		external
			"IL creator signature (System.RuntimeArgumentHandle) use System.ArgIterator"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ArgIterator"
		alias
			"GetHashCode"
		end

	frozen get_remaining_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.ArgIterator"
		alias
			"GetRemainingCount"
		end

	frozen end_ is
		external
			"IL signature (): System.Void use System.ArgIterator"
		alias
			"End"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ArgIterator"
		alias
			"Equals"
		end

	frozen get_next_arg_type: RUNTIME_TYPE_HANDLE is
		external
			"IL signature (): System.RuntimeTypeHandle use System.ArgIterator"
		alias
			"GetNextArgType"
		end

end -- class ARG_ITERATOR
