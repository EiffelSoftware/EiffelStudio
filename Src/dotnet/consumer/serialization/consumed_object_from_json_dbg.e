note
	description: "[
		JSON deserialization of dotnet CONSUMED_... objects.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_OBJECT_FROM_JSON_DBG

inherit
	CONSUMED_OBJECT_FROM_JSON
		redefine
			from_json_file,
			from_json_file_at,
			report_error
		end

create
	make

feature -- Deserialization

	from_json_file (f: FILE): like from_json
		do
			print ("From-JSON: file=" + f.path.utf_8_name + "%N")
			Result := Precursor (f)
		end

	from_json_file_at (f: FILE; a_pos: INTEGER): like from_json
		do
			print ("From-JSON: at "+ a_pos.out+" file=" + f.path.utf_8_name + "%N")
			Result := Precursor (f, a_pos)
		end

feature -- Helpers

	report_error (m: detachable READABLE_STRING_GENERAL)
		do
			print ("<<ERROR>>")
			if m /= Void then
				print (m)
			end
			print ("%N")
			Precursor (m)
		end

end
