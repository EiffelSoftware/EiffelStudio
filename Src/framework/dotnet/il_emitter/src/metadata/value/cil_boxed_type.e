note
	description: "[
			A boxed type, e.g. the reference to a System::* object which
			represents the basic type
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_BOXED_TYPE

inherit

	CIL_TYPE
		rename
			make as make_type
		redefine
			il_src_dump,
			render,
			type_names
		end

create
	make

feature {NONE} -- Initialization

	make (a_basic_type: CIL_BASIC_TYPE)
		do
			make_with_pointer_level (a_basic_type, 0)
		end

feature -- Output

	render (a_stream: FILE_STREAM; a_bytes: SPECIAL [NATURAL_8]; a_offset: INTEGER): NATURAL_8
		local
			l_system: NATURAL_64
			l_name: NATURAL_64
			l_result: ANY
			l_res: BOOLEAN
		do
			if attached {PE_WRITER} a_stream.pe_writer as l_writer then
				if pe_index = 0 then
						-- systemName in C++.
					l_system := l_writer.system_index

					l_name := l_writer.hash_string (type_names[{CIL_BASIC_TYPE}.index_of (basic_type)])
					l_result := a_stream.find ("System." + type_names[{CIL_BASIC_TYPE}.index_of (basic_type)])
					if attached {CIL_CLASS} l_result as l_class then
						l_res := l_class.pe_dump (a_stream)
						pe_index := l_class.pe_index
					end
				end
				{BYTE_ARRAY_HELPER}.put_array_integer_32_with_natural_64 (a_bytes, pe_index | {PE_TABLES}.ttyperef |<< 24, a_offset)
				Result := 4
			end
		end

	il_src_dump (a_stream: FILE_STREAM): BOOLEAN
		do
				-- no point in looking up the type name in the assembly for this...
				-- TODO double check with the latest .Net framework.
			--a_stream.put_string ("[mscorlib]System.")
			a_stream.put_string ("[System.Runtime]System.")
			a_stream.put_string (type_names [{CIL_BASIC_TYPE}.index_of (basic_type) + 1])
			Result := True
		end

feature -- Static

	type_names: ARRAYED_LIST [STRING]
		once
			create Result.make_from_array (<<
					"", "", "", "", "", "Bool", "Char", "SByte", "Byte",
					"Int16", "UInt16", "Int32", "UInt32", "Int64", "UInt64", "IntPtr",
					"UIntPtr", "Single", "Double", "Object", "String"
				>>)
		end

end
