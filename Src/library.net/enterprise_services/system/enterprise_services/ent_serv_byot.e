indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.BYOT"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_BYOT

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen create_with_transaction (transaction: SYSTEM_OBJECT; t: TYPE): SYSTEM_OBJECT is
		external
			"IL static signature (System.Object, System.Type): System.Object use System.EnterpriseServices.BYOT"
		alias
			"CreateWithTransaction"
		end

	frozen create_with_tip_transaction (url: SYSTEM_STRING; t: TYPE): SYSTEM_OBJECT is
		external
			"IL static signature (System.String, System.Type): System.Object use System.EnterpriseServices.BYOT"
		alias
			"CreateWithTipTransaction"
		end

end -- class ENT_SERV_BYOT
