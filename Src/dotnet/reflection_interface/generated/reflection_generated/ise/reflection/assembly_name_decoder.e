indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ASSEMBLY_NAME_DECODER"

deferred external class
	ASSEMBLY_NAME_DECODER

feature -- Basic Operations

	empty_string: STRING is
		external
			"IL deferred signature (): STRING use ASSEMBLY_NAME_DECODER"
		alias
			"empty_string"
		end

	assembly_info_from_name (an_assembly_name: ASSEMBLY_NAME): ARRAY_ANY is
		external
			"IL deferred signature (System.Reflection.AssemblyName): ARRAY_ANY use ASSEMBLY_NAME_DECODER"
		alias
			"assembly_info_from_name"
		end

	decode_key (a_key: NATIVE_ARRAY [INTEGER_8]): STRING is
		external
			"IL deferred signature (System.Byte[]): STRING use ASSEMBLY_NAME_DECODER"
		alias
			"decode_key"
		end

	neutral_culture: STRING is
		external
			"IL deferred signature (): STRING use ASSEMBLY_NAME_DECODER"
		alias
			"neutral_culture"
		end

end -- class ASSEMBLY_NAME_DECODER
