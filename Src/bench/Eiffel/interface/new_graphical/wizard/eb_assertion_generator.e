indexing
	description: "Generates a list of possible assertion given a feature."
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
			cl := Eiffel_system.Universe.compiled_classes_with_name (a_type)
			if cl /= Void and then not cl.is_empty then
				Result := cl.i_th (1).compiled_class.is_expanded
			end
		end

	is_integer (a_type: STRING): BOOLEAN is
			-- Is `a_type' an integer type?
		local
			l: STRING
		do
			l := clone (a_type)
			l.to_lower
			Result := l.is_equal ("integer_16") or l.is_equal ("integer_8") or
				l.is_equal ("integer") or l.is_equal ("integer_64")
		end

	is_pointer (a_type: STRING): BOOLEAN is
			-- Is `a_type' a pointer type?
		local
			l: STRING
		do
			l := clone (a_type)
			l.to_lower
			Result := l.is_equal ("pointer")
		end

	is_character (a_type: STRING): BOOLEAN is
			-- Is `a_type' a character type?
		local
			l: STRING
		do
			l := clone (a_type)
			l.to_lower
			Result := l.is_equal ("character") or l.is_equal ("wide_character")
		end

	is_real (a_type: STRING): BOOLEAN is
			-- Is `a_type' a floating point type?
		local
			l: STRING
		do
			l := clone (a_type)
			l.to_lower
			Result := l.is_equal ("real") or l.is_equal ("double")
		end

	is_string (a_type: STRING): BOOLEAN is
			-- Is `a_type' a string type?
		local
			l: STRING
		do
			l := clone (a_type)
			l.to_lower
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

end -- class EB_ASSERTION_GENERATOR
