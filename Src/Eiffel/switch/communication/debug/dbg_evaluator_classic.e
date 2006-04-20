indexing
	description: "Class used to process evaluation on classic system ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	effective_evaluate_function (a_addr: STRING; a_target: DUMP_VALUE; f, realf: FEATURE_I;
			ctype: CLASS_TYPE; params: LIST [DUMP_VALUE]) is
		local
			fi: FEATURE_I
			dmp: DUMP_VALUE
			par: INTEGER
			rout_info: ROUT_INFO
		do
				-- Initialize the communication.
			fi := f
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
						fi := realf
						par := par + 4
					end
					dmp.classic_send_value
				end
					-- Send the final request.
				if fi.is_external then
					par := par + 1
				end

				if fi.written_class.is_precompiled then
					par := par + 2
					rout_info := System.rout_info_table.item (fi.rout_id_set.first)
					send_rqst_3_integer (Rqst_dynamic_eval, rout_info.offset, rout_info.origin, par)
				else
					fixme ("it seems the runtime/debug is not designed to call precursor ...")
					send_rqst_3_integer (Rqst_dynamic_eval, fi.feature_id, ctype.static_type_id - 1, par)
				end
					-- Receive the Result.
				recv_value (Current)
				if is_exception_trace then
					notify_error (Cst_error_exception_during_evaluation,
							"Exception occurred during evaluation"
							+ " of {" + fi.written_class.name_in_upper + "}." + fi.feature_name + ": %N"
							+ exception_trace
							)
					reset_recv_value
				else
					if item /= Void then
						item.set_hector_addr
						last_result_value := item.dump_value
						clear_item
					end
				end
			end
		end

	effective_evaluate_once (f: FEATURE_I) is
		local
			once_r: ONCE_REQUEST
			res: ABSTRACT_DEBUG_VALUE
		do
				--| Classic
			once_r := Once_request
			if once_r.already_called (f) then
				res := once_r.once_result (f)
				if once_r.last_failed then
					notify_error (cst_error_exception_during_evaluation, "Once feature " + f.feature_name + ": " + once_r.last_exception_meaning)
				else
					if res /= Void then
						last_result_value := res.dump_value
						last_result_static_type := f.type.associated_class
					else
						notify_error (cst_error_exception_during_evaluation, "Once feature " + f.feature_name + ": an exception occurred")
					end
				end
				once_r.clear_last_values
			else
				notify_error (cst_error_occurred, "Once feature " + f.feature_name + ": not yet called")
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

feature -- Implementation

	Once_request: ONCE_REQUEST is
			-- Facilities to inspect whether a once routine
			-- has already been called
		once
			create Result.make
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
