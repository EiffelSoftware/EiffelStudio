indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CURSOR_STRUCTURE_INT32"

deferred external class
	CURSOR_STRUCTURE_INT32

inherit
	ACTIVE_INT32
	BAG_INT32
	CONTAINER_INT32
	COLLECTION_INT32

feature -- Basic Operations

	go_to (p: CURSOR) is
		external
			"IL deferred signature (CURSOR): System.Void use CURSOR_STRUCTURE_INT32"
		alias
			"go_to"
		end

	cursor: CURSOR is
		external
			"IL deferred signature (): CURSOR use CURSOR_STRUCTURE_INT32"
		alias
			"cursor"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL deferred signature (CURSOR): System.Boolean use CURSOR_STRUCTURE_INT32"
		alias
			"valid_cursor"
		end

end -- class CURSOR_STRUCTURE_INT32
