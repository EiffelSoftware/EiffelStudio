indexing
	description: "Class used to process evaluation on classic system ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EVALUATOR_CLASSIC

inherit
	DBG_EVALUATOR_IMP
		redefine
			init
		end

	RECV_VALUE
		rename
			error as recv_error
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

feature -- Concrete initialization

	init is
			-- Retrieve new value for evaluation mecanism.
		do
			Precursor
		end

feature {DBG_EVALUATOR} -- Interface

	effective_evaluate_function (a_addr: STRING; a_target: DUMP_VALUE; f, realf: E_FEATURE;
			ctype: CLASS_TYPE; params: LIST [DUMP_VALUE]) is
		local
			dmp: DUMP_VALUE
			par: INTEGER
			rout_info: ROUT_INFO
		do
				-- Initialize the communication.
			Init_recv_c

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
					parameters_reset
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
					last_result_value := item.dump_value
				end
			end
		end

	effective_evaluate_once (a_addr: STRING; a_target: DUMP_VALUE; f: E_FEATURE; params: LIST [DUMP_VALUE]) is
		local
			once_r: ONCE_REQUEST
		do
				--| Classic
			once_r := debug_info.once_request
			if once_r.already_called (f) then
				if a_addr /= Void or a_target /= Void then
					evaluate_function (a_addr, a_target, Void, f, params)
				else
fixme ("Complete once evaluation implementation changes (cf: jfiat + alexk)")
					last_result_value := once_r.once_result (f).dump_value
					last_result_static_type := f.type.associated_class
				end
				if last_result_value = Void then
					notify_error (cst_error_exception_during_evaluation, "Once feature " + f.name + ": an exception occurred")
				end
			else
				notify_error (cst_error_occurred, "Once feature " + f.name + ": not yet called")
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
			Result := l_basic.associated_class_type
		end

	current_object_from_callstack (cse: EIFFEL_CALL_STACK_ELEMENT): DUMP_VALUE is
		do
			create Result.make_object (cse.object_address, cse.dynamic_class)
		end

	dump_value_at_address (addr: STRING): DUMP_VALUE is
		local
			l_cl: CLASS_C
		do
			l_cl := debugged_object_manager.class_c_at_address (addr)
			if l_cl /= Void then
				create Result.make_object (addr, l_cl)
			end
		end

feature {NONE} -- Parameters operation

	parameters_push (dmp: DUMP_VALUE) is
		do
			dmp.classic_send_value
		end

	parameters_push_and_metamorphose (dmp: DUMP_VALUE) is
		do
			debug ("debugger_trace_eval_data")
				print (generating_type + ".parameters_push_and_metamorphose :: Send Metamorphose request ... %N")
			end
			dmp.classic_send_value
			send_rqst_0 (Rqst_metamorphose)
		end

end
