indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "TABLE_ANY_ANY"

deferred external class
	TABLE_ANY_ANY

inherit
	BAG_ANY
	COLLECTION_ANY
	CONTAINER_ANY

feature -- Basic Operations

	infix "@" (k: ANY): ANY is
		external
			"IL deferred signature (ANY): ANY use TABLE_ANY_ANY"
		alias
			"infix %"@%""
		end

	valid_key (k: ANY): BOOLEAN is
		external
			"IL deferred signature (ANY): System.Boolean use TABLE_ANY_ANY"
		alias
			"valid_key"
		end

	item (k: ANY): ANY is
		external
			"IL deferred signature (ANY): ANY use TABLE_ANY_ANY"
		alias
			"item"
		end

	put_any_any (v: ANY; k: ANY) is
		external
			"IL deferred signature (ANY, ANY): System.Void use TABLE_ANY_ANY"
		alias
			"put"
		end

end -- class TABLE_ANY_ANY
