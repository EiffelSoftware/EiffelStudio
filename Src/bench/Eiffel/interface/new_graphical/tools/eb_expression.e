indexing
	description: "Abstraction of an expression as in %"expression evaluation%" in the debugger.%
				%Note that it is not possible to change the type of the expression dynamically%
				%(i.e it is not possible to switch from an object-related expression to%
				%a class-related one, etc.)."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPRESSION

inherit
	ANY

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_class,
	make_with_object,
	make_for_context

feature {NONE} -- Initialization

	make_with_object (obj: DEBUGGED_OBJECT; new_expr: STRING) is
			-- Initialize `Current' and link it to an object `obj' whose dynamic type is `dtype'.
			-- Initialize the expression to `new_expr'.
		require
			valid_object: obj /= Void
			valid_class: obj.dtype /= Void and then obj.dtype.is_valid
			valid_expression: valid_expression (new_expr)
		do
			on_object := True
			context_address := obj.object_address
			context_class := obj.dtype
			create_expression (new_expr)
		end

	make_with_class (cl: CLASS_C; new_expr: STRING) is
			-- Initialize `Current' and link it to a class `cl'.
			-- Initialize the expression to `new_expr'.
		require
			valid_class: cl /= Void and then cl.is_valid
			valid_expression: valid_expression (new_expr)
		do
			on_class := True
			context_class := cl
			create_expression (new_expr)
		end

	make_for_context (new_expr: STRING) is
			-- Initialize `Current' and link it to the context.
			-- Initialize the expression to `new_expr'.
		require
			valid_expression: valid_expression (new_expr)
		do
			on_context := True
			create_expression (new_expr)
		end
		
	create_expression (new_expr: STRING) is
			-- create `dbg_expression' from `new_expr' text
		do
			create {DBG_EXPRESSION_B} dbg_expression.make_with_expression (new_expr)
		end

feature -- Recycling

	recycle is
			-- Recycle data
			-- in order to free special data (for instance dotnet references)
		do
			reset_expression_evaluator
		end

feature {NONE} -- Expression validator

	valid_expression (expr: STRING): BOOLEAN is
			-- Is `expr' a valid expression?
		do
			Result := expr /= Void
			if Result then
				Result := not expr.has ('%R') and not expr.has ('%N')
			end
		end

feature -- Status

	enable_evaluation is
			-- Enable evaluation of Current expression
		do
			evaluation_disabled := False
		end
		
	disable_evaluation is
			-- Disable evaluation of Current expression
		do
			evaluation_disabled := True
		end
		
	evaluation_disabled: BOOLEAN
			-- Is Current expression evaluation disabled ?
			
	evaluation_enabled: BOOLEAN is
			-- Is Current expression evaluation enabled ?	
		do
			Result := not evaluation_disabled
		end

feature -- Status report

	is_condition (f: E_FEATURE): BOOLEAN is
			-- Is `Current' a condition (boolean query) in the context of `f'?
		require
			valid_f: f /= Void
			no_error: not dbg_expression.syntax_error
			good_state: f.written_class /= Void and then f.written_class.has_feature_table
		do
			Result := expression_evaluator.is_condition (f)
		end

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

	context: STRING is
			-- Return a string representing `Current's context.
		do
			if on_class then
				Result := context_class.name_in_upper
			elseif on_object then
				Result := context_address
			else
				Result := interface_names.l_Current_context
			end
		end

feature -- Bridge to dbg_expression_evaluator

	error_message: STRING is
			-- Error message text if any error occurred
		do
			if Result = Void and then expression_evaluator /= Void then
				Result := expression_evaluator.error_message
			end
		end
		
feature -- Bridge to dbg_expression
		
	syntax_error: BOOLEAN is
			-- Is there a syntax error in dbg_expression ?
		do
			Result := dbg_expression.syntax_error
		end
		
	expression: STRING is
			-- Expression text
		do
			Result := dbg_expression.expression
		end

feature {EB_EXPRESSION_DEFINITION_DIALOG, EB_EXPRESSION_EVALUATOR} -- Restricted Bridge to dbg_expression

	set_expression (expr: STRING) is
			-- Set string value for `dbg_expression'
		do
			dbg_expression.set_expression (expr)
			internal_evaluator := Void
		end

feature {EB_EXPRESSION, EB_EXPRESSION_EVALUATOR_TOOL, EB_EXPRESSION_DEFINITION_DIALOG, DBG_EXPRESSION_EVALUATOR} -- Status report: Propagate the context and the results.

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
		
feature -- Basic operations

	dbg_expression: DBG_EXPRESSION
			-- Object representing the expression to evaluate

	evaluate is
			-- Evaluate `dbg_expression' with `expression_evaluator'
		require
			valid_syntax: not dbg_expression.syntax_error
		do
			expression_evaluator.evaluate
		end

	expression_evaluator: DBG_EXPRESSION_EVALUATOR is
			-- Expression_evaluator used to evaluate DBG_EXPRESSION
		do
			Result := internal_evaluator
			if Result = Void then
				create_internal_evaluator
				Result := internal_evaluator
			end
		end		

	reset_expression_evaluator is
			-- Reset expression_evaluator
		do
			internal_evaluator := Void
		end
		
	create_internal_evaluator is
			-- Create internal_evaluator
		local
			l_expr_b: DBG_EXPRESSION_B
		do
			if internal_evaluator = Void then
				l_expr_b ?= dbg_expression
				check
					l_expr_b_not_void: l_expr_b /= Void
				end
				create {DBG_EXPRESSION_EVALUATOR_B} internal_evaluator.make_with_expression (l_expr_b)
				internal_evaluator.set_context_class (context_class)
				internal_evaluator.set_context_address (context_address)
				internal_evaluator.set_on_class (on_class)
				internal_evaluator.set_on_context (on_context)
				internal_evaluator.set_on_object (on_object)				
			end			
		end

	internal_evaluator: like expression_evaluator
			-- internal value for the once per object `expression_evaluator'

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

end -- class EB_EXPRESSION
