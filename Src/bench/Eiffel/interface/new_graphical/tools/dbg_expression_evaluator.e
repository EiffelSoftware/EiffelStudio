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

	make_as_object (addr: like context_address) is
		do
			set_context_address (addr)
			set_as_object  (True)
			set_on_object  (True)
			set_on_context (False)
			set_on_class   (False)
		end

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

	set_as_object (v: like as_object) is
			-- set value of `as_object' with `v'
		do
			as_object := v
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

	as_object: BOOLEAN
			-- Is the expression pointing to the object ?

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
	
feature {NONE} -- Error code

	cst_error_evaluation: INTEGER is -1
	cst_error_expression: INTEGER is -2
	cst_error_exception: INTEGER is -3
	cst_error_not_implemented: INTEGER is -9
	
feature {NONE} -- Error message values
	
	Cst_error_call_on_void_target: STRING is "Error: Call on void target "

	Cst_error_context_corrupted_or_not_found:STRING is "Context corrupted or not found"

	Cst_error_during_expression_analyse: STRING is "Error during expression analyse"

	Cst_error_type_checking_failed : STRING is "Type checking failed"

	Cst_error_evaluation_failed_with_exception: STRING is "Evaluation failed with an exception"

	Cst_error_not_yet_ready: STRING is " : sorry not yet ready"

	Cst_error_report_to_support: STRING is " => ERROR : please report to support"

	Cst_error_other_than_func_cst_once_not_available: STRING is " => ERROR : other than function, constant and once : not available"

	Cst_error_during_evaluation_of_external_call: STRING is " => ERROR during evaluation of external call : "

	Cst_error_evaluating_parameter: STRING is " => Error evaluating parameter"

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
			dbg_expression_valid_syntax: as_object or else not dbg_expression.syntax_error
			running_and_stopped: Application.is_running and Application.is_stopped
		deferred
		ensure
			error_message_if_failed: (final_result_value = Void 
										and	final_result_static_type = Void
										and final_result_type = Void)
									implies (error_occurred)
		end
		

end -- class DBG_EXPRESSION_EVALUATOR
