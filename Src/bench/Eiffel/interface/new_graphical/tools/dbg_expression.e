indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EXPRESSION

inherit

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	PREFIX_INFIX_NAMES
		export
			{NONE} all
		end

create
	make_with_class,
--	make_with_object,
	make_for_context

create {DBG_EXPRESSION}
	make_with_target,
	make_like

feature {NONE} -- Initialization

	make_with_class (cl: CLASS_C; new_expr: STRING) is
			-- Initialize `Current' and link it to a class `cl'.
			-- Initialize the expression to `new_expr'.
		require
			valid_class: cl /= Void and then cl.is_valid
			valid_expression: valid_expression (new_expr)
		do
			on_class := True
			context_class := cl
			set_expression (new_expr)
		end

	make_for_context (new_expr: STRING) is
			-- Initialize `Current' and link it to the context.
			-- Initialize the expression to `new_expr'.
		require
			valid_expression: valid_expression (new_expr)
		do
			on_context := True
			set_expression (new_expr)
		end

	make_with_target (tgt: like Current; new_expr: STRING) is
			-- Initialize `Current' and link it to its target `tgt'.
			-- Initialize the expression to `new_expr'.
			-- Used to initialize messages.
		require
			valid_target: tgt /= Void
			valid_expression: valid_expression (new_expr)
		do
				--| Propagate the initial context.
			target := tgt
			make_like (target, new_expr)
		end

	make_like (other: like Current; new_expr: STRING) is
			-- Initialize `Current' and link it to the same context as `other'.
			-- Initialize the expression to `new_expr'.
			-- Used to initialize parameters.
		require
			valid_other: other /= Void
			valid_expression: valid_expression (new_expr)
		do
				--| Propagate the initial context.
			on_context := other.on_context
			on_class := other.on_class
			on_object := other.on_object
			context_address := other.context_address
			context_class := other.context_class
			
			set_expression (new_expr)
		end

feature -- Properties settings

	set_expression (new_expr: STRING) is
			-- Change the expression that is evaluated.
		require
			valid_expression: valid_expression (new_expr)
		local
			open_pars: INTEGER
			cc: CHARACTER
			i: INTEGER
			s: STRING
			first_dot, par1, par2, first_op: INTEGER
			op: STRING
			look_for_op: BOOLEAN
		do
				-- Reinitialize everything.
			error_message := Void
			feature_name := Void
			is_constant := False
			is_non_equality_test := False
			is_equality_test := False
			constant_result_type := Void
			constant_result_value := Void
			is_identity := False
			message := Void
			create parameters.make (5)
			syntax_error := False
			expression := new_expr
			
			s := expression.twin
			remove_prefix_operators (s)
			s.left_adjust
			s.right_adjust
			look_for_op := s.count < Prefix_str.count or else
							(s.substring_index_in_bounds (Prefix_str, 1, Prefix_str.count) /= 1 and
							s.substring_index_in_bounds (Infix_str, 1, Infix_str.count) /= 1)
			from
				i := 1
			until
					-- We can stop as soon as we find the first dot or operator: 
					-- other parentheses do not concern us.
				i > s.count or first_dot > 0 or first_op > 0
			loop
				cc := s.item (i)
				if cc = '(' then
					if open_pars = 0 then
						if par1 = 0 then
							par1 := i
						else
								-- *(*)X(*)* where X contains neither . 
								-- nor operator is not a valid syntax.
							syntax_error := True
						end
					end
					open_pars := open_pars + 1
				elseif cc = ')' then
					open_pars := open_pars - 1
					if open_pars = 0 then
						par2 := i
					end
				elseif open_pars = 0 then
					if cc = '.' then
						first_dot := i
					elseif look_for_op then
						op := operator_starting_at (i, s)
						if op /= Void then
							first_op := i
						end
					end
				end
				i := i + 1
			end
				-- At this point, we have the positions of (, ), . and the first operator
				-- in par1, par2, first_dot and first_op (whichever of both comes first).
			if par1 = 1 then
					-- The first character is a parenthesis 
					-- => we hack with the identity feature.
				is_identity := True
				set_feature_name (Identity)
				parse_parameters (s.substring (par1 + 1, par2 - 1))
				if parameters.count /= 1 then
					syntax_error := True
				end
			elseif par1 > 0 then
					-- There are parameters.
				parse_parameters (s.substring (par1 + 1, par2 - 1))
				if parameters.count = 0 then
					syntax_error := True
				end
				set_feature_name (s.substring (1, par1 - 1))
			else
					-- No parameters.
				if first_dot > 0 or first_op > 0 then
					set_feature_name (s.substring (1, first_dot.max (first_op) - 1))
				else
					set_feature_name (s)
				end
			end
			if first_dot > 0 then
					-- There is no operator part: just process dot calls.
				create message.make_with_target (Current, s.substring (first_dot + 1, s.count))
				syntax_error := syntax_error or message.syntax_error
			elseif first_op > 0 then
					-- There is an operator in `Current' at the first level.
				s.keep_tail (s.count - (first_op + op.count - 1))
				s.prepend (infix_feature_name_with_symbol (op) + "(")
				s.append_character (')')
				create message.make_with_target (Current, s)
				syntax_error := syntax_error or message.syntax_error
			end
			if is_equality_test or is_non_equality_test then
					-- We must have a target and exactly one parameter.
				if (target = Void) or (parameters.count /= 1) then
					syntax_error := True
				end
			end
		ensure
			expression_set: expression = new_expr
			feature_name_if_not_error: (not syntax_error) implies (feature_name /= Void)
		end

feature -- Properties

	expression: STRING
			-- String representation of the like Current.

	message: like Current
			-- Message part of `Current'.

	target: like Current
			-- Target for the call described by `Current'.

	error_message: STRING
			-- If `Current' or one of its descendants couldn't be evaluated,
			-- return an explanatory message.

	is_constant: BOOLEAN
			-- Does `Current' operate on a constant?

	constant_result_value: DUMP_VALUE
			-- Value associated to a constant expression.
	
	constant_result_type: CLASS_C
			-- Type associated to a constant expression.

	is_identity: BOOLEAN
			-- Does `Current' simply return its parameter?

	is_equality_test: BOOLEAN
			-- Does `Current' perform a comparison between its target and its parameter?

	is_non_equality_test: BOOLEAN
			-- Does `Current' perform a difference test between its target 
			-- and its parameter?

	parameters: ARRAYED_LIST [like Current]
			-- Parameters concerning `Current' at the first level.

	feature_name: STRING
			-- Name of the feature that is `Current's root.

feature {DBG_EXPRESSION} -- Status report: Propagate the context and the results.

	on_object: BOOLEAN
			-- Is the expression relative to an object?

	on_class: BOOLEAN
			-- Is the expression relative to a class (the expression must be a once/constant).

	on_context: BOOLEAN
			-- Is the expression to be evaluated in the current call stack element context?

	context_class: CLASS_C
			-- Class the expression refers to (only valid if `on_class').
	
	context_address: STRING
			-- Address of the object the expression refers to (only valid if `on_object').


feature -- Status

	valid_expression (expr: STRING): BOOLEAN is
			-- Is `expr' a valid expression?
		do
			Result := expr /= Void
			if Result then
				Result := not expr.has ('%R') and not expr.has ('%N')
			end
		end

feature -- Access

	syntax_error: BOOLEAN
			-- Is the provided expression syntactically valid?

feature {NONE} -- Implementation

	parse_parameters (pars: STRING) is
			-- Fill in `parameters'.
		require
			pars_not_void: pars /= Void
		local
			i: INTEGER
			start: INTEGER
		do
			from
				i := 1
				start := 1
			until
				i > pars.count
			loop
				if pars.item (i) = ',' then
					if i <= start then
						syntax_error := True
					else
						parameters.extend (create {like Current}.make_like (Current, pars.substring (start, i - 1)))
						start := i + 1
					end
				end
				i := i + 1
			end
				-- Don't forget the last parameter.
			if i <= start then
				syntax_error := True
			else
				parameters.extend (create {like Current}.make_like (Current, pars.substring (start, i - 1)))
				start := i + 1
			end
				-- If one parameter has a syntax error, propagate it.
			from
				parameters.start
			until
				parameters.after or syntax_error
			loop
				syntax_error := parameters.item.syntax_error
				parameters.forth
			end
		end

	is_blank (c: CHARACTER): BOOLEAN is
			-- Is `c' blank?
		do
			Result := c = ' ' or c = '%T'
		end

	set_feature_name (fn: STRING) is
			-- Attempt to set `feature_name' to `fn'.
			-- Check in the process that `fn' is a valid feature name.
			-- Do nothing if there already was a syntax error.
		require
			valid_fn: fn /= Void
		do
			fn.left_adjust
			fn.right_adjust
			fn.to_lower
			if fn.is_empty then
				syntax_error := True
			elseif fn.item (1) = '%"' then
				if fn.item (fn.count) = '%"' then
					is_constant := True
					constant_result_type := System.string_class.compiled_class
					constant_result_value := create {DUMP_VALUE}.make_manifest_string (
													fn.substring (2, fn.count - 1),
													constant_result_type
												)
				else
					syntax_error := True
				end
			elseif fn.is_integer then
				is_constant := True
				constant_result_type := System.integer_32_class.compiled_class
				constant_result_value := create {DUMP_VALUE}.make_integer (fn.to_integer, constant_result_type)
			elseif fn.is_real then
				is_constant := True
				constant_result_type := System.real_class.compiled_class
				constant_result_value := create {DUMP_VALUE}.make_real (fn.to_real, constant_result_type)
			elseif fn.is_double then
				is_constant := True
				constant_result_type := System.double_class.compiled_class
				constant_result_value := create {DUMP_VALUE}.make_double (fn.to_double, constant_result_type)
			elseif fn.is_boolean then
				is_constant := True
				constant_result_type := System.boolean_class.compiled_class
				constant_result_value := create {DUMP_VALUE}.make_boolean (fn.to_boolean, constant_result_type)
			elseif fn.is_equal (infix_feature_name_with_symbol ("=")) then
				is_equality_test := True
			elseif fn.is_equal (infix_feature_name_with_symbol ("/=")) then
				is_non_equality_test := True
			elseif Syntax_checker.is_valid_feature_name (fn) then
				-- Nothing special.
			else
				syntax_error := True
			end
			if not syntax_error then
				feature_name := fn
			end
		ensure
			set_if_valid: (not syntax_error) implies (
							(Syntax_checker.is_valid_feature_name (feature_name) or
							 Syntax_checker.is_constant (feature_name) or
							 is_equality_test or is_non_equality_test
							) and
							(feature_name = fn)
						  )
			valid_flags: (not syntax_error) implies (
						 (is_identity = feature_name.is_equal (Identity)) and
						 (is_equality_test = feature_name.is_equal (infix_feature_name_with_symbol ("="))) and
						 (is_non_equality_test = feature_name.is_equal (infix_feature_name_with_symbol ("/=")))
						 )
		end

	remove_prefix_operators (s: STRING) is
			-- Remove prefix operators from the head of `s' and put them as function calls at the end.
		local
			op: STRING
			i: INTEGER
			ops: ARRAYED_LIST [STRING]
		do
			if not s.is_empty then
				from
					i := 1
					create ops.make (5)
					op := operator_starting_at (i, s)
				until
					(i > s.count) or else (not is_blank (s.item (i)) and op = Void)
				loop
					if op /= Void then
						s.keep_tail (s.count - (op.count + i - 1))
						ops.extend (op)
						i := 0
					end
					i := i + 1
					op := operator_starting_at (i, s)
				end
				from
					ops.finish
				until
					ops.before
				loop
					s.append_character ('.')
					s.append (prefix_feature_name_with_symbol (ops.item))
					ops.back
				end
			end
		end

	operator_starting_at (pos: INTEGER; s: STRING): STRING is
			-- If an operator starts at `pos' in `s', return its symbol.
		local
			i: INTEGER
			cop: STRING
		do
			if (pos = 1) or else is_blank (s.item (pos - 1)) then
				if Syntax_checker.Free_operators_start.has (s.item (pos)) then
						-- A free operator is surrounded by blanks
					from
						i := pos + 1
					until
						i > s.count or else is_blank (s.item (i))
					loop
						i := i + 1
					end
					Result := s.substring (pos, i - 1)
				end
			end
			if Result = Void then
				if s.item (pos) = '=' then
					Result := "="
				elseif (s.item (pos) = '/') and (pos < s.count) and then (s.item (pos + 1) = '=') then
					Result := "/="
				end
			end
			from
				Syntax_checker.Basic_operators.start
			until
				Syntax_checker.Basic_operators.after
			loop
				cop := Syntax_checker.Basic_operators.item
				if s.substring (pos, pos + cop.count - 1).is_equal (cop) then
						-- Ah! We may have found a matching operator.
					if (Result = Void) or else (Result.count < cop.count) then
							-- Aaahh... We found a longer matching operator.
						if cop.item (1).is_alpha then
								-- Hmm we must check that it is surrounded by spaces.
							if
								(pos + cop.count <= s.count) and then
								(is_blank (s.item (pos + cop.count))) and
								((pos = 1) or (pos > 1 and then is_blank (s.item (pos - 1))))
							then
								Result := cop
							end
						else
							Result := cop
						end
					end
				end
				Syntax_checker.Basic_operators.forth
			end
		end

feature {NONE} -- Implementation data

	syntax_checker: EIFFEL_SYNTAX_CHECKER is
			-- Helper that validates feature names.
			--| `once' only for optimization reasons (no need to create zillions of empty objects).
		once
			create Result
		end

	Identity: STRING is "identity"
			-- Feature name when `is_identity'.

	Result_name: STRING is "result"
			-- Name of the 'Result' debug value.

feature {NONE} -- Implementation: Contract support

	flag_sum: INTEGER is
			-- How many flags are set?
			-- For invariant purposes only.
		do
			if on_object then
				Result := Result + 1
			end
			if on_class then
				Result := Result + 1
			end
			if on_context then
				Result := Result + 1
			end
		end

invariant
	good_flags: flag_sum = 1
	valid_context: ((context_address /= Void) = on_object) and
					(on_class implies (context_class /= Void))
	valid_expression: valid_expression (expression)
	identity_consistency: is_identity = (feature_name = Identity)

end -- class DBG_EXPRESSION
