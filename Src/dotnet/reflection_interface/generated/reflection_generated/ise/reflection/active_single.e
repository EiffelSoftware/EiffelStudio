indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ACTIVE_SINGLE"

deferred external class
	ACTIVE_SINGLE

inherit
	CONTAINER_SINGLE
	COLLECTION_SINGLE
	BAG_SINGLE

feature -- Basic Operations

	replace (v: REAL) is
		external
			"IL deferred signature (System.Single): System.Void use ACTIVE_SINGLE"
		alias
			"replace"
		end

	item: REAL is
		external
			"IL deferred signature (): System.Single use ACTIVE_SINGLE"
		alias
			"item"
		end

	readable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ACTIVE_SINGLE"
		alias
			"readable"
		end

	writable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ACTIVE_SINGLE"
		alias
			"writable"
		end

	remove is
		external
			"IL deferred signature (): System.Void use ACTIVE_SINGLE"
		alias
			"remove"
		end

end -- class ACTIVE_SINGLE
