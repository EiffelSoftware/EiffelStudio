indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.WebHeaderCollection"

external class
	SYSTEM_NET_WEBHEADERCOLLECTION

inherit
	SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		redefine
			system_runtime_serialization_iserializable_get_object_data,
			remove,
			set,
			get_values,
			add_string,
			on_deserialization,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end
	SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root,
			copy_to as icollection_copy_to
		end

create
	make_webheadercollection

feature {NONE} -- Initialization

	frozen make_webheadercollection is
		external
			"IL creator use System.Net.WebHeaderCollection"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Net.WebHeaderCollection"
		alias
			"ToString"
		end

	frozen to_byte_array: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Net.WebHeaderCollection"
		alias
			"ToByteArray"
		end

	frozen add_string2 (header: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebHeaderCollection"
		alias
			"Add"
		end

	on_deserialization (sender: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Net.WebHeaderCollection"
		alias
			"OnDeserialization"
		end

	get_values (header: STRING): ARRAY [STRING] is
		external
			"IL signature (System.String): System.String[] use System.Net.WebHeaderCollection"
		alias
			"GetValues"
		end

	remove (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebHeaderCollection"
		alias
			"Remove"
		end

	frozen is_restricted (header_name: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Net.WebHeaderCollection"
		alias
			"IsRestricted"
		end

	add_string (name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Net.WebHeaderCollection"
		alias
			"Add"
		end

	set (name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Net.WebHeaderCollection"
		alias
			"Set"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (serialization_info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; streaming_context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.WebHeaderCollection"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	frozen add_without_validate (header_name: STRING; header_value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Net.WebHeaderCollection"
		alias
			"AddWithoutValidate"
		end

end -- class SYSTEM_NET_WEBHEADERCOLLECTION
