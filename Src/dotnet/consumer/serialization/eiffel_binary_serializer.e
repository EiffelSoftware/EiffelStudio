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
		do
--			last_error := No_error
--			last_error_context := Void
			if not retried then
				path.remove_tail (4)
				path.append (".bin")
				create f.make_open_write (path)
				f.independent_store (a)
				f.close
			end
		rescue
			retried := True
--			last_error := Generic_error
--			last_error_context := ""
			if f /= Void then
				f.close		
			end
			retry
		end

end -- class EIFFEL_BINARY_SERIALIZER
