indexing
	description : "Objects used to evaluate a DBG_EXPRESSION_B ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	DBG_EXPRESSION_EVALUATOR_B

inherit
	DBG_EXPRESSION_EVALUATOR
		redefine
			dbg_expression
		end

	SHARED_DEBUG
		export
			{ANY} Application
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

	PREFIX_INFIX_NAMES
		export
			{NONE} all
		end
		
	COMPILER_EXPORTER
			--| Just to be able to access E_FEATURE::associated_feature_i :(
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

	SHARED_AST_CONTEXT	
		rename
			Context as Ast_context
		export
			{NONE} all
		end
		
	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end	

create
	make_with_expression

feature -- Evaluation

	evaluate is
			-- Compute the value of the last message of `Current'.
		local
			obj: DEBUGGED_OBJECT
		do
			error_message := Void
			
				--| prepare context
				--| this may trigger the reset of `expression_byte_node' value
			if on_context then
					--| .. Init current context using current call_stack
				init_context_with_current_callstack
			elseif on_object then
				if application.is_dotnet then
					create {DEBUGGED_OBJECT_DOTNET} obj.make (context_address, 0, 1)
				else
					create {DEBUGGED_OBJECT_CLASSIC} obj.make (context_address, 0, 1)					
				end
				set_context_data (Void, obj.dtype)
			elseif on_class then
				set_context_data (Void, context_class)
			end


				--| Compute and get `expression_byte_node'
			get_expression_byte_node

			if error_message = Void then
					--| prepare target's context
				if on_context then
					context_address := application.status.current_stack_element.object_address
				end

					--| Initializing
				tmp_result_static_type := Void
				tmp_result_value := Void
				tmp_target := Void
				
					--| concrete evaluation
				process_expression_evaluation (expression_byte_node)
				
					--| Process result 				
				if tmp_result_value /= Void then
					final_result_value := tmp_result_value
					final_result_type := tmp_result_value.dynamic_class
					final_result_static_type := final_result_type
				else
					final_result_value := Void
					final_result_type := Void
					final_result_static_type := Void
					check
						error_message /= Void
					end
				end
			else
				final_result_value := Void
				final_result_type := Void
				final_result_static_type := Void				
			end
		end
		
feature -- EXPR_B evaluation

	process_expression_evaluation (a_expr_b: EXPR_B) is
		local
			retried: BOOLEAN
		do
			if not retried then
				evaluate_expr_b (a_expr_b)
			else
				error_message := "Evaluation failed with an exception"
			end
		rescue
			retried := True
			retry
		end		

	evaluate_expr_b (a_expr_b: EXPR_B) is
		local
			l_paran_b: PARAN_B
			l_call_b: CALL_B
			l_access_b: ACCESS_B
			l_nested_b: NESTED_B

			l_binary_b: BINARY_B
			l_unary_b: UNARY_B
			
			l_void_b: VOID_B

			l_value_i: VALUE_I
		do
			l_value_i := a_expr_b.evaluate
			if l_value_i.is_no_value then
				l_paran_b ?= a_expr_b
				if l_paran_b /= Void then
						--| PARAN_B |--					
					evaluate_expr_b (l_paran_b.expr)
				else
						--| CALL_B |--
					l_call_b ?= a_expr_b
					if l_call_b /= Void then
							--| ACCESS_B |--
						l_access_b ?= l_call_b
						if l_access_b /= Void then
							evaluate_access_b (l_access_b)
						else
								--| NESTED_B |--
							l_nested_b ?= l_call_b
							evaluate_nested_b (l_nested_b)
						end
					else
							--| BINARY_B |--
						l_binary_b ?= a_expr_b
						if l_binary_b /= Void then
							evaluate_binary_b (l_binary_b)
						else
								--| UNARY_B |--
							l_unary_b ?= a_expr_b
							if l_unary_b /= Void then
								evaluate_unary_b (l_unary_b)
							else
									--| VOID_B |--
								l_void_b ?= a_expr_b
								if l_void_b /= Void then
									evaluate_void_b (l_void_b)
								else
									evaluate_manifest_value (a_expr_b)								
								end
							end
						end
					end
				end
			else
				evaluate_value_i (l_value_i)
			end
		end
	
	standalone_evaluation_expr_b (a_expr_b: EXPR_B): DUMP_VALUE is
		require
			a_expr_b /= Void
		local
			l_tmp_result_value_backup: like tmp_result_value
			l_tmp_target_backup: like tmp_target
			l_tmp_result_static_type_backup: like tmp_result_static_type
		do
				-- Backup
			l_tmp_result_value_backup := tmp_result_value
			l_tmp_target_backup := tmp_target
			l_tmp_result_static_type_backup	:= tmp_result_static_type
			
			evaluate_expr_b (a_expr_b)
			Result := tmp_result_value
			
				-- Restore
			tmp_result_value := l_tmp_result_value_backup
			tmp_target := l_tmp_target_backup
			tmp_result_static_type := l_tmp_result_static_type_backup
		end	
		
	evaluate_void_b	(a_void_b: VOID_B) is
			-- Evaluate Void keyword value
		local
			t: TYPE_I
		do
			t := a_void_b.type

			tmp_result_value := Void
			create tmp_result_value.make_object (Void, Void)
		end
		
	evaluate_manifest_value (a_expr_b: EXPR_B) is
			-- Manifest value, that is to say STRING manisfest value,
			-- since the INTEGER and so on value are handled by the parser
		local
			l_string_b: STRING_B
		do
			l_string_b ?= a_expr_b
			if l_string_b /= Void then
				tmp_result_value := string_to_dump_value (l_string_b.value)
			else
					--| NotYetReady |--
				error_message := a_expr_b.generator + " : sorry not yet ready"				
			end
		end		

	evaluate_value_i (a_value_i: VALUE_I) is
		local
			l_integer: INTEGER_CONSTANT
			l_char: CHAR_VALUE_I
			l_real: REAL_VALUE_I
			l_string: STRING_VALUE_I
			-- ...
		do
			if     a_value_i.is_integer		then
				l_integer ?= a_value_i
				if l_integer.size = 64 		then
					tmp_result_value := integer_64_to_dump_value (l_integer.to_integer_64)
				else
					tmp_result_value := integer_to_dump_value (l_integer.value)
				end
			elseif a_value_i.is_string		then
				l_string ?= a_value_i
				tmp_result_value := string_to_dump_value (l_string.string_value)
			elseif a_value_i.is_boolean		then
				tmp_result_value := boolean_to_dump_value (a_value_i.boolean_value)				
			elseif a_value_i.is_character	then
				l_char ?= a_value_i
				tmp_result_value := character_to_dump_value (l_char.character_value)				
			elseif a_value_i.is_real		then
				l_real ?= a_value_i
				tmp_result_value := real_to_dump_value (l_real.real_value)				
			elseif a_value_i.is_double		then
				l_real ?= a_value_i
				tmp_result_value := double_to_dump_value (l_real.double_value)				
--			elseif a_value_i.is_bit			then
			else
				error_message := a_value_i.generator + " : sorry not yet ready"
			end
		end

	evaluate_binary_b (a_binary_b: BINARY_B) is
		local
			l_bin_equal_b: BIN_EQUAL_B
			l_nested_b: NESTED_B
		do
			l_bin_equal_b ?= a_binary_b
			if l_bin_equal_b /= Void then
				evaluate_bin_equal_b (l_bin_equal_b)
			elseif a_binary_b.access /= Void then
				l_nested_b := a_binary_b.nested_b
				evaluate_nested_b (l_nested_b)
			else
				error_message := a_binary_b.generator + "/BINARY_B : sorry not available"				
			end
		end

	evaluate_bin_equal_b (a_bin_equal_b: BIN_EQUAL_B) is
		local
			l_bin_eq_b: BIN_EQ_B
			l_bin_ne_b: BIN_NE_B
			l_right, l_left: EXPR_B
			l_right_value, l_left_value: DUMP_VALUE
			res: BOOLEAN
		do
			l_left := a_bin_equal_b.left
			l_right := a_bin_equal_b.right

			l_left_value := standalone_evaluation_expr_b (l_left)
			l_right_value := standalone_evaluation_expr_b (l_right)

			if l_left_value /= Void and l_right_value /= Void then
				l_bin_eq_b ?= a_bin_equal_b
				if l_bin_eq_b /= Void then
					res := l_left_value.same_as (l_right_value)
				else
					l_bin_ne_b ?= a_bin_equal_b
					if l_bin_ne_b /= Void then
						res := not l_left_value.same_as (l_right_value)
					end
				end
				if not error_occurred then
					tmp_result_static_type := System.boolean_class.compiled_class
					create tmp_result_value.make_boolean (res, tmp_result_static_type)
				end
			end
			if not error_occurred and tmp_result_value = Void then
				error_message := a_bin_equal_b.generator + "/BINARY_B : sorry not available"				
			end
		end

	evaluate_unary_b (a_unary_b: UNARY_B) is
			-- Evaluate unary_b expression
		local
			l_un_minus_b: UN_MINUS_B
			l_un_plus_b: UN_PLUS_B			
			l_un_not_b: UN_NOT_B
		do
			l_un_not_b ?= a_unary_b
			if l_un_not_b /= Void then
				evaluate_nested_b (l_un_not_b.nested_b)				
			else
				l_un_minus_b ?= a_unary_b
				if l_un_minus_b /= Void then
					evaluate_nested_b (l_un_minus_b.nested_b)				
				else
					l_un_plus_b ?= a_unary_b
					if l_un_plus_b /= Void then
						evaluate_nested_b (l_un_plus_b.nested_b)				
					else
						error_message := a_unary_b.generator + " = UNARY_B : sorry not yet ready"	
					end
				end				
			end
		end

	evaluate_access_b (a_access_b: ACCESS_B) is
		local
			l_call_access_b: CALL_ACCESS_B
			l_access_expr_b: ACCESS_EXPR_B
--			l_constant_b: CONSTANT_B
			l_local_b: LOCAL_B
			l_result_b: RESULT_B
			l_argument_b: ARGUMENT_B
			l_current_b: CURRENT_B
			l_creation_expr_b: CREATION_EXPR_B
			-- ...
		do
			l_call_access_b ?= a_access_b
			if l_call_access_b /= Void then
				evaluate_call_access_b (l_call_access_b)
			else
				l_access_expr_b ?= a_access_b
				if l_access_expr_b /= Void then
					evaluate_expr_b (l_access_expr_b.expr)
				else
					l_local_b ?= a_access_b
					if l_local_b /= Void then
						evaluate_local_b (l_local_b)
					else
						l_argument_b ?= a_access_b
						if l_argument_b /= Void then
							evaluate_argument_b (l_argument_b)
						else
							l_result_b ?= a_access_b
							if l_result_b /= Void then
								evaluate_result_b (l_result_b)						
							else
								l_current_b ?= a_access_b
								if l_current_b /= Void then
									evaluate_current_b (l_current_b)
								else
									l_creation_expr_b ?= a_access_b
									if l_creation_expr_b /= Void then
										evaluate_creation_expr_b (l_creation_expr_b)
									else

	-- Constants value should be already caught by the value_i in evaluate_expr_b									
	--									l_constant_b ?= a_access_b
	--									if l_constant_b /= Void then
	--					--					l_constant_b.evaluate
	--									else
											error_message := a_access_b.generator + " = ACCESS_B : sorry not yet ready"				
	--									end	
									end
								end		
							end
						end
					end
				end
			end
		end

	evaluate_nested_b (a_nested_b: NESTED_B) is
		local
			l_tmp_target_backup: like tmp_target
			l_target: ACCESS_B
			l_target_value: DUMP_VALUE
			l_message_value: DUMP_VALUE
			l_message: CALL_B
		do
			l_tmp_target_backup := tmp_target
			
			l_target := a_nested_b.target
			l_target_value := standalone_evaluation_expr_b (l_target)
			
			if not error_occurred then
				tmp_target := l_target_value
				l_message := a_nested_b.message
				l_message_value := standalone_evaluation_expr_b (l_message)
				
				if not error_occurred then
					tmp_result_value := l_message_value					
				end
			end
			tmp_target := l_tmp_target_backup
		end
		
	evaluate_creation_expr_b (a_creation_expr_b: CREATION_EXPR_B) is
		local
--			l_tmp_target_backup: like tmp_target
			retried: BOOLEAN

			l_type_to_create: CL_TYPE_I
--			l_create_info_type: CREATE_TYPE
--			l_basic_type_to_create: BASIC_I
			l_f_b: FEATURE_B
			l_p_b: PARAMETER_B
			l_e_b: EXPR_B
			l_v_i: VALUE_I
		do
			if not retried then
				-- FIXME JFIAT: 2004/03/18 for now just process basic type ...
				
--				l_tmp_target_backup := tmp_target
--
--				l_create_info_type ?= a_creation_expr_b.info
--				l_type_to_create ?= l_create_info_type.type
--				l_basic_type_to_create ?= l_type_to_create

				l_f_b ?= a_creation_expr_b.call
				if l_f_b /= Void then
					l_p_b ?= l_f_b.parameters.first
					if l_p_b /= Void then
						l_e_b ?= l_p_b.expression
						if l_e_b /= Void then
							l_v_i := l_e_b.evaluate
							if l_v_i /= Void then
								evaluate_value_i (l_v_i)
							end
						end							
					end						
				end
--				tmp_target := l_tmp_target_backup
			else
				error_message := a_creation_expr_b.generator + " = CREATION_EXPR_B : sorry not yet ready"
				
				l_type_to_create := a_creation_expr_b.info.type_to_create
				if l_type_to_create /= Void then
					error_message.append_string (" for " + l_type_to_create.name )					
				end
			end
		rescue
			retry
		end

	evaluate_call_access_b (a_call_access_b: CALL_ACCESS_B) is
		local
			l_feature_b: FEATURE_B
			l_attribue_b: ATTRIBUTE_B
			l_external_b: EXTERNAL_B
		do
			if a_call_access_b.is_feature then
				l_feature_b ?= a_call_access_b
				evaluate_feature_b (l_feature_b)
			elseif a_call_access_b.is_attribute then
				l_attribue_b ?= a_call_access_b
				evaluate_attribute_b (l_attribue_b)
			elseif a_call_access_b.is_external then
				l_external_b ?= a_call_access_b
				evaluate_external_b (l_external_b)				
			else
				error_message := a_call_access_b.generator + " = CALL_ACCESS_B : sorry not yet ready"					
			end
		end
	
	evaluate_feature_b (a_feature_b: FEATURE_B) is
		local
			fi: FEATURE_I
			ef: E_FEATURE
			cl: CLASS_C
			params: ARRAYED_LIST [DUMP_VALUE]
		do
			if tmp_target /= Void then
				cl := tmp_target.dynamic_class
			elseif context_class /= Void then
				cl := context_class
			else
				cl := system.class_of_id (a_feature_b.written_in)
			end
			
			if cl = Void then
				error_message := "Error: Call on void target " + a_feature_b.feature_name
			else
				ef := cl.feature_with_name (a_feature_b.feature_name)
				if ef /= Void then
					fi := ef.associated_feature_i
			
					if fi.is_once then
						evaluate_once (ef)
					elseif fi.is_constant then
						evaluate_constant (ef)
					elseif fi.is_function then					
							--| parameters ...
						params := parameter_values_from_parameters_b (a_feature_b.parameters)
						if tmp_target /= Void then
							evaluate_function (tmp_target.value_address, tmp_target, ef, params)
						else
							evaluate_function (context_address, tmp_target, ef, params)
						end
					else
						error_message := a_feature_b.generator +  " => ERROR : other than function, constant and once : not available"
					end
				else
					error_message := a_feature_b.generator +  " => ERROR : please report to support"					
				end
			end
		end
		
	evaluate_external_b	(a_external_b: EXTERNAL_B) is
		local
			fi: FEATURE_I
			ef: E_FEATURE
			cl: CLASS_C
			params: ARRAYED_LIST [DUMP_VALUE]
		do
			if tmp_target /= Void then
				cl := tmp_target.dynamic_class
			elseif context_class /= Void then
				cl := context_class
			else
				cl := system.class_of_id (a_external_b.written_in)
			end
			
			if cl = Void then
				error_message := "Error: Call on void target " + a_external_b.feature_name
			else
				ef := cl.feature_with_name (a_external_b.feature_name)
				fi := ef.associated_feature_i
		
				if fi.is_external then
						--| parameters ...
					params := parameter_values_from_parameters_b (a_external_b.parameters)
					if tmp_target /= Void then
						evaluate_function (tmp_target.value_address, tmp_target, ef, params)
					else
						evaluate_function (context_address, tmp_target, ef, params)
					end
				else
					error_message := a_external_b.generator +  " => ERROR during evaluation of external call " + a_external_b.feature_name
				end	
			end
--			error_message := a_external_b.generator + " = EXTERNAL_B : sorry not yet ready"		
		end		

	parameter_values_from_parameters_b (a_params: BYTE_LIST [EXPR_B]): ARRAYED_LIST [DUMP_VALUE] is
		local
			l_dmp: DUMP_VALUE
			l_parameters_b: BYTE_LIST [EXPR_B]
		do
			l_parameters_b := a_params
			if l_parameters_b /= Void then
				from
					create Result.make (l_parameters_b.count)
					l_parameters_b.start
				until
					l_parameters_b.after or error_message /= Void
				loop
					l_dmp := parameter_evaluation (l_parameters_b.item)
					if not error_occurred then
						Result.extend (l_dmp)
					end
					l_parameters_b.forth
				end
			end
		end

	evaluate_attribute_b (a_attribute_b: ATTRIBUTE_B) is
		local
			cl: CLASS_C
			ef: E_FEATURE
		do
			if tmp_target /= Void then
				cl := tmp_target.dynamic_class
			elseif context_class /= Void then
				cl := context_class
			else
				cl := system.class_of_id (a_attribute_b.written_in)
			end

			if cl = Void then
				error_message := "Error: Call on void target"
			else
				ef := cl.feature_with_name (a_attribute_b.attribute_name)
	
				if tmp_target /= Void then
					evaluate_attribute (tmp_target.value_address, tmp_target, ef)
				else
					evaluate_attribute (context_address, tmp_target, ef)
				end				
			end
		end
		
	parameter_evaluation (a_expr_b: EXPR_B): DUMP_VALUE is
		require
			a_expr_b /= Void
		local
			l_param_b: PARAMETER_B
			l_expr_b: EXPR_B
			l_tmp_target_backup: like tmp_target
		do
			
			l_param_b ?= a_expr_b
			if l_param_b /= Void then
				l_expr_b := l_param_b.expression
			else
				l_expr_b := a_expr_b
			end
			
			l_tmp_target_backup := tmp_target
			tmp_target := Void 
				--| in case of parameter, there is not target except the top one
			Result := standalone_evaluation_expr_b (l_expr_b)
			tmp_target := l_tmp_target_backup			

			if Result = Void then
				error_message := a_expr_b.generator +  " => error evaluating parameter"				
			end
		end		

	evaluate_local_b (l_local_b: LOCAL_B) is
		local
			cse: CALL_STACK_ELEMENT
			dv: ABSTRACT_DEBUG_VALUE
			cf: E_FEATURE
		do
			cse := Application.status.current_stack_element
			if cse = Void then
				check
					False -- Shouldn't occur.
				end
			else
				cf := cse.routine
			end
			if cf = Void then
				check
					False -- Shouldn't occur.
				end			
			else
				dv :=  cse.locals.i_th (l_local_b.position)
				tmp_result_value := dv.dump_value
				tmp_result_static_type := tmp_result_value.dynamic_class
				-- FIXME jfiat [2004/02/26] : optimisation : maybe compute the static type ....
			end
		end
		
	evaluate_argument_b (l_argument_b: ARGUMENT_B) is
		local
			cse: CALL_STACK_ELEMENT
			dv: ABSTRACT_DEBUG_VALUE
			cf: E_FEATURE
		do
			cse := Application.status.current_stack_element
			if cse = Void then
				check
					False -- Shouldn't occur.
				end
			else
				cf := cse.routine
			end
			if cf = Void then
				check
					False -- Shouldn't occur.
				end			
			else
				dv :=  cse.arguments.i_th (l_argument_b.position)
				tmp_result_value := dv.dump_value
				tmp_result_static_type := tmp_result_value.dynamic_class
				-- FIXME jfiat [2004/02/26] : optimisation : maybe compute the static type ....
			end
		end		

	evaluate_result_b (l_result_b: RESULT_B) is
		local
			cse: CALL_STACK_ELEMENT
			dv: ABSTRACT_DEBUG_VALUE
			cf: E_FEATURE
		do
			cse := Application.status.current_stack_element
			if cse = Void then
				check
					False -- Shouldn't occur.
				end
			else
				cf := cse.routine
			end
			if cf = Void then
				check
					False -- Shouldn't occur.
				end			
			else
				dv := cse.result_value
				if dv /= Void then
					tmp_result_value := dv.dump_value
					if cf.type /= Void then
						tmp_result_static_type := cf.type.associated_class
					end
				end			
			end
		end
		
	evaluate_current_b (l_current_b: CURRENT_B) is
		local
			cse: CALL_STACK_ELEMENT
			cse_dotnet: CALL_STACK_ELEMENT_DOTNET
			l_addr: STRING
		do
			cse := Application.status.current_stack_element
			if cse = Void then
				check
					False -- Shouldn't occur.
				end
			end
			l_addr := cse.object_address
			if application.is_dotnet then
				cse_dotnet ?= cse
				tmp_result_value := cse_dotnet.current_object.dump_value
			else
				create tmp_result_value.make_object (l_addr, context_class)
			end
			tmp_result_static_type := context_class

		end		
		
feature -- Concrete evaluation

	evaluate_once (f: E_FEATURE) is
			-- 
		require
			feature_not_void: f /= Void
--			f_is_once: f.is_once
--			f_is_once: f.associated_feature_i.is_once
		local
			once_r: ONCE_REQUEST			
		do
			check
				f_is_once: f.associated_feature_i.is_once
			end
			if f.written_class.types.count > 1 then
				error_message := "Once evaluation on generic classes not available"		
			else
				if application.is_dotnet then
					tmp_result_value := dbg_evaluator.dotnet_evaluate_once_function (f)
					tmp_result_static_type := f.type.associated_class
				else
					once_r := debug_info.once_request
					if once_r.already_called (f) then
						tmp_result_value := once_r.once_result (f).dump_value
						tmp_result_static_type := f.type.associated_class
					end				
				end
				if tmp_result_value = Void then
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
			cv_cst_i: CONSTANT_I
		do		
			cv_cst_i ?= f.associated_feature_i
			if cv_cst_i /= Void then
				evaluate_value_i (cv_cst_i.value)
			else
				cv_cst ?= f
				if cv_cst /= Void then
					val := cv_cst.value
					tmp_result_static_type := cv_cst.type.associated_class
					if val.is_integer then
						 create tmp_result_value.make_integer (val.to_integer, tmp_result_static_type);
					elseif val.is_real then
						 create tmp_result_value.make_real (val.to_real, tmp_result_static_type);
					elseif val.is_double then
						 create tmp_result_value.make_double (val.to_double, tmp_result_static_type);
					elseif val.is_boolean then
						 create tmp_result_value.make_boolean (val.to_boolean, tmp_result_static_type);
					elseif tmp_result_static_type.conform_to (system.character_class.compiled_class) then
						 create tmp_result_value.make_character (val.item (1), tmp_result_static_type);			
					else				
						error_message := "Unknown constant type for " + cv_cst.name
					end
				else
					error_message := "Unknown constant type for " + f.name
				end				
			end
		end

	evaluate_attribute (a_addr: STRING; a_target: DUMP_VALUE; f: E_FEATURE) is
			-- Evaluate attribute feature
		local
			lst: LIST [ABSTRACT_DEBUG_VALUE]
			dobj: DEBUGGED_OBJECT
			dv: ABSTRACT_DEBUG_VALUE
			dump: DUMP_VALUE
			l_address: STRING
		do
			l_address := a_addr
			if l_address = Void then
					--| cannot evaluate attribute on manifest value
					--| (such as "foo", 1 or True .. in the expression)
					-- but let's try to improve this ...
				if application.is_dotnet then
					dump := dbg_evaluator.dotnet_metamorphose_basic_to_value (a_target)
					l_address := dump.address
				end
			end
			if l_address /= Void then
				if application.is_dotnet then
					create {DEBUGGED_OBJECT_DOTNET} dobj.make (l_address, 0, 1)
				else
					create {DEBUGGED_OBJECT_CLASSIC} dobj.make (l_address, 0, 1)
				end
				lst := dobj.attributes
				dv := find_item_in_list (f.name, lst)
				tmp_result_static_type := f.type.actual_type.associated_class
				if dv = Void then
					if f.name.is_equal ("Void") then
						create tmp_result_value.make_object (Void, Void)
					else
						error_message := "Could not find attribute value for " + f.name
					end
				else
					tmp_result_value := dv.dump_value
				end
--			elseif f.name.is_equal ("item") then
--				result_object := a_target
--				result_static_type := a_target.dynamic_class
			else

				error_message := "Cannot evaluate an attribute ["+ f.name+"] of a manifest value"
			end
		end
		
	evaluate_function (a_addr: STRING; a_target: DUMP_VALUE; f: E_FEATURE; params: LIST [DUMP_VALUE]) is
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		local
			l_dynclass: CLASS_C
			l_dyntype: CLASS_TYPE
			dobj: DEBUGGED_OBJECT
			realf: E_FEATURE
			l_params: ARRAY [DUMP_VALUE]
			l_params_index: INTEGER
			dmp: DUMP_VALUE
			at: TYPE_A
			par: INTEGER
			rout_info: ROUT_INFO

			l_ref_type: CL_TYPE_I
			l_icd_value: ICOR_DEBUG_VALUE
		do
			debug ("debugger_trace_eval")
				print (generating_type + ".evaluate_function :%N")
				print ("%Taddr="); print (a_addr); print ("%N")
				if a_target /= Void then
					print ("%Ttarget=not Void %N")
				else
					print ("%Ttarget=Void %N")
				end
				print ("%Tfeature="); print (f.name); print ("%N")
			end
			if not Application.is_dotnet then
					-- Initialize the communication.
				Init_recv_c
			end

				--| Get target data ...
			if tmp_target /= Void then
				l_dynclass := tmp_target.dynamic_class
			end
			if l_dynclass /= Void and then l_dynclass.is_basic then
					-- FIXME JFIAT: basic types ..
				create l_ref_type.make (l_dynclass.class_id)
				l_dyntype := l_ref_type.associated_class_type
--				l_dyntype := l_dynclass.types.first
			elseif l_dynclass = Void or else l_dynclass.types.count > 1 then
				if a_addr /= Void then
						-- The type has generic derivations: we need to find the precise type.
					if application.is_dotnet then
						create {DEBUGGED_OBJECT_DOTNET} dobj.make (a_addr, 0, 1)
					else
						create {DEBUGGED_OBJECT_CLASSIC} dobj.make (a_addr, 0, 1)
					end
					l_dyntype := dobj.class_type
					if l_dyntype = Void then
						error_message := "Error occurred: unable to find the context object <" + a_addr + ">"
					elseif l_dynclass = Void then
						l_dynclass := l_dyntype.associated_class						
					end
				else
						--| Shouldn't happen: basic types are not generic.
					error_message := "Cannot find complete dynamic type of a basic type"
				end
			else
				l_dyntype := l_dynclass.types.first
			end				

			if not error_occurred then
					-- Get real feature
				realf := f.ancestor_version (f.written_class)
				if realf = Void then
						--| FIXME JFIAT: 2004-02-01 : why `realf' can be Void in some case ?
						--| occurred for EV_RICH_TEXT_IMP.line_index (...)
					debug ("debugger_trace_eval_data")
						print ("f.ancestor_version (f.written_class) = Void%N")
						print ("  f.feature_signature = " + f.feature_signature + "%N")
						print ("  f.written_class     = " + f.written_class.name_in_upper + "%N")
					end
					realf := f
				end
				check
					valid_dyn_type: l_dyntype /= Void
				end

				if params /= Void and then not params.is_empty then
						--| Prepare parameters ...
					if Application.is_dotnet then
						from
							create l_params.make (1, params.count)
							l_params_index := 0
							params.start
							byte_context.set_class_type (l_dyntype)
						until
							params.after or error_occurred
						loop
							dmp := params.item
							l_params_index := l_params_index + 1
							if
								dmp.is_basic and
								(not byte_context.real_type (
									realf.arguments.i_th (params.index).type_i).is_basic)
							then
								dmp := dbg_evaluator.dotnet_metamorphose_basic_to_reference_value (dmp)
								debug ("debugger_trace_eval_data")
									print (generating_type + ".evaluate_function :: Metamorphose ... %N")
								end
							end
							
							l_params.put (dmp, l_params_index)
							params.forth
						end
					else --| Classic case
						from
							params.start
							byte_context.set_class_type (l_dyntype)
						until
							params.after or error_occurred
						loop
							dmp := params.item
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
									realf.arguments.i_th (params.index).type_i).is_basic)
							then
								debug ("debugger_trace_eval_data")
									print (generating_type + ".evaluate_function :: Send Metamorphose request ... %N")
								end
								send_rqst_0 (Rqst_metamorphose)
							end
							params.forth
						end
					end -- metamorphosme on dotnet or classic
				end -- preparing parameters 

					--| Function's Evaluation
				if Application.is_dotnet then
					tmp_result_value := dbg_evaluator.dotnet_evaluate_function (a_addr, a_target, realf.associated_feature_i, l_dyntype, l_params)
					if tmp_result_value = Void then
						error_message := "Unable to evaluate {" + l_dyntype.associated_class.name_in_upper + "}." + f.name
						if on_object then
							error_message.append_string (" on <" + a_addr + ">")
						end
						l_icd_value := dbg_evaluator.icd_value_by_address (a_addr)
						if not l_icd_value.is_valid_object then
							error_message.append_string (" : object collected ... ")
						end
					end
				else -- Classic case
						-- Send the target object. 
					if a_addr /= Void then
						create dmp.make_object (a_addr, l_dynclass)
					else
						dmp := a_target
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
						send_rqst_3 (Rqst_dynamic_eval, f.feature_id, l_dyntype.static_type_id - 1, par)
					end
						-- Receive the Result.
					c_recv_value (Current)
					
					if item /= Void then
						item.set_hector_addr
						tmp_result_value := item.dump_value
					else
						error_message := "Function " + f.name + " raised an exception"
					end
				end -- evaluation
				if not error_occurred and then tmp_result_value /= Void then
					at := f.type.actual_type
					tmp_result_static_type := at.associated_class
					if tmp_result_static_type = Void then
						tmp_result_static_type:= Workbench.Eiffel_system.Any_class.compiled_class
					end
					if
						tmp_result_static_type /= Void and then
						tmp_result_static_type.is_basic and
						(tmp_result_value.address /= Void)
					then
							-- We expected a basic type, but got a reference.
							-- This happens in "2 + 2" because we convert the first 2
							-- to a reference and therefore get a reference.
						tmp_result_value := tmp_result_value.to_basic
					end
				end
			end			
--			error_message := "ERROR : function evaluation not yet ready"
		end

feature {DBG_EXPRESSION_EVALUATOR} -- Evaluation data

	tmp_target: DUMP_VALUE

	tmp_result_value: DUMP_VALUE
	
	tmp_result_static_type: CLASS_C	

feature -- Context

	dbg_expression: DBG_EXPRESSION_B

	context_feature: E_FEATURE
	
feature -- Change Context

	init_context_with_current_callstack is
		local
			cse: CALL_STACK_ELEMENT
			cf: E_FEATURE
		do
			cse := Application.status.current_stack_element
			if cse = Void then
				check
					False -- Shouldn't occur.
				end
			else
				cf := cse.routine
				set_context_data (cf, cse.dynamic_class)
			end
		end
		
	set_context_data (f: like context_feature; c: like context_class) is
		require
--			f_not_void: f /= Void
--			c_not_void: c /= Void
		local
			l_reset_byte_node: BOOLEAN
			f_i: FEATURE_I
			c_f_i: FEATURE_I
		do
			if c /= Void then
				if f /= Void then
					f_i := f.associated_feature_i
				end
				if context_feature /= Void then
					c_f_i := context_feature.associated_feature_i
				end
				
				if 
					f_i /= c_f_i
				then
					context_feature := f
					l_reset_byte_node := True
				end
				if context_class = Void or else not c.is_equal (context_class) then
					context_class := c
					l_reset_byte_node := True
				end			
				if l_reset_byte_node then
						--| this means we will recompute the EXPR_B value according to the new context				
					reset_expression_byte_node
				end				
			end
		end

feature -- Access
	
	expression_byte_node: EXPR_B is
		do
			Result := internal_expression_byte_node
			if Result = Void then
				get_expression_byte_node
				Result := internal_expression_byte_node
			end
		end

	is_condition (f: E_FEATURE): BOOLEAN is
			-- Is `Current' a condition (boolean query) in the context of `f'?
		local
			old_context_feature: like context_feature
			old_context_class: like context_class
			old_int_expression_byte_note: like internal_expression_byte_node
		do
				--| Backup current context and values
			old_context_feature := context_feature
			old_context_class := context_class
			old_int_expression_byte_note := internal_expression_byte_node
			
				--| prepare context
				--| this may reset the `expression_byte_node' value
			set_context_data (f, f.associated_class)

				--| Get expression_byte_node
			get_expression_byte_node
			
			Result := expression_byte_node.type.is_boolean
			
				--| FIXME JFIAT: check in which cases we call the is_condition
				--| to see if it is pertinent to save.restore data ...			
			if 
				old_context_class = Void 
				and old_context_feature = Void
				and old_int_expression_byte_note = Void
			then
				-- if everything was unset before, let's keep these values
				-- we may use them again soon ...
				-- so no need to recompute the EXPR_B again and again
			else
					--| Restore context and values
				if old_context_class = Void then
						--| FIXME JFIAT: check this ... how to have a context_class .. not void
						--| and pertinent ...
					old_context_class := context_class				
				end
				set_context_data (old_context_feature, old_context_class)
				internal_expression_byte_node := old_int_expression_byte_note				
			end
		end

feature {NONE} -- Implementation

	get_expression_byte_node is
			-- get expression byte node depending of the context
		require
			context_feature_not_void: on_context implies context_feature /= Void
			context_class_not_void: context_class /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if internal_expression_byte_node = Void then
					debug ("debugger_trace_eval_data")
						print ("DBG_EXPRESSION_EVALUATOR_B: Recompute expression_byte_node ["+dbg_expression.expression+"]%N")
						if on_context then
							print ("                on_context: " + on_context.out +"%N")					
						end
						if on_class then
							print ("                on_class  : " + on_class.out +"%N")
						end
						if on_object then
							print ("                on_object : " + on_object.out +"%N")
						end
						if context_class /= Void then
							print ("            context_class : " + context_class.name_in_upper +"%N")
						end
						if context_address /= Void then
							print ("          context_address : " + context_address.out +"%N")						
						end
						if context_feature /= Void then
							print ("          context_feature : " + context_feature.name +"%N")
						end
					end
						--| If we want to recompute the `expression_byte_node', 
						--| we need to call `reset_expression_byte_nod' 
						
						--| Prepare AST context
					prepare_ast_context (context_feature, context_class)
					
						--| Compute and get `expression_byte_node'
					internal_expression_byte_node := expression_byte_node_from_ast (dbg_expression.expression_ast)				
				end
			else
				error_message := "Error during expression analyse"
			end
		rescue
			retried := True
			retry
		end

	expression_byte_node_from_ast (exp: EXPR_AS): like expression_byte_node is
			-- compute expression_byte_node from EXPR_AS `exp'
		require
			exp_not_void: exp /= Void
		local
			retried: BOOLEAN
			type_check_succeed: BOOLEAN
			l_error: ERROR
		do
			error_message := Void
			if not retried then
				error_handler.wipe_out
				exp.type_check
				if error_handler.has_error then
					type_check_succeed := True
					l_error := error_handler.error_list.first
					error_message := "Error " + l_error.code + " :" + error_to_string (l_error)					
					Result := Void
				else
					ast_context.start_lines
					Result := exp.byte_node
				end
				ast_context.clear1
			else
				if not type_check_succeed then
					error_message := "Type checking failed"
				end
				if error_handler.has_error then
					l_error := error_handler.error_list.first
					error_message := "Error " + l_error.code + " :" + error_to_string (l_error)
				else
					error_message := "Error!"
				end
				Result := Void
			end
		rescue
			retried := True
			retry
		end		
		
	prepare_ast_context (f: like context_feature; c: like context_class) is
			-- Preparing AST Context for evaluation
		require
			f_not_void: on_context implies context_feature /= Void
			c_not_void: c /= Void
		local
			l_ct_locals: HASH_TABLE [LOCAL_INFO, STRING]
			f_as: FEATURE_AS
			l_fi: FEATURE_I
		do
			Ast_context.set_current_class (c)
			Inst_context.set_cluster (ast_context.current_class.cluster)

			if on_context and then f /= Void then
				Ast_context.set_current_feature (f.associated_feature_i)
				
					--| Locals
				f_as := f.ast
				l_fi := f.associated_feature_i
				if l_fi /= Void then
					l_ct_locals := f_as.local_table (l_fi)
					ast_context.set_locals (l_ct_locals)
				end
			end
		end

	reset_expression_byte_node is
		do
			internal_expression_byte_node := Void
		end

	internal_expression_byte_node: like expression_byte_node
	
feature {NONE} -- Utility Implementation
	
	error_to_string (e: ERROR): STRING is
			-- Convert Error code to Error description STRING
		require
			error_not_void: e /= Void
		local
			yw: YANK_STRING_WINDOW
			st: STRUCTURED_TEXT
		do
			create st.make
			e.trace (st)
			create yw.make
			yw.process_text (st)
			Result := yw.stored_output
		end
		
feature {NONE} -- List helpers

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

feature {NONE} -- Dump value helpers

	string_to_dump_value (v: STRING): DUMP_VALUE is
			-- Convert a string value `v' to the corresponding DUMP_VALUE
		do
			create Result.make_manifest_string (v, system.string_class.compiled_class)			
		end
		
	integer_to_dump_value (v: INTEGER): DUMP_VALUE is
			-- Convert a INTEGER value `v' to the corresponding DUMP_VALUE	
		do
			create Result.make_integer (v, system.integer_32_class.compiled_class)						
		end
		
	integer_64_to_dump_value (v: INTEGER_64): DUMP_VALUE is
			-- Convert a INTEGER_64 value `v' to the corresponding DUMP_VALUE		
		do
			create Result.make_integer_64 (v, system.integer_64_class.compiled_class)						
		end	
		
	boolean_to_dump_value (v: BOOLEAN): DUMP_VALUE is
			-- Convert a BOOLEAN value `v' to the corresponding DUMP_VALUE	
		do
			create Result.make_boolean (v, system.boolean_class.compiled_class)						
		end	
		
	character_to_dump_value (v: CHARACTER): DUMP_VALUE is
			-- Convert a CHARACTER value `v' to the corresponding DUMP_VALUE	
		do
			create Result.make_character (v, system.character_class.compiled_class)						
		end			
	
	real_to_dump_value (v: REAL): DUMP_VALUE is
			-- Convert a REAL value `v' to the corresponding DUMP_VALUE	
		do
			create Result.make_real (v, system.real_class.compiled_class)						
		end
		
	double_to_dump_value (v: DOUBLE): DUMP_VALUE is
			-- Convert a DOUBLE value `v' to the corresponding DUMP_VALUE	
		do
			create Result.make_double (v, system.double_class.compiled_class)						
		end		

end -- class DBG_EXPRESSION_EVALUATOR_B
