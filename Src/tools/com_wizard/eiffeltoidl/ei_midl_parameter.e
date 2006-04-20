indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_PARAMETER

inherit
	EI_PARAMETER
		redefine
			make,
			code
		end

	WIZARD_SPECIAL_SYMBOLS
		export
			{NONE} all
		end

	ECOM_PARAM_FLAGS

create
	make

feature {NONE} -- Initialization

	make (l_name, l_type: STRING) is
			-- Initialize object.
		do
			Precursor (l_name, l_type)
			flag := Paramflag_fin

		end

feature -- Access

	flag: INTEGER
			-- Parameter flag.
			-- See ECOM_PARAM_FLAGS

feature -- Element change

	set_flag (l_flag: INTEGER) is
			-- Set 'flag' to 'l_flag'.
		require
			valid_flag: is_valid_paramflag (l_flag)
		do
			flag := l_flag
		ensure
			value_set: flag = l_flag
		end

feature -- Output

	code: STRING is
			-- Code output
		do
			if is_paramflag_fin (flag) then
				Result := "[in]"
			else
				Result := "[in, out]"
			end
			Result.append (type)
			Result.append (" ")
			Result.append (name)
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
end -- class EI_MIDL_PARAMETER

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

