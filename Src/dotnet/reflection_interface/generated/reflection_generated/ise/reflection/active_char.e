indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ACTIVE_CHAR"

deferred external class
	ACTIVE_CHAR

inherit
	COLLECTION_CHAR
	BAG_CHAR
	CONTAINER_CHAR

feature -- Basic Operations

	replace (v: CHARACTER) is
		external
			"IL deferred signature (System.Char): System.Void use ACTIVE_CHAR"
		alias
			"replace"
		end

	item: CHARACTER is
		external
			"IL deferred signature (): System.Char use ACTIVE_CHAR"
		alias
			"item"
		end

	readable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ACTIVE_CHAR"
		alias
			"readable"
		end

	writable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ACTIVE_CHAR"
		alias
			"writable"
		end

	remove is
		external
			"IL deferred signature (): System.Void use ACTIVE_CHAR"
		alias
			"remove"
		end

end -- class ACTIVE_CHAR
