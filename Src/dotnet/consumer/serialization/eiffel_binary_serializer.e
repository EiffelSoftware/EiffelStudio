indexing
	description: "Simple Binary serializer"

class
	EIFFEL_BINARY_SERIALIZER

inherit
	EIFFEL_XML_SERIALIZATION_ERRORS

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
				l_bin_path := clone (path)
				l_bin_path.remove_tail (4)
				l_bin_path.append (".bin")
				create f.make_open_write (l_bin_path)
				f.independent_store (a)
				f.close
			end
		rescue
			retried := True
			if f /= Void then
				f.close		
			end
			retry
		end

end -- class EIFFEL_BINARY_SERIALIZER
