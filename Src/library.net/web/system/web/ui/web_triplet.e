indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.Triplet"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_TRIPLET

inherit
	SYSTEM_OBJECT

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (x: SYSTEM_OBJECT; y: SYSTEM_OBJECT; z: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object, System.Object, System.Object) use System.Web.UI.Triplet"
		end

	frozen make is
		external
			"IL creator use System.Web.UI.Triplet"
		end

	frozen make_1 (x: SYSTEM_OBJECT; y: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object, System.Object) use System.Web.UI.Triplet"
		end

feature -- Access

	frozen third: SYSTEM_OBJECT is
		external
			"IL field signature :System.Object use System.Web.UI.Triplet"
		alias
			"Third"
		end

	frozen first: SYSTEM_OBJECT is
		external
			"IL field signature :System.Object use System.Web.UI.Triplet"
		alias
			"First"
		end

	frozen second: SYSTEM_OBJECT is
		external
			"IL field signature :System.Object use System.Web.UI.Triplet"
		alias
			"Second"
		end

end -- class WEB_TRIPLET
