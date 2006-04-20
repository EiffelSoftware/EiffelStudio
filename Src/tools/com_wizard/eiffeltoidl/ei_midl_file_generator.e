indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

				l_str_buffer := e_class.name.twin
				l_str_buffer.to_lower
				l_str_buffer.append ("_library")

				create midl_library.make (l_str_buffer)

				l_code.append (midl_library.code (midl_coclass.code))
				l_code.append ("%N")

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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class EI_MIDL_FILE_GENERATOR

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

