indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "COUNTABLE_INT32"

deferred external class
	COUNTABLE_INT32

inherit
	BOX_INT32
	INFINITE_INT32
	CONTAINER_INT32

feature -- Basic Operations

	item (i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use COUNTABLE_INT32"
		alias
			"item"
		end

end -- class COUNTABLE_INT32
