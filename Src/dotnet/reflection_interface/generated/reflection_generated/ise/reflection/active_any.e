indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ACTIVE_ANY"

deferred external class
	ACTIVE_ANY

inherit
	BAG_ANY
	COLLECTION_ANY
	CONTAINER_ANY

feature -- Basic Operations

	replace (v: ANY) is
		external
			"IL deferred signature (ANY): System.Void use ACTIVE_ANY"
		alias
			"replace"
		end

	item: ANY is
		external
			"IL deferred signature (): ANY use ACTIVE_ANY"
		alias
			"item"
		end

	readable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ACTIVE_ANY"
		alias
			"readable"
		end

	writable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ACTIVE_ANY"
		alias
			"writable"
		end

	remove is
		external
			"IL deferred signature (): System.Void use ACTIVE_ANY"
		alias
			"remove"
		end

end -- class ACTIVE_ANY
