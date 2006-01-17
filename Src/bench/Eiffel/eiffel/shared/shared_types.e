indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class SHARED_TYPES
	
feature {NONE}

	natural_8_type: NATURAL_A is
			-- Actual integer type of 8 bits
		once
			create Result.make (8)
		end

	natural_16_type: NATURAL_A is
			-- Actual integer type of 16 bits
		once
			create Result.make (16)
		end

	natural_32_type: NATURAL_A is
			-- Actual integer type of 32 bits
		once
			create Result.make (32)
		end

	natural_64_type: NATURAL_A is
			-- Actual integer type of 64 bits
		once
			create Result.make (64)
		end

	Integer_8_type: INTEGER_A is
			-- Actual integer type of 8 bits
		once
			create Result.make (8)
		end

	Integer_16_type: INTEGER_A is
			-- Actual integer type of 16 bits
		once
			create Result.make (16)
		end

	Integer_type: INTEGER_A is
			-- Actual integer type of 32 bits
		once
			create Result.make (32)
		end

	Integer_64_type: INTEGER_A is
			-- Actual integer type of 64 bits
		once
			create Result.make (64)
		end

	Boolean_type: BOOLEAN_A is
			-- Actual boolean type
		once
			create Result
		end

	Character_type: CHARACTER_A is
			-- Actual character type
		once
			create Result.make (False)
		end

	Wide_char_type: CHARACTER_A is
			-- Actual wide character type
		once
			create Result.make (True)
		end

	Real_32_type: REAL_32_A is
			-- Actual real 32 bits type
		once
			create Result
		end

	Real_64_type: REAL_64_A is
			-- Actual real 64 bits type
		once
			create Result
		end

	Void_type: VOID_A is
			-- Actual void type
		once
			create Result
		end

	Pointer_type: POINTER_A is
			-- Actual pointer type
		once
			create Result
		end
		
	None_type: NONE_A is
			-- Actual NONE type
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
