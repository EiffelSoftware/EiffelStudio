indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.AxHost+State"

external class
	STATE_IN_SYSTEM_WINDOWS_FORMS_AXHOST

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make

feature {NONE} -- Initialization

	frozen make (ms: SYSTEM_IO_STREAM; storage_type: INTEGER; manual_update: BOOLEAN; lic_key: STRING) is
		external
			"IL creator signature (System.IO.Stream, System.Int32, System.Boolean, System.String) use System.Windows.Forms.AxHost+State"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.AxHost+State"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AxHost+State"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.AxHost+State"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (si: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Windows.Forms.AxHost+State"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost+State"
		alias
			"Finalize"
		end

end -- class STATE_IN_SYSTEM_WINDOWS_FORMS_AXHOST
