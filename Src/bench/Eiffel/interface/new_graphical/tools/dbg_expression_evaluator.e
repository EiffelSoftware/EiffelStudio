indexing
	description : "Objects used to evaluate a DBG_EXPRESSION ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	DBG_EXPRESSION_EVALUATOR

inherit
	ANY
	
	SHARED_DBG_EVALUATOR
		export
			{NONE} all
		end
		
	SHARED_DEBUG
		export
			{ANY} Application
			{NONE} all
		end	

feature {NONE} -- Initialization

	make_with_expression (expr: like dbg_expression) is
			-- Create Current from `expr'.
		require
			expr_not_void: expr /= Void
		do
			dbg_expression := expr
		end

feature -- change

	set_on_class (v: like on_class) is
			-- set value of `on_class' with `v'
		do
			on_class := v
		end
		
	set_on_object (v: like on_object) is
			-- set value of `on_object' with `v'	
		do
			on_object := v
		end
		
	set_on_context (v: like on_context) is
			-- set value of `on_context' with `v'	
		do
			on_context := v
		end		
		
	set_context_class (c: like context_class) is
			-- set value of `context_class' with `c'
		do
			context_class := c
		end
		
	set_context_address (c: like context_address) is
			-- set value of `context_address' with `c'
		do
			context_address := c
		end		

feature -- Properties

	dbg_expression: DBG_EXPRESSION
			-- Current expression to evaluate

	on_class: BOOLEAN
			-- Is the expression relative to a class ?
	
	on_object: BOOLEAN
			-- Is the expression relative to an object ?

	on_context: BOOLEAN
			-- Is the expression relative to a context ?	

	context_class_type: CLASS_TYPE
			-- Class related to the target, in on_object context	
	
	context_class: CLASS_C
			-- Class related to the expression
	
	context_address: STRING
			-- Object's address related to the expression	

feature -- Change

	reset_error is
		do
			error := 0
			error_message := Void
			error_tag := Void
		end

	set_error_evaluation (mesg: STRING) is
		do
			error := cst_error_evaluation
			error_message := mesg
		end

	set_error_exception (mesg: STRING) is
		do
			error := cst_error_exception
			error_message := mesg
		end

	set_error_expression_and_tag (mesg: STRING; t: STRING) is
		do
			error := cst_error_expression
			error_message := mesg
			error_tag := t
		end

	set_error_expression (mesg: STRING) is
		do
			error := cst_error_expression
			error_message := mesg
		end

	set_error_not_implemented (mesg: STRING) is
		do
			error := cst_error_not_implemented
			error_message := mesg
		end
	
feature -- Error code

	cst_error_evaluation: INTEGER is -1
	cst_error_expression: INTEGER is -2
	cst_error_exception: INTEGER is -3
	cst_error_not_implemented: INTEGER is -9

feature -- Access

	is_error_evaluation: BOOLEAN is
		do
			Result := error = cst_error_evaluation
		end

	is_error_expression: BOOLEAN is
		do
			Result := error = cst_error_expression
		end

	is_error_exception: BOOLEAN is
		do
			Result := error = cst_error_exception
		end

	is_error_not_implemented: BOOLEAN is
		do
			Result := error = cst_error_not_implemented
		end

	error: INTEGER
	
	error_tag: STRING
			-- Short error message if needed

	error_message: STRING
			-- Error's message if any otherwise Void
	
	error_occurred: BOOLEAN is
			-- Did an error occurred ?
		do
			Result := error < 0
		end		
	
	is_condition (f: FEATURE_I): BOOLEAN is
			-- is feature `f' a condition ?
		require
			valid_f: f /= Void
			no_error: not dbg_expression.syntax_error
			good_state: f.written_class /= Void and then f.written_class.has_feature_table
		deferred
		end

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

	final_result_is_true_boolean_value: BOOLEAN is
			-- if final_result is a boolean
			-- return its value
			-- otherwise return False .
		do
			Result := final_result_type.is_basic
				and then final_result_value.is_type_boolean
				and then final_result_value.value_boolean
		end

	final_result_static_type: CLASS_C
			-- Static type of `Current'.
			-- Only used and set in `is_condition', not in `evaluate' or `set_expression'.

feature -- Evaluation

	evaluate is
			-- Compute the value of the last message of `Current'.
		require
			dbg_expression_valid_syntax: not dbg_expression.syntax_error
			running_and_stopped: Application.is_running and Application.is_stopped
		deferred
		ensure
			error_message_if_failed: ((final_result_value = Void) implies (error_occurred)) and
									 ((final_result_static_type = Void) implies (error_occurred)) and
									 ((final_result_type = Void) implies (error_occurred))
		end

end -- class DBG_EXPRESSION_EVALUATOR
