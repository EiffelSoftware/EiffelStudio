indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.CurrencyWrapper"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	CURRENCY_WRAPPER

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (obj: DECIMAL) is
		external
			"IL creator signature (System.Decimal) use System.Runtime.InteropServices.CurrencyWrapper"
		end

	frozen make_1 (obj: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object) use System.Runtime.InteropServices.CurrencyWrapper"
		end

feature -- Access

	frozen get_wrapped_object: DECIMAL is
		external
			"IL signature (): System.Decimal use System.Runtime.InteropServices.CurrencyWrapper"
		alias
			"get_WrappedObject"
		end

end -- class CURRENCY_WRAPPER
