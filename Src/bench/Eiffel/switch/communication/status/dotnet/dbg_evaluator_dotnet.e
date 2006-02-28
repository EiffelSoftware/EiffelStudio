indexing
	description: "[
			Class used to process evaluation on dotnet system ...
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EVALUATOR_DOTNET

inherit
	DBG_EVALUATOR_IMP
		redefine
			init,
			Cst_error_messages,
			effective_evaluate_function_with_name,
			effective_evaluate_static_function,
			address_from_basic_dump_value,
			parameters_init,
			parameters_reset
		end

	EIFNET_EXPORTER

	ICOR_EXPORTER

	SHARED_EIFNET_DEBUG_VALUE_FACTORY

create
	make

feature -- Concrete initialization

	init is
			-- Retrieve new value for evaluation mecanism.
		do
			Precursor
			eifnet_debugger := Application.imp_dotnet.eifnet_debugger
			eifnet_evaluator := eifnet_debugger.eifnet_dbg_evaluator
		end

feature {DBG_EVALUATOR} -- Interface

	effective_evaluate_function (addr: STRING; a_target: DUMP_VALUE; f, realf: FEATURE_I;
			ctype: CLASS_TYPE; params: LIST [DUMP_VALUE]) is
			-- Evaluate dotnet function
		local
			l_params: ARRAY [DUMP_VALUE]
			l_error_message: STRING
			l_icdv_obj: ICOR_DEBUG_VALUE
			l_icd_function: ICOR_DEBUG_FUNCTION
			l_ctype: CLASS_TYPE
		do
			debug ("debugger_trace_eval")
				print (generating_type + ".impl_dotnet_evaluate_function : ")
				print (ctype.associated_class.name_in_upper + "." + f.feature_name)
				print ("%N")
			end
				--| Reset error status
			reset_error

				--| Process parameters
			if params /= Void and then not params.is_empty then
				prepare_parameters (ctype, realf, params)
				l_params := dotnet_parameters
				parameters_reset
			end

				--| Get the real adapted class_type
			l_ctype := adapted_class_type (ctype, f)

				--| Get the target object : `l_icdv_obj'
			l_icdv_obj := target_icor_debug_value (addr, a_target)

			if l_icdv_obj = Void then
				notify_error (Cst_error_unable_to_get_target_object, Void)
			else
					--| Get the ICorDebugFunction to call.
				l_icd_function := eifnet_debugger.icd_function_by_feature (l_icdv_obj, l_ctype, f)

					--| And then let's process the following ...
				if l_icd_function = Void then
					notify_error (Cst_error_unable_to_get_icd_function, Void)
				else
					last_result_value := dotnet_evaluate_icd_function (l_icdv_obj, l_icd_function, l_params)
					if error_occurred then
						l_error_message := "%"" + realf.feature_name + "%" : "
						if evaluation_aborted then
							l_error_message.append_string ("Evaluation aborted")
						elseif error_occurred then
							l_error_message.append_string (error_message)
						else
							l_error_message.append_string (" error occurred")
						end
						notify_error (Cst_error_occurred, l_error_message)
					end
				end
			end
		end

	effective_evaluate_function_with_name (a_addr: STRING; a_target: DUMP_VALUE;
				a_feature_name, a_external_name: STRING;
				params: LIST [DUMP_VALUE]) is
		local
			l_params: ARRAY [DUMP_VALUE]
			l_icdv_obj: ICOR_DEBUG_VALUE
			l_icd_function: ICOR_DEBUG_FUNCTION
			edvi: EIFNET_DEBUG_VALUE_INFO
		do
			debug ("debugger_trace_eval")
				print (generating_type + ".impl_dotnet_evaluate_function_with_name : ")
				print (a_feature_name + ", " + a_external_name )
				if a_addr /= Void then
					print (" on 0x" + a_addr)
				elseif a_target.address /= Void then

					print (" on 0x" + a_target.address )
				end
				print ("%N")
			end
				--| Reset error status
			reset_error
			if params /= Void and then not params.is_empty then
				prepare_parameters (a_target.dynamic_class_type, Void, params)
				l_params := dotnet_parameters
				parameters_reset
			end

				--| Get the target object : `l_icdv_obj'
			l_icdv_obj := target_icor_debug_value (a_addr, a_target)
			if l_icdv_obj = Void then
				notify_error (Cst_error_unable_to_get_target_object, Void)
			else
					--| Get the ICorDebugFunction to call.
				create edvi.make (l_icdv_obj)
				if edvi.has_object_interface then
					l_icd_function := edvi.value_icd_function (a_external_name)
				end
				edvi.icd_prepared_value.clean_on_dispose
				edvi.clean

					--| And then let's process the following ...
				if l_icd_function = Void then
					notify_error (Cst_error_unable_to_get_icd_function, Void)
				else
					last_result_value := dotnet_evaluate_icd_function (l_icdv_obj, l_icd_function, l_params)
				end
			end

			if last_result_value = Void then
				if a_addr = Void then
					notify_error (cst_error_occurred, "Unable to evaluate : " + a_external_name)
				else
					notify_error (cst_error_occurred, "Unable to evaluate : " + a_external_name + " on <" + a_addr + ">")
				end
			end
			if not error_occurred and then last_result_value /= Void then
				last_result_static_type := last_result_value.dynamic_class
				if last_result_static_type = Void then
					last_result_static_type:= Workbench.Eiffel_system.Any_class.compiled_class
				end
				if
					last_result_static_type /= Void and then
					last_result_static_type.is_basic and
					(last_result_value.address /= Void)
				then
						-- We expected a basic type, but got a reference.
						-- This happens in "2 + 2" because we convert the first 2
						-- to a reference and therefore get a reference.
					last_result_value := last_result_value.to_basic
				end
			end
		end

	effective_evaluate_static_function (f: FEATURE_I; ctype: CLASS_TYPE; params: LIST [DUMP_VALUE]) is
		local
			l_params: ARRAY [DUMP_VALUE]
			l_ctype: CLASS_TYPE
			l_icdv_args: ARRAY [ICOR_DEBUG_VALUE]
			l_icdm: ICOR_DEBUG_MODULE
			l_cl_tok, l_f_tok: INTEGER
			l_icd_fun: ICOR_DEBUG_FUNCTION
			l_result: ICOR_DEBUG_VALUE
			l_adv: ABSTRACT_DEBUG_VALUE
			l_icd_frame: ICOR_DEBUG_FRAME
		do
				--| Reset error status
			reset_error

			debug ("debugger_trace_eval")
				print (generating_type + ".dotnet_evaluate_static_function : ")
				print (ctype.associated_class.name_in_upper + "." + f.feature_name)
				print ("%N")
			end

			if params /= Void and then not params.is_empty then
				prepare_parameters (ctype, f, params)
				l_params := dotnet_parameters
				parameters_reset
			end

				--| Get the real adapted class_type
			l_ctype := adapted_class_type (ctype, f)
			l_icdv_args := prepared_parameters (l_params, False)

			l_icdm := Eifnet_debugger.runtime_module
				--| FIXME jfiat: here we are only dealing with EiffelSoftware runtime ... classes

			l_cl_tok := l_icdm.md_class_token_by_type_name (l_ctype.full_il_type_name)
			l_f_tok := l_icdm.md_feature_token (l_cl_tok, f.external_name)
			l_icd_fun := l_icdm.get_function_from_token (l_f_tok)
			if l_icd_fun /= Void then
				l_icd_frame := current_icor_debug_frame
				if l_icd_frame = Void then
						-- In case `associated_frame' is not set
					l_icd_frame := new_active_icd_frame
				end

				l_result := eifnet_evaluator.function_evaluation (l_icd_frame, l_icd_fun, l_icdv_args)

				if eifnet_evaluator.last_eval_aborted then
					notify_error (Cst_error_evaluation_aborted, Void)
				elseif eifnet_evaluator.last_eval_is_exception then
					l_result := Void
					notify_error (Cst_error_exception_during_evaluation, Void)
				elseif not eifnet_evaluator.last_call_succeed then
					notify_error (Cst_error_occurred, Void)
				end
				if not error_occurred then
					l_adv := debug_value_from_icdv (l_result, f.type.actual_type.associated_class)
					last_result_value := l_adv.dump_value
				end
			end
		end

	effective_evaluate_once (f: FEATURE_I) is
		local
			l_class_c: CLASS_C
			l_icd_value: ICOR_DEBUG_VALUE
			l_adv: ABSTRACT_DEBUG_VALUE
			err_dv: DUMMY_MESSAGE_DEBUG_VALUE
			exc_dv: EXCEPTION_DEBUG_VALUE
		do
			debug ("debugger_trace_eval")
				print (generating_type + ".effective_evaluate_once : ")
				print (f.written_class.name_in_upper + "." + f.feature_name)
				print ("%N")
			end

				--| Reset error status
			reset_error

			last_result_static_type := f.type.actual_type.associated_class
			l_class_c := f.written_class
				--| FIXME: JFIAT: 2004-01-05 : Does not support once evalution on generic
				--| this is related to dialog and issue to provide derivation selection


			l_icd_value := eifnet_debugger.once_function_value (Void, l_class_c, f)

			if l_icd_value /= Void then
				l_adv := debug_value_from_icdv (l_icd_value, last_result_static_type)
			end

			if last_once_available then
				if not last_once_already_called then
					create err_dv.make_with_name (f.feature_name)
					err_dv.set_message ("Once feature [" + f.feature_name + "]: not yet called")
					last_result_value := err_dv.dump_value

					notify_error (cst_error_occurred, "Once feature [" + f.feature_name + "]: not yet called")
				elseif last_once_failed then
					create exc_dv.make_with_name (f.feature_name)
					exc_dv.set_tag ("Once feature [" + f.feature_name + "]: an exception occurred")
					if l_adv /= Void then
						exc_dv.set_exception_value (l_adv)
					end
					last_result_value := exc_dv.dump_value

					notify_error (cst_error_exception_during_evaluation, "Once feature [" + f.feature_name + "]: an exception occurred")
				elseif l_adv = Void then
						--| Is it possible ???
					notify_error (cst_error_occurred, "Once feature [" + f.feature_name + "]: Default value (i.e: Void ...)")
				else
					last_result_value := l_adv.dump_value
				end
			else
				notify_error (cst_error_occurred , "Once feature " + f.feature_name + ": Could not get information")
			end
		end

	associated_reference_basic_class_type (cl: CLASS_C): CLASS_TYPE is
		local
			l_basic: BASIC_I
		do
			l_basic ?= cl.actual_type.type_i
			check
				l_basic_not_void: l_basic /= Void
			end
			Result := l_basic.associated_reference_class_type
		end

	current_object_from_callstack (cse: EIFFEL_CALL_STACK_ELEMENT): DUMP_VALUE is
		local
			cse_dotnet: CALL_STACK_ELEMENT_DOTNET
			l_curr_obj : ABSTRACT_DEBUG_VALUE
		do
			cse_dotnet ?= cse
			l_curr_obj := cse_dotnet.current_object
			if l_curr_obj /= Void then
				Result := l_curr_obj.dump_value
			end
		end

	dump_value_at_address (addr: STRING): DUMP_VALUE is
		do
			if Eifnet_debugger.know_about_kept_object (addr) then
				Result := Eifnet_debugger.kept_object_item (addr).dump_value
			end
		end

	address_from_basic_dump_value (a_target: DUMP_VALUE): STRING is
		local
			dump: DUMP_VALUE
		do
			dump := dotnet_metamorphose_basic_to_value (a_target)
			Result := dump.address
		end

feature {NONE} -- Parameters operation

	parameters_reset is
		do
			Precursor
			dotnet_parameters := Void
		end

	parameters_init (n: INTEGER) is
		do
			Precursor (n)
			create dotnet_parameters.make (1, n)
			dotnet_parameters_index := 0
		end

	parameters_push (dmp: DUMP_VALUE) is
		do
			dotnet_parameters_index := dotnet_parameters_index + 1
			dotnet_parameters.put (dmp, dotnet_parameters_index)
		end

	parameters_push_and_metamorphose (dmp: DUMP_VALUE) is
		local
			l_dmp: DUMP_VALUE
		do
			debug ("debugger_trace_eval_data")
				print (generating_type + ".parameters_push_and_metamorphose :: dotnet Metamorphose ... %N")
			end
			l_dmp := dotnet_metamorphose_basic_to_reference_value (dmp)
			dotnet_parameters_index := dotnet_parameters_index + 1
			dotnet_parameters.put (l_dmp, dotnet_parameters_index)
		end

	prepared_parameters (a_params: ARRAY [DUMP_VALUE]; with_first_empty_element: BOOLEAN): ARRAY [ICOR_DEBUG_VALUE] is
			-- Prepared param for dotnet evaluation.
		local
			l_param_i: INTEGER
			l_dumpvalue_param: DUMP_VALUE
			l_icdv_param: ICOR_DEBUG_VALUE
		do
			if a_params /= Void then
				if with_first_empty_element then
					create Result.make (1, a_params.count + 1)
				else
					create Result.make (2, a_params.count + 1)
				end
				from
					l_param_i := a_params.lower
				until
					l_param_i > a_params.upper or error_occurred
				loop
					l_dumpvalue_param := a_params @ l_param_i
					l_icdv_param := l_dumpvalue_param.value_dotnet
					if l_icdv_param = Void then
							--| This means this value has been created by eStudioDbg
							--| We need to build the corresponding ICorDebugValue object.
						debug ("debugger_trace_eval_data")
							print (generating_type + ".prepared_parameters: creating dotnet value from DUMP_VALUE %N")
						end
						l_icdv_param := dump_value_to_icdv (l_dumpvalue_param)
						if not eifnet_evaluator.last_call_succeed then
							notify_error (Cst_error_occurred_during_parameters_preparation, Void)
						end
					end
					debug ("debugger_trace_eval_data")
						print (generating_type + ".prepared_parameters: param ... %N")
						display_info_on_object (l_icdv_param)
					end
					Result.put (l_icdv_param, l_param_i + 1)
						-- we'll set the first arg later
					l_param_i := l_param_i + 1
				end
			else
				if with_first_empty_element then
					create Result.make (1, 1)
				else
					Result := << >>
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	dotnet_parameters: ARRAY [DUMP_VALUE]

	dotnet_parameters_index: INTEGER


feature {NONE} -- Properties

	eifnet_debugger: EIFNET_DEBUGGER
			-- Facade to the dotnet debugger

	eifnet_evaluator: EIFNET_DEBUGGER_EVALUATOR
			-- Feature evaluator

feature {NONE} -- Bridge

	last_once_available: BOOLEAN is
		do
			Result := eifnet_debugger.last_once_available
		end

	last_once_failed: BOOLEAN is
		do
			Result := eifnet_debugger.last_once_failed
		end

	last_once_already_called: BOOLEAN is
		do
			Result := eifnet_debugger.last_once_already_called
		end

	current_icor_debug_frame: ICOR_DEBUG_FRAME is
			-- Current shared ICorDebugFrame encapsulated instance
		do
			Result := eifnet_debugger.current_stack_icor_debug_frame
		end

	new_active_icd_frame: ICOR_DEBUG_FRAME is
			-- Default ICorDebugFrame which is the active frame
		do
			Result := eifnet_debugger.new_active_frame
		end
feature {NONE} -- Error code id

	Cst_error_unable_to_get_icd_function: INTEGER is 0x20

	Cst_error_messages: HASH_TABLE [STRING, INTEGER] is
		once
			Result := Precursor
			Result.force ("Unable to get ICorDebugFunction", Cst_error_unable_to_get_icd_function)
		end

feature {NONE} -- Implementation

	dotnet_metamorphose_basic_to_reference_value (dmp: DUMP_VALUE): DUMP_VALUE is
			-- Metamorphose basic type into corresponding "reference TYPE" type
		local
			icdv: ICOR_DEBUG_VALUE
			dv: EIFNET_ABSTRACT_DEBUG_VALUE
		do
			icdv := dump_value_to_reference_icdv (dmp)
			if icdv /= Void then
				dv := debug_value_from_icdv (icdv, Void)
				Result := dv.dump_value
			else
				Result := dmp
			end
		end

	dotnet_metamorphose_basic_to_value (dmp: DUMP_VALUE): DUMP_VALUE is
			-- Metamorphose basic type into corresponding dotnet value type
		require
			dmp_not_void: dmp /= Void
		local
			icdv: ICOR_DEBUG_VALUE
			dv: EIFNET_ABSTRACT_DEBUG_VALUE
		do
			icdv := dump_value_to_icdv (dmp)
			if icdv /= Void then
-- FIXME JFIAT
				dv := debug_value_from_icdv (icdv, Void)
				Result := dv.dump_value
			else
				Result := dmp
			end
		ensure
			Result /= Void
		end

	dotnet_evaluate_icd_function (target_icdv: ICOR_DEBUG_VALUE; func: ICOR_DEBUG_FUNCTION;
					a_params: ARRAY [DUMP_VALUE]): DUMP_VALUE is
		require
			target_icdv /= Void
			func /= Void
		local
			l_adv: ABSTRACT_DEBUG_VALUE
			l_icd_frame: ICOR_DEBUG_FRAME
			l_icdv_args: ARRAY [ICOR_DEBUG_VALUE]
			l_result: ICOR_DEBUG_VALUE
		do
			debug ("debugger_trace_eval_data")
				display_funct_info_on_object (func)
			end

				--| Build the arguments for dotnet
			l_icdv_args := prepared_parameters (a_params, True)
			if not error_occurred then
				debug ("debugger_trace_eval_data")
					print (generating_type + ".dotnet_evaluate_icd_function: target ... %N")
					display_info_on_object (target_icdv)
				end

				l_icdv_args.put (target_icdv, 1) -- First arg is the obj on which the evaluation is done.
				l_icd_frame := current_icor_debug_frame
				if l_icd_frame = Void then
						-- In case `associated_frame' is not set
					l_icd_frame := new_active_icd_frame
				end

				l_result := eifnet_evaluator.function_evaluation (l_icd_frame, func, l_icdv_args)
				if eifnet_evaluator.last_eval_aborted then
					notify_error (Cst_error_evaluation_aborted, Void)
				elseif eifnet_evaluator.last_eval_is_exception then

--					print (eifnet_debugger.exception_text_from (l_result))
--					l_result := Void
					l_adv := debug_value_from_icdv (l_result, Void)
					Result := l_adv.dump_value

					notify_error (Cst_error_exception_during_evaluation, Void)
				elseif not eifnet_evaluator.last_call_succeed then
					notify_error (Cst_error_occurred, Void)
				end
				if not error_occurred then
					l_adv := debug_value_from_icdv (l_result, Void)
					Result := l_adv.dump_value
				end
			end
			debug ("debugger_trace_eval_data")
				if l_result /= Void then
					print (generating_type + ".dotnet_evaluate_icd_function: result ... %N")
					display_info_on_object (l_result)
				end
			end
		end

	target_icor_debug_value (addr: STRING; dvalue: DUMP_VALUE): ICOR_DEBUG_VALUE is
		do
				--| Get the target object : `l_icdv_obj'
			if dvalue = Void then
				Result := icd_value_by_address (addr)
					-- FIXME JFIAT: l_icdv_obj might be Void if object not found ... how come ?
					-- should be fixed now, but .. may occur regarding to .NET GC
			else
				if dvalue.is_basic then
					Result := dotnet_metamorphose_basic_to_reference_value (dvalue).value_dotnet
				else
					Result := dvalue.value_dotnet
				end
				if Result = Void then
					Result := dump_value_to_reference_icdv (dvalue)
				end
			end
		ensure
			valid_result: Result /= Void implies Result.item_not_null
		end

	dump_value_to_icdv (dmv: DUMP_VALUE): ICOR_DEBUG_VALUE is
			-- DUMP_VALUE converted into ICOR_DEBUG_VALUE.
		require
			dmv_not_void: dmv /= Void
		do
			Result := dmv.value_dotnet
			if Result = Void then
					--| This means this value has been created by eStudioDbg
					--| We need to build the corresponding ICorDebugValue object.
				inspect dmv.type
				when {DUMP_VALUE_CONSTANTS}.type_integer_32 then
					Result := eifnet_evaluator.new_i4_evaluation (new_active_icd_frame, dmv.value_integer_32)
				when {DUMP_VALUE_CONSTANTS}.type_boolean then
					Result := eifnet_evaluator.new_boolean_evaluation (new_active_icd_frame, dmv.value_boolean )
				when {DUMP_VALUE_CONSTANTS}.type_character then
					Result := eifnet_evaluator.new_char_evaluation (new_active_icd_frame, dmv.value_character )
				when {DUMP_VALUE_CONSTANTS}.type_string then
					Result := eifnet_evaluator.new_eiffel_string_evaluation (new_active_icd_frame, dmv.value_string )
				else
				end

				if not eifnet_evaluator.last_call_succeed then
					notify_error (Cst_error_occurred, Void)
				end
			end
		end

	dump_value_to_reference_icdv (dmv: DUMP_VALUE): ICOR_DEBUG_VALUE is
			-- DUMP_VALUE converted into ICOR_DEBUG_VALUE for reference TYPE Objects
		do
			Result := dmv.value_dotnet

			if dmv.is_basic or dmv.is_type_string then
				if Result /= Void then
						--| we have a basic type as dotnet value

						--| typically result of previous expression
					inspect dmv.type
					when {DUMP_VALUE_CONSTANTS}.type_integer_32 then
						Result := eifnet_evaluator.icdv_reference_integer_32_from_icdv_integer_32 (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_real_32 then
						Result := eifnet_evaluator.icdv_reference_real_from_icdv_real (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_real_64 then
						Result := eifnet_evaluator.icdv_reference_double_from_icdv_double (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_boolean then
						Result := eifnet_evaluator.icdv_reference_boolean_from_icdv_boolean (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_character then
						Result := eifnet_evaluator.icdv_reference_character_from_icdv_character (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_string then
						Result := eifnet_evaluator.icdv_string_from_icdv_system_string (new_active_icd_frame, Result)
					else
					end
				else
						--| we have manifest value

						--| This means this value has been created by eStudioDbg
						--| We need to build the corresponding ICorDebugValue object.
					inspect dmv.type
					when {DUMP_VALUE_CONSTANTS}.type_integer_32 then
						Result := eifnet_evaluator.new_reference_i4_evaluation (new_active_icd_frame, dmv.value_integer_32)
					when {DUMP_VALUE_CONSTANTS}.type_real_32 then
						Result := eifnet_evaluator.new_reference_real_evaluation (new_active_icd_frame, dmv.value_real )
					when {DUMP_VALUE_CONSTANTS}.type_real_64 then
						Result := eifnet_evaluator.new_reference_double_evaluation (new_active_icd_frame, dmv.value_double )
					when {DUMP_VALUE_CONSTANTS}.type_boolean then
						Result := eifnet_evaluator.new_reference_boolean_evaluation (new_active_icd_frame, dmv.value_boolean )
					when {DUMP_VALUE_CONSTANTS}.type_character then
						Result := eifnet_evaluator.new_reference_character_evaluation (new_active_icd_frame, dmv.value_character )
					when {DUMP_VALUE_CONSTANTS}.type_string then
						Result := eifnet_evaluator.new_eiffel_string_evaluation (new_active_icd_frame, dmv.value_string )
					else
					end
				end
				if not eifnet_evaluator.last_call_succeed then
					notify_error (Cst_error_occurred, Void)
				end
			end
		end

feature {NONE} -- Internal Helpers

	icd_value_by_address (addr: STRING): ICOR_DEBUG_VALUE is
			-- ICorDebugValue indexed by `addr' if exists
		require
			address_valid: addr /= Void and then not addr.is_empty
		local
			dv: EIFNET_ABSTRACT_DEBUG_VALUE
		do
			dv ?= debug_value_by_address (addr)
			if dv /= Void then
				Result := dv.icd_referenced_value
			else
				--| FIXME jfiat [2004/02/19] : can't find object by address .. how can this happens ???!!!
				-- should be fixed now, but .. may occur regarding to .NET GC
				-- we need to find a way to keep strong references
			end
		end

feature -- Helpers

	debug_value_by_address (addr: STRING): ABSTRACT_DEBUG_VALUE is
			-- ABSTRACT_DEBUG_VALUE indexed by `addr' if exists
		require
			address_valid: addr /= Void and then not addr.is_empty
		do
			if Eifnet_debugger.know_about_kept_object (addr) then
				Result := Eifnet_debugger.kept_object_item (addr)
			end
		end

feature {NONE} -- Debug purpose only

	display_funct_info_on_object (icd_f: ICOR_DEBUG_FUNCTION) is
			-- Display information related to feature `icd_f'
			-- debug purpose only
		local
			mdi: MD_IMPORT
			l_class: ICOR_DEBUG_CLASS
		do
			debug ("debugger_trace_eval_data")
				if icd_f /= Void then
					mdi := icd_f.get_class.get_module.interface_md_import
					print (generating_type + " : Fct evaluation : " + mdi.get_method_props (icd_f.get_token) + "%N")
					l_class := icd_f.get_class
					print (generating_type + " :      on class : " + mdi.get_typedef_props (l_class.get_token) + "%N")
				end
			end
		end

	display_info_on_object (icdv: ICOR_DEBUG_VALUE) is
			-- Display information related to object `icdv'
			-- debug purpose only
		local
			l_edvi: EIFNET_DEBUG_VALUE_INFO
			retried: BOOLEAN
		do
			debug ("debugger_trace_eval_data")
				if not retried then
					create l_edvi.make (icdv)
					if l_edvi.has_object_interface and then l_edvi.value_class_name /= Void then
						print (generating_type + " : ClassName = " + l_edvi.value_class_name + "%N")
					else
						if l_edvi.is_reference_type then
							print ("IsNull =? " + l_edvi.is_null.out +"%N")
						end
						print (generating_type + " : Basic type = " + l_edvi.is_basic_type.out + "%N")
					end
				else
					print (generating_type + " : Error in display info .. %N")
				end
			end
		rescue
			retried := True
			retry
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
