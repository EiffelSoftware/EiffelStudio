indexing
	description: "Simple Binary serializer"

class
	EIFFEL_BINARY_SERIALIZER

inherit
	EIFFEL_XML_SERIALIZATION_ERRORS
		export
			{NONE} all
		end

feature -- Basic Operation

	serialize (a: ANY; path: STRING) is
			-- Serialize object `a' into file `path'.
		require
			non_void_object: a /= Void
			non_void_path: path /= Void
		local
			f: RAW_FILE
			retried: BOOLEAN
			l_bin_path: STRING
		do
			if not retried then
				feature {SYSTEM_DLL_TRACE}.write_line_string_string ("Serializing '{0}' in binary form.", path)
				l_bin_path := path.substring (1, path.count - 4)
				l_bin_path.append (".bin")
				create f.make_open_write (l_bin_path)
				f.independent_store (a)
				f.close
			end
		rescue
			feature {SYSTEM_DLL_TRACE}.write_line_string_string ("Binary serialization failed for '{0}'.", path)
			retried := True
			if f /= Void then
				f.close
			end
			retry
		end

end -- class EIFFEL_BINARY_SERIALIZER
