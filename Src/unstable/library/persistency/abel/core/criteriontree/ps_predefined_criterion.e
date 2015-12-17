note
	description: "A criterion to filter objects according to some predefined %
				% operations on attributes (see class PS_PREDEFINED_OPERATORS)."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_PREDEFINED_CRITERION

inherit

	PS_CRITERION

	PS_PREDEFINED_OPERATORS

	REFACTORING_HELPER

create
	make

feature -- Check

	is_satisfied_by (object: ANY): BOOLEAN
			-- Does `object' satisfy the criteria in Current?
		local
			attribute_is_present: BOOLEAN
			index: INTEGER
			loop_var: INTEGER
			intern: INTERNAL
			field_value: detachable ANY
		do
				-- find out the value of the attribute using reflection
			create intern
			from
				loop_var := intern.field_count (object)
				attribute_is_present := false
			until
				loop_var < 1 or attribute_is_present
			loop
				if attribute_name.is_case_insensitive_equal (intern.field_name (loop_var, object)) then
					attribute_is_present := true
					index := loop_var
				end
				loop_var := loop_var - 1
			variant
				loop_var
			end
			field_value := intern.field (index, object)
				-- Apparently automatic conversion doesn't work in tuples,
				-- so we have to do it manually
			if attached {INTEGER_64} field_value as int then
				Result := my_agent.item ([int])
			elseif attached {INTEGER_32} field_value as int then
				Result := my_agent.item ([int.to_integer_64])
			elseif attached {INTEGER_16} field_value as int then
				Result := my_agent.item ([int.to_integer_64])
			elseif attached {INTEGER_8} field_value as int then
				Result := my_agent.item ([int.to_integer_64])
					-- Reals
			elseif attached {REAL_32} field_value as real then
				Result := my_agent.item ([real.to_double])
			elseif attached {REAL_64} field_value as real then
				Result := my_agent.item ([real])
					-- Naturals
			elseif attached {NATURAL_64} field_value as nat then
				Result := my_agent.item ([nat])
			elseif attached {NATURAL_32} field_value as nat then
				Result := my_agent.item ([nat.to_natural_64])
			elseif attached {NATURAL_16} field_value as nat then
				Result := my_agent.item ([nat.to_natural_64])
			elseif attached {NATURAL_8} field_value as nat then
				Result := my_agent.item ([nat.to_natural_64])
					-- Boolean
			elseif attached {BOOLEAN} field_value as bool then
				Result := my_agent.item ([bool])
					-- Character
			elseif attached {CHARACTER_8} field_value as char then
				Result := my_agent.item ([char])
			elseif attached {CHARACTER_32} field_value as char then
				Result := my_agent.item ([char])
					-- Strings
			elseif attached {STRING} field_value as str then
				Result := my_agent.item ([str])
			elseif attached {STRING_32} field_value as str then
				Result := my_agent.item ([str])
			elseif attached {IMMUTABLE_STRING_8} field_value as str then
				Result := my_agent.item ([str])
			elseif attached {IMMUTABLE_STRING_32} field_value as str then
				Result := my_agent.item ([str])
			else
				check unknown_basic_type: False end
			end
		end

	can_handle_object (an_object: ANY): BOOLEAN
			-- Can `Current' handle `an_object' in the is_satisfied_by check?
		local
			attribute_is_present: BOOLEAN
			index: INTEGER
			loop_var: INTEGER
			intern: INTERNAL
			field_type: INTEGER
		do
				-- See if the attribute is actually present in the object and get its type ID
			create intern
			from
				loop_var := intern.field_count (an_object)
				attribute_is_present := false
			until
				loop_var < 1 or attribute_is_present
			loop
				if attribute_name.is_case_insensitive_equal (intern.field_name (loop_var, an_object)) then
					attribute_is_present := true
					field_type := intern.field_static_type_of_type (loop_var, intern.dynamic_type (an_object))
				end
				loop_var := loop_var - 1
			variant
				loop_var
			end
				-- now see if both types match
			if attribute_is_present then
				Result := valid_types.there_exists (agent intern.field_conforms_to (field_type, ?))
			else
				Result := False
			end
		end

feature -- Miscellaneous

	has_agent_criterion: BOOLEAN = False
			-- Is there an agent criterion in the criterion tree?

	accept (a_visitor: PS_CRITERION_VISITOR [ANY]): ANY
			-- Call visit_predefined on `a_visitor'
		do
			Result := a_visitor.visit_predefined (Current)
		end

feature --Access

	attribute_name: STRING
			-- The attribute on which the criteria shall operate on.

	operator: STRING
			-- The operator. Must be an operation defined in PS_PREDEFINED_OPERATORS

	value: ANY
			-- The value to check for

	my_agent: PREDICATE [ANY]
			-- Used if the predefined queries cannot be executed by the database.

feature -- Predefined Operators

	string8_op (s1, s2: READABLE_STRING_8): BOOLEAN
			-- Operations on STRING_8
		local
			cursor: INDEXABLE_ITERATION_CURSOR [CHARACTER_8]
			index, stored_index, substring_index: INTEGER
			i: INTEGER
			result_found, place_found: BOOLEAN
			variable_start, variable_end: BOOLEAN
			substrings: LIST [STRING]
		do
			if operator.is_case_insensitive_equal (equals) then
				Result := s2.is_case_insensitive_equal (s1)
			else -- operator = like_string
				Result := pattern_match_string8 (s1, s2)
					--print ("Final result: " + Result.out + "%N%N" )
			end
		end

	string32_op (s1, s2: READABLE_STRING_32): BOOLEAN
			-- Operations on STRING_32
		do
			if operator.is_case_insensitive_equal (equals) then
				Result := s2.is_case_insensitive_equal (s1)
			else
				Result := pattern_match_string32 (s1, s2)
			end
		end

	real_op (r1, r2: REAL_64): BOOLEAN
			-- Operations on REAL
		do
			if operator.is_case_insensitive_equal (equals) then
				Result := r1 = r2
			elseif operator.is_case_insensitive_equal (less_equal) then
				Result := r1 <= r2
			elseif operator.is_case_insensitive_equal (less) then
				Result := r1 < r2
			elseif operator.is_case_insensitive_equal (greater_equal) then
				Result := r1 >= r2
			else -- Other operators are not possible due to the invariant
				Result := r1 > r2
			end
		end

	integer_op (i1, i2: INTEGER_64): BOOLEAN
			-- Operations on INTEGER
		do
			if operator.is_case_insensitive_equal (equals) then
				Result := i1 = i2
			elseif operator.is_case_insensitive_equal (less_equal) then
				Result := i1 <= i2
			elseif operator.is_case_insensitive_equal (less) then
				Result := i1 < i2
			elseif operator.is_case_insensitive_equal (greater_equal) then
				Result := i1 >= i2
			else
				check operator.is_case_insensitive_equal (greater) then
					Result := i1 > i2
				end
					-- Other operators are not possible due to the invariant
			end
		end

	natural_op (n1, n2: NATURAL_64): BOOLEAN
			-- Operations on NATURAL
		do
			if operator.is_case_insensitive_equal (equals) then
				Result := n1 = n2
			elseif operator.is_case_insensitive_equal (less_equal) then
				Result := n1 <= n2
			elseif operator.is_case_insensitive_equal (less) then
				Result := n1 < n2
			elseif operator.is_case_insensitive_equal (greater_equal) then
				Result := n1 >= n2
			else -- Other operators are not possible due to the invariant
				Result := n1 > n2
			end
		end

	boolean_op (b1, b2: BOOLEAN): BOOLEAN
			-- Operations on BOOLEAN
		do
			Result := b1 = b2
		end

feature {NONE} -- Creation

	make (an_object_attribute_name, an_operator: STRING; a_value: ANY)
			-- Creates a predefined selection criterion given
			-- an object attribute name,
			-- an operator (see 'PS_PREDEFINED_OPERATORS'),
			-- and a value for the attribute.
		require
			correct_operator_and_value: is_valid_combination (an_operator, a_value)
		do
			attribute_name := an_object_attribute_name
			operator := an_operator
			value := a_value
				-- Initialize the agent. This is kind of ugly, but I think there's no other way if we want to support all the basic types
				-- Strings
			if attached {READABLE_STRING_8} value as str then
				my_agent := agent string8_op (?, str);
			elseif attached {READABLE_STRING_32} value as str then
				my_agent := agent string32_op (?, str);
				-- Booleans
			elseif attached {BOOLEAN} value as bool then
				my_agent := agent boolean_op (?, bool);
				-- Integers
			elseif attached {INTEGER_64} value as int then
				my_agent := agent integer_op (?, int)
			elseif attached {INTEGER_32} value as int then
				my_agent := agent integer_op (?, int)
			elseif attached {INTEGER_16} value as int then
				my_agent := agent integer_op (?, int)
			elseif attached {INTEGER_8} value as int then
				my_agent := agent integer_op (?, int)
					-- Reals
			elseif attached {REAL_64} value as real then
				my_agent := agent real_op (?, real)
			elseif attached {REAL_32} value as real then
				my_agent := agent real_op (?, real)
					-- Naturals
			elseif attached {NATURAL_64} value as nat then
				my_agent := agent natural_op (?, nat)
			elseif attached {NATURAL_32} value as nat then
				my_agent := agent natural_op (?, nat)
			elseif attached {NATURAL_16} value as nat then
				my_agent := agent natural_op (?, nat)
			else
				check attached {NATURAL_8} value as nat then
					my_agent := agent natural_op (?, nat)
				end
					-- There should not be any other type according to the precondition
			end
		end

feature -- Implementation

	valid_types: LIST [INTEGER]
			-- All type id's of the valid types as used by INTERNAL
		local
			reflection: INTERNAL
		do
			create {ARRAYED_LIST [INTEGER]} Result.make (4)
			create reflection
			if is_boolean_type (value) then
				Result.extend (reflection.dynamic_type_from_string ("BOOLEAN"))
			elseif is_string_8_type (value) then
				Result.extend (reflection.dynamic_type_from_string ("READABLE_STRING_8"))
			elseif is_string_32_type (value) then
				Result.extend (reflection.dynamic_type_from_string ("READABLE_STRING_32"))
			elseif is_natural_type (value) then
				Result.extend (reflection.dynamic_type_from_string ("NATURAL_8"))
				Result.extend (reflection.dynamic_type_from_string ("NATURAL_16"))
				Result.extend (reflection.dynamic_type_from_string ("NATURAL_32"))
				Result.extend (reflection.dynamic_type_from_string ("NATURAL_64"))
			elseif is_integer_type (value) then
				Result.extend (reflection.dynamic_type_from_string ("INTEGER_8"))
				Result.extend (reflection.dynamic_type_from_string ("INTEGER_16"))
				Result.extend (reflection.dynamic_type_from_string ("INTEGER_32"))
				Result.extend (reflection.dynamic_type_from_string ("INTEGER_64"))
			elseif is_real_type (value) then
				Result.extend (reflection.dynamic_type_from_string ("REAL_32"))
				Result.extend (reflection.dynamic_type_from_string ("REAL_64"))
			end
		end

feature {NONE} -- Pattern matching
		-- Unfortunately, I cannot use polymorphism or constrained genericity as some vital functions in the only common ancestor of both string types are missing...
		-- TODO: Any idea on how to avoid this code duplication is welcome.
		-- The algorithms are exactly the same in both versions, just the function names and some variable types are different.

	pattern_match_string8 (word, pattern: READABLE_STRING_8): BOOLEAN
			-- See if word matches the pattern.
		local
			substrings: LIST [READABLE_STRING_8]
			first_occurrence: INTEGER
			current_index: INTEGER
			ending: READABLE_STRING_8
		do
			Result := True
			current_index := 1
			substrings := pattern.split ('*')
				-- Find all occurrences of substrings in list
			from
				substrings.start
			until
				substrings.after
			loop
					--print (substrings.item + "%N")
				if not substrings.item.is_empty then
					if not word.valid_index (current_index) then
						first_occurrence := -1
					else
						first_occurrence := find_occurrence_string8 (word.substring (current_index, word.count), substrings.item)
					end
					if first_occurrence < 0 then
						Result := False
					else
						current_index := current_index + first_occurrence + substrings.item.count
					end
				end
				substrings.forth
			end
				-- Cover special cases (if there are no asterisks at the start or the end of the string)
			if word [1] /= '*' then
				Result := Result and starts_with_string8 (word, substrings [1])
			end
			if word [word.count] /= '*' then
				ending := word.substring (word.count - substrings [substrings.count].count + 1, word.count)
				Result := Result and starts_with_string8 (ending, substrings [substrings.count])
			end
		end

	find_occurrence_string8 (word, pattern: READABLE_STRING_8): INTEGER
			-- find first occurrence of `word' in `pattern', and return start index of it. Return -1 if not found
		local
			found: BOOLEAN
		do
			from
				Result := 1
			until
				found or Result > word.count
			loop
				found := starts_with_string8 (word.substring (Result, word.count), pattern)
				if not found then
					Result := Result + 1
				end
			end
			if not found then
				Result := -1
			end
		end

	starts_with_string8 (word, pattern: READABLE_STRING_8): BOOLEAN
			-- does `word' start with `pattern'?
		local
			index: INTEGER
		do
			Result := True
			index := 1
			across
				pattern as p
			loop
				if word.valid_index (index) and then p.item = word [index] or p.item = '?' then
					index := index + 1
				else
					Result := False
				end
			end
		end

	pattern_match_string32 (word, pattern: READABLE_STRING_32): BOOLEAN
			-- See if word matches the pattern.
		local
			substrings: LIST [READABLE_STRING_32]
			first_occurrence: INTEGER
			current_index: INTEGER
			ending: READABLE_STRING_32
		do
			Result := True
			current_index := 1
			substrings := pattern.split ('*')
				-- Find all occurrences of substrings in list
			from
				substrings.start
			until
				substrings.after
			loop
					--print (substrings.item + "%N")
				if not substrings.item.is_empty then
					if not word.valid_index (current_index) then
						first_occurrence := -1
					else
						first_occurrence := find_occurrence_string32 (word.substring (current_index, word.count), substrings.item)
					end
					if first_occurrence < 0 then
						Result := False
					else
						current_index := current_index + first_occurrence + substrings.item.count
					end
				end
				substrings.forth
			end
				-- Cover special cases (if there are no asterisks at the start or the end of the string)
			if word [1] /= '*' then
				Result := Result and starts_with_string32 (word, substrings [1])
			end
			if word [word.count] /= '*' then
				ending := word.substring (word.count - substrings [substrings.count].count + 1, word.count)
				Result := Result and starts_with_string32 (ending, substrings [substrings.count])
			end
		end

	find_occurrence_string32 (word, pattern: READABLE_STRING_32): INTEGER
			-- find first occurrence of `word' in `pattern', and return start index of it. Return -1 if not found
		local
			found: BOOLEAN
		do
			from
				Result := 1
			until
				found or Result > word.count
			loop
				found := starts_with_string32 (word.substring (Result, word.count), pattern)
				if not found then
					Result := Result + 1
				end
			end
			if not found then
				Result := -1
			end
		end

	starts_with_string32 (word, pattern: READABLE_STRING_32): BOOLEAN
			-- does `word' start with `pattern'?
		local
			index: INTEGER
		do
			Result := True
			index := 1
			across
				pattern as p
			loop
				if word.valid_index (index) and then p.item = word [index] or p.item = '?' then
					index := index + 1
				else
					Result := False
				end
			end
		end

invariant
	operator_and_value_match: is_valid_combination (operator, value)

end
