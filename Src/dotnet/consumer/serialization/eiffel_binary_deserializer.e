indexing
	description: "Simple Binary deserializer"

class
	EIFFEL_BINARY_DESERIALIZER

inherit
	EIFFEL_XML_SERIALIZATION_ERRORS

feature -- Access

	deserialized_object: ANY
			-- Last deserialized object

feature -- Basic Operation

	deserialize (path: STRING) is
			-- Deserialize object previously serialized in `path'.
		require
			non_void_path: path /= Void
			valid_path: (create {RAW_FILE}.make (path)).exists
		local
			retried: BOOLEAN
			name: STRING
			dt: INTEGER
			name_att: SYSTEM_STRING
			binary_path: STRING
			f: RAW_FILE
		do
			if not retried then		
				last_error := No_error
				last_error_context := Void
				binary_path := clone (path)
				binary_path.remove_tail (4)
				binary_path.append (".bin")
				create f.make_open_read (binary_path)
				if 
					f.exists and then 
					f.Support_storable
				then
					deserialized_object := f.retrieved
				end
				f.close
			end
		rescue
			retried := True
			if f /= Void then
				f.close
			end
			retry
		end

end -- class EIFFEL_BINARY_DESERIALIZER
