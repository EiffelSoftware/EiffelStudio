indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.PropertyCollection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_PROPERTY_COLLECTION

inherit
	HASHTABLE
	IDICTIONARY
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	ISERIALIZABLE
	IDESERIALIZATION_CALLBACK
	ICLONEABLE

create
	make_data_property_collection

feature {NONE} -- Initialization

	frozen make_data_property_collection is
		external
			"IL creator use System.Data.PropertyCollection"
		end

end -- class DATA_PROPERTY_COLLECTION
