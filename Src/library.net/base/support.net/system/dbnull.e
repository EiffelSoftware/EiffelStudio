indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DBNull"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DBNULL

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISERIALIZABLE

create {NONE}

feature -- Access

	frozen value: DBNULL is
		external
			"IL static_field signature :System.DBNull use System.DBNull"
		alias
			"Value"
		end

feature -- Basic Operations

	frozen get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.DBNull"
		alias
			"GetObjectData"
		end

	frozen to_string_iformat_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.DBNull"
		alias
			"ToString"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.DBNull"
		alias
			"ToString"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.DBNull"
		alias
			"GetHashCode"
		end

	frozen get_type_code: TYPE_CODE is
		external
			"IL signature (): System.TypeCode use System.DBNull"
		alias
			"GetTypeCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.DBNull"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.DBNull"
		alias
			"Finalize"
		end

end -- class DBNULL
