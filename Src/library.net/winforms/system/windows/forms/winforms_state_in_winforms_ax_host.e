indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.AxHost+State"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_STATE_IN_WINFORMS_AX_HOST

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make

feature {NONE} -- Initialization

	frozen make (ms: SYSTEM_STREAM; storage_type: INTEGER; manual_update: BOOLEAN; lic_key: SYSTEM_STRING) is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AxHost+State"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.AxHost+State"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (si: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
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

end -- class WINFORMS_STATE_IN_WINFORMS_AX_HOST
