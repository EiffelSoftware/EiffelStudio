indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.Pair"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_PAIR

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.Pair"
		end

	frozen make_1 (x: SYSTEM_OBJECT; y: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object, System.Object) use System.Web.UI.Pair"
		end

feature -- Access

	frozen first: SYSTEM_OBJECT is
		external
			"IL field signature :System.Object use System.Web.UI.Pair"
		alias
			"First"
		end

	frozen second: SYSTEM_OBJECT is
		external
			"IL field signature :System.Object use System.Web.UI.Pair"
		alias
			"Second"
		end

end -- class WEB_PAIR
