indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CURSOR_STRUCTURE_BOOLEAN"

deferred external class
	CURSOR_STRUCTURE_BOOLEAN

inherit
	CONTAINER_BOOLEAN
	BAG_BOOLEAN
	ACTIVE_BOOLEAN
	COLLECTION_BOOLEAN

feature -- Basic Operations

	go_to (p: CURSOR) is
		external
			"IL deferred signature (CURSOR): System.Void use CURSOR_STRUCTURE_BOOLEAN"
		alias
			"go_to"
		end

	cursor: CURSOR is
		external
			"IL deferred signature (): CURSOR use CURSOR_STRUCTURE_BOOLEAN"
		alias
			"cursor"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL deferred signature (CURSOR): System.Boolean use CURSOR_STRUCTURE_BOOLEAN"
		alias
			"valid_cursor"
		end

end -- class CURSOR_STRUCTURE_BOOLEAN
