indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CURSOR_STRUCTURE_BYTE"

deferred external class
	CURSOR_STRUCTURE_BYTE

inherit
	CONTAINER_BYTE
	COLLECTION_BYTE
	BAG_BYTE
	ACTIVE_BYTE

feature -- Basic Operations

	go_to (p: CURSOR) is
		external
			"IL deferred signature (CURSOR): System.Void use CURSOR_STRUCTURE_BYTE"
		alias
			"go_to"
		end

	cursor: CURSOR is
		external
			"IL deferred signature (): CURSOR use CURSOR_STRUCTURE_BYTE"
		alias
			"cursor"
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		external
			"IL deferred signature (CURSOR): System.Boolean use CURSOR_STRUCTURE_BYTE"
		alias
			"valid_cursor"
		end

end -- class CURSOR_STRUCTURE_BYTE
