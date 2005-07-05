indexing
	description : "Objects used to evaluate concrete feature ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	DBG_EVALUATOR

inherit

	SHARED_DEBUG
		export
			{ANY} Application
			{NONE} all
		end	

	SHARED_WORKBENCH
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
			--| and other expression evaluation purpose
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

	BEURK_HEXER

	IPC_SHARED
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			if application.is_dotnet then
					--| Soon or later .. change this by creating descendant of Current
				is_dotnet_system := True
				create dotnet_impl.make
			end
		end

feature -- Status

	is_dotnet_system: BOOLEAN

feature {SHARED_DBG_EVALUATOR} -- Init

	reset is
		do
			if is_dotnet_system then
				dotnet_parameters_reset
			end
			last_result_value := Void
			last_result_static_type := Void
		end

feature {SHARED_DBG_EVALUATOR} -- Variables

	last_result_value: DUMP_VALUE
	
	last_result_static_type: CLASS_C	

	error_evaluation_message: STRING
	
	error_exception_message: STRING
	
	error_occurred: BOOLEAN is
		do
			Result := error_evaluation_message /= Void or error_exception_message /= Void
		end

feature {SHARED_DBG_EVALUATOR} -- Variables preparation

	set_last_variables (trv: DUMP_VALUE; trs: CLASS_C) is
		do
			error_evaluation_message := Void
			error_exception_message := Void
			last_result_value := trv
			last_result_static_type := trs
		end

	notify_error_evaluation (mesg: STRING) is
		do
			if error_evaluation_message /= Void then
				error_evaluation_message.append_string ("%N" + mesg)
			else
				error_evaluation_message := mesg
			end
		end

	notify_error_exception (mesg: STRING) is
		do
			if error_exception_message /= Void then
				error_exception_message.append_string ("%N" + mesg)
			else
				error_exception_message := mesg
			end
		end

feature -- Concrete evaluation

	evaluate_static_function (f: E_FEATURE; params: LIST [DUMP_VALUE]) is
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		local
			l_dyntype: CLASS_TYPE
			l_params: ARRAY [DUMP_VALUE]
		do
			l_dyntype := f.associated_class.types.first
			if is_dotnet_system then
					--| FIXME jfiat: we deal only non generic types
				if params /= Void and then not params.is_empty then
					prepare_parameters (l_dyntype, f, params)
					l_params := dotnet_parameters
					dotnet_parameters_reset
				end
				last_result_value := dotnet_impl.dotnet_evaluate_static_function (f.associated_feature_i, l_dyntype, l_params)
				last_result_static_type := f.type.associated_class
			else
			end
			if last_result_value = Void then
				notify_error_evaluation ("Unable to evaluate {" + l_dyntype.associated_class.name_in_upper + "}." + f.name)
			end
		end

	evaluate_once (a_addr: STRING; a_target: DUMP_VALUE; f: E_FEATURE; params: LIST [DUMP_VALUE]) is
			-- 
		require
			feature_not_void: f /= Void
		local
			once_r: ONCE_REQUEST
		do
			check
				f_is_once: f.associated_feature_i.is_once
			end
			if f.written_class.types.count > 1 then
				notify_error_evaluation ("Once evaluation on generic classes not available")
			else
				if is_dotnet_system then
						--| Dotnet
					last_result_value := dotnet_impl.dotnet_evaluate_once_function (a_addr, a_target, f, params)
					if not dotnet_impl.last_once_available then
						notify_error_evaluation ("Once feature " + f.name + ": could not get information")
					elseif dotnet_impl.last_once_failed then
						notify_error_evaluation ("Once feature " + f.name + ": an exception occurred")
					elseif last_result_value = Void then
						notify_error_evaluation ("Once feature " + f.name + ": not yet called")
					end
					last_result_static_type := f.type.associated_class
					
				else
						--| Classic
					once_r := debug_info.once_request
					if once_r.already_called (f) then
						evaluate_function (a_addr, a_target, Void, f, params)
-- FIXME jfiat [2005/03/11] : changed
--						last_result_value := once_r.once_result (f).dump_value
--						last_result_static_type := f.type.associated_class
						if last_result_value = Void then
							notify_error_evaluation ("Once feature " + f.name + ": an exception occurred")
						end
					else
						notify_error_evaluation ("Once feature " + f.name + ": not yet called")
					end				
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
				last_result_static_type := cv_cst.type.associated_class
				if val.is_integer then
					 create last_result_value.make_integer_32 (val.to_integer, last_result_static_type);
				elseif val.is_real then
					 create last_result_value.make_real (val.to_real, last_result_static_type);
				elseif val.is_double then
					 create last_result_value.make_double (val.to_double, last_result_static_type);
				elseif val.is_boolean then
					 create last_result_value.make_boolean (val.to_boolean, last_result_static_type);
				elseif last_result_static_type.conform_to (system.character_class.compiled_class) then
					 create last_result_value.make_character (val.item (1), last_result_static_type);			
				else				
					notify_error_evaluation ("Unknown constant type for " + cv_cst.name)
				end
			else
				notify_error_evaluation ("Unknown constant type for " + f.name)
			end				
		end

	evaluate_attribute (a_addr: STRING; a_target: DUMP_VALUE; f: E_FEATURE) is
			-- Evaluate attribute feature
		local
			lst: DS_LIST [ABSTRACT_DEBUG_VALUE]
			dv: ABSTRACT_DEBUG_VALUE
			dump: DUMP_VALUE
			l_address: STRING
		do
			if a_target /= Void then
				l_address := a_target.address
			end
			if l_address = Void then
				l_address := a_addr
			end
			if l_address = Void then
					--| cannot evaluate attribute on manifest value
					--| (such as "foo", 1 or True .. in the expression)
					-- but let's try to improve this ...
				if is_dotnet_system then
					dump := dotnet_impl.dotnet_metamorphose_basic_to_value (a_target)
					l_address := dump.address
				end
			end
			if l_address /= Void then
				lst := attributes_list_from_object (l_address)
				dv := find_item_in_list (f.name, lst)
				
				last_result_static_type := f.type.actual_type.associated_class
				if dv = Void then
					if f.name.is_equal ("Void") then
						create last_result_value.make_void
					else
						notify_error_evaluation ("Could not find attribute value for " + f.name)
					end
				else
					last_result_value := dv.dump_value
				end
--			elseif f.name.is_equal ("item") then
--				result_object := a_target
--				result_static_type := a_target.dynamic_class
			else
				notify_error_evaluation ("Cannot evaluate an attribute ["+ f.name+"] of a expanded value")
			end
		end

	evaluate_function (a_addr: STRING; a_target: DUMP_VALUE; cl: CLASS_C; f: E_FEATURE; params: LIST [DUMP_VALUE]) is
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		local
			l_dynclass: CLASS_C
			l_dyntype: CLASS_TYPE
			realf: E_FEATURE
			at: TYPE_A
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
			if Application.is_classic then
					-- Initialize the communication.
				Init_recv_c
			end

				--| Get target data ...
			if cl /= Void then
				l_dynclass := cl
			elseif a_target /= Void then
				l_dynclass := a_target.dynamic_class
			end
			if l_dynclass /= Void and then l_dynclass.is_basic then
				l_dyntype := associated_reference_class_type (l_dynclass)
			elseif l_dynclass /= Void and then l_dynclass.types.count = 1 then
				l_dyntype := l_dynclass.types.first
			elseif l_dynclass = Void or else l_dynclass.types.count > 1 then
				if a_addr /= Void then
						-- The type has generic derivations: we need to find the precise type.
					l_dyntype := class_type_from_object_relative_to (a_addr, l_dynclass)
					if l_dyntype = Void then
						notify_error_evaluation ("Error occurred: unable to find the context object <" + a_addr + ">")
					elseif l_dynclass = Void then
						l_dynclass := l_dyntype.associated_class						
					end
				else
						--| Shouldn't happen: basic types are not generic.
					notify_error_evaluation ("Cannot find complete dynamic type of a expanded type")
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

				last_result_value := effective_evaluate_function (a_addr, a_target, f, realf, l_dyntype, params)
				if last_result_value = Void then
					if a_addr = Void then
						notify_error_evaluation ("Unable to evaluate {" + l_dyntype.associated_class.name_in_upper + "}." + f.name)
					else
						notify_error_evaluation ("Unable to evaluate {" + l_dyntype.associated_class.name_in_upper + "}." + f.name + " on <" + a_addr + ">")
					end
				end
				
				if not error_occurred and then last_result_value /= Void then
					at := f.type.actual_type
					last_result_static_type := at.associated_class
					if last_result_static_type = Void then
						last_result_static_type:= Workbench.Eiffel_system.Any_class.compiled_class
					end
					if
						last_result_static_type /= Void and then
						last_result_static_type.is_basic and
						last_result_value.address /= Void
					then
							-- We expected a basic type, but got a reference.
							-- This happens in "2 + 2" because we convert the first 2
							-- to a reference and therefore get a reference.
						last_result_value := last_result_value.to_basic
					end
				end
			end			
		end

	attributes_list_from_object (a_addr: STRING): DS_LIST [ABSTRACT_DEBUG_VALUE] is
		do
			Result := Debugged_object_manager.attributes_at_address (a_addr, 0, 0)
		end

	class_type_from_object (a_addr: STRING): CLASS_TYPE is
		do
			Result := Debugged_object_manager.class_type_at_address (a_addr)
		end
		
	class_type_from_object_relative_to (a_addr: STRING; cl: CLASS_C): CLASS_TYPE is
		do
			Result := class_type_from_object (a_addr)
			if 
				Result /= Void 
				and then cl /= Void 
				and then Result.associated_class /= cl 
			then
				if Result.associated_class.conform_to (cl) then
					Result := cl.meta_type (Result)
				end
			end
		end

	effective_evaluate_function (a_addr: STRING; a_target: DUMP_VALUE; f, realf: E_FEATURE; 
			ctype: CLASS_TYPE; params: LIST [DUMP_VALUE]): DUMP_VALUE is
		do
			if is_dotnet_system then
				Result := dotnet_evaluate_function (a_addr, a_target, f, realf,
								ctype, params)
			else
				Result := classic_evaluate_function (a_addr, a_target, f, realf,
								ctype, params)
			end
		end

feature {DBG_EXPRESSION_EVALUATOR_B} -- Restricted dotnet

	dotnet_evaluate_function_with_name (a_addr: STRING; a_target: DUMP_VALUE;
				a_feature_name, a_external_name: STRING; 
				params: LIST [DUMP_VALUE]) is
		require
			is_dotnet_system
		local
			l_params: ARRAY [DUMP_VALUE]
		do
			if params /= Void and then not params.is_empty then
				prepare_parameters (a_target.dynamic_class_type, Void, params)
				l_params := dotnet_parameters
				dotnet_parameters_reset
			end			
			last_result_value := dotnet_impl.dotnet_evaluate_function_with_name (a_addr, a_target, a_feature_name, a_external_name, l_params)
			if last_result_value = Void then
				if a_addr = Void then
					notify_error_evaluation ("Unable to evaluate : " + a_external_name)
				else
					notify_error_evaluation ("Unable to evaluate : " + a_external_name + " on <" + a_addr + ">")
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
		
feature {NONE} -- Implementation classic

	classic_evaluate_function (a_addr: STRING; a_target: DUMP_VALUE; f, realf: E_FEATURE; 
			ctype: CLASS_TYPE; params: LIST [DUMP_VALUE]): DUMP_VALUE is
		require
			is_classic_system: not is_dotnet_system
		local
			dmp: DUMP_VALUE
			par: INTEGER
			rout_info: ROUT_INFO
		do
			if 
				a_target /= Void 
				and then not a_target.dynamic_class.is_basic
				and then a_target.dynamic_class.is_expanded 
			then
				fixme ("must change the runtime to allow expression evaluation on expanded object !")
				notify_error_evaluation ("Current restriction: unable to evaluate expression on expanded object")
			else
				if params /= Void and then not params.is_empty then
					prepare_parameters (ctype, realf, params)
				end
					-- Send the target object.
				if a_target = Void then
					send_ref_value (hex_to_pointer (a_addr))
				else
					dmp := a_target
					if dmp.is_basic then
						par := par + 4
					end
					dmp.classic_send_value
				end
					-- Send the final request.
				if f.is_external then
					par := par + 1
				end
				
				if f.written_class.is_precompiled then
					par := par + 2
					rout_info := System.rout_info_table.item (f.rout_id_set.first)
					send_rqst_3_integer (Rqst_dynamic_eval, rout_info.offset, rout_info.origin, par)
				else
					fixme ("it seems the runtime/debug is not designed to call precursor ...")
					send_rqst_3_integer (Rqst_dynamic_eval, f.feature_id, ctype.static_type_id - 1, par)
				end
					-- Receive the Result.
				c_recv_value (Current)
				if item /= Void then
					item.set_hector_addr
					Result := item.dump_value
				end
			end
		end

feature {NONE} -- Implementation dotnet

	dotnet_evaluate_function (a_addr: STRING; a_target: DUMP_VALUE; f, realf: E_FEATURE; 
			ctype: CLASS_TYPE; params: LIST [DUMP_VALUE]): DUMP_VALUE is
		require
			is_dotnet_system: is_dotnet_system
		local
			l_params: ARRAY [DUMP_VALUE]
			l_error_message: STRING
		do
			if params /= Void and then not params.is_empty then
				prepare_parameters (ctype, realf, params)
				l_params := dotnet_parameters
				dotnet_parameters_reset
			end
			Result := dotnet_impl.dotnet_evaluate_function (a_addr, a_target, realf.associated_feature_i, ctype, l_params)
			if dotnet_impl.error_occurred then 
				l_error_message := "%"" + realf.name + "%" : "
				if dotnet_impl.evaluation_aborted then
					l_error_message.append_string ("Evaluation aborted")
				elseif dotnet_impl.error_occurred then
					l_error_message.append_string (dotnet_impl.error_message)
				else
					l_error_message.append_string (" error occurred")
				end
				notify_error_evaluation (l_error_message)
			end
		end

	dotnet_parameters_reset is
		require
			is_dotnet_system: is_dotnet_system
		do
			dotnet_parameters := Void
		end

	dotnet_parameters: ARRAY [DUMP_VALUE]

	dotnet_parameters_index: INTEGER

feature {NONE} -- Implementation

	parameters_init (n: INTEGER) is
		do
			if is_dotnet_system then
				create dotnet_parameters.make (1, n)
				dotnet_parameters_index := 0
			end
		end

	parameters_push (dmp: DUMP_VALUE) is
		do
			if is_dotnet_system then
				dotnet_parameters_index := dotnet_parameters_index + 1
				dotnet_parameters.put (dmp, dotnet_parameters_index)
			else
				dmp.classic_send_value
			end
		end

	parameters_push_and_metamorphose (dmp: DUMP_VALUE) is
		local
			l_dmp: DUMP_VALUE
		do
			if is_dotnet_system then
				debug ("debugger_trace_eval_data")
					print (generating_type + ".parameters_push_and_metamorphose :: dotnet Metamorphose ... %N")
				end
				l_dmp := dotnet_impl.dotnet_metamorphose_basic_to_reference_value (dmp)
				dotnet_parameters_index := dotnet_parameters_index + 1
				dotnet_parameters.put (l_dmp, dotnet_parameters_index)
			else
				debug ("debugger_trace_eval_data")
					print (generating_type + ".parameters_push_and_metamorphose :: Send Metamorphose request ... %N")
				end
				dmp.classic_send_value
				send_rqst_0 (Rqst_metamorphose)
			end
		end

	prepare_parameters (dt: CLASS_TYPE; f: E_FEATURE; params: LIST [DUMP_VALUE]) is
			-- Prepare parameters for function evaluation
			-- For classic system
			--| Warning: for classic system be sure `Init_recv_c' had been done before
		require
			f_is_not_attribute: f = Void or else not f.is_attribute
			params /= Void and then not params.is_empty
		local
			dmp: DUMP_VALUE
			bak_ct: CLASS_TYPE
			bak_cc: CLASS_C
		do
				--| Prepare parameters ...
			bak_ct := Byte_context.class_type
			bak_cc := System.current_class
			if dt /= Void then
				System.set_current_class (dt.associated_class)
				Byte_context.set_class_type (dt)
			end
			parameters_init (params.count)
			from
				params.start
			until
				params.after or error_occurred
			loop
				dmp := params.item
					-- We need to evaluate feature argument using BYTE_CONTEXT because
					-- it might have some formal and the metamorphose should only appear
					-- when there is indeed a type difference and not because the expected
					-- argument is a formal parameter and the actual argument value is
					-- a basic type.
					-- This happen when evaluation `my_hash_table.item (1)' where
					-- `my_hash_table' is of type `HASH_TABLE [STRING, INTEGER]'.
				if dmp.is_basic then
					if
						f /= Void
						and then (not Byte_context.real_type (
							f.arguments.i_th (params.index).type_i).is_basic)
					then
						parameters_push_and_metamorphose (dmp)
					else
						parameters_push (dmp)
						-- FIXME jfiat : in very specific case we have  'f =  Void'
						-- i.e: when we have only the feature_name with no more info
					end
				else
					parameters_push (dmp)
				end
				params.forth
			end
			if bak_ct /= Void then
				Byte_context.set_class_type (bak_ct)				
			end
			if bak_cc /= Void then
				System.set_current_class (bak_cc)
			end
		end

feature {NONE} -- List helpers

	find_item_in_list (n: STRING; lst: DS_LIST [ABSTRACT_DEBUG_VALUE]): ABSTRACT_DEBUG_VALUE is
			-- Try to find an item named `n' in list `lst'.
		require
			not_void: n /= Void
		local
			l_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
			l_item: ABSTRACT_DEBUG_VALUE
		do
			if lst /= Void then
				from
					l_cursor := lst.new_cursor
					l_cursor.start
				until
					l_cursor.after or Result /= Void
				loop
					l_item := l_cursor.item
					if l_item.name /= Void and then l_item.name.is_equal (n) then
						Result := l_item
					end
					l_cursor.forth
				end
			end
		ensure
			same_name_if_found: (Result /= Void) implies (Result.name.is_equal (n))
		end	

feature {NONE} -- compiler helpers

	associated_reference_class_type (cl: CLASS_C): CLASS_TYPE is
			-- Associated _REF classtype for type `cl'
			--| for instance return INTEGER_REF for INTEGER
		require
			cl_not_void: cl /= Void
			cl_is_basic: cl.is_basic
		local
			l_basic: BASIC_I
		do
			l_basic ?= cl.actual_type.type_i
			check
				l_basic_not_void: l_basic /= Void
			end
			if is_dotnet_system then
				Result := l_basic.associated_reference_class_type
			else
					-- FIXME jfiat 2004-10-06 : why do we have two different behaviors
					-- depending if we are on dotnet or classic ?
				Result := l_basic.associated_class_type
			end
		ensure
			associated_reference_class_type_not_void: Result /= Void
		end		

feature {NONE} -- Implementation

	dotnet_impl: DBG_EVALUATOR_DOTNET
--	classic_impl: DBG_EVALUATOR_DOTNET

invariant
	
	is_dotnet_system = application.is_dotnet

end
