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

	DBG_EXPRESSION
		export 
			{EB_EXPRESSION, EB_EXPRESSION_DEFINITION_DIALOG, EB_EXPRESSION_EVALUATOR}
				on_object, on_class, on_context, context_class, context_address
		end

	SHARED_DEBUG
		export
			{ANY} Application
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_DEBUG_TOOLS
		export
			{NONE} all
		end

	RECV_VALUE
		rename
			error as recv_error
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

	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
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
			set_expression (new_expr)
		end

feature -- Status report

	is_condition (f: E_FEATURE): BOOLEAN is
			-- Is `Current' a condition (boolean query) in the context of `f'?
		require
			valid_f: f /= Void
			no_error: not syntax_error
			good_state: f.written_class /= Void and then f.written_class.has_feature_table
		do
			find_static_type_in_context (f)
			Result := final_result_static_type = System.boolean_class.compiled_class
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

feature -- Basic operations

	evaluate is
			-- Compute the value of the last message of `Current'.
		require
			valid_syntax: not syntax_error
			running_and_stopped: Application.is_running and Application.is_stopped
		local
			f: E_FEATURE
			par1: EB_EXPRESSION
		do
			error_message := Void
			result_object := Void
			result_static_type := Void
			final_result_type := Void
			final_result_value := Void
			final_result_static_type := Void
			if is_identity then
				check
					parameters.count = 1
					-- Otherwise there would have been a syntax error.
				end
				par1 := parameters.first
				par1.evaluate
				result_object := par1.final_result_value
				result_static_type := par1.final_result_static_type
				error_message := par1.error_message
			elseif is_equality_test then
				evaluate_equal
			elseif is_non_equality_test then
				evaluate_different
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
						evaluate_feature_on_object (f, Void, target.result_type, target.result_object)
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
					evaluate_feature_on_object (f, context_address, context_class, Void)
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
								final_result_static_type := message.final_result_static_type
							end
						elseif result_object.is_void then
							error_message := feature_name + " has a Void result"
						else
							error_message := "Could not evaluate the dynamic type of " + feature_name
						end
					else
						error_message := "Could not evaluate " + feature_name
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
					final_result_static_type := result_static_type
				end
			end
		ensure
			error_message_if_failed: ((final_result_value = Void) implies (error_message /= Void)) and
									 ((final_result_static_type = Void) implies (error_message /= Void)) and
									 ((final_result_type = Void) implies (error_message /= Void))
		end

feature {EB_EXPRESSION} -- Status report: intermediate results.

	find_static_type_in_context (f: E_FEATURE) is
			-- Find the static type of `Current' in the context of `f'.
		require
			valid_f: f /= Void
			no_error: not syntax_error
			good_state: f.written_class /= Void and then f.written_class.has_feature_table
		local
			fargs: LIST [STRING]
			locals: EIFFEL_LIST [TYPE_DEC_AS]
			type: TYPE_A
			t: TYPE
			fi: FEATURE_I
			i: INTEGER
			prev_class: CLASS_C
			prev_cluster: CLUSTER_I
		do
			check
				not is_equality_test and not is_non_equality_test
				-- These cases imply we have a target.
			end
				-- First, initialize the context.
			prev_class := System.current_class
			prev_cluster := Inst_context.cluster
			System.set_current_class (f.written_class)
			Inst_context.set_cluster (f.written_class.cluster)
			
			result_static_type := Void
			if is_identity then
				check
					parameters.count = 1
					-- There would be a syntax error otherwise.
				end
				parameters.first.find_static_type_in_context (f)
				result_static_type := parameters.first.final_result_static_type
			elseif feature_name.is_equal (Result_name) then
					-- Ah, that's an easy one: we evaluate the result.
				type := f.type
				if type /= Void then
					result_static_type := type.actual_type.associated_class
				end
			else
					-- First look up in the feature arguments.
				if f.arguments /= Void then
					fargs := f.argument_names
					from
						fargs.start
					until
						fargs.after or result_static_type /= Void
					loop
						if fargs.item.is_equal (feature_name) then
							type := f.arguments.i_th (fargs.index)
							if type /= Void then
								result_static_type := type.actual_type.associated_class
							end
						end
						fargs.forth
					end
				end

					-- Then look up in the feature locals
				locals := f.locals
				if result_static_type = Void and then locals /= Void then
					from
						locals.start
					until
						locals.after or result_static_type /= Void
					loop
						from
							i := 1
						until
							i > locals.item.id_list.count or result_static_type /= Void
						loop
							if locals.item.item_name (i).is_equal (feature_name) then
								t := locals.item.type
								if t /= Void then
									result_static_type := t.actual_type.associated_class
								end
							end
							i := i + 1
						end
						locals.forth
					end
				end
				if result_static_type = Void then
						-- Last, look up in the class features.
					fi := f.written_class.feature_named (feature_name)
					if fi /= Void then
						t := fi.type
					end
					if t /= Void then
						result_static_type := t.actual_type.associated_class
					end
				end
			end
			if result_static_type /= Void then
				if message /= Void then
					message.find_static_type
					final_result_static_type := message.final_result_static_type
				else
					final_result_static_type := result_static_type
				end
			end
				-- Reset the context.
			System.set_current_class (prev_class)
			Inst_context.set_cluster (prev_cluster)
		end

	result_type: CLASS_C is
			-- Type of the result of `Current'.
			--| Only valid after `evaluate' was called.
			--| Used to evaluate the message.
		require
			evaluated: result_object /= Void
		do
			Result := result_object.dynamic_class
		end

	result_static_type: CLASS_C
			-- Declared type of the result of `Current'.
			--| Only valid after `evaluate' was called.
			--| Used to find the feature that corresponds to the message.

	result_object: DUMP_VALUE
			-- Result of `Current'.
			--| Only valid after `evaluate' was called.

	final_result_static_type: CLASS_C
			-- Static type of `Current'.
			-- Only used and set in `is_condition', not in `evaluate' or `set_expression'.

	find_static_type is
			-- Find the static type of the final result of `Current'.
		require
			has_target: not is_equality_test and not is_non_equality_test and not is_identity implies target /= Void
			target_has_type: target /= Void implies target.result_static_type /= Void
			no_error: not syntax_error
		local
			t: TYPE
			fi: FEATURE_I
			prev_class: CLASS_C
			prev_cluster: CLUSTER_I
		do
			result_static_type := Void
			final_result_static_type := Void
			if is_equality_test or is_non_equality_test then
				result_static_type := System.boolean_class.compiled_class
			elseif is_identity then
				check
					parameters.count = 1
					-- There would be a syntax error otherwise.
				end
				parameters.first.find_static_type
				result_static_type := parameters.first.final_result_static_type
			else
				result_static_type := Void
				fi := target.result_static_type.feature_named (feature_name)
				if fi /= Void then
					t := fi.type
					if t /= Void then
							-- First, initialize the context.
						prev_class := System.current_class
						prev_cluster := Inst_context.cluster
						System.set_current_class (fi.written_class)
						Inst_context.set_cluster (fi.written_class.cluster)
			
						result_static_type := t.actual_type.associated_class
						
							-- Reset the context.
						System.set_current_class (prev_class)
						Inst_context.set_cluster (prev_cluster)
					end
				end
			end
			if result_static_type /= Void then
				if message /= Void then
					message.find_static_type
					final_result_static_type := message.final_result_static_type
				else
					final_result_static_type := result_static_type
				end
			end
		end

feature {NONE} -- Implementation

	evaluate_equal is
			-- Evaluate `Current' as an equality test.
		require
			parsed: feature_name /= Void
			really_equality_test: feature_name.is_equal (infix_feature_name_with_symbol ("="))
			operands: parameters.count = 1 and target /= Void
		local
			res: BOOLEAN
		do
			evaluate_parameters
			if error_message = Void then
				res := target.result_object.same_as (parameters.first.result_object)
				result_static_type := System.boolean_class.compiled_class
				create result_object.make_boolean (res, result_static_type)
			end
		end

	evaluate_different is
			-- Evaluate `Current' as an non-equality test.
		require
			parsed: feature_name /= Void
			really_equality_test: feature_name.is_equal (infix_feature_name_with_symbol ("/="))
			operands: parameters.count = 1 and target /= Void
		local
			res: BOOLEAN
		do
			evaluate_parameters
			if error_message = Void then
				res := not target.result_object.same_as (parameters.first.result_object)
				result_static_type := System.boolean_class.compiled_class
				create result_object.make_boolean (res, result_static_type)
			end
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

	evaluate_feature_on_object (sf: E_FEATURE; o_addr: STRING; dtype: CLASS_C; value: DUMP_VALUE) is
			-- Evaluate `sf' in the context of its dynamic_class.
			-- Evaluate and pass `parameters' if necessary.
			-- `o_addr' is the address of the object on which the `sf' should be evaluated,
			-- `dtype' is its dynamic type, `value' is its value, if it is a basic type (no address in that case).
		require
			valid_feature: sf /= Void
			valid_dtype: dtype /= Void
			valid_address: (o_addr /= Void) implies (Application.is_valid_object_address (o_addr))
			enough_data: (o_addr = Void) /= (value = Void)
--			good_type: (o_addr /= Void) implies ((create {DEBUGGED_OBJECT_CLASSIC}.make (o_addr, 0, 1)).dtype = dtype)
		local
			f: E_FEATURE
			addr: STRING
		do
			addr := o_addr
			if addr = Void then
				addr := value.address
			end
			f := sf.ancestor_version (dtype)
			if f = Void then
				error_message := "No descendant of feature " + sf.name +
					" in class " + dtype.name_in_upper
			elseif f.associated_feature_i.is_once and f.type /= Void then
				evaluate_once (f)
			elseif f.is_attribute then
				evaluate_attribute (value, f, addr)
			elseif f.is_constant then
				evaluate_constant (f)
			elseif f.is_function then
				evaluate_function (dtype, value, f, addr)
			else
				error_message := "Cannot evaluate command " + feature_name
			end
		end

	evaluate_function (dtype: CLASS_C; value: DUMP_VALUE; f: E_FEATURE; addr: STRING) is
			-- Evaluate function feature
		local
			dmp: DUMP_VALUE
			par: INTEGER
			realf: E_FEATURE
			rout_info: ROUT_INFO
			obj: DEBUGGED_OBJECT
			at: TYPE_A
			l_class_type: CLASS_TYPE
			l_params: ARRAY [DUMP_VALUE]
			l_params_index: INTEGER
		do
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
					at := f.arguments.i_th (parameters.index).actual_type
					if
						at.associated_class /= Void and then
						not parameters.item.final_result_type.simple_conform_to (
							at.associated_class)
					then
						error_message := "Invalid parameter: " + parameters.item.expression +
							" (Class " + parameters.item.final_result_type.name_in_upper +
							" does not conform to " +
							f.arguments.i_th (parameters.index).associated_class.name_in_upper +
							")"
					end
					parameters.forth
				end
			end

			if not Application.is_dotnet then
					-- Initialize the communication.
				Init_recv_c
			end
		
			
				-- First find out the generic derivation if any in which we are
				-- evaluation `f'.
			if dtype.types.count > 1 then
				if addr /= Void then
						-- The type has generic derivations: we need to find the precise type.
					if application.is_dotnet then
						create {DEBUGGED_OBJECT_DOTNET} obj.make (addr, 0, 1)
					else
						create {DEBUGGED_OBJECT_CLASSIC} obj.make (addr, 0, 1)
					end
					l_class_type := obj.class_type
				else
						--| Shouldn't happen: basic types are not generic.
					error_message := "Cannot find complete dynamic type of a basic type"
				end
			else
				l_class_type := dtype.types.first
			end
					
			if error_message = Void then

					-- Get real feature
				realf := f.ancestor_version (f.written_class)
				
				check
					valid_class_type: l_class_type /= Void
				end
					--| Get|Send the parameters.
				if not parameters.is_empty then
					if Application.is_dotnet then
						from
							create l_params.make (1, parameters.count)
							l_params_index := 0
							parameters.start
						until
							parameters.after or error_message /= Void
						loop
							dmp := parameters.item.final_result_value
							l_params_index := l_params_index + 1
							l_params.put (dmp, l_params_index)
							parameters.forth
						end
					else
						from
							parameters.start
							byte_context.set_class_type (l_class_type)
						until
							parameters.after or error_message /= Void
						loop
							dmp := parameters.item.final_result_value
							dmp.send_value
								-- We need to evaluate feature argument using BYTE_CONTEXT because
								-- it might have some formal and the metamorphose should only appear
								-- when there is indeed a type difference and not because the expected
								-- argument is a formal parameter and the actual argument value is
								-- a basic type.
								-- This happen when evaluation `my_hash_table.item (1)' where
								-- `my_hash_table' is of type `HASH_TABLE [STRING, INTEGER]'.
							if
								dmp.is_basic and
								(not byte_context.real_type (
									realf.arguments.i_th (parameters.index).type_i).is_basic)
							then
								send_rqst_0 (Rqst_metamorphose)
							end
							parameters.forth
						end
					end
				end

					--| Feature's Evaluation
				if Application.is_dotnet then

					result_object := evaluator.dotnet_evaluate_function (addr, value, realf.associated_feature_i, l_class_type, l_params)

					at := f.type.actual_type
					if at.associated_class /= Void then
						result_static_type := at.associated_class
					else
						result_static_type := Workbench.Eiffel_system.Any_class.compiled_class
					end
					if
						result_static_type /= Void and then
						result_static_type.is_basic and
						(result_object.address /= Void)
					then
							-- We expected a basic type, but got a reference.
							-- This happens in "2 + 2" because we convert the first 2
							-- to a reference and therefore get a reference.
						result_object := result_object.to_basic
					end
				else
						-- Send the target object.
					if addr /= Void then
						create dmp.make_object (addr, dtype)
					else
						dmp := value
						if dmp.is_basic then
							par := par + 4
						end
					end
					dmp.send_value
						-- Send the final request.
					if f.is_external then
						par := par + 1
					end
					if f.written_class.is_precompiled then
						par := par + 2
						rout_info := System.rout_info_table.item (f.rout_id_set.first)
						send_rqst_3 (Rqst_dynamic_eval, rout_info.offset, rout_info.origin, par)
					else
						send_rqst_3 (Rqst_dynamic_eval, f.feature_id, l_class_type.static_type_id - 1, par)
					end
						-- Receive the Result.
					c_recv_value (Current)
					if item /= Void then
						item.set_hector_addr
						result_object := item.dump_value
						at := f.type.actual_type
						if at.associated_class /= Void then
							result_static_type := at.associated_class
						else
							result_static_type := Workbench.Eiffel_system.Any_class.compiled_class
						end
						if
							result_static_type /= Void and then
							result_static_type.is_basic and
							(result_object.address /= Void)
						then
								-- We expected a basic type, but got a reference.
								-- This happens in "2 + 2" because we convert the first 2
								-- to a reference and therefore get a reference.
							result_object := result_object.to_basic
						end
					else
						error_message := "Function " + f.name + " raised an exception"
					end
				end
			end
		end

	evaluate_attribute (value: DUMP_VALUE; f: E_FEATURE; addr: STRING) is
			-- Evaluate attribute feature
		local
			lst: LIST [ABSTRACT_DEBUG_VALUE]
			obj: DEBUGGED_OBJECT
			dv: ABSTRACT_DEBUG_VALUE
		do
			if addr /= Void then
				if application.is_dotnet then
					create {DEBUGGED_OBJECT_DOTNET} obj.make (addr, 0, 1)
				else
					create {DEBUGGED_OBJECT_CLASSIC} obj.make (addr, 0, 1)
				end
				lst := obj.attributes
				dv := find_item_in_list (f.name, lst)
				result_static_type := f.type.actual_type.associated_class
				if dv = Void then
					if f.name.is_equal ("Void") then
						create result_object.make_object (Void, Void)
					else
						error_message := "Could not find attribute value for " + f.name
					end
				else
					result_object := dv.dump_value
				end
			elseif f.name.is_equal ("item") then
				result_object := value
				result_static_type := value.dynamic_class
			else
				error_message := "Cannot evaluate an attribute of a basic type"
			end
		end

	evaluate_once (f: E_FEATURE) is
			-- Call the once function `f'.
		require
			valid_feature: f /= Void
			is_once: f.associated_feature_i.is_once and f.type /= Void
		local
			once_r: ONCE_REQUEST
		do			
			if f.written_class.types.count > 1 then
				error_message := "Once evaluation on generic classes not available"		
			else
				if application.is_dotnet then
					result_object := evaluator.dotnet_evaluate_once_function (f)
					result_static_type := f.type.associated_class
				else
					once_r := debug_info.once_request
					if once_r.already_called (f) then
						result_object := once_r.once_result (f).dump_value
						result_static_type := f.type.associated_class
					end				
				end
				if result_object = Void then
					error_message := "Once feature " + f.name + " not called yet"		
				end		
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
					result_object := create {DUMP_VALUE}.make_integer (val.to_integer,
						result_static_type);
				elseif val.is_real then
					result_object := create {DUMP_VALUE}.make_real (val.to_real,
						result_static_type);
				elseif val.is_double then
					result_object := create {DUMP_VALUE}.make_double (val.to_double,
						result_static_type);
				elseif val.is_boolean then
					result_object := create {DUMP_VALUE}.make_boolean (val.to_boolean,
						result_static_type);
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
				parameters.forth
			end
		end

	find_item_in_context (n: STRING) is
			-- Try to find a debug value named `n' in the context of the current call stack element.
		require
			valid_name: n /= Void
			application_paused: Application.is_running and Application.is_stopped
		local
			lower_name: STRING
			cse: CALL_STACK_ELEMENT
			cf, f: E_FEATURE
			pos, cnt: INTEGER
			locals: EIFFEL_LIST [TYPE_DEC_AS]
			t: TYPE_DEC_AS
			prev_class: CLASS_C
			prev_cluster: CLUSTER_I
			dv: ABSTRACT_DEBUG_VALUE
		do
			lower_name := n.as_lower
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
							debug ("DEBUGGER_INTERFACE")
								io.putstring ("cse.dtype: " + cse.dynamic_class.name_in_upper)
								io.putstring ("%Ndtype: ")
								if application.is_dotnet then
									io.put_string ((create {DEBUGGED_OBJECT_DOTNET}.make (cse.object_address, 0, 1)).dtype.name_in_upper)
								else
									io.put_string ((create {DEBUGGED_OBJECT_CLASSIC}.make (cse.object_address, 0, 1)).dtype.name_in_upper)									
								end
								io.new_line
							end
							evaluate_feature_on_object (f, cse.object_address, cse.dynamic_class, Void)
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
		
feature -- test jfiat

	evaluator: DBG_EVALUATOR is
		once
			create Result.make
		end

end -- class EB_EXPRESSION
