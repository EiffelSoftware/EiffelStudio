indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CURSOR_STRUCTURE_DOUBLE"

deferred external class
	CURSOR_STRUCTURE_DOUBLE

inherit
	BAG_DOUBLE
	COLLECTION_DOUBLE
	ACTIVE_DOUBLE
	CONTAINER_DOUBLE

feature -- Basic Operations

	go_to (p: CURSOR) is
		external
			"IL deferred signature (CURSOR): System.Void use CURSOR_STRUCTURE_DOUBLE"
		alias
			"go_to"
		end

	cursor: CURSOR is
		external
			"IL deferred signature (): CURSOR use CURSOR_STRUCTURE_DOUBLE"
		alias
			"cursor"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL deferred signature (CURSOR): System.Boolean use CURSOR_STRUCTURE_DOUBLE"
		alias
			"valid_cursor"
		end

end -- class CURSOR_STRUCTURE_DOUBLE
