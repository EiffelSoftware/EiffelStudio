indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.StrongNameKeyPair"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	STRONG_NAME_KEY_PAIR

inherit
	SYSTEM_OBJECT

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (key_pair_container: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.StrongNameKeyPair"
		end

	frozen make (key_pair_file: FILE_STREAM) is
		external
			"IL creator signature (System.IO.FileStream) use System.Reflection.StrongNameKeyPair"
		end

	frozen make_1 (key_pair_array: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Reflection.StrongNameKeyPair"
		end

feature -- Access

	frozen get_public_key: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Reflection.StrongNameKeyPair"
		alias
			"get_PublicKey"
		end

end -- class STRONG_NAME_KEY_PAIR
