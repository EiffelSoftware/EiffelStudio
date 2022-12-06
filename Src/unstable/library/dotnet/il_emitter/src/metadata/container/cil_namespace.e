note
	description: "A namespace"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_NAMESPACE

inherit

	CIL_DATA_CONTAINER
		rename
			make as make_container
		redefine
			il_src_dump,
			pe_dump
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_32)
		do
			make_container (a_name, create {CIL_QUALIFIERS}.make_with_flags (0))
		end

feature -- Output

	reverse_name (child: CIL_DATA_CONTAINER): STRING_32
			-- Get the full namespace name including all parents.
		local
			l_result: STRING_32
		do
			create l_result.make_empty
			if attached {CIL_DATA_CONTAINER} child.parent as l_parent then
				if attached l_parent.parent then
					l_result := reverse_name (l_parent) + "."
				end
				l_result.append (child.name)
			end
			Result := l_result
		end

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			a_file.put_string (".namespace '")
			a_file.put_string (name)
			a_file.put_string ("' {")
			a_file.put_new_line
			Result := Precursor (a_file)
			a_file.put_string ("}")
			a_file.put_new_line
			Result := True
		end

	pe_dump (a_stream: FILE_STREAM): BOOLEAN
		local
			l_full_name: STRING_32
		do
			if not in_assembly_ref or else pe_index = 0 then
				l_full_name := reverse_name (Current)
				if attached {PE_WRITER} a_stream.pe_writer as l_writer then
					pe_index := l_writer.hash_string (l_full_name)
				end
			end
			if not in_assembly_ref then
				Result := Precursor {CIL_DATA_CONTAINER} (a_stream)
			end
			Result := True
		end

end
