indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CURSOR_STRUCTURE_SINGLE"

deferred external class
	CURSOR_STRUCTURE_SINGLE

inherit
	CONTAINER_SINGLE
	COLLECTION_SINGLE
	ACTIVE_SINGLE
	BAG_SINGLE

feature -- Basic Operations

	go_to (p: CURSOR) is
		external
			"IL deferred signature (CURSOR): System.Void use CURSOR_STRUCTURE_SINGLE"
		alias
			"go_to"
		end

	cursor: CURSOR is
		external
			"IL deferred signature (): CURSOR use CURSOR_STRUCTURE_SINGLE"
		alias
			"cursor"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL deferred signature (CURSOR): System.Boolean use CURSOR_STRUCTURE_SINGLE"
		alias
			"valid_cursor"
		end

end -- class CURSOR_STRUCTURE_SINGLE
