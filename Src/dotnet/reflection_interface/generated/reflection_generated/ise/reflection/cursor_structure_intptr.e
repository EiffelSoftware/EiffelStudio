indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CURSOR_STRUCTURE_INTPTR"

deferred external class
	CURSOR_STRUCTURE_INTPTR

inherit
	BAG_INTPTR
	CONTAINER_INTPTR
	COLLECTION_INTPTR
	ACTIVE_INTPTR

feature -- Basic Operations

	go_to (p: CURSOR) is
		external
			"IL deferred signature (CURSOR): System.Void use CURSOR_STRUCTURE_INTPTR"
		alias
			"go_to"
		end

	cursor: CURSOR is
		external
			"IL deferred signature (): CURSOR use CURSOR_STRUCTURE_INTPTR"
		alias
			"cursor"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL deferred signature (CURSOR): System.Boolean use CURSOR_STRUCTURE_INTPTR"
		alias
			"valid_cursor"
		end

end -- class CURSOR_STRUCTURE_INTPTR
