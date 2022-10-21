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

	render (a_stream: FILE_STREAM; a_bytes: detachable ARRAY [NATURAL_8]): NATURAL_8
		do
			to_implement ("Add implementation")
		end


	il_src_dump (a_stream: FILE_STREAM): BOOLEAN
		do
			 	-- no point in looking up the type name in the assembly for this...
			a_stream.put_string ("[mscorlib]System.")
			a_stream.put_string (type_names [{CIL_BASIC_TYPE}.index_of(basic_type) + 1])
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
