indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.Interlocked"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	INTERLOCKED

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen exchange_int32 (location1: INTEGER; value: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32&, System.Int32): System.Int32 use System.Threading.Interlocked"
		alias
			"Exchange"
		end

	frozen decrement (location: INTEGER_64): INTEGER_64 is
		external
			"IL static signature (System.Int64&): System.Int64 use System.Threading.Interlocked"
		alias
			"Decrement"
		end

	frozen compare_exchange_int32 (location1: INTEGER; value: INTEGER; comparand: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32&, System.Int32, System.Int32): System.Int32 use System.Threading.Interlocked"
		alias
			"CompareExchange"
		end

	frozen compare_exchange_single (location1: REAL; value: REAL; comparand: REAL): REAL is
		external
			"IL static signature (System.Single&, System.Single, System.Single): System.Single use System.Threading.Interlocked"
		alias
			"CompareExchange"
		end

	frozen exchange (location1: SYSTEM_OBJECT; value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL static signature (System.Object&, System.Object): System.Object use System.Threading.Interlocked"
		alias
			"Exchange"
		end

	frozen increment (location: INTEGER_64): INTEGER_64 is
		external
			"IL static signature (System.Int64&): System.Int64 use System.Threading.Interlocked"
		alias
			"Increment"
		end

	frozen exchange_single (location1: REAL; value: REAL): REAL is
		external
			"IL static signature (System.Single&, System.Single): System.Single use System.Threading.Interlocked"
		alias
			"Exchange"
		end

	frozen decrement_int32 (location: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32&): System.Int32 use System.Threading.Interlocked"
		alias
			"Decrement"
		end

	frozen increment_int32 (location: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32&): System.Int32 use System.Threading.Interlocked"
		alias
			"Increment"
		end

	frozen compare_exchange (location1: SYSTEM_OBJECT; value: SYSTEM_OBJECT; comparand: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL static signature (System.Object&, System.Object, System.Object): System.Object use System.Threading.Interlocked"
		alias
			"CompareExchange"
		end

end -- class INTERLOCKED
