indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.CheckoutException"

external class
	SYSTEM_COMPONENTMODEL_DESIGN_CHECKOUTEXCEPTION

inherit
	SYSTEM_RUNTIME_INTEROPSERVICES_EXTERNALEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_checkoutexception_2,
	make_checkoutexception_1,
	make_checkoutexception

feature {NONE} -- Initialization

	frozen make_checkoutexception_2 (message: STRING; error_code: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.ComponentModel.Design.CheckoutException"
		end

	frozen make_checkoutexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.Design.CheckoutException"
		end

	frozen make_checkoutexception is
		external
			"IL creator use System.ComponentModel.Design.CheckoutException"
		end

feature -- Access

	frozen canceled: SYSTEM_COMPONENTMODEL_DESIGN_CHECKOUTEXCEPTION is
		external
			"IL static_field signature :System.ComponentModel.Design.CheckoutException use System.ComponentModel.Design.CheckoutException"
		alias
			"Canceled"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_CHECKOUTEXCEPTION
