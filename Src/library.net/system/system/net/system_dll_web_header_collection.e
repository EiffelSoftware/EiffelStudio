indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.WebHeaderCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_WEB_HEADER_COLLECTION

inherit
	SYSTEM_DLL_NAME_VALUE_COLLECTION
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
	ICOLLECTION
		rename
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			copy_to as system_collections_icollection_copy_to
		end
	IENUMERABLE
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end
	IDESERIALIZATION_CALLBACK

create
	make_system_dll_web_header_collection

feature {NONE} -- Initialization

	frozen make_system_dll_web_header_collection is
		external
			"IL creator use System.Net.WebHeaderCollection"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.WebHeaderCollection"
		alias
			"ToString"
		end

	frozen to_byte_array: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Net.WebHeaderCollection"
		alias
			"ToByteArray"
		end

	frozen add_string2 (header: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebHeaderCollection"
		alias
			"Add"
		end

	on_deserialization (sender: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Net.WebHeaderCollection"
		alias
			"OnDeserialization"
		end

	get_values (header: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (System.String): System.String[] use System.Net.WebHeaderCollection"
		alias
			"GetValues"
		end

	remove (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebHeaderCollection"
		alias
			"Remove"
		end

	frozen is_restricted (header_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Net.WebHeaderCollection"
		alias
			"IsRestricted"
		end

	add_string (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Net.WebHeaderCollection"
		alias
			"Add"
		end

	set (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Net.WebHeaderCollection"
		alias
			"Set"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (serialization_info: SERIALIZATION_INFO; streaming_context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.WebHeaderCollection"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	frozen add_without_validate (header_name: SYSTEM_STRING; header_value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Net.WebHeaderCollection"
		alias
			"AddWithoutValidate"
		end

end -- class SYSTEM_DLL_WEB_HEADER_COLLECTION
