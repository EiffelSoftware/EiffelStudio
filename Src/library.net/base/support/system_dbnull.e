indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DBNull"

frozen external class
	SYSTEM_DBNULL

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create {NONE}

feature -- Access

	frozen value: SYSTEM_DBNULL is
		external
			"IL static_field signature :System.DBNull use System.DBNull"
		alias
			"Value"
		end

feature -- Basic Operations

	frozen get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.DBNull"
		alias
			"GetObjectData"
		end

	frozen to_string_iformat_provider (provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.DBNull"
		alias
			"ToString"
		end

	to_string: STRING is
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

	frozen get_type_code: SYSTEM_TYPECODE is
		external
			"IL signature (): System.TypeCode use System.DBNull"
		alias
			"GetTypeCode"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_DBNULL
