indexing
	description: "Class representing a precondition."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	APPLICATION_PRECONDITION

creation
	make

feature -- Initialization

	make (an_expression: STRING) is
			-- Create a precondition with 'an_expression'.
		require
			valid_precondition_expression: an_expression /= Void
		do
			precondition := an_expression			
		end

feature -- Attribute

	precondition: STRING
			-- Precondition expression

feature -- Code generation

	generated_eiffel_text (formal_arg_name, actual_arg_name: STRING): STRING is
			-- Generate eiffel text:
			-- * changing formal arguments into actual ones
			-- * adding before queries the word `target'
			-- * changing `Current' into `target'
			-- * changing `implies' into a corresponding 
			-- * leaving `Void' as it is
			--   boolean expression.
		require
			valid_formal_argument: formal_arg_name /= Void and then not formal_arg_name.empty
			valid_actual_argument: actual_arg_name /= Void and then not actual_arg_name.empty
			
		local
			i: INTEGER
		do
			formal_argument := formal_arg_name
			actual_argument := actual_arg_name
			!! Result.make (0)
			Result.append ("(")
			Result.append (generate_eiffel_text (precondition))
			Result.append (")")
		end

feature {NONE} -- Code generation

	formal_argument: STRING
			-- Formal argument name

	actual_argument: STRING
			-- Actual argument name

	generate_eiffel_text (precondition_text: STRING): STRING is
			-- Select what kind of expression `precondition_text' is.
		local
			i: INTEGER
		do
			!! Result.make (0)
			i := precondition_text.substring_index (implies_keyword, 1)
			if i > 0 then
				Result.append (generated_with_operator (precondition_text, implies_keyword, i))
			else
				i := precondition_text.substring_index (or_keyword, 1)
				if i > 0 then
					Result.append (generated_with_operator (precondition_text, or_keyword, i))
				else
					i := precondition_text.substring_index (and_keyword, 1)
					if i > 0 then
						Result.append (generated_with_operator (precondition_text, or_keyword, i))
					else
						Result.append (generated_from_simple_expression (precondition_text))
					end
				end
			end
		end

	generated_with_operator (precondition_text, operator: STRING; i: INTEGER): STRING is
			-- Generate code for a boolean operation.
		do
			!! Result.make (0)
			Result.append (generate_eiffel_text (precondition_text.substring (1, i - 1)))
			Result.append (" ")
			Result.append (operator)
			Result.append (" ")
			Result.append (generate_eiffel_text (precondition_text.substring (i + operator.count, precondition_text.count)))
		end

	generated_from_simple_expression (precondition_text: STRING): STRING is
			-- Generate text when `precondition_text' is a simple boolean
			-- expression (no operators).
		local
			temp_word: STRING
			i: INTEGER
		do
			!! Result.make (0)
			from
				i := 1
			until
				i > precondition_text.count
			loop
				if precondition_text.item (i).is_digit 
					or precondition_text.item (i).is_alpha
					or precondition_text.item (i).is_equal ('_')
				then
					temp_word := next_word (precondition_text, i)
					i := i + temp_word.count
					if temp_word.is_equal ("Current") 
						or temp_word.is_equal ("current") 
					then
						Result.append ("target")
					elseif temp_word.is_equal (formal_argument) then
						Result.append (actual_argument)
					elseif temp_word.is_boolean
						or temp_word.is_double
						or temp_word.is_integer
						or temp_word.is_real
					then
						Result.append (temp_word)
					elseif temp_word.is_equal ("Void") 
						or temp_word.is_equal ("void") 
						or temp_word.is_equal ("not")
						or temp_word.is_equal ("Not")
					then
						Result.append (temp_word)
					else
						Result.append ("target.")
						Result.append (temp_word)
					end					
				else
					Result.append_character (precondition_text.item (i))
					i := i + 1
				end
			end
		end

	next_word (precondition_text: STRING; index: INTEGER): STRING is
			-- Return the next word starting at `index' in
			-- `precondition_text'. 
		require
			character_is_valid: precondition_text.item (index).is_digit 
					or precondition_text.item (index).is_alpha
					or precondition_text.item (index).is_equal ('_') 
		local
			i: INTEGER
		do
			!! Result.make (0)
			from
				i := index
			until
				not precondition_text.item (i).is_digit 
				and not precondition_text.item (i).is_alpha
			   	and not precondition_text.item (i).is_equal ('_')
				and not precondition_text.item (i).is_equal ('.')
			loop
				Result.append_character (precondition_text.item (i))
				i := i + 1
			end
		end

	implies_keyword: STRING is "implies"
			-- Boolean operator `implies'

	or_keyword: STRING is "or"
			-- Boolean operator `or'

	and_keyword: STRING is "and"
			-- Boolean operator `and'

end -- class APPLICATION_PRECONDITION
