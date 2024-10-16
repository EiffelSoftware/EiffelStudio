﻿note
	description: "Common instances of predefined types."

class SHARED_TYPES

feature -- Access

	natural_8_type: NATURAL_A
			-- Actual integer type of 8 bits
		once
			create Result.make (8)
		end

	natural_16_type: NATURAL_A
			-- Actual integer type of 16 bits
		once
			create Result.make (16)
		end

	natural_32_type: NATURAL_A
			-- Actual integer type of 32 bits
		once
			create Result.make (32)
		end

	natural_64_type: NATURAL_A
			-- Actual integer type of 64 bits
		once
			create Result.make (64)
		end

	Integer_8_type: INTEGER_A
			-- Actual integer type of 8 bits
		once
			create Result.make (8)
		end

	Integer_16_type: INTEGER_A
			-- Actual integer type of 16 bits
		once
			create Result.make (16)
		end

	Integer_32_type, Integer_type: INTEGER_A
			-- Actual integer type of 32 bits
		once
			create Result.make (32)
		end

	Integer_64_type: INTEGER_A
			-- Actual integer type of 64 bits
		once
			create Result.make (64)
		end

	Boolean_type: BOOLEAN_A
			-- Actual boolean type
		once
			create Result
		end

	Character_type: CHARACTER_A
			-- Actual character type
		once
			create Result.make (False)
		end

	Wide_char_type: CHARACTER_A
			-- Actual wide character type
		once
			create Result.make (True)
		end

	Real_32_type: REAL_A
			-- Actual real 32 bits type
		once
			create Result.make (32)
		end

	Real_64_type: REAL_A
			-- Actual real 64 bits type
		once
			create Result.make (64)
		end

	manifest_real_32_type: MANIFEST_REAL_A
			-- Type for manifest real_type.
			--| They can be once because at the moment we do not care about the
			--| actual value of the constant, we assume it will work equally well
			--| as a REAL_32 and REAL_64.
		once
			create Result.make (32)
		end

	manifest_real_64_type: MANIFEST_REAL_A
			-- Type for manifest real_type.
			--| They can be once because at the moment we do not care about the
			--| actual value of the constant, we assume it will work equally well
			--| as a REAL_32 and REAL_64.
		once
			create Result.make (64)
		end

	Void_type: VOID_A
			-- Actual void type
		once
			create Result
		end

	Pointer_type: POINTER_A
			-- Actual pointer type
		once
			create Result
		end

	none_type: NONE_A
			-- Actual NONE type.
			-- See also `detachable_none_type`.
		once
			create Result
		end

	detachable_none_type: NONE_A
			-- Actual detachable NONE type (e.g., for `Void`).
			-- See also `none_type`.
		once
			create Result
			Result.set_detachable_mark
		end

	unknown_type: UNKNOWN_TYPE_A
			-- An unknown type.
		once
			create Result
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
