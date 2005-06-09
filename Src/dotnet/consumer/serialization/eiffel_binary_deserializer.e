indexing
	description: "Simple Binary deserializer"

class
	EIFFEL_BINARY_DESERIALIZER

inherit
	EIFFEL_XML_SERIALIZATION_ERRORS
		export
			{NONE} all
		end
		
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
			binary_path: STRING
			f: RAW_FILE
			l_bin_file: FILE_INFO
			l_xml_file: FILE_INFO
		do
			if not retried then
				deserialized_object := Void
				last_error := No_error
				last_error_context := Void
				binary_path := path.twin
				binary_path.remove_tail (4)
				binary_path.append (".bin")
				
				create l_bin_file.make (binary_path)
				if l_bin_file.exists then
					feature {SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Deserializing binary file '{0}'.", path))
					create l_xml_file.make (path)
					if l_bin_file.last_write_time >= l_xml_file.last_write_time then
							-- Only use binary file if XML file is not newer.
						create f.make_open_read (binary_path)
						if f.exists and then f.support_storable then
							deserialized_object := f.retrieved
							if deserialized_object = Void then
								feature {SYSTEM_DLL_TRACE}.write_line_string ("Could not retrieve object from binary deserialization process.")
							end
						end
						f.close	
					end
				end
			end
		rescue
			feature {SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Binary deserialization failed for '{0}'.", path))
			retried := True
			if f /= Void then
				f.close
			end
			retry
		end

end -- class EIFFEL_BINARY_DESERIALIZER
