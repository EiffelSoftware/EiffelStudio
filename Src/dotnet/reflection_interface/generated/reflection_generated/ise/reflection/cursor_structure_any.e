indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CURSOR_STRUCTURE_ANY"

deferred external class
	CURSOR_STRUCTURE_ANY

inherit
	BAG_ANY
	COLLECTION_ANY
	CONTAINER_ANY
	ACTIVE_ANY

feature -- Basic Operations

	go_to (p: CURSOR) is
		external
			"IL deferred signature (CURSOR): System.Void use CURSOR_STRUCTURE_ANY"
		alias
			"go_to"
		end

	cursor: CURSOR is
		external
			"IL deferred signature (): CURSOR use CURSOR_STRUCTURE_ANY"
		alias
			"cursor"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL deferred signature (CURSOR): System.Boolean use CURSOR_STRUCTURE_ANY"
		alias
			"valid_cursor"
		end

end -- class CURSOR_STRUCTURE_ANY
