indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.CheckoutException"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CHECKOUT_EXCEPTION

inherit
	EXTERNAL_EXCEPTION
	ISERIALIZABLE

create
	make_system_dll_checkout_exception,
	make_system_dll_checkout_exception_2,
	make_system_dll_checkout_exception_1

feature {NONE} -- Initialization

	frozen make_system_dll_checkout_exception is
		external
			"IL creator use System.ComponentModel.Design.CheckoutException"
		end

	frozen make_system_dll_checkout_exception_2 (message: SYSTEM_STRING; error_code: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.ComponentModel.Design.CheckoutException"
		end

	frozen make_system_dll_checkout_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.Design.CheckoutException"
		end

feature -- Access

	frozen canceled: SYSTEM_DLL_CHECKOUT_EXCEPTION is
		external
			"IL static_field signature :System.ComponentModel.Design.CheckoutException use System.ComponentModel.Design.CheckoutException"
		alias
			"Canceled"
		end

end -- class SYSTEM_DLL_CHECKOUT_EXCEPTION
