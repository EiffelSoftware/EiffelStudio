indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.ArgIterator"

frozen expanded external class
	SYSTEM_ARGITERATOR

inherit
	SYSTEM_VALUETYPE
		redefine
			get_hash_code,
			is_equal
		end



feature {NONE} -- Initialization

	frozen make_argiterator (arglist: SYSTEM_RUNTIMEARGUMENTHANDLE) is
		external
			"IL creator signature (System.RuntimeArgumentHandle) use System.ArgIterator"
		end

feature -- Basic Operations

	frozen end_ is
		external
			"IL signature (): System.Void use System.ArgIterator"
		alias
			"End"
		end

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ArgIterator"
		alias
			"Equals"
		end

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

	frozen get_next_arg_type: SYSTEM_RUNTIMETYPEHANDLE is
		external
			"IL signature (): System.RuntimeTypeHandle use System.ArgIterator"
		alias
			"GetNextArgType"
		end

end -- class SYSTEM_ARGITERATOR
