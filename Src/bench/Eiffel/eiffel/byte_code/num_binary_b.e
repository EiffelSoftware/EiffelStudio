-- Binary expression byte code for a possible numeric expression

deferred class NUM_BINARY_B 

inherit
	BINARY_B
		redefine
			generate_standard_il
		end
	
feature

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := context.real_type (left.type).is_numeric;
		end;

feature -- IL code generation

	generate_standard_il is
			-- Generate standard IL code for binary expression.
		local
			l_left_type, l_right_type: TYPE_I
			l_type: TYPE_I
			l_same_type: BOOLEAN
		do
			l_left_type := left.type
			l_right_type := right.type
			l_same_type := l_left_type.same_type (l_right_type)
			if not l_same_type then
				l_type := l_left_type.heaviest (l_right_type)
			end

			left.generate_il
			if not l_same_type and then l_type = l_right_type then
					-- FIXME: Manu 1/29/2002: When evaluating inherited assertions where
					-- type is formal, type is not properly computed and therefore we do
					-- not get a basic type, but a formal one instead.
					-- When this bug will be fixed, we can remove the if statement for
					-- a basic type and replace it by a check statement.
				if l_type.is_basic then
					il_generator.convert_to (l_type)
				end
			end
			right.generate_il
			if not l_same_type and then l_type = l_left_type then
					-- FIXME: See above fixme.
				if l_type.is_basic then
					il_generator.convert_to (l_type)
				end
			end
			
			il_generator.generate_binary_operator (il_operator_constant)
		end

end
