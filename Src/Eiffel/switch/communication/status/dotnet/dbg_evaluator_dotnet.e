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
		local
			app: APPLICATION_EXECUTION_DOTNET
		do
			Precursor
			app ?= debugger_manager.application
			eifnet_debugger := app.eifnet_debugger
			eifnet_evaluator := eifnet_debugger.eifnet_dbg_evaluator
		end

feature {DBG_EVALUATOR} -- Interface

	effective_evaluate_routine (addr: STRING; a_target: DUMP_VALUE; f, realf: FEATURE_I;
			ctype: CLASS_TYPE; orig_class: CLASS_C; params: LIST [DUMP_VALUE];
			is_static_call: BOOLEAN) is
			-- Evaluate dotnet function
		local
			l_params: ARRAY [DUMP_VALUE]
			l_error_message: STRING
			l_icdv_obj: ICOR_DEBUG_VALUE
			l_icd_function: ICOR_DEBUG_FUNCTION
			l_ctype: CLASS_TYPE
			exc_dv: EXCEPTION_DEBUG_VALUE
			nat_ct: NATIVE_ARRAY_CLASS_TYPE
			nat_edv: EIFNET_DEBUG_NATIVE_ARRAY_VALUE
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
				nat_ct ?= l_ctype
				if nat_ct /= Void then
					if a_target /= Void then
						nat_edv ?= a_target.as_dump_value_dotnet.eifnet_debug_value
					end
					if nat_edv /= Void then
						internal_evaluate_function_on_native_array (nat_edv, realf, l_params)
					else
						notify_error (Cst_error_occurred, " NATIVE_ARRAY is not yet fully supported")
					end
				else
						--| Get the ICorDebugFunction to call.
					l_icd_function := eifnet_debugger.icd_function_by_feature (l_icdv_obj, l_ctype, realf)

						--| And then let's process the following ...
					if l_icd_function = Void then
						notify_error (Cst_error_unable_to_get_icd_function, Void)
					else
						last_result_value := dotnet_evaluate_icd_function (l_icdv_obj, l_icd_function, l_params, l_ctype.is_external, f.is_function)
						if error_occurred then
							l_error_message := "%"" + realf.feature_name + "%" : "
							if evaluation_aborted then
								l_error_message.append_string ("Evaluation aborted")
							elseif exception_occurred then
								exc_dv := last_result_value.value_exception
								if exc_dv /= Void then
									exc_dv.set_name (f.feature_name)
									exc_dv.set_tag ("Feature [" + f.feature_name + "]: an exception occurred")
									l_error_message.append_string ("Exception occurred during evaluation"
											+ " of {" + f.written_class.name_in_upper + "}." + f.feature_name + ": %N"
											+ exc_dv.display_message
	--										+ last_exception_trace
										)
								else
									l_error_message.append_string (error_message)
								end
							elseif error_occurred then
								l_error_message.append_string (error_message)
							else
								l_error_message.append_string (" error occurred")
							end
							notify_error (Cst_error_occurred, l_error_message)
						else
							if not f.is_function then
								check last_result_value = Void end
								last_result_value := debugger_manager.dump_value_factory.new_procedure_return_value (
										create {PROCEDURE_RETURN_DEBUG_VALUE}.make_with_name (f.feature_name)
									)
							end
						end
					end
				end
			end
		end

	internal_evaluate_function_on_native_array (nat_edv: EIFNET_DEBUG_NATIVE_ARRAY_VALUE; f: FEATURE_I; a_params: ARRAY [DUMP_VALUE]) is
			-- Internal evaluation on NATIVE_ARRAY dotnet pseudo objects
			-- The debugger does not fully support any evaluation on it
			-- but we try to support as much as possible
			-- FIXME: improve support of NATIVE_ARRAY under dotnet
		require
			nat_edv_not_void: nat_edv /= Void
			f_not_void: f /= Void
		local
			fn: STRING
			dv: DUMP_VALUE
			idv: ICOR_DEBUG_VALUE
			l_adv: EIFNET_ABSTRACT_DEBUG_VALUE
			i: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				nat_edv.get_array_value
				fn := f.feature_name
				if fn /= Void then
					if fn.is_equal ("count") then
						last_result_value := debugger_manager.dump_value_factory.new_integer_32_value (nat_edv.array_value.get_count, system.integer_32_class.compiled_class)
					elseif fn.is_equal ("upper") then
						last_result_value := debugger_manager.dump_value_factory.new_integer_32_value (nat_edv.array_value.get_count - 1, system.integer_32_class.compiled_class)
					elseif fn.is_equal ("lower") then
						last_result_value := debugger_manager.dump_value_factory.new_integer_32_value (0, system.integer_32_class.compiled_class)
					elseif fn.is_equal ("item") or else fn.is_equal ("infix %"@%"") then
						if a_params /= Void and then a_params.count > 0 then
							dv := a_params [a_params.lower]
							if dv.is_type_integer_32 then
								i := dv.as_dump_value_basic.value_integer_32
								idv := nat_edv.array_value.get_element_at_position (i)
								if idv /= Void then
									l_adv := debug_value_from_icdv (idv, Void)
									last_result_value := l_adv.dump_value
								end
							end
						end
					else
						notify_error (Cst_error_occurred, " NATIVE_ARRAY is not yet fully supported, unable to evaluate %"" + fn + "%"")
					end
				end
				nat_edv.release_array_value
			else
				notify_error (Cst_error_occurred, " an internal error occurred during evaluation of  %"{NATIVE_ARRAY}." + f.feature_name + "%"")
				if nat_edv.array_value /= Void then
					nat_edv.release_array_value
				end
			end
		rescue
			retried := True
			retry
		end

	effective_evaluate_function_with_name (a_addr: STRING; a_target: DUMP_VALUE;
				a_feature_name, a_external_name: STRING;
				params: LIST [DUMP_VALUE]) is
			-- Note: this feature is used only for external function
		local
			l_ct: CLASS_TYPE
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
				elseif a_target /= Void and then a_target.address /= Void then

					print (" on 0x" + a_target.address )
				end
				print ("%N")
			end
				--| Reset error status
			reset_error
			if a_target /= Void then
				--| fixme: maybe we could retrieve the dyn class type using the `a_addr' value
				l_ct := a_target.dynamic_class_type
			end
			if params /= Void and then not params.is_empty then
				prepare_parameters (l_ct, Void, params)
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
						--| The current feature is used only for external function
						--| Then we pass `True' to set the `is_external' argument.
					last_result_value := dotnet_evaluate_icd_function (l_icdv_obj, l_icd_function, l_params, True, True)
				end
			end

			if last_result_value = Void or error_occurred then
				if a_addr = Void then
					notify_error (cst_error_occurred, "Unable to evaluate : " + a_external_name)
				else
					notify_error (cst_error_occurred, "Unable to evaluate : " + a_external_name + " on <" + a_addr + ">")
				end
			end
			if not error_occurred and then last_result_value /= Void then
				last_result_static_type := last_result_value.dynamic_class
				if last_result_static_type = Void then
					last_result_static_type := Workbench.Eiffel_system.Any_class.compiled_class
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

			l_icdm := Eifnet_debugger.ise_runtime_module
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
					l_adv := debug_value_from_icdv (l_result, f.type.associated_class)
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

			last_result_static_type := f.type.associated_class
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
					exc_dv.set_wrapper_mode (True)
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

	create_empty_instance_of (a_type_i: CL_TYPE_I) is
			-- create an empty instance of `a_type_i'
		local
			l_class_c: CLASS_C
			l_icd_value: ICOR_DEBUG_VALUE
			l_class: ICOR_DEBUG_CLASS
			l_adv: ABSTRACT_DEBUG_VALUE

			l_gens: ARRAY [TYPE_I]
			l_gens_nb: INTEGER
		do
			if a_type_i.has_associated_class_type then
				l_gens := a_type_i.true_generics
				if l_gens /= Void then
					l_gens_nb := l_gens.count
				end
				if l_gens_nb > 0 then
						--| Create INTERNAL's object
					l_class_c := debugger_manager.compiler_data.internal_class_c
					if l_class_c /= Void then
						l_class := eifnet_debugger.icor_debug_class (l_class_c.types.first)
						l_icd_value := eifnet_evaluator.new_object_no_constructor_evaluation (new_active_icd_frame, l_class)
						if not eifnet_evaluator.last_call_succeed then
							notify_error (Cst_error_occurred, Void)
						else
								--| At this point l_icd_value represents an instance of INTERNAL
							last_result_value := new_empty_instance_of_using_internal (a_type_i, l_icd_value, l_class_c)
						end
					else
						notify_error (Cst_error_occurred, Void)
					end
				else
					l_class := eifnet_debugger.icor_debug_class (a_type_i.associated_class_type)
					l_icd_value := eifnet_evaluator.new_object_no_constructor_evaluation (new_active_icd_frame, l_class)
					if not eifnet_evaluator.last_call_succeed then
						l_icd_value := Void
						notify_error (Cst_error_occurred, Void)
					else
						l_adv := debug_value_from_icdv (l_icd_value, a_type_i.associated_class_type.associated_class)
						last_result_value := l_adv.dump_value
					end
				end
			else
				notify_error (cst_error_occurred, "Could not create instance of [" + a_type_i.name + "]")
			end
		end

	new_empty_instance_of_using_internal (a_type_i: CL_TYPE_I; a_internal_value: ICOR_DEBUG_VALUE; a_internal_class_c: CLASS_C): DUMP_VALUE is
			--
		local
			l_dyn_type_from_str_feat_i,
			l_new_instance_of_feat_i: FEATURE_I
			l_icd_func: ICOR_DEBUG_FUNCTION
			l_i_dv, l_dv: DUMP_VALUE
		do
			l_dyn_type_from_str_feat_i := a_internal_class_c.feature_named ("dynamic_type_from_string")
			l_icd_func := eifnet_debugger.icd_function_by_feature (a_internal_value, a_internal_class_c.types.first, l_dyn_type_from_str_feat_i)
			l_i_dv := debugger_manager.dump_value_factory.new_manifest_string_value (a_type_i.name, debugger_manager.compiler_data.string_8_class_c)
			l_dv := dotnet_evaluate_icd_function (a_internal_value, l_icd_func, <<l_i_dv>>, False, True)

			l_new_instance_of_feat_i := a_internal_class_c.feature_named ("new_instance_of")
			l_icd_func := eifnet_debugger.icd_function_by_feature (a_internal_value, a_internal_class_c.types.first, l_new_instance_of_feat_i)
			Result := dotnet_evaluate_icd_function (a_internal_value, l_icd_func, <<l_dv>>, False, True)
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

	last_exception_trace: STRING

	dotnet_evaluate_icd_function (target_icdv: ICOR_DEBUG_VALUE; func: ICOR_DEBUG_FUNCTION;
				a_params: ARRAY [DUMP_VALUE]; is_external: BOOLEAN; expecting_result: BOOLEAN): DUMP_VALUE is
		require
			target_icdv /= Void
			func /= Void
		local
			l_adv: ABSTRACT_DEBUG_VALUE
			l_icd_frame: ICOR_DEBUG_FRAME
			l_icdv_args: ARRAY [ICOR_DEBUG_VALUE]
			l_result: ICOR_DEBUG_VALUE
			l_exc_dv: EXCEPTION_DEBUG_VALUE
		do
			debug ("debugger_trace_eval_data")
				display_funct_info_on_object (func)
			end

			last_exception_trace := Void

				--| Build the arguments for dotnet
			l_icdv_args := prepared_parameters (a_params, True) --not is_external)
			if not error_occurred then
				debug ("debugger_trace_eval_data")
					print (generating_type + ".dotnet_evaluate_icd_function: target ... %N")
					display_info_on_object (target_icdv)
				end

--| FIXME: bug#11255: Debugger gets it all wrong in .NET
--| Might be related to first argument, or arguments count ...

				l_icdv_args.put (target_icdv, l_icdv_args.lower) -- First arg is the obj on which the evaluation is done.

				l_icd_frame := current_icor_debug_frame
				if l_icd_frame = Void then
						-- In case `associated_frame' is not set
					l_icd_frame := new_active_icd_frame
				end

				l_result := eifnet_evaluator.function_evaluation (l_icd_frame, func, l_icdv_args)
				if eifnet_evaluator.last_eval_aborted then
					notify_error (Cst_error_evaluation_aborted, Void)
				elseif eifnet_evaluator.last_eval_is_exception then
					l_adv := debug_value_from_icdv (l_result, Void)
					create l_exc_dv.make_with_name (once "Unknown")
					l_exc_dv.set_wrapper_mode (True)
					l_exc_dv.set_tag ("An exception occurred")
					l_exc_dv.set_message (eifnet_debugger.exception_text_from (l_result))
					if l_adv /= Void then
						l_exc_dv.set_exception_value (l_adv)
					end
					Result := l_exc_dv.dump_value
					notify_error (Cst_error_exception_during_evaluation, Void)
				elseif not eifnet_evaluator.last_call_succeed then
					notify_error (Cst_error_occurred, Void)
				end
				if not error_occurred then
					if l_result /= Void or expecting_result then
						if l_result /= Void then
							l_adv := debug_value_from_icdv (l_result, Void)
							Result := l_adv.dump_value
						else
							fixme("How come l_result is Void with no Error message ?")
						end
					else
						--| This might be a procedure return
						--| then we return Void
					end
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
		local
			dmvb: DUMP_VALUE_BASIC
		do
			Result := dmv.value_dotnet
			if Result = Void then
					--| This means this value has been created by eStudioDbg
					--| We need to build the corresponding ICorDebugValue object.
				dmvb ?= dmv
				inspect dmv.type
				when {DUMP_VALUE_CONSTANTS}.type_integer_8 then
					Result := eifnet_evaluator.new_i1_evaluation (new_active_icd_frame, dmvb.value_integer_8)
				when {DUMP_VALUE_CONSTANTS}.type_integer_16 then
					Result := eifnet_evaluator.new_i2_evaluation (new_active_icd_frame, dmvb.value_integer_16)
				when {DUMP_VALUE_CONSTANTS}.type_integer_32 then
					Result := eifnet_evaluator.new_i4_evaluation (new_active_icd_frame, dmvb.value_integer_32)
				when {DUMP_VALUE_CONSTANTS}.type_integer_64 then
					Result := eifnet_evaluator.new_i8_evaluation (new_active_icd_frame, dmvb.value_integer_64)

				when {DUMP_VALUE_CONSTANTS}.type_natural_8 then
					Result := eifnet_evaluator.new_u1_evaluation (new_active_icd_frame, dmvb.value_natural_8)
				when {DUMP_VALUE_CONSTANTS}.type_natural_16 then
					Result := eifnet_evaluator.new_u2_evaluation (new_active_icd_frame, dmvb.value_natural_16)
				when {DUMP_VALUE_CONSTANTS}.type_natural_32 then
					Result := eifnet_evaluator.new_u4_evaluation (new_active_icd_frame, dmvb.value_natural_32)
				when {DUMP_VALUE_CONSTANTS}.type_natural_64 then
					Result := eifnet_evaluator.new_u8_evaluation (new_active_icd_frame, dmvb.value_natural_64)

				when {DUMP_VALUE_CONSTANTS}.type_boolean then
					Result := eifnet_evaluator.new_boolean_evaluation (new_active_icd_frame, dmvb.value_boolean )
				when {DUMP_VALUE_CONSTANTS}.type_character_8 then
					Result := eifnet_evaluator.new_char_evaluation (new_active_icd_frame, dmvb.value_character_8)
				when {DUMP_VALUE_CONSTANTS}.type_character_32 then
					fixme ("FIXME: when CHARACTER_32 is redesign for dotnet, change that")
					Result := eifnet_evaluator.new_u4_evaluation (new_active_icd_frame, dmvb.value_character_32.natural_32_code)

				when {DUMP_VALUE_CONSTANTS}.type_real_32 then
					Result := eifnet_evaluator.new_r4_evaluation (new_active_icd_frame, dmvb.value_real_32)
				when {DUMP_VALUE_CONSTANTS}.type_real_64 then
					Result := eifnet_evaluator.new_r8_evaluation (new_active_icd_frame, dmvb.value_real_64)
				when {DUMP_VALUE_CONSTANTS}.type_pointer then
					Result := eifnet_evaluator.new_ptr_evaluation (new_active_icd_frame, dmvb.value_pointer)

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
		local
			dmvb: DUMP_VALUE_BASIC
		do
			Result := dmv.value_dotnet

			if dmv.is_basic or dmv.is_type_string then
				if Result /= Void then
						--| we have a basic type as dotnet value

						--| typically result of previous expression
					inspect dmv.type
					when {DUMP_VALUE_CONSTANTS}.type_integer_8 then
						Result := eifnet_evaluator.icdv_reference_integer_8_from_icdv_integer_8 (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_integer_16 then
						Result := eifnet_evaluator.icdv_reference_integer_16_from_icdv_integer_16 (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_integer_32 then
						Result := eifnet_evaluator.icdv_reference_integer_32_from_icdv_integer_32 (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_integer_64 then
						Result := eifnet_evaluator.icdv_reference_integer_64_from_icdv_integer_64 (new_active_icd_frame, Result)

					when {DUMP_VALUE_CONSTANTS}.type_natural_8 then
						Result := eifnet_evaluator.icdv_reference_natural_8_from_icdv_natural_8 (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_natural_16 then
						Result := eifnet_evaluator.icdv_reference_natural_16_from_icdv_natural_16 (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_natural_32 then
						Result := eifnet_evaluator.icdv_reference_natural_32_from_icdv_natural_32 (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_natural_64 then
						Result := eifnet_evaluator.icdv_reference_natural_64_from_icdv_natural_64 (new_active_icd_frame, Result)

					when {DUMP_VALUE_CONSTANTS}.type_real_32 then
						Result := eifnet_evaluator.icdv_reference_real_from_icdv_real (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_real_64 then
						Result := eifnet_evaluator.icdv_reference_double_from_icdv_double (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_boolean then
						Result := eifnet_evaluator.icdv_reference_boolean_from_icdv_boolean (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_character_8 then
						Result := eifnet_evaluator.icdv_reference_character_8_from_icdv_character_8 (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_character_32 then
						Result := eifnet_evaluator.icdv_reference_character_32_from_icdv_character_32 (new_active_icd_frame, Result)

					when {DUMP_VALUE_CONSTANTS}.type_pointer then
						Result := eifnet_evaluator.icdv_reference_pointer_from_icdv_pointer (new_active_icd_frame, Result)
					when {DUMP_VALUE_CONSTANTS}.type_string then
						Result := eifnet_evaluator.icdv_string_from_icdv_system_string (new_active_icd_frame, Result)
					else
					end
				else
						--| we have manifest value

						--| This means this value has been created by eStudioDbg
						--| We need to build the corresponding ICorDebugValue object.
					dmvb ?= dmv
					inspect dmv.type
					when {DUMP_VALUE_CONSTANTS}.type_integer_8 then
						Result := eifnet_evaluator.new_reference_i1_evaluation (new_active_icd_frame, dmvb.value_integer_8)
					when {DUMP_VALUE_CONSTANTS}.type_integer_16 then
						Result := eifnet_evaluator.new_reference_i2_evaluation (new_active_icd_frame, dmvb.value_integer_16)
					when {DUMP_VALUE_CONSTANTS}.type_integer_32 then
						Result := eifnet_evaluator.new_reference_i4_evaluation (new_active_icd_frame, dmvb.value_integer_32)
					when {DUMP_VALUE_CONSTANTS}.type_integer_64 then
						Result := eifnet_evaluator.new_reference_i8_evaluation (new_active_icd_frame, dmvb.value_integer_64)

					when {DUMP_VALUE_CONSTANTS}.type_natural_8 then
						Result := eifnet_evaluator.new_reference_u1_evaluation (new_active_icd_frame, dmvb.value_natural_8)
					when {DUMP_VALUE_CONSTANTS}.type_natural_16 then
						Result := eifnet_evaluator.new_reference_u2_evaluation (new_active_icd_frame, dmvb.value_natural_16)
					when {DUMP_VALUE_CONSTANTS}.type_natural_32 then
						Result := eifnet_evaluator.new_reference_u4_evaluation (new_active_icd_frame, dmvb.value_natural_32)
					when {DUMP_VALUE_CONSTANTS}.type_natural_64 then
						Result := eifnet_evaluator.new_reference_u8_evaluation (new_active_icd_frame, dmvb.value_natural_64)

					when {DUMP_VALUE_CONSTANTS}.type_real_32 then
						Result := eifnet_evaluator.new_reference_real_evaluation (new_active_icd_frame, dmvb.value_real_32 )
					when {DUMP_VALUE_CONSTANTS}.type_real_64 then
						Result := eifnet_evaluator.new_reference_double_evaluation (new_active_icd_frame, dmvb.value_real_64 )
					when {DUMP_VALUE_CONSTANTS}.type_boolean then
						Result := eifnet_evaluator.new_reference_boolean_evaluation (new_active_icd_frame, dmvb.value_boolean )
					when {DUMP_VALUE_CONSTANTS}.type_character_8 then
						Result := eifnet_evaluator.new_reference_character_8_evaluation (new_active_icd_frame, dmvb.value_character_8 )
					when {DUMP_VALUE_CONSTANTS}.type_character_32 then
						Result := eifnet_evaluator.new_reference_character_32_evaluation (new_active_icd_frame, dmvb.value_character_32 )
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
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
