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
				deserialized_object := Void
				last_error := No_error
				last_error_context := Void
				binary_path := path.twin
				binary_path.remove_tail (4)
				binary_path.append (".bin")
				if feature {SYSTEM_FILE}.exists (binary_path) then
					create f.make_open_read (binary_path)
					if f.exists and then f.support_storable then
						deserialized_object := f.retrieved
					end
					f.close
				end
			end
		rescue
			retried := True
			if f /= Void then
				f.close
			end
			retry
		end

end -- class EIFFEL_BINARY_DESERIALIZER
