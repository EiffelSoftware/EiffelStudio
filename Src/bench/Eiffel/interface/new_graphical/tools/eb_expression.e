indexing
	description: "Abstraction of an expression as in %"expression evaluation%" in the debugger.%
				%Note that it is not possible to change the type of the expression dynamically%
				%(i.e it is not possible to switch from an object-related expression to%
				%a class-related one, etc.)."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPRESSION

inherit
	SHARED_DEBUG

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_DEBUG_TOOLS
		export
			{NONE} all
		end

	RECV_VALUE
		export
			{NONE} all
		end

	DEBUG_EXT
		export
			{NONE} all
		end

	IPC_SHARED
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_INST_CONTEXT
		export
			{NONE} all
		end

	PREFIX_INFIX_NAMES
		export
			{NONE} all
		end

	COMPILER_EXPORTER
			--| Just to be able to access E_FEATURE::associated_feature_i :(
		export
			{NONE} all
		end

create
	make_with_class,
	make_with_object,
	make_for_context

create {EB_EXPRESSION}
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

	make_with_object (obj: DEBUGGED_OBJECT; new_expr: STRING) is
			-- Initialize `Current' and link it to an object `obj' whose dynamic type is `dtype'.
			-- Initialize the expression to `new_expr'.
		require
			valid_object: obj /= Void
			valid_class: obj.dtype /= Void and then obj.dtype.is_valid
			valid_expression: valid_expression (new_expr)
		do
			on_object := True
			context_object := obj
			context_class := obj.dtype
			Debugger_manager.kept_objects.extend (obj.object_address)
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

	make_with_target (tgt: EB_EXPRESSION; new_expr: STRING) is
			-- Initialize `Current' and link it to its target `tgt'.
			-- Initialize the expression to `new_expr'.
			-- Used to initialize messages.
		require
			valid_target: tgt /= Void
			valid_expression: valid_expression (new_expr)
		do
				--| Propagate the initial context.
			target := tgt
			on_context := target.on_context
			on_class := target.on_class
			on_object := target.on_object
			context_object := target.context_object
			context_class := target.context_class
			
			set_expression (new_expr)
		end

	make_like (other: EB_EXPRESSION; new_expr: STRING) is
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
			context_object := other.context_object
			context_class := other.context_class
			
			set_expression (new_expr)
		end

feature -- Status setting

	--| From the client's point of view, an expression is a string plus a context, basically.
	--| Internally the string is split into as many parts as it contains features,
	--| and each of these parts is an expression on its own.

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
			rest: STRING
			op: STRING
			look_for_op: BOOLEAN
		do
				-- Reinitialize everything.
			error_message := Void
			feature_name := Void
			is_constant := False
			constant_result_type := Void
			constant_result_value := Void
			is_identity := False
			message := Void
			create parameters.make (5)
			syntax_error := False
			expression := new_expr
			
			s := clone (expression)
			remove_prefix_operators (s)
			s.left_adjust
			s.right_adjust
			look_for_op := s.count < Prefix_str.count or else
							(s.substring_index_in_bounds (Prefix_str, 1, Prefix_str.count) /= 1 and
							s.substring_index_in_bounds (Infix_str, 1, Infix_str.count) /= 1)
			from
				i := 1
			until
					-- We can stop as soon as we find the first dot or operator: other parentheses do not concern us.
				i > s.count or first_dot > 0 or first_op > 0
			loop
				cc := s.item (i)
				if cc = '(' then
					if open_pars = 0 then
						if par1 = 0 then
							par1 := i
						else
								-- *(*)X(*)* where X contains neither . nor operator is not a valid syntax.
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
					-- The first character is a parenthesis => we hack with the identity feature.
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
				s.tail (s.count - (first_op + op.count - 1))
				s.prepend (infix_feature_name_with_symbol (op) + "(")
				s.append_character (')')
				create message.make_with_target (Current, s)
				syntax_error := syntax_error or message.syntax_error
			end
		ensure
			expression_set: expression = new_expr
			feature_name_if_not_error: (not syntax_error) implies (feature_name /= Void)
		end

feature -- Status report

	valid_expression (expr: STRING): BOOLEAN is
			-- Is `expr' a valid expression?
		do
			Result := expr /= Void
			if Result then
				Result := not expr.has ('%R') and not expr.has ('%N')
			end
		end

	expression: STRING
			-- Expression that is evaluated by `Current'.

	syntax_error: BOOLEAN
			-- Is the provided expression syntactically valid?

	is_still_valid: BOOLEAN is
			-- Is `Current' still valid?
			-- Should be checked when a debugging session starts.
		do
			Result :=
				--| If `Current' relies on an object, it is clearly
				--| no longer valid when a new debugging session starts.
				not on_object and then
				--| If `Current' relies on an class, the class it relies on
				--| must be valid itself and correctly compiled.
				(not on_class or else
				(context_class.is_valid and then context_class.has_feature_table))
		end

--	final_result: ABSTRACT_DEBUG_VALUE
			-- Result of the last message of `Current'.
			--| Only valid after `evaluate' was called.

	final_result_type: CLASS_C
			-- Dynamic type of `final_result'.
			--| Should be its dynamic type, but for implementation reasons
			--| it may be the static type instead.
			--| Only valid after `evaluate' was called.

	final_result_value: DUMP_VALUE
			-- In case `Current' doesn't produce an ABSTRACT_DEBUG_VALUE,
			-- it returns a DUMP_VALUE (which doesn't represent an object, just a value).
			-- This is the case for constants.
			-- Note: it is not possible to call features on expressions that do not
			-- return an object.

	error_message: STRING
			-- If `Current' or one of its descendants couldn't be evaluated,
			-- return an explanatory message.

	context: STRING is
			-- Return a string representing `Current's context.
		do
			if on_class then
				Result := context_class.name_in_upper
			elseif on_object then
				Result := context_object.object_address
			else
				Result := interface_names.l_Current_context
			end
		end

feature -- Basic operations

	evaluate is
			-- Compute the value of the last message of `Current'.
		require
			valid_syntax: not syntax_error
			running_and_stopped: Application.is_running and Application.is_stopped
		local
			f: E_FEATURE
			o: DEBUGGED_OBJECT
			par1: EB_EXPRESSION
		do
			error_message := Void
			result_object := Void
			result_static_type := Void
			final_result_type := Void
			final_result_value := Void
			if is_identity then
				check
					parameters.count = 1
					-- Otherwise there would have been a syntax error.
				end
				par1 := parameters.first
				par1.evaluate
				result_object := par1.result_object
				result_static_type := par1.result_static_type
				error_message := par1.error_message
			elseif is_constant then
				result_object := constant_result_value
				result_static_type := constant_result_type
			elseif target /= Void then
					-- Use the target to get the context.
				check
					-- The target shouldn't have propagated the evaluation if it had no result.
					target.result_static_type /= Void
					target.result_object /= Void
					target.result_type /= Void
					-- The target shouldn't have propagated the evaluation if it found an error.
					target.error_message = Void
				end
				f := target.result_static_type.feature_with_name (feature_name)
				if f /= Void then
					f := f.ancestor_version (target.result_type)
					if f /= Void then
						o := dump_to_object (target.result_object)
						if o /= Void then
							evaluate_feature_on_object (f, o)
						else
							--| FIXME XR: Handle calls on basic types.
							error_message := "Cannot evaluate " + feature_name + " because its target is not an object"
						end
					else
						error_message := "Feature named " + feature_name + 
										" has no descendant in class " + target.result_type.name_in_upper
					end
				else
					error_message := "No feature named " + feature_name + 
									" in class " + target.result_static_type.name_in_upper
				end
			elseif on_class then
					-- That's easy: we can only evaluate a constant or a once.
				f := context_class.feature_with_name (feature_name)
				if f /= Void then
					evaluate_feature_on_class (f)
				else
					error_message := "No feature named " + feature_name + 
									" in class " + context_class.name_in_upper
				end
			elseif on_object then
				f := context_class.feature_with_name (feature_name)
				if f /= Void then
					evaluate_feature_on_object (f, context_object)
				else
					error_message := "No feature named " + feature_name + 
									" in class " + context_class.name_in_upper
				end
			else
				check
					on_context
					-- Last possible flag.
				end
				-- First try to match `feature_name' in the locals/result and then in the features of the current object.
				find_item_in_context (feature_name)
				if result_object = Void then
						-- Keep the previous error message if any: it may be more specific.
					if error_message = Void then
						error_message := "Could not resolve " + feature_name + " in current context"
					end
				end
			end
			if error_message = Void then
					-- Wow, there have been no errors yet!
				if message /= Void then
					if result_object /= Void and result_static_type = Void then
						error_message := "Could not resolve static type of " + feature_name
					elseif result_object /= Void then
							-- We must evaluate the message.
						if result_type /= Void then
							message.evaluate
							if message.error_message /= Void then
								error_message := message.error_message
							else
								final_result_value := message.final_result_value
								final_result_type := message.final_result_type
							end
						elseif result_object.is_void then
							error_message := feature_name + " has a Void result"
						else
							error_message := "Could not evaluate the dynamic type of " + feature_name
						end
					else
						error_message := "Could not evaluate " + expression
					end
				else
					final_result_value := result_object
					if result_type /= Void then
						final_result_type := result_type
					elseif result_object.is_void then
						final_result_type := result_static_type
					else
						error_message := "Could not evaluate the type of " + expression
					end
				end
			end
		ensure
			error_message_if_failed: ((final_result_value = Void) implies (error_message /= Void)) and
									 ((final_result_type = Void) implies (error_message /= Void))
		end

feature {EB_EXPRESSION, EB_EXPRESSION_DEFINITION_DIALOG, EB_EXPRESSION_EVALUATOR} -- Status report: Propagate the context and the results.

	on_object: BOOLEAN
			-- Is the expression relative to an object?

	on_class: BOOLEAN
			-- Is the expression relative to a class (the expression must be a once/constant).

	on_context: BOOLEAN
			-- Is the expression to be evaluated in the current call stack element context?

	context_class: CLASS_C
			-- Class the expression refers to (only valid if `on_class').
	
	context_object: DEBUGGED_OBJECT
			-- Object the expression refers to (only valid if `on_object')

feature {EB_EXPRESSION} -- Status report: intermediate results.

	result_type: CLASS_C is
			-- Type of the result of `Current'.
			--| Only valid after `evaluate' was called.
			--| Used to evaluate the message.
		require
			evaluated: result_object /= Void
		do
			Result := result_object.dynamic_type
		end

	result_static_type: CLASS_C
			-- Declared type of the result of `Current'.
			--| Only valid after `evaluate' was called.
			--| Used to find the feature that corresponds to the message.

	result_object: DUMP_VALUE
			-- Result of `Current'.
			--| Only valid after `evaluate' was called.

feature {NONE} -- Internal status

	is_constant: BOOLEAN
			-- Does `Current' operate on a constant?

	constant_result_value: DUMP_VALUE
			-- Value associated to a constant expression.
	
	constant_result_type: CLASS_C
			-- Type associated to a constant expression.
	
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
						parameters.extend (create {EB_EXPRESSION}.make_like (Current, pars.substring (start, i - 1)))
						start := i + 1
					end
				end
				i := i + 1
			end
				-- Don't forget the last parameter.
			if i <= start then
				syntax_error := True
			else
				parameters.extend (create {EB_EXPRESSION}.make_like (Current, pars.substring (start, i - 1)))
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
		local
			i, first_weird, last_weird: INTEGER
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
					constant_result_value := create {DUMP_VALUE}.make_manifest_string (fn.substring (2, fn.count - 1), constant_result_type)
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
						(Syntax_checker.is_valid_feature_name (feature_name) or Syntax_checker.is_constant (feature_name)) and
						(feature_name = fn)
					)
		end

	remove_prefix_operators (s: STRING) is
			-- Remove prefix operators from the head of `s' and put them as function calls at the end.
		local
			op: STRING
			i: INTEGER
			ops: ARRAYED_LIST [STRING]
		do
			from
				i := 1
				create ops.make (5)
				op := operator_starting_at (i, s)
			until
				(i > s.count) or else (not is_blank (s.item (i)) and op = Void)
			loop
				if op /= Void then
					s.tail (s.count - (op.count + i - 1))
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
								(pos > 1 and then is_blank (s.item (pos - 1)))
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

	find_closing_parenthesis (s: STRING; pos: INTEGER): INTEGER is
			-- Find the closing parenthesis that corresponds to the one at position `pos' in `s'.
			-- Return `s.count + 1' if it couldn't be found.
		require
			valid_pos: pos > 0 and pos < s.count
			is_opening_parenthesis: s.item (pos) = '('
		local
			i: INTEGER
			cc: CHARACTER
			open_pars: INTEGER
		do
			from
				i := pos + 1
				open_pars := 1
			until
				i > s.count or open_pars = 0
			loop
				cc := s.item (i)
				if cc = '(' then
					open_pars := open_pars + 1
				elseif cc = ')' then
					open_pars := open_pars - 1
				end
				i := i + 1
			end
		ensure
			valid_result: Result > pos
			is_closing: (Result < s.count) implies (s.item (Result) = ')')
			invalid_string_if_invalid_result: (Result > s.count) implies
					((s.substring (pos, s.count).occurrences ('(')) >
					 (s.substring (pos, s.count).occurrences (')')))
		end

	find_next_blank (s: STRING; pos: INTEGER): INTEGER is
			-- Find next blank character, starting at `pos' in `s'.
			-- Return `s.count + 1' if it couldn't be found.
		require
			valid_pos: pos > 0 and pos < s.count
		local
			i: INTEGER
		do
			from
				i := pos
			until
				i > s.count or else is_blank (s.item (i))
			loop
				i := i + 1
			end
		ensure
			valid_result: Result > pos
			is_blank: (Result < s.count) implies is_blank (s.item (Result))
		end

	find_next_non_blank (s: STRING; pos: INTEGER): INTEGER is
			-- Find next non_blank character, starting at `pos' in `s'.
			-- Return `s.count + 1' if it couldn't be found.
		require
			valid_pos: pos > 0 and pos < s.count
		local
			i: INTEGER
		do
			from
				i := pos
			until
				i > s.count or else is_blank (s.item (i))
			loop
				i := i + 1
			end
		ensure
			valid_result: Result > pos
			is_not_blank: (Result < s.count) implies not is_blank (s.item (Result))
		end

	evaluate_feature_on_class (f: E_FEATURE) is
			-- Evaluate `f' in the context of its dynamic_class
		require
			valid_feature: f /= Void
		do
			if f.is_once and f.is_function then
				evaluate_once (f)
			elseif f.is_constant then
				evaluate_constant (f)
			else
				error_message := "Cannot evaluate non-once feature " + f.name
			end
		end

	evaluate_feature_on_object (sf: E_FEATURE; obj: DEBUGGED_OBJECT) is
			-- Evaluate `sf' in the context of its dynamic_class.
			-- Evaluate and pass `parameters' if necessary.
		require
			valid_feature: sf /= Void
			valid_object: obj /= Void
		local
			lst: LIST [ABSTRACT_DEBUG_VALUE]
			dmp: DUMP_VALUE
			found: BOOLEAN
			par: INTEGER
			f: E_FEATURE
			fid: INTEGER
			rout_info: ROUT_INFO
			dv: ABSTRACT_DEBUG_VALUE
		do
			f := sf.ancestor_version (obj.dtype)
			if f = Void then
				error_message := "No descendant of feature " + sf.name + " in class " + obj.dtype.name_in_upper
			elseif f.associated_feature_i.is_once and f.type /= Void then
				evaluate_once (f)
			elseif f.is_attribute then
				lst := obj.attributes
				dv := find_item_in_list (f.name, lst)
				result_static_type := f.type.associated_class
				if dv = Void then
					if f.name.is_equal ("Void") then
						create result_object.make_object (Void, Void)
					else
						error_message := "Could not find attribute value for " + f.name
					end
				else
					result_object := dv.dump_value
				end
			elseif f.is_constant then
				evaluate_constant (f)
			elseif f.is_function then
					-- Evaluate the parameters.
				evaluate_parameters
					-- Check the number and type of parameters.
				if f.argument_count /= parameters.count then
					error_message := "Wrong number of parameters for " + f.name
				else
					from
						parameters.start
					until
						parameters.after or error_message /= Void
					loop
						if
							not parameters.item.final_result_type.conforms_to (
								f.arguments.i_th (parameters.index).associated_class
							)
						then
							error_message := "Invalid parameter: " + parameters.item.expression
						end
						parameters.forth
					end
				end
					-- Initialize the communication.
				Init_recv_c
					-- Send the parameters.
				from
					parameters.start
				until
					parameters.after or error_message /= Void
				loop
					dmp := get_expression_dump (parameters.item)
					if dmp = Void then
						error_message := "Could not evaluate " + parameters.item.expression
					else
						dmp.send_value
					end
					parameters.forth
				end
				if error_message = Void then
						-- Send the target object.
					create dmp.make_object (obj.object_address, obj.dtype)
					dmp.send_value
						-- Send the final request.
					if f.is_external then
						par := 1
					end
					if f.written_class.is_precompiled then
						par := par + 2
						rout_info := System.rout_info_table.item (f.rout_id_set.first)
						send_rqst_3 (Rqst_dynamic_eval, rout_info.offset, rout_info.origin, par)
					else
						send_rqst_3 (Rqst_dynamic_eval, f.feature_id, obj.class_type.static_type_id - 1, par)
					end
						-- Receive the Result.
					c_recv_value (Current)
					if item /= Void then
						item.set_hector_addr
						result_object := item.dump_value
						result_static_type := f.type.associated_class
					else
						error_message := "Could not evaluate function " + f.name
					end
				end
			else
				error_message := "Cannot evaluate command " + feature_name
			end
		end

	get_expression_dump (expr: EB_EXPRESSION): DUMP_VALUE is
			-- Retrieve the dump result of `expr'.
		require
			valid_expression: expr /= Void
		local
			dv: ABSTRACT_DEBUG_VALUE
		do
			Result := expr.final_result_value
		ensure
			no_errors_means_dump: (expr.error_message = Void) implies (Result /= Void)
		end

	evaluate_once (f: E_FEATURE) is
			-- Call the once function `f'.
		require
			valid_feature: f /= Void
			is_once: f.associated_feature_i.is_once and f.type /= Void
		local
			once_r: ONCE_REQUEST
		do
			once_r := debug_info.once_request
			if once_r.already_called (f) then
				result_object := once_r.once_result (f).dump_value
				result_static_type := f.type.associated_class
			else
				error_message := "Once feature " + f.name + " not called yet"
			end
		end

	evaluate_constant (f: E_FEATURE) is
			-- Find the value of constant feature `f'.
		require
			valid_feature: f /= Void
			is_constant: f.is_constant
		local
			val: STRING
			cv_cst: E_CONSTANT
		do
			cv_cst ?= f
			if cv_cst /= Void then
				val := cv_cst.value
				result_static_type := f.type.associated_class
				if val.is_integer then
					result_object := create {DUMP_VALUE}.make_integer (val.to_integer, result_static_type);
				elseif val.is_real then
					result_object := create {DUMP_VALUE}.make_real (val.to_real, result_static_type);
				elseif val.is_double then
					result_object := create {DUMP_VALUE}.make_double (val.to_double, result_static_type);
				elseif val.is_boolean then
					result_object := create {DUMP_VALUE}.make_boolean (val.to_boolean, result_static_type);
				else
					error_message := "Unknown constant type for " + feature_name
				end
			else
				error_message := "Unknown constant type for " + feature_name
			end
		end

	evaluate_parameters is
			-- Evaluate all parameters.
		do
			from
				parameters.start
			until
				parameters.after or error_message /= Void
			loop
				parameters.item.evaluate
				error_message := parameters.item.error_message
					-- FIXME XR: We must protect the parameters!
				parameters.forth
			end
		end

	value_to_object (dv: ABSTRACT_DEBUG_VALUE): DEBUGGED_OBJECT is
			-- Return a debugged_object corresponding to `dv', if any.
		require
			valid_dv: dv /= Void
		local
			cv_ref: REFERENCE_VALUE
			cv_spec: SPECIAL_VALUE
		do
			cv_ref ?= dv
			if cv_ref /= Void and then cv_ref.address /= Void then
				create Result.make (cv_ref.address, Min_slice_ref.item, Max_slice_ref.item)
			else
				cv_spec ?= dv
				if cv_spec /= Void then
					create Result.make (cv_spec.address, Min_slice_ref.item, Max_slice_ref.item)
				end
			end
		end

	dump_to_object (dump: DUMP_VALUE): DEBUGGED_OBJECT is
			-- Return a debugged_object corresponding to `dump', if any.
		require
			valid_dv: dump /= Void
		do
			if dump.address /= Void then
				create Result.make (dump.address, Min_slice_ref.item, Max_slice_ref.item)
			end
		end

	value_to_dump (dv: ABSTRACT_DEBUG_VALUE): DUMP_VALUE is
			-- Return a dump_value corresponding to `dv'.
		require
			valid_dv: dv /= Void
		do
			Result := dv.dump_value
		end

	find_item_in_context (n: STRING) is
			-- Try to find a debug value named `n' in the context of the current call stack element.
		require
			valid_name: n /= Void
			application_paused: Application.is_running and Application.is_stopped
		local
			lower_name: STRING
			cse: CALL_STACK_ELEMENT
			o: DEBUGGED_OBJECT
			cf, f: E_FEATURE
			pos, cnt: INTEGER
			locals: EIFFEL_LIST [TYPE_DEC_AS]
			t: TYPE_DEC_AS
			prev_class: CLASS_C
			prev_cluster: CLUSTER_I
			dv: ABSTRACT_DEBUG_VALUE
		do
			lower_name := clone (n)
			lower_name.to_lower
			cse := Application.status.current_stack_element
			if cse = Void then
				check
					False
					-- Shouldn't occur.
				end
			else
				cf := cse.routine
			end
			if cf = Void then
				check
					False
					-- Shouldn't occur.
				end
			elseif lower_name.is_equal (Result_name) then
					-- The wanted debug value is the feature result.
				dv := cse.result_value
				if dv /= Void then
					result_object := dv.dump_value
					if cf.type /= Void then
						result_static_type := cf.type.associated_class
					end
				end
			else
					-- Is it in the locals?
				dv := find_item_in_list (lower_name, cse.locals)
				if dv = Void then
						-- Is it in the arguments?
					dv := find_item_in_list (lower_name, cse.arguments)
					if dv = Void then
							-- Darn, if that's so, I'm gonna look through the current object's attributes and onces!
						f := cf.written_class.feature_with_name (n)
						if f /= Void then
							create o.make (cse.object_address, Min_slice_ref.item, Max_slice_ref.item)
							evaluate_feature_on_object (f, o)
						end
					else
						result_object := dv.dump_value
							-- Find the type of the corresponding argument.
						cf.argument_names.compare_objects
						pos := cf.argument_names.index_of (n, 1)
						result_static_type := cf.arguments.i_th (pos).associated_class
					end
				else
					result_object := dv.dump_value
						-- Find the type of the corresponding local.
						-- First, initialize the context.
					prev_class := System.current_class
					prev_cluster := Inst_context.cluster
					System.set_current_class (cf.written_class)
					Inst_context.set_cluster (cf.written_class.cluster)
						-- Then, iterate through all locals.
					locals := cf.locals
					if locals /= Void then
						from
							locals.start
						until
							locals.after
						loop
							t := locals.item
							if t /= Void then
								from
									pos := 1
									cnt := t.id_list.count
								until
									pos > cnt
								loop
									if t.item_name (pos).is_equal (n) then
										result_static_type := t.type.actual_type.associated_class
									end
									pos := pos + 1
								end
							end
							locals.forth
						end
					end
						-- Reset the context.
					System.set_current_class (prev_class)
					Inst_context.set_cluster (prev_cluster)
				end
			end
		end

	find_item_in_list (n: STRING; lst: LIST [ABSTRACT_DEBUG_VALUE]): ABSTRACT_DEBUG_VALUE is
			-- Try to find an item named `n' in list `lst'.
		require
			not_void: n /= Void
		do
			if lst /= Void then
				from
					lst.start
				until
					lst.after or Result /= Void
				loop
					if lst.item.name /= Void and then lst.item.name.is_equal (n) then
						Result := lst.item
					end
					lst.forth
				end
			end
		ensure
			same_name_if_found: (Result /= Void) implies (Result.name.is_equal (n))
		end

feature {NONE} -- Internal data

	target: EB_EXPRESSION
			-- Target for the call described by `Current'.

	message: EB_EXPRESSION
			-- Message part of `Current'.

	is_identity: BOOLEAN
			-- Does `Current' simply return its parameter?

	parameters: ARRAYED_LIST [EB_EXPRESSION]
			-- Parameters concerning `Current' at the first level.

	feature_name: STRING
			-- Name of the feature that is `Current's root.

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
	valid_context: ((context_object /= Void) = on_object) and
					((context_class /= Void) = on_class)
	valid_expression: valid_expression (expression)
	identity_consistency: is_identity = (feature_name = Identity)

end -- class EB_EXPRESSION
