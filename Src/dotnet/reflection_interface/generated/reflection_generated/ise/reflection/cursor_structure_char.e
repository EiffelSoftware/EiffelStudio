indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CURSOR_STRUCTURE_CHAR"

deferred external class
	CURSOR_STRUCTURE_CHAR

inherit
	COLLECTION_CHAR
	BAG_CHAR
	ACTIVE_CHAR
	CONTAINER_CHAR

feature -- Basic Operations

	go_to (p: CURSOR) is
		external
			"IL deferred signature (CURSOR): System.Void use CURSOR_STRUCTURE_CHAR"
		alias
			"go_to"
		end

	cursor: CURSOR is
		external
			"IL deferred signature (): CURSOR use CURSOR_STRUCTURE_CHAR"
		alias
			"cursor"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL deferred signature (CURSOR): System.Boolean use CURSOR_STRUCTURE_CHAR"
		alias
			"valid_cursor"
		end

end -- class CURSOR_STRUCTURE_CHAR
