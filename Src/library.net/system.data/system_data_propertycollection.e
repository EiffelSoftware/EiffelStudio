indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.PropertyCollection"

external class
	SYSTEM_DATA_PROPERTYCOLLECTION

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
	SYSTEM_COLLECTIONS_HASHTABLE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_IDICTIONARY
		rename
			get_enumerator as ienumerable_get_enumerator
		end

create
	make_propertycollection

feature {NONE} -- Initialization

	frozen make_propertycollection is
		external
			"IL creator use System.Data.PropertyCollection"
		end

end -- class SYSTEM_DATA_PROPERTYCOLLECTION
