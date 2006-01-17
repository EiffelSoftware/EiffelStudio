indexing
	description: "List of precomputed TYPE_I instances that can be reused."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SHARED_TYPE_I
	
feature -- Access

	Boolean_c_type: BOOLEAN_I is
			-- Boolean C type
		once
			create Result
		end

	Char_c_type: CHAR_I is
			-- Char C type
		once
			create Result.make (False)
		end

	Wide_char_c_type: CHAR_I is
			-- Wide char C type
		once
			create Result.make (True)
		end

	Pointer_c_type: POINTER_I is
			-- Pointer C type
		once
			create Result
		end

	uint8_c_type: NATURAL_I is
			-- uint8 C type
		once
			create Result.make (8)
		end

	uint16_c_type: NATURAL_I is
			-- uint16 C type
		once
			create Result.make (16)
		end

	uint32_c_type: NATURAL_I is
			-- uint32 C type
		once
			create Result.make (32)
		end

	uint64_c_type: NATURAL_I is
			-- uint64 C type
		once
			create Result.make (64)
		end

	int8_c_type: INTEGER_I is
			-- int8 C type
		once
			create Result.make (8)
		end

	int16_c_type: INTEGER_I is
			-- int16 C type
		once
			create Result.make (16)
		end

	int32_c_type: INTEGER_I is
			-- int32 C type
		once
			create Result.make (32)
		end

	int64_c_type: INTEGER_I is
			-- int64 C type
		once
			create Result.make (64)
		end

	real32_c_type: REAL_32_I is
			-- Float C type
		once
			create Result
		end

	real64_c_type: REAL_64_I is
			-- Double C type
		once
			create Result
		end

	Reference_c_type: REFERENCE_I is
			-- Reference C type
		once
			create Result
		end

	Void_c_type: VOID_I is
			-- Void C type
		once
			create Result
		end

	None_c_type: NONE_I is
			-- None C type
		once
			create Result
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end
