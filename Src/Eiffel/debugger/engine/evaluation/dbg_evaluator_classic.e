note
	description: "Class used to process evaluation on classic system ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EVALUATOR_CLASSIC

inherit
	DBG_EVALUATOR
		redefine
			make
		end

	DEBUG_EXT

	RECV_VALUE
		rename
			error as recv_error
		end

	DEBUG_EXT
		export
			{NONE} all
		end

	HEXADECIMAL_STRING_CONVERTER
		export
			{NONE} all
		end

	IPC_SHARED
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (dm: like debugger_manager)
		require else
			is_classic_project: dm.is_classic_project
		do
			Precursor {DBG_EVALUATOR} (dm)
		end

feature {NONE} -- Implementation

	effective_evaluate_routine (a_addr: DBG_ADDRESS; a_target: DUMP_VALUE; f, realf: FEATURE_I;
			ctype: CLASS_TYPE; orig_class: CLASS_C; params: LIST [DUMP_VALUE];
			is_static_call: BOOLEAN)
		local
			fi: FEATURE_I
			dmp: DUMP_VALUE
			par: INTEGER
			rout_info: ROUT_INFO
			wclt: CLASS_TYPE
		do
				-- Initialize the communication.
			fi := f
			Init_recv_c

			if params /= Void and then not params.is_empty then
				prepare_parameters (ctype, realf, params)
				parameters_reset
			end
				-- Send the target object.
			if a_target = Void then
				if a_addr /= Void and then not a_addr.is_void then
					if a_addr.has_offset then
						send_ref_offset_value (a_addr.as_pointer, a_addr.offset)
					else
						send_ref_value (a_addr.as_pointer)
					end
				else
					dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_unable_to_evaluate_non_once_call_with_any_object (
								fi.written_class.name_in_upper,
								fi.feature_name
								)
							)
				end
			else
				dmp := a_target
				check is_valid_value: dmp.is_valid_value end
				if dmp.is_basic then
					fi := realf
					par := par + 4
				end
				dmp.classic_send_value
				if not dmp.last_classic_send_value_succeed then
					dbg_error_handler.notify_error_exception_internal_issue
				end
			end

			if not error_occurred then
					-- Send the final request.
				if fi.is_external then
					par := par + 1
				end
				if is_static_call then
					par := par + 8
				end

				if
					(a_addr = Void or (dmp /= Void and then dmp.is_basic)) and then
					orig_class.is_expanded and then orig_class.is_basic
				then
						--| Take care of "2 > 3"
					if ctype.associated_class.conform_to (fi.written_class) then
						wclt := fi.written_type (ctype)
					else
						wclt := fi.written_class.types.first
					end
				else
					wclt := ctype
				end

				if fi.written_class.is_precompiled then
					par := par + 2
					rout_info := System.rout_info_table.item (fi.rout_id_set.first)
					send_rqst_4_integer (Rqst_dynamic_eval, rout_info.offset, rout_info.origin, wclt.type_id - 1, par)
				else
					debug ("refactor_fixme")
						fixme ("it seems the runtime/debug is not designed to call precursor ...")
					end
					send_rqst_4_integer (Rqst_dynamic_eval, fi.feature_id, wclt.static_type_id - 1, 0, par)
				end
					-- Receive the Result.
				recv_value (Current)
				if is_exception then
					if attached exception_item as exv then
						exv.set_hector_addr
						dbg_error_handler.notify_error_exception (Debugger_names.msg_error_exception_occurred_during_evaluation (fi.written_class.name_in_upper, fi.feature_name, exv.long_description))
					else
						dbg_error_handler.notify_error_exception (Debugger_names.msg_error_exception_occurred_during_evaluation (fi.written_class.name_in_upper, fi.feature_name, Void))
					end

					reset_recv_value
				else
					if fi.is_function then
						if item /= Void then
							item.set_hector_addr
							if attached item.dump_value as dv then
								create last_result.make_with_value (dv)
							else
								--FIXME: should we create last_result.failed
							end
							reset_recv_value
						end
					else
						create last_result.make_with_value (debugger_manager.dump_value_factory.new_procedure_return_value (create {PROCEDURE_RETURN_DEBUG_VALUE}.make_with_name (fi.feature_name)))
					end
				end
			end
		end

	effective_evaluate_once_function (f: FEATURE_I)
		local
			once_r: ONCE_REQUEST
			res: ABSTRACT_DEBUG_VALUE
		do
				--| Classic
			once_r := Once_request
			if once_r.already_called (f) then
				if f.is_function or else f.is_constant then
					res := once_r.once_result (f)
					if once_r.last_failed then
						if attached {EXCEPTION_DEBUG_VALUE} res as e then
							dbg_error_handler.notify_error_exception (Debugger_names.msg_error_once_evaluation_failed (f.feature_name, e.long_description))
						else
							dbg_error_handler.notify_error_exception (Debugger_names.msg_error_once_evaluation_failed (f.feature_name, "exception occurred"))
						end
					else
						if res /= Void then
							create last_result.make_with_value (res.dump_value)
							if attached f.type.associated_class as cl then
								last_result.suggest_static_class (cl)
							end
						else
								--| FIXME: should we return a last_result.failed?
							dbg_error_handler.notify_error_exception (Debugger_names.msg_error_once_evaluation_failed (f.feature_name, Void))
						end
					end
					once_r.clear_last_values
				else
					dbg_error_handler.notify_error_exception (Debugger_names.msg_error_once_procedure_evaluation_not_yet_available (f.feature_name))
				end
			else
				dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_once_routine_not_yet_called (f.feature_name))
			end
		end

	create_empty_instance_of (a_type_i: CL_TYPE_A)
			-- create an empty instance of `a_type_i' in the context of object's type `a_curr_obj_typeid'
		local
			b: BOOLEAN
			c_string: C_STRING
		do
			send_rqst_1 (Rqst_new_instance, a_type_i.associated_class_type (Void).type_id - 1)
			create c_string.make (a_type_i.name)
			send_string_value (c_string.item)
			b := recv_ack
			reset_recv_value
			if b then
				recv_value (Current)
			end
			if item /= Void then
				item.set_hector_addr
				if attached item.dump_value as dv then
					create last_result.make_with_value (dv)
				else
					--FIXME: should we create last_result.failed
				end
				reset_recv_value
			else
				dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_instantiation_of_type_raised_error (a_type_i.name))
--				create_empty_instance_using_internal (a_type_i)
--				if error_occurred or last_result_value = Void then
--					dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_instanciation_of_type_raised_error (a_type_i.name))
--				end
			end
		end

--	create_empty_instance_using_internal (a_type_i: CL_TYPE_A) is
--			--
--		require
--			is_not_special: not a_type_i.associated_class_type.associated_class.is_special
--		local
--			l_class_c: CLASS_C
--			l_params: LINKED_LIST [DUMP_VALUE]
--			f: FEATURE_I
--		do
--			l_class_c := debugger_manager.compiler_data.internal_class_c
--			if l_class_c /= Void then
--				create_empty_instance_of (l_class_c.types.first.type) -- Create instance of {INTERNAL}
--				if not error_occurred then
--					create l_params.make
--					l_params.extend (debugger_manager.dump_value_factory.new_integer_32_value (a_type_i.type_id, debugger_manager.compiler_data.integer_32_class_c))
--					f := l_class_c.feature_named ("new_instance_of")
--					effective_evaluate_routine (Void, last_result_value, f, f, l_class_c.types.first, l_class_c, l_params, False)
--				end
--			end
--		end

	create_special_any_instance (a_type_i: CL_TYPE_A; a_count: INTEGER)
		local
			l_class_c: CLASS_C
			l_params: LINKED_LIST [DUMP_VALUE]
			l_id_dv: DUMP_VALUE
			l_int_dv: DUMP_VALUE
			l_int_ct: CLASS_TYPE
			f: FEATURE_I
		do
			l_class_c := debugger_manager.compiler_data.internal_class_c
			if l_class_c /= Void then
				l_int_ct := l_class_c.types.first
				create_empty_instance_of (l_int_ct.type) -- Create instance of {INTERNAL}
				l_int_dv := last_result_value
				if not error_occurred then
					create l_params.make
					l_params.extend (debugger_manager.dump_value_factory.new_manifest_string_value (a_type_i.name, debugger_manager.compiler_data.string_8_class_c))
					f := l_class_c.feature_named ("dynamic_type_from_string")
					effective_evaluate_routine (Void, l_int_dv, f, f, l_int_ct, l_class_c, l_params, False)
					l_id_dv := last_result_value
					if not error_occurred then
						create l_params.make
						l_params.extend (l_id_dv)
						l_params.extend (debugger_manager.dump_value_factory.new_integer_32_value (a_count, debugger_manager.compiler_data.integer_32_class_c))
						f := l_class_c.feature_named ("new_special_any_instance")
						effective_evaluate_routine (Void, l_int_dv, f, f, l_int_ct, l_class_c, l_params, False)
					end
				end
			end
		end

feature -- Query

	current_object_from_callstack (cse: EIFFEL_CALL_STACK_ELEMENT): DUMP_VALUE
		do
			Result := Debugger_manager.Dump_value_factory.new_object_value (cse.object_address, cse.dynamic_class)
		end

	dump_value_at_address (addr: DBG_ADDRESS): detachable DUMP_VALUE
			-- <Precursor>
		local
			l_cl: CLASS_C
			dbg: DEBUGGER_MANAGER
		do
			dbg := debugger_manager
			if dbg.object_manager.is_valid_and_known_object_address (addr) then
				l_cl := dbg.object_manager.class_c_at_address (addr)
				if l_cl /= Void then
					Result := dbg.dump_value_factory.new_object_value (addr, l_cl)
				end
			end
		end

	address_from_basic_dump_value (a_target: DUMP_VALUE): DBG_ADDRESS
		require else
			a_target_not_void: a_target /= Void
		local
			dv: DUMP_VALUE
		do
			if a_target.is_type_manifest_string then
				dv := a_target.manifest_string_to_dump_value_object
				if dv /= Void then
					Result := dv.address
				end
			end
		end

feature {NONE} -- Parameters operation

	parameters_push (dmp: DUMP_VALUE)
		do
			dmp.classic_send_value
			if not dmp.last_classic_send_value_succeed then
				dbg_error_handler.notify_error_exception_internal_issue
			end
		end

	parameters_push_and_metamorphose (dmp: DUMP_VALUE)
		do
			debug ("debugger_trace_eval_data")
				print (generating_type + ".parameters_push_and_metamorphose :: Send Metamorphose request ... %N")
			end
			dmp.classic_send_value
			if not dmp.last_classic_send_value_succeed then
				dbg_error_handler.notify_error_exception_internal_issue
			else
				send_rqst_0 (Rqst_metamorphose)
			end
		end

feature -- Implementation

	Once_request: ONCE_REQUEST
			-- Facilities to inspect whether a once routine
			-- has already been called
		once
			create Result.make
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
