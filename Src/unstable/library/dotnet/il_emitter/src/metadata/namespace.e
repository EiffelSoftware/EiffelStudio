note
	description: "A namespace"
	date: "$Date$"
	revision: "$Revision$"

class
	NAMESPACE

inherit

	DATA_CONTAINER
		rename
			make as make_container
		redefine
			il_src_dump
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_32)
		do
			make_container (a_name, create {QUALIFIERS}.make_with_flags (0))
		end

feature -- Output

	reverse_name (child: DATA_CONTAINER): STRING_32
		do
			Result := "" -- TO be implemented.
		end

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			a_file.put_string (".namespace '")
			a_file.put_string (name)
			a_file.put_string ("' {")
			a_file.put_new_line
			Result := Precursor(a_file)
			a_file.put_string ("}")
			a_file.put_new_line
			Result := True
		end

end
