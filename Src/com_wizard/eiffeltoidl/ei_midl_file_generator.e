indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_FILE_GENERATOR

inherit
	WIZARD_SPECIAL_SYMBOLS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize object.
		do
		end

feature -- Status report

	succeed: BOOLEAN
			-- Whether last operation succeed?

feature  -- Basic operations

	generate (e_class: EI_CLASS) is
			-- Generate idl code from 'e_class' and save to file.
		require
			non_void_class: e_class /= Void
		local
			midl_coclass_creator: EI_MIDL_COCLASS_CREATOR
			l_code, l_str_buffer: STRING
			midl_coclass: EI_MIDL_COCLASS
			midl_library: EI_MIDL_LIBRARY
			output_file: PLAIN_TEXT_FILE
		do
			create midl_coclass_creator.make
			midl_coclass_creator.create_from_eiffel_class (e_class)

			l_code := "import %"oaidl.idl%"%N%N"


			if midl_coclass_creator.succeed then
				midl_coclass := midl_coclass_creator.midl_coclass

				if midl_coclass.interfaces.is_empty then
					succeed := False
				else
					from
						midl_coclass.interfaces.start
					until
						midl_coclass.interfaces.after
					loop
						l_code.append (midl_coclass.interfaces.item.code)
						l_code.append (New_line)
						midl_coclass.interfaces.forth
					end
				end

				l_str_buffer := clone (e_class.name)
				l_str_buffer.to_lower
				l_str_buffer.append ("_library")

				create midl_library.make (l_str_buffer)

				l_code.append (midl_library.code (midl_coclass.code))

				l_str_buffer := "path"
				l_str_buffer.append ("\")
				l_str_buffer.append (e_class.name)
				l_str_buffer.append (".idl")

				output_file.make_open_write (l_str_buffer)

				output_file.put_string (l_code)
				output_file.flush
				output_file.close
			else
				succeed := False
			end
		end

end -- class EI_MIDL_FILE_GENERATOR
