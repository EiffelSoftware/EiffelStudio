indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ACTIVE_DOUBLE"

deferred external class
	ACTIVE_DOUBLE

inherit
	BAG_DOUBLE
	COLLECTION_DOUBLE
	CONTAINER_DOUBLE

feature -- Basic Operations

	replace (v: DOUBLE) is
		external
			"IL deferred signature (System.Double): System.Void use ACTIVE_DOUBLE"
		alias
			"replace"
		end

	item: DOUBLE is
		external
			"IL deferred signature (): System.Double use ACTIVE_DOUBLE"
		alias
			"item"
		end

	readable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ACTIVE_DOUBLE"
		alias
			"readable"
		end

	writable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ACTIVE_DOUBLE"
		alias
			"writable"
		end

	remove is
		external
			"IL deferred signature (): System.Void use ACTIVE_DOUBLE"
		alias
			"remove"
		end

end -- class ACTIVE_DOUBLE
