indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.StrongNameKeyPair"

external class
	SYSTEM_REFLECTION_STRONGNAMEKEYPAIR

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (keyPairContainer: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.StrongNameKeyPair"
		end

	frozen make (keyPairFile: SYSTEM_IO_FILESTREAM) is
		external
			"IL creator signature (System.IO.FileStream) use System.Reflection.StrongNameKeyPair"
		end

	frozen make_1 (keyPairArray: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Reflection.StrongNameKeyPair"
		end

feature -- Access

	frozen get_public_key: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Reflection.StrongNameKeyPair"
		alias
			"get_PublicKey"
		end

end -- class SYSTEM_REFLECTION_STRONGNAMEKEYPAIR
