indexing
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

	assertions (a_id, a_type: STRING): LIST [STRING] is
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

	is_expanded (a_type: STRING): BOOLEAN is
			-- Should a non-void assertion for `a_type' be generated?
		local
			cl: LIST [CLASS_I]
		do
			if (create {IDENTIFIER_CHECKER}).is_valid_upper (a_type) then
				cl := Eiffel_system.Universe.compiled_classes_with_name (a_type)
				if cl /= Void and then not cl.is_empty then
					Result := cl.i_th (1).compiled_class.is_expanded
				end
			end
		end

	is_integer (a_type: STRING): BOOLEAN is
			-- Is `a_type' an integer type?
		local
			l: STRING
		do
			l := a_type.as_lower
			Result := l.is_equal ("integer_16") or l.is_equal ("integer_8") or
				l.is_equal ("integer") or l.is_equal ("integer_64")
		end

	is_pointer (a_type: STRING): BOOLEAN is
			-- Is `a_type' a pointer type?
		local
			l: STRING
		do
			l := a_type.as_lower
			Result := l.is_equal ("pointer")
		end

	is_character (a_type: STRING): BOOLEAN is
			-- Is `a_type' a character type?
		local
			l: STRING
		do
			l := a_type.as_lower
			Result := l.is_equal ("character") or l.is_equal ("wide_character")
		end

	is_real (a_type: STRING): BOOLEAN is
			-- Is `a_type' a floating point type?
		local
			l: STRING
		do
			l := a_type.as_lower
			Result := l.is_equal ("real") or l.is_equal ("double")
		end

	is_string (a_type: STRING): BOOLEAN is
			-- Is `a_type' a string type?
		local
			l: STRING
		do
			l := a_type.as_lower
			Result := l.is_equal ("string")
		end

	reference_assertions (a_attribute: STRING): LINKED_LIST [STRING] is
			-- Possible assertions for reference types.
		require
			a_attribute_not_void: a_attribute /= Void
		do
			create Result.make
			Result.extend (a_attribute + "_not_void: " + a_attribute + " /= Void")
		ensure
			not_void: Result /= Void
		end

	pointer_assertions (a_attribute: STRING): LINKED_LIST [STRING] is
			-- Possible assertions for POINTER.
		require
			a_attribute_not_void: a_attribute /= Void
		do
			create Result.make
			Result.extend (a_attribute + "_not_null: " + a_attribute + " /= Default_pointer")
		ensure
			not_void: Result /= Void
		end

	integer_assertions (a_attribute: STRING): LINKED_LIST [STRING] is
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

	real_assertions (a_attribute: STRING): LINKED_LIST [STRING] is
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

	character_assertions (a_attribute: STRING): LINKED_LIST [STRING] is
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

	string_assertions (a_attribute: STRING): LINKED_LIST [STRING] is
			-- Possible assertions for STRING.
		require
			a_attribute_not_void: a_attribute /= Void
		do
			create Result.make
			Result.extend (a_attribute + "_not_void: " + a_attribute + " /= Void")
			Result.extend (a_attribute + "_not_empty: " + a_attribute + " /= Void and then not " + a_attribute + ".is_empty")
		ensure
			not_void: Result /= Void
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

end -- class EB_ASSERTION_GENERATOR
