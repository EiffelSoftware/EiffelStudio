indexing
	description: "Class used for EB_EXPRESSION, to evaluate functions and ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EVALUATOR

inherit

	SHARED_APPLICATION_EXECUTION

	EIFNET_EXPORTER
	
	ICOR_EXPORTER

	COMPILER_EXPORTER	

	SHARED_EIFNET_DEBUG_VALUE_FACTORY

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			eifnet_debugger := Application.imp_dotnet.eifnet_debugger
			il_debug_info_recorder := eifnet_debugger.il_debug_info_recorder
			eifnet_evaluator := eifnet_debugger.evaluator
		end

	eifnet_debugger: EIFNET_DEBUGGER
			-- Facade to the dotnet debugger

	eifnet_evaluator: EIFNET_DEBUGGER_EVALUATOR
			-- Feature evaluator

	il_debug_info_recorder: IL_DEBUG_INFO_RECORDER
			-- IL Info container

	icd_frame: ICOR_DEBUG_FRAME is
			-- Default ICorDebugFrame which is the active frame
		do
			Result := eifnet_debugger.active_frame
		end

	error_occured: BOOLEAN
			-- Did an error occured during processing ?

feature -- Access

	dotnet_metamorphose_basic_to_ref (dmp: DUMP_VALUE): DUMP_VALUE is
			-- Metamorphose basic type into corresponding _REF type
		local
			icdv: ICOR_DEBUG_VALUE
			dv: EIFNET_ABSTRACT_DEBUG_VALUE
		do
			icdv := dump_value_to_icdv_ref (dmp)
			if icdv /= Void then
				dv := debug_value_from_icdv (icdv)
				Result := dv.dump_value
			else
				Result := dmp
			end
		end

	dotnet_evaluate_once_function (f: E_FEATURE): DUMP_VALUE is
			-- Evaluation of once function
		local
			l_class_type: CLASS_TYPE
			l_class_c: CLASS_C
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_value: ICOR_DEBUG_VALUE
			l_adv: ABSTRACT_DEBUG_VALUE
		do
			l_class_c := f.written_class
				--| FIXME: JFIAT: 2004-01-05 : Does not support once evalution on generic
				
			l_class_type := l_class_c.types.first
			l_icd_class := eifnet_debugger.icor_debug_class (l_class_type)
			l_icd_value := eifnet_debugger.once_function_value_on_icd_class (Void, l_icd_class, l_class_type, f)
			if l_icd_value /= Void then
				l_adv := debug_value_from_icdv (l_icd_value)
				Result := l_adv.dump_value
			end
		end

	dotnet_evaluate_function (addr: STRING; dvalue: DUMP_VALUE; f: FEATURE_I; ctype: CLASS_TYPE; a_params: ARRAY [DUMP_VALUE]): DUMP_VALUE is
			-- Evaluate dotnet function
		require
			is_dotnet: application.is_dotnet
		local
			l_d_value: EIFNET_ABSTRACT_DEBUG_VALUE
			l_icdv_obj: ICOR_DEBUG_VALUE
			l_feature_token: INTEGER
			l_icd_function: ICOR_DEBUG_FUNCTION
			l_module_name: STRING
			l_icd_module: ICOR_DEBUG_MODULE
			l_result: ICOR_DEBUG_VALUE
			l_adv: ABSTRACT_DEBUG_VALUE
			l_icd_frame: ICOR_DEBUG_FRAME
			l_icdv_args: ARRAY [ICOR_DEBUG_VALUE]

			l_dumpvalue_param: DUMP_VALUE
			l_icdv_param: ICOR_DEBUG_VALUE
			l_param_i: INTEGER
			l_ctype: CLASS_TYPE
			
		do
			error_occured := False
				--| Get the real adapted class_type
			l_ctype := adapted_class_type (ctype, f)
			
				--| and now the other data
			l_module_name := il_debug_info_recorder.module_file_name_for_class (l_ctype)
			l_icd_module := eifnet_debugger.icor_debug_module (l_module_name)
			l_feature_token := il_debug_info_recorder.feature_token_for_feat_and_class_type (f, l_ctype)
			l_icd_function := l_icd_module.get_function_from_token (l_feature_token)

			if l_icd_function /= Void then

				debug ("debugger_trace_eval")
					display_funct_info_on_object (l_icd_function) -- FIXME: JFIAT
				end

				if dvalue = Void then
					l_d_value ?= Application.imp_dotnet.kept_object_item (addr)
					l_icdv_obj := l_d_value.icd_referenced_value
				else
					if dvalue.is_basic then
						l_icdv_obj := dotnet_metamorphose_basic_to_ref (dvalue).value_dotnet
					else
						l_icdv_obj := dvalue.value_dotnet
					end
					if l_icdv_obj = Void then
						l_icdv_obj := dump_value_to_icdv_ref (dvalue)
					end
				end
				if l_icdv_obj /= Void then
					l_icd_frame := l_icdv_obj.associated_frame
					if l_icd_frame = Void then
							-- In case `associated_frame' is not set
						l_icd_frame := icd_frame
					end

						--| Build the arguments for dotnet
					if a_params /= Void then
						create l_icdv_args.make (1, a_params.count + 1)
						from
							l_param_i := a_params.lower
						until
							l_param_i > a_params.upper or error_occured
						loop
							l_dumpvalue_param := a_params @ l_param_i
							l_icdv_param := l_dumpvalue_param.value_dotnet
							if l_icdv_param = Void then
									--| This means this value has been created by eStudioDbg
									--| We need to build the corresponding ICorDebugValue object.
								debug ("debugger_trace_eval")
									print ("creating dotnet value from DUMP_VALUE %N")
								end
								l_icdv_param := dump_value_to_icdv (l_dumpvalue_param)
								error_occured := (eifnet_evaluator.last_call_success /= 0)
							end
							print ("param ... %N")
							display_info_on_object (l_icdv_param)
							l_icdv_args.put (l_icdv_param, l_param_i + 1)
								-- we'll set the first arg later
							l_param_i := l_param_i + 1
						end
					else
						create l_icdv_args.make (1, 1)
					end
					if not error_occured then
						print ("target ... %N")
						display_info_on_object (l_icdv_obj)				
						
						l_icdv_args.put (l_icdv_obj, 1) -- First arg is the obj on which the evaluation is done.

						l_result := eifnet_evaluator.function_evaluation (l_icd_frame, l_icd_function, l_icdv_args)
						error_occured := (eifnet_evaluator.last_call_success /= 0)
						
						if not error_occured then
							l_adv := debug_value_from_icdv (l_result)
							Result := l_adv.dump_value	
						end			
					end
				end
			end
				
			debug ("debugger_trace_eval")
				if l_result /= Void then
						print ("result ... %N")					
						display_info_on_object (l_result)				
				end
			end
		end
		
	display_funct_info_on_object (icd_f: ICOR_DEBUG_FUNCTION) is
			-- Display information related to feature `icd_f'
			-- debug purpose only
		local
			mdi: MD_IMPORT
		do
			if icd_f /= Void then
				mdi := icd_f.get_class.get_module.interface_md_import
				print ("Fct evaluation : " + mdi.get_method_props (icd_f.get_token) + "%N")
				print ("      on class : " + mdi.get_typedef_props (icd_f.get_class.get_token) + "%N")
				
			end
		end
		
	display_info_on_object (icdv: ICOR_DEBUG_VALUE) is
			-- Display information related to object `icdv'
			-- debug purpose only
		local
			edvi: EIFNET_DEBUG_VALUE_INFO
			retried: BOOLEAN
		do
			if not retried then
				create edvi.make (icdv)
				if edvi.has_object_interface then
					print ("ClassName = " + edvi.value_class_name + "%N")
				else
					if edvi.is_reference_type then
						print ("IsNull =? " + edvi.is_null.out +"%N")
					end
					print ("Basic type = " + edvi.is_basic_type.out + "%N")
				end
			else
				print ("Error in display info .. %N")
			end
		rescue
			retried := True
			retry
		end
		

feature {NONE} -- Implementation

	dump_value_to_icdv (dmv: DUMP_VALUE): ICOR_DEBUG_VALUE is
			-- DUMP_VALUE converted into ICOR_DEBUG_VALUE.
		local
		do
			Result := dmv.value_dotnet
			if Result = Void then
					--| This means this value has been created by eStudioDbg
					--| We need to build the corresponding ICorDebugValue object.
				if dmv.is_type_integer then
					Result := eifnet_evaluator.new_i4_evaluation (icd_frame, dmv.value_integer)
				elseif dmv.is_type_boolean then
					Result := eifnet_evaluator.new_boolean_evaluation (icd_frame, dmv.value_boolean )
				elseif dmv.is_type_character then
					Result := eifnet_evaluator.new_char_evaluation (icd_frame, dmv.value_character )
				elseif dmv.is_type_string then
					Result := eifnet_evaluator.new_eiffel_string_evaluation (icd_frame, dmv.value_object )
				end
				error_occured := (eifnet_evaluator.last_call_success /= 0)
			end
		end
		
	dump_value_to_icdv_ref (dmv: DUMP_VALUE): ICOR_DEBUG_VALUE is
			-- DUMP_VALUE converted into ICOR_DEBUG_VALUE for _REF Objects
		do
			Result := dmv.value_dotnet	
		
			if dmv.is_basic  then
				if Result /= Void then
						--| we have a basic type as dotnet value
						
						--| typically result of previous expression
					if dmv.is_type_integer then
						Result := eifnet_evaluator.icdv_integer_ref_from_icdv_integer (icd_frame, Result)
					elseif dmv.is_type_boolean then
						Result := eifnet_evaluator.icdv_boolean_ref_from_icdv_boolean (icd_frame, Result)
					elseif dmv.is_type_character then
						Result := eifnet_evaluator.icdv_character_ref_from_icdv_character (icd_frame, Result)
					elseif dmv.is_type_string then
						Result := eifnet_evaluator.icdv_string_from_icdv_system_string (icd_frame, Result)
					end
				else
						--| we have manifest value
						
						--| This means this value has been created by eStudioDbg
						--| We need to build the corresponding ICorDebugValue object.						
					if dmv.is_type_integer then
						Result := eifnet_evaluator.new_i4_ref_evaluation (icd_frame, dmv.value_integer)
					elseif dmv.is_type_boolean then
						Result := eifnet_evaluator.new_boolean_ref_evaluation (icd_frame, dmv.value_boolean )
					elseif dmv.is_type_character then
						Result := eifnet_evaluator.new_character_ref_evaluation (icd_frame, dmv.value_character )
					elseif dmv.is_type_string then
						Result := eifnet_evaluator.new_eiffel_string_evaluation (icd_frame, dmv.value_object )
					end
				end
				error_occured := (eifnet_evaluator.last_call_success /= 0)				
			end
		end

	adapted_class_type (ctype: CLASS_TYPE; f: FEATURE_I): CLASS_TYPE is
			-- Adapated class_type receiving the call of `f'
		local
			l_f_class_c: CLASS_C
			l_cl_type_a: CL_TYPE_A
		do
				--| Get the real class_type
			l_f_class_c := f.written_class
			if ctype.associated_class.is_equal (l_f_class_c) then
					--| The feature is not inherited
				Result := ctype
			else
				if l_f_class_c.types.count = 1 then
					Result := l_f_class_c.types.first
				else
					--| The feature is inherited
	
					--| let's search and find the correct CLASS_TYPE among the parents
					--| this will solve the problem of inherited once and generic class
					--| the level on inheritance is represented by the CLASS_C
					--| then the derivation of the GENERIC by the CLASS_TYPE
					--| among the parent we know the right CLASS_TYPE
					--| so first we localite the CLASS_C then we keep the CLASS_TYPE					
					l_cl_type_a := ctype.type.type_a
					Result := l_cl_type_a.find_class_type (l_f_class_c).type_i.associated_class_type
				end
			end
		end

end -- class DBG_EVALUATOR
