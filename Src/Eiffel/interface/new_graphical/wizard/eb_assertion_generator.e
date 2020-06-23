note
	description: "Generates a list of possible assertion given a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ASSERTION_GENERATOR

inherit
	SHARED_EIFFEL_PROJECT

feature -- Access

	assertions (a_id, a_type: STRING): LIST [STRING]
			-- Possible assertions for feature with name `a_id' and `a_type'.
		require
			a_id_not_void: a_id /= Void
			a_type_not_void: a_type /= Void
		do
			if not is_expanded (a_type) then
				if is_string (a_type) then
					Result := string_assertions (a_id)
				else
					Result := reference_assertions (a_id)
				end
			elseif is_integer (a_type) then
				Result := integer_assertions (a_id)
			elseif is_natural (a_type) then
				Result := natural_assertions (a_id)
			elseif is_pointer (a_type) then
				Result := pointer_assertions (a_id)
			elseif is_character (a_type) then
				Result := character_assertions (a_id)
			elseif is_real (a_type) then
				Result := real_assertions (a_id)
			else
					-- Unknown expanded type.
				create {LINKED_LIST [STRING]} Result.make
			end
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	is_expanded (a_type: STRING): BOOLEAN
			-- Should a non-void assertion for `a_type' be generated?
		local
			cl: LIST [CLASS_I]
		do
			if (create {EIFFEL_SYNTAX_CHECKER}).is_valid_class_name (a_type) and a_type.as_upper.is_equal (a_type) then
				cl := Eiffel_system.Universe.compiled_classes_with_name (a_type)
				if cl /= Void and then not cl.is_empty then
					Result := cl.i_th (1).compiled_class.is_expanded
				end
			end
		end

	is_integer (a_type: STRING): BOOLEAN
			-- Is `a_type' an integer type?
		do
			Result :=
				a_type.is_case_insensitive_equal ("integer_8") or
				a_type.is_case_insensitive_equal ("integer_16") or
				a_type.is_case_insensitive_equal_general ("integer_32") or
				a_type.is_case_insensitive_equal ("integer_64")
				or a_type.is_case_insensitive_equal ("integer") -- legacy
		end

	is_natural (a_type: STRING): BOOLEAN
			-- Is `a_type' a natural type?
		do
			Result :=
				a_type.is_case_insensitive_equal ("natural_8") or
				a_type.is_case_insensitive_equal ("natural_16") or
				a_type.is_case_insensitive_equal ("natural_32") or
				a_type.is_case_insensitive_equal ("natural_64")
				or a_type.is_case_insensitive_equal ("natural") -- legacy
		end

	is_pointer (a_type: STRING): BOOLEAN
			-- Is `a_type' a pointer type?
		do
			Result := a_type.is_case_insensitive_equal ("pointer")
		end

	is_character (a_type: STRING): BOOLEAN
			-- Is `a_type' a character type?
		do
			Result := a_type.is_case_insensitive_equal ("character_8") or else a_type.is_case_insensitive_equal ("character_32")
			 or else a_type.is_case_insensitive_equal ("character") or else a_type.is_case_insensitive_equal ("wide_character") -- legacy
		end

	is_real (a_type: STRING): BOOLEAN
			-- Is `a_type' a floating point type?
		do
			Result := a_type.is_case_insensitive_equal ("real_32") or a_type.is_case_insensitive_equal ("real_64")
				or else a_type.is_case_insensitive_equal ("real") or else a_type.is_case_insensitive_equal ("double") -- legacy
		end

	is_string (a_type: STRING): BOOLEAN
			-- Is `a_type' a string type?
		do
			Result := a_type.is_case_insensitive_equal ("string_8") or else a_type.is_case_insensitive_equal ("string_32")
				or else a_type.is_case_insensitive_equal ("string") -- legacy
		end

	reference_assertions (a_attribute: STRING): LINKED_LIST [STRING]
			-- Possible assertions for reference types.
		require
			a_attribute_not_void: a_attribute /= Void
		do
			create Result.make
			Result.extend (a_attribute + "_attached: " + a_attribute + " /= Void")
		ensure
			not_void: Result /= Void
		end

	pointer_assertions (a_attribute: STRING): LINKED_LIST [STRING]
			-- Possible assertions for POINTER.
		require
			a_attribute_not_void: a_attribute /= Void
		do
			create Result.make
			Result.extend (a_attribute + "_not_null: " + a_attribute + " /= default_pointer")
		ensure
			not_void: Result /= Void
		end

	integer_assertions (a_attribute: STRING): LINKED_LIST [STRING]
			-- Possible assertions for INTEGER(_*).
		require
			a_attribute_not_void: a_attribute /= Void
		do
			create Result.make
			Result.extend (a_attribute + "_positive: " + a_attribute + " > 0")
			Result.extend (a_attribute + "_non_negative: " + a_attribute + " >= 0")
			Result.extend (a_attribute + "_negative: " + a_attribute + " < 0")
			Result.extend (a_attribute + "_within_bounds: " + a_attribute + " > 0 and " + a_attribute + " <= 1")
		ensure
			not_void: Result /= Void
		end

	natural_assertions (a_attribute: STRING): LINKED_LIST [STRING]
			-- Possible assertions for NATURAL(_*).
		require
			a_attribute_not_void: a_attribute /= Void
		do
			create Result.make
			Result.extend (a_attribute + "_positive: " + a_attribute + " > 0")
			Result.extend (a_attribute + "_within_bounds: " + a_attribute + " > 0 and " + a_attribute + " <= 1")
		ensure
			not_void: Result /= Void
		end

	real_assertions (a_attribute: STRING): LINKED_LIST [STRING]
			-- Possible assertions for REAL and DOUBLE.
		require
			a_attribute_not_void: a_attribute /= Void
		do
			create Result.make
			Result.extend (a_attribute + "_positive: " + a_attribute + " > 0.0")
			Result.extend (a_attribute + "_non_negative: " + a_attribute + " >= 0.0")
			Result.extend (a_attribute + "_negative: " + a_attribute + " < 0.0")
			Result.extend (a_attribute + "_within_bounds: " + a_attribute + " >= 0.0 and " + a_attribute + " <= 1.0")
		ensure
			not_void: Result /= Void
		end

	character_assertions (a_attribute: STRING): LINKED_LIST [STRING]
			-- Possible assertions for (WIDE_)CHARACTER.
		require
			a_attribute_not_void: a_attribute /= Void
		do
			create Result.make
			Result.extend (a_attribute + "_not_null: " + a_attribute + " /= '%%U'")
			Result.extend (a_attribute + "_is_alpha: " + a_attribute + ".is_alpha")
			Result.extend (a_attribute + "_is_digit: " + a_attribute + ".is_digit")
		ensure
			not_void: Result /= Void
		end

	string_assertions (a_attribute: STRING): LINKED_LIST [STRING]
			-- Possible assertions for STRING.
		require
			a_attribute_not_void: a_attribute /= Void
		do
			create Result.make
			Result.extend (a_attribute + "_attached: " + a_attribute + " /= Void")
			Result.extend (a_attribute + "_not_empty: " + a_attribute + " /= Void and then not " + a_attribute + ".is_empty")
		ensure
			not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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

end -- class EB_ASSERTION_GENERATOR
