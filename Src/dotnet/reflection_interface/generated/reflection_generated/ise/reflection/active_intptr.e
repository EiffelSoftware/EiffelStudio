indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ACTIVE_INTPTR"

deferred external class
	ACTIVE_INTPTR

inherit
	BAG_INTPTR
	CONTAINER_INTPTR
	COLLECTION_INTPTR

feature -- Basic Operations

	replace (v: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use ACTIVE_INTPTR"
		alias
			"replace"
		end

	item: POINTER is
		external
			"IL deferred signature (): System.IntPtr use ACTIVE_INTPTR"
		alias
			"item"
		end

	readable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ACTIVE_INTPTR"
		alias
			"readable"
		end

	writable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ACTIVE_INTPTR"
		alias
			"writable"
		end

	remove is
		external
			"IL deferred signature (): System.Void use ACTIVE_INTPTR"
		alias
			"remove"
		end

end -- class ACTIVE_INTPTR
