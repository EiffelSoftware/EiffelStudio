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
			init
		end

feature -- Concrete initialization

	init is
			-- Retrieve new value for evaluation mecanism.
		do
			eifnet_debugger := Application.imp_dotnet.eifnet_debugger
			il_debug_info_recorder := eifnet_debugger.il_debug_info_recorder
			eifnet_evaluator := eifnet_debugger.eifnet_dbg_evaluator
		end

feature {NONE} -- Properties

	eifnet_debugger: EIFNET_DEBUGGER
			-- Facade to the dotnet debugger

	eifnet_evaluator: EIFNET_DEBUGGER_EVALUATOR
			-- Feature evaluator

	il_debug_info_recorder: IL_DEBUG_INFO_RECORDER
			-- IL Info container

	error_occurred: BOOLEAN
			-- Did an error occurred during processing ?

feature -- Bridge

	active_icd_frame: ICOR_DEBUG_FRAME is
			-- Default ICorDebugFrame which is the active frame
		do
			Result := eifnet_debugger.active_frame
		end
		
	icor_debug_class (a_class_type: CLASS_TYPE): ICOR_DEBUG_CLASS is
			-- ICorDebugClass related to `a_class_type'
		do		
			Result := eifnet_debugger.icor_debug_class (a_class_type)
		end

	once_function_value_on_icd_class (a_icd_frame: ICOR_DEBUG_FRAME; a_icd_class: ICOR_DEBUG_CLASS; a_adapted_class_type: CLASS_TYPE; a_feat: E_FEATURE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue object representing the once value.
		do
			Result := eifnet_debugger.once_function_value_on_icd_class (a_icd_frame, a_icd_class, a_adapted_class_type, a_feat)			
		end
		
	icor_debug_module (a_mod_name: STRING): ICOR_DEBUG_MODULE is
			-- ICorDebugModule related to `a_mod_name'
		do
			Result := eifnet_debugger.icor_debug_module (a_mod_name)
		end

feature -- Access

	dotnet_metamorphose_basic_to_reference_value (dmp: DUMP_VALUE): DUMP_VALUE is
			-- Metamorphose basic type into corresponding "reference TYPE" type
		local
			icdv: ICOR_DEBUG_VALUE
			dv: EIFNET_ABSTRACT_DEBUG_VALUE
		do
			icdv := dump_value_to_reference_icdv (dmp)
			if icdv /= Void then
				dv := debug_value_from_icdv (icdv)
				Result := dv.dump_value
			else
				Result := dmp
			end
		end

	dotnet_metamorphose_basic_to_value (dmp: DUMP_VALUE): DUMP_VALUE is
			-- Metamorphose basic type into corresponding dotnet value type
		local
			icdv: ICOR_DEBUG_VALUE
			dv: EIFNET_ABSTRACT_DEBUG_VALUE
		do
			icdv := dump_value_to_icdv (dmp)
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
			debug ("debugger_trace_eval")
				print (generating_type + ".dotnet_evaluate_once_function : ")
				print (f.written_class.name_in_upper + "." + f.name)
				print ("%N")
			end
			l_class_c := f.written_class
				--| FIXME: JFIAT: 2004-01-05 : Does not support once evalution on generic
				--| this is related to dialog and issue to provide derivation selection
				
			l_class_type := l_class_c.types.first
			--| FIXME jfiat [2004/03/15] : do we really need to use adapted_class_type (..) ?
			l_class_type := adapted_class_type (l_class_type, f.associated_feature_i)

			l_icd_class := icor_debug_class (l_class_type)
			l_icd_value := once_function_value_on_icd_class (Void, l_icd_class, l_class_type, f)
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
			l_icdv_obj: ICOR_DEBUG_VALUE
			l_icd_function: ICOR_DEBUG_FUNCTION
			l_result: ICOR_DEBUG_VALUE
			l_adv: ABSTRACT_DEBUG_VALUE
			l_icd_frame: ICOR_DEBUG_FRAME
			l_icdv_args: ARRAY [ICOR_DEBUG_VALUE]

			l_dumpvalue_param: DUMP_VALUE
			l_icdv_param: ICOR_DEBUG_VALUE
			l_param_i: INTEGER
			l_ctype: CLASS_TYPE
			
		do
			debug ("debugger_trace_eval")
				print (generating_type + ".dotnet_evaluate_function : ")
				print (ctype.associated_class.name_in_upper + "." + f.feature_name)
				print ("%N")
			end
			error_occurred := False
				--| Get the real adapted class_type
			l_ctype := adapted_class_type (ctype, f)
			
				--| and now the other data
			l_icd_function := eifnet_debugger.icd_function_by_name (l_ctype, f.feature_name)
			if l_icd_function /= Void then

				debug ("debugger_trace_eval_data")
					display_funct_info_on_object (l_icd_function)
				end

				if dvalue = Void then
					l_icdv_obj := icd_value_by_address (addr)
						-- FIXME JFIAT: l_icdv_obj might be Void if object not found ...
						-- how come ?
						-- should be fixed now, but .. may occur regarding to .NET GC
				else
					if dvalue.is_basic then
						l_icdv_obj := dotnet_metamorphose_basic_to_reference_value (dvalue).value_dotnet				
					else
						l_icdv_obj := dvalue.value_dotnet
					end
					if l_icdv_obj = Void then
						l_icdv_obj := dump_value_to_reference_icdv (dvalue)
					end
				end
				if l_icdv_obj /= Void then
					l_icd_frame := l_icdv_obj.associated_frame
					if l_icd_frame = Void then
							-- In case `associated_frame' is not set
						l_icd_frame := active_icd_frame
					end

						--| Build the arguments for dotnet
					if a_params /= Void then
						create l_icdv_args.make (1, a_params.count + 1)
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
									print (generating_type + ".dotnet_evaluate_function: creating dotnet value from DUMP_VALUE %N")
								end
								l_icdv_param := dump_value_to_icdv (l_dumpvalue_param)
								error_occurred := (eifnet_evaluator.last_call_success /= 0)
							end
							debug ("debugger_trace_eval_data")
								print (generating_type + ".dotnet_evaluate_function: param ... %N")
								display_info_on_object (l_icdv_param)								
							end
							l_icdv_args.put (l_icdv_param, l_param_i + 1)
								-- we'll set the first arg later
							l_param_i := l_param_i + 1
						end
					else
						create l_icdv_args.make (1, 1)
					end
					if not error_occurred then
						debug ("debugger_trace_eval_data")
							print (generating_type + ".dotnet_evaluate_function: target ... %N")
							display_info_on_object (l_icdv_obj)							
						end
						
						l_icdv_args.put (l_icdv_obj, 1) -- First arg is the obj on which the evaluation is done.

						l_result := eifnet_evaluator.function_evaluation (l_icd_frame, l_icd_function, l_icdv_args)
						error_occurred := (eifnet_evaluator.last_call_success /= 0) or (eifnet_evaluator.last_eval_is_exception)
						
						if not error_occurred then
							l_adv := debug_value_from_icdv (l_result)
							Result := l_adv.dump_value	
						end			
					end
				end
			end
				
			debug ("debugger_trace_eval_data")
				if l_result /= Void then
						print (generating_type + ".dotnet_evaluate_function: result ... %N")
						display_info_on_object (l_result)				
				end
			end
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
				inspect dmv.type 
				when feature {DUMP_VALUE_CONSTANTS}.type_integer then
					Result := eifnet_evaluator.new_i4_evaluation (active_icd_frame, dmv.value_integer)
				when feature {DUMP_VALUE_CONSTANTS}.type_boolean then
					Result := eifnet_evaluator.new_boolean_evaluation (active_icd_frame, dmv.value_boolean )
				when feature {DUMP_VALUE_CONSTANTS}.type_character then
					Result := eifnet_evaluator.new_char_evaluation (active_icd_frame, dmv.value_character )
				when feature {DUMP_VALUE_CONSTANTS}.type_string then
					Result := eifnet_evaluator.new_eiffel_string_evaluation (active_icd_frame, dmv.value_string )				
				else					
				end

				error_occurred := (eifnet_evaluator.last_call_success /= 0)
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
					when feature {DUMP_VALUE_CONSTANTS}.type_integer then
						Result := eifnet_evaluator.icdv_reference_integer_from_icdv_integer (active_icd_frame, Result)
					when feature {DUMP_VALUE_CONSTANTS}.type_real then
						Result := eifnet_evaluator.icdv_reference_real_from_icdv_real (active_icd_frame, Result)							
					when feature {DUMP_VALUE_CONSTANTS}.type_double then
						Result := eifnet_evaluator.icdv_reference_double_from_icdv_double (active_icd_frame, Result)	
					when feature {DUMP_VALUE_CONSTANTS}.type_boolean then
						Result := eifnet_evaluator.icdv_reference_boolean_from_icdv_boolean (active_icd_frame, Result)
					when feature {DUMP_VALUE_CONSTANTS}.type_character then
						Result := eifnet_evaluator.icdv_reference_character_from_icdv_character (active_icd_frame, Result)
					when feature {DUMP_VALUE_CONSTANTS}.type_string then
						Result := eifnet_evaluator.icdv_string_from_icdv_system_string (active_icd_frame, Result)
					else					
					end
				else
						--| we have manifest value
						
						--| This means this value has been created by eStudioDbg
						--| We need to build the corresponding ICorDebugValue object.
					inspect dmv.type 
					when feature {DUMP_VALUE_CONSTANTS}.type_integer then
						Result := eifnet_evaluator.new_reference_i4_evaluation (active_icd_frame, dmv.value_integer)
					when feature {DUMP_VALUE_CONSTANTS}.type_real then
						Result := eifnet_evaluator.new_reference_real_evaluation (active_icd_frame, dmv.value_real )
					when feature {DUMP_VALUE_CONSTANTS}.type_double then
						Result := eifnet_evaluator.new_reference_double_evaluation (active_icd_frame, dmv.value_double )
					when feature {DUMP_VALUE_CONSTANTS}.type_boolean then
						Result := eifnet_evaluator.new_reference_boolean_evaluation (active_icd_frame, dmv.value_boolean )
					when feature {DUMP_VALUE_CONSTANTS}.type_character then
						Result := eifnet_evaluator.new_reference_character_evaluation (active_icd_frame, dmv.value_character )
					when feature {DUMP_VALUE_CONSTANTS}.type_string then
						Result := eifnet_evaluator.new_eiffel_string_evaluation (active_icd_frame, dmv.value_string )
					else					
					end
				end
				error_occurred := (eifnet_evaluator.last_call_success /= 0)
			end
		end

	adapted_class_type (ctype: CLASS_TYPE; f: FEATURE_I): CLASS_TYPE is
			-- Adapated class_type receiving the call of `f'
		local
			l_f_class_c: CLASS_C
			l_cl_type_a: CL_TYPE_A
		do
			if ctype.associated_class.is_basic then
				Result := ctype
			else
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
		end

feature -- Helpers

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

	debug_value_by_address (addr: STRING): ABSTRACT_DEBUG_VALUE is
			-- ABSTRACT_DEBUG_VALUE indexed by `addr' if exists
		require
			address_valid: addr /= Void and then not addr.is_empty
		do
			if Application.imp_dotnet.know_about_kept_object (addr) then
				Result := Application.imp_dotnet.kept_object_item (addr)				
			end
		end

feature {NONE} -- Debug purpose only

	display_funct_info_on_object (icd_f: ICOR_DEBUG_FUNCTION) is
			-- Display information related to feature `icd_f'
			-- debug purpose only
		local
			mdi: MD_IMPORT
		do
			debug ("debugger_trace_eval_data")
				if icd_f /= Void then
					mdi := icd_f.get_class.get_module.interface_md_import
					print (generating_type + " : Fct evaluation : " + mdi.get_method_props (icd_f.get_token) + "%N")
					print (generating_type + " :      on class : " + mdi.get_typedef_props (icd_f.get_class.get_token) + "%N")
				end			
			end
		end
		
	display_info_on_object (icdv: ICOR_DEBUG_VALUE) is
			-- Display information related to object `icdv'
			-- debug purpose only
		local
			edvi: EIFNET_DEBUG_VALUE_INFO
			retried: BOOLEAN
		do
			debug ("debugger_trace_eval_data")
				if not retried then
					create edvi.make (icdv)
					if edvi.has_object_interface then
						print (generating_type + " : ClassName = " + edvi.value_class_name + "%N")
					else
						if edvi.is_reference_type then
							print ("IsNull =? " + edvi.is_null.out +"%N")
						end
						print (generating_type + " : Basic type = " + edvi.is_basic_type.out + "%N")
					end
				else
					print (generating_type + " : Error in display info .. %N")
				end
			end
		rescue
			retried := True
			retry
		end
		
end -- class DBG_EVALUATOR
