indexing
	description : "Objects used to evaluate concrete feature ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred
class
	DBG_EVALUATOR

inherit
	REFACTORING_HELPER

	SHARED_BENCH_NAMES

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

	DEBUGGER_COMPILER_UTILITIES

--create
--	make

feature {NONE} -- Initialization

	make (dm: like debugger_manager) is
			-- Initialize `Current'.
		require
			dm_not_void: dm /= Void
		do
			debugger_manager := dm
			create dbg_error_handler.make
		end

feature {DEBUGGER_MANAGER, DBG_EXPRESSION_EVALUATOR, APPLICATION_EXECUTION} -- Init

	reset is
			-- Reset data
		do
			reset_error
			clear_evaluation
			parameters_reset
		end

	clear_evaluation is
			-- Clear evaluation data	
		do
			last_result := Void
		end

feature {NONE} -- Internal properties

	debugger_manager: DEBUGGER_MANAGER

feature -- Access

	error_occurred: BOOLEAN is
			-- Did an error occurred during processing ?
		do
			Result := dbg_error_handler.error_occurred
		end

	dbg_error_handler: DBG_ERROR_HANDLER
			-- Debugger's error handler

feature {DBG_EXPRESSION_EVALUATOR, DEBUGGER_MANAGER, APPLICATION_EXECUTION} -- Variables

	last_result: DBG_EVALUATED_VALUE
			-- Last result

	last_result_value: DUMP_VALUE
			-- Value of last result
		do
			Result := last_result.value
		end

	last_result_static_type: CLASS_C
			-- Static type of last result	
		do
			Result := last_result.static_class
		end

feature {DBG_EXPRESSION_EVALUATOR} -- Variables preparation

	set_last_variables (v: DBG_EVALUATED_VALUE) is
		do
			reset_error
			if v /= Void then
				create last_result.make_clone (v)
			else
				clear_evaluation
			end
		end

	reset_error is
		do
			dbg_error_handler.reset
		end

feature {NONE} -- Query		

	address_from_basic_dump_value (a_target: DUMP_VALUE): DBG_ADDRESS is
		require
			a_target /= Void and then a_target.address = Void
		deferred
		end

feature {NONE} -- Parameters Implementation

	parameters_reset is
		do
		end

	parameters_init (n: INTEGER) is
		do
		end

	parameters_push (dmp: DUMP_VALUE) is
		deferred
		end

	parameters_push_and_metamorphose (dmp: DUMP_VALUE) is
		deferred
		end

	prepare_parameters (dt: CLASS_TYPE; f: FEATURE_I; params: LIST [DUMP_VALUE]) is
			-- Prepare parameters for function evaluation
			-- For classic system
			--| Warning: for classic system be sure `Init_recv_c' had been done before
		require
			f_is_not_attribute: f = Void or else not f.is_attribute
			params_not_empty: params /= Void and then not params.is_empty
		local
			dmp: DUMP_VALUE
			bak_cc: CLASS_C
			l_type: TYPE_A
		do
				--| Prepare parameters ...
			if f /= Void and then f.argument_count /= params.count then
				dbg_error_handler.notify_error_evaluation (debugger_names.msg_error_evaluation_wrong_nb_of_args (f.argument_count, params.count))
			else
				bak_cc := System.current_class
				if dt /= Void then
					System.set_current_class (dt.associated_class)
				end
				parameters_init (params.count)
				from
					params.start
				until
					params.after or error_occurred
				loop
					dmp := params.item
						-- We need to evaluate feature argument in the context of `dt'
						-- it might have some formal and the metamorphose should only appear
						-- when there is indeed a type difference and not because the expected
						-- argument is a formal parameter and the actual argument value is
						-- a basic type.
						-- This happen when evaluation `my_hash_table.item (1)' where
						-- `my_hash_table' is of type `HASH_TABLE [STRING, INTEGER]',
						-- or when evaluating `test.has_item (1)' if `test' is a descendant
						-- of `HASH_TABLE [INTEGER, XXXX]'.
					check dmp_not_void: dmp /= Void end
					if dmp.is_basic then
						if dt /= Void and f /= Void then
							if {ta: TYPE_A} f.arguments.i_th (params.index) then
								l_type := ta.instantiation_in (dt.type, f.written_in)
							end
							if l_type /= Void and then not l_type.is_basic then
								parameters_push_and_metamorphose (dmp)
							else
								parameters_push (dmp)
							end
						else
							-- FIXME jfiat : in very specific case we have  'f =  Void'
							-- i.e: when we have only the feature_name with no more info
							parameters_push (dmp)
						end
					else
						parameters_push (dmp)
					end
					params.forth
				end
				if bak_cc /= Void then
					System.set_current_class (bak_cc)
				end
			end
		end

feature -- Concrete evaluation

	evaluate_static_function (f: FEATURE_I; cl: CLASS_C; params: LIST [DUMP_VALUE]) is
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
			cl_not_void: cl /= Void
			no_error_occurred: not error_occurred
		local
			l_dyntype: CLASS_TYPE
		do
			l_dyntype := cl.types.first
				--| FIXME jfiat: we deal only non generic types

			effective_evaluate_static_function (f, l_dyntype, params)

			if last_result /= Void and then {sc: CLASS_C} class_c_from_type_a (f.type, cl) then
				last_result.suggest_static_class (sc)
			end
			if last_result = Void or else not last_result.has_value then
				dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_unable_to_evaluate_call (cl.name_in_upper, f.feature_name, Void, Void))
			end
		end

	evaluate_once (f: FEATURE_I) is
			-- Evaluate once feature
		require
			feature_not_void: f /= Void
			no_error_occurred: not error_occurred
		do
			check
				f_is_once: f.is_once
			end
			effective_evaluate_once_function (f)
		end

	evaluate_attribute (a_addr: DBG_ADDRESS; a_target: DUMP_VALUE; c: CLASS_C; f: FEATURE_I) is
			-- Evaluate attribute feature
		local
			lst: DS_LIST [ABSTRACT_DEBUG_VALUE]
			dv: ABSTRACT_DEBUG_VALUE
			l_address: DBG_ADDRESS
			cl: CLASS_C
		do
			if a_target /= Void then
				l_address := a_target.address
			end
			if l_address = Void or else l_address.is_void then
				l_address := a_addr
			end
			if (l_address = Void or else l_address.is_void) and a_target /= Void then
					--| cannot evaluate attribute on manifest value
					--| (such as "foo", 1 or True .. in the expression)
					-- but let's try to improve this ...
				l_address := address_from_dump_value (a_target)
			end
			if l_address /= Void and then not l_address.is_void then
				lst := attributes_list_from_object (l_address)
				dv := find_item_in_list (f.feature_name, lst)

				cl := class_c_from_type_a (f.type, c)
				if dv = Void then
					if f.feature_name.is_equal (once "Void") then
						create last_result.make_with_value (Debugger_manager.Dump_value_factory.new_void_value (cl))
					else
						dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_cannot_find_attribute (f.feature_name))
					end
				else
					create last_result.make_with_value (dv.dump_value)
				end
				if cl /= Void then
					last_result.suggest_static_class (cl)
				end
--			elseif f.name.is_equal ("item") then
--				result_object := a_target
--				result_static_type := a_target.dynamic_class
			else
				if a_target /= Void and then a_target.is_type_manifest_string then
						-- Manifest string
					dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_cannot_evaluate_attribute_of_manifest_string (f.feature_name))
				else
					dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_cannot_evaluate_attribute_of_expanded (f.feature_name))
				end
			end
		end

	evaluate_routine (a_addr: DBG_ADDRESS; a_target: DUMP_VALUE; cl: CLASS_C; f: FEATURE_I; params: LIST [DUMP_VALUE]; is_static_call: BOOLEAN) is
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		local
			l_target_dynclass, l_statcl: CLASS_C
			l_dyntype: CLASS_TYPE
			realf: FEATURE_I
		do
			debug ("debugger_trace_eval")
				print (generating_type + ".evaluate_routine :%N")
				print ("%Taddr="); print (a_addr.output); print ("%N")
				if a_target /= Void then
					print ("%Ttarget=not Void : [")
					print (a_target.full_output)
					print ("] %N")
				else
					print ("%Ttarget=Void %N")
				end
				print ("%Tfeature="); print (f.feature_name); print ("%N")
			end

				--| Get target data ...
			if cl /= Void then
				l_target_dynclass := cl
			elseif a_target /= Void then
				l_target_dynclass := a_target.dynamic_class
			end
			if l_target_dynclass /= Void and then l_target_dynclass.is_basic then
				l_dyntype := associated_basic_class_type (l_target_dynclass)
			elseif l_target_dynclass /= Void and then l_target_dynclass.types.count = 1 then
				l_dyntype := l_target_dynclass.types.first
			elseif l_target_dynclass = Void or else l_target_dynclass.types.count > 1 then
				if a_addr /= Void and then not a_addr.is_void then
						-- The type has generic derivations: we need to find the precise type.
					l_dyntype := class_type_from_object_relative_to (a_addr, l_target_dynclass)
					if l_dyntype = Void then
						dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_cannot_find_context_object (a_addr.output))
					elseif l_target_dynclass = Void then
						l_target_dynclass := l_dyntype.associated_class
					end
				elseif f.is_once then
						--| Useless for once
					l_target_dynclass := Void
					l_dyntype := Void
				else
						--| Shouldn't happen: basic types are not generic.
					dbg_error_handler.notify_error_evaluation (Debugger_names.cst_error_cannot_find_complete_dynamic_type_of_expanded_type)
				end
			else
				check l_target_dynclass /= Void and then l_target_dynclass.types.count = 0 end
			end
			if f.is_once then
				effective_evaluate_once_function (f)
				if last_result_value = Void then
					dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_unable_to_evaluate_once_call (f.written_class.name_in_upper, f.feature_name))
				end
			elseif not error_occurred then
				check l_target_dynclass /= Void end
				if l_dyntype = Void then
					dbg_error_handler.notify_error_evaluation (
								Debugger_names.msg_error_unable_to_evaluate_call (f.written_class.name_in_upper, f.feature_name, Void,
										Debugger_names.msg_error_type_not_compiled (l_target_dynclass.name_in_upper)
									)
							)
				else
						-- Get real feature
					realf := ancestor_version_of (f, f.written_class)
					if realf = Void then
							--| FIXME JFIAT: 2004-02-01 : why `realf' can be Void in some case ?
							--| occurred for EV_RICH_TEXT_IMP.line_index (...)
						debug ("debugger_trace_eval_data")
							print ("f.ancestor_version (f.written_class) = Void%N")
							print ("  f.feature_name  = " + f.feature_name + "%N")
							print ("  f.written_class = " + f.written_class.name_in_upper + "%N")
						end
						realf := f
					elseif realf.is_deferred then
						realf := f
					end
					check
						valid_dyn_type: l_dyntype /= Void
						f_is_not_once: not f.is_once
					end
					if realf.is_deferred and f.is_deferred then
						dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_unable_to_evaluate_deferred_call (f.written_class.name_in_upper, f.feature_name))
					else
						effective_evaluate_routine (a_addr, a_target, f, realf, l_dyntype, l_target_dynclass, params, is_static_call)
						if last_result = Void or else not last_result.has_value then
							dbg_error_handler.notify_error_evaluation (
										Debugger_names.msg_error_unable_to_evaluate_call (l_dyntype.associated_class.name_in_upper, f.feature_name, a_addr.output, Void)
									)
						end
					end
				end
				if not error_occurred and then last_result /= Void then
					if f.is_function then
						check l_target_dynclass /= Void end
						l_statcl := class_c_from_type_a (f.type, l_target_dynclass)
						if l_statcl = Void then
							l_statcl := Workbench.Eiffel_system.Any_class.compiled_class
						end
						if l_statcl /= Void then
							last_result.suggest_static_class (l_statcl)
							if
								l_statcl.is_basic and
								last_result.has_attached_value
							then
									-- We expected a basic type, but got a reference.
									-- This happens in "2 + 2" because we convert the first 2
									-- to a reference and therefore get a reference.
								last_result.value := last_result.value.to_basic
								last_result.update
								last_result.suggest_static_class (l_statcl)
							end
						end
					else
						-- `f' is a procedure, so we keep the last_result_value as it is
						-- i.e: a procedure return value
					end
				end
			end
		end

	evaluate_function_with_name (a_addr: DBG_ADDRESS; a_target: DUMP_VALUE;
				a_feature_name, a_external_name: STRING;
				params: LIST [DUMP_VALUE]) is
			-- Note: this feature is used only for external function				
		require
			a_feature_name_not_void: a_feature_name /= Void
			a_external_name_not_void: a_external_name /= Void
		do
			effective_evaluate_function_with_name (a_addr, a_target, a_feature_name, a_external_name, params)
		end

	effective_evaluate_once_function (f: FEATURE_I) is
		require
			feature_not_void: f /= Void
			f.written_class.types.count <= 1
			f_is_once: f.is_once
			no_error_occurred: not error_occurred
		deferred
		end

	effective_evaluate_routine (a_addr: DBG_ADDRESS; a_target: DUMP_VALUE; f, realf: FEATURE_I;
				ctype: CLASS_TYPE; orig_class: CLASS_C;
				params: LIST [DUMP_VALUE];
				is_static_call: BOOLEAN
			) is
		require
			realf /= Void
			no_error_occurred: not error_occurred
		deferred
		end

	create_empty_instance_of (a_type_i: CL_TYPE_A) is
		require
			a_type_i_not_void: a_type_i /= Void
			a_type_i_compiled: a_type_i.has_associated_class_type (Void)
		deferred
		end

	create_special_any_instance (a_type_i: CL_TYPE_A; a_count: INTEGER) is
		require
			a_type_i_not_void: a_type_i /= Void
			a_type_i_compiled: a_type_i.has_associated_class_type (Void)
			is_special: a_type_i.associated_class.is_special
		deferred
		end

feature -- Implementation

	effective_evaluate_static_function (f: FEATURE_I; ctype: CLASS_TYPE; params: LIST [DUMP_VALUE]) is
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
			no_error_occurred: not error_occurred
		do
			--| only for dotnet for now
		end

	effective_evaluate_function_with_name (a_addr: DBG_ADDRESS; a_target: DUMP_VALUE;
				a_feature_name, a_external_name: STRING;
				params: LIST [DUMP_VALUE]) is
			-- Note: this feature is used only for external function				
		require
			a_feature_name_not_void: a_feature_name /= Void
			a_external_name_not_void: a_external_name /= Void
			no_error_occurred: not error_occurred
		do
		end

feature -- Query

	attributes_list_from_object (a_addr: DBG_ADDRESS): DS_LIST [ABSTRACT_DEBUG_VALUE] is
		do
			Result := debugger_manager.object_manager.attributes_at_address (a_addr, 0, 0)
		end

	class_type_from_object (a_addr: DBG_ADDRESS): CLASS_TYPE is
		do
			Result := debugger_manager.object_manager.class_type_at_address (a_addr)
		end

	class_type_from_object_relative_to (a_addr: DBG_ADDRESS; cl: CLASS_C): CLASS_TYPE is
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

	current_object_from_callstack (cse: EIFFEL_CALL_STACK_ELEMENT): DUMP_VALUE is
		require
			cse_not_void: cse /= Void
		deferred
		end

	dump_value_at_address (addr: DBG_ADDRESS): DUMP_VALUE is
		require
			addr_attached: addr /= Void and then not addr.is_void
		deferred
		end

	address_from_dump_value (a_target: DUMP_VALUE): DBG_ADDRESS is
		require
			a_target /= Void
		do
			Result := a_target.address
			if Result = Void then
					--| cannot evaluate attribute on manifest value
					--| (such as "foo", 1 or True .. in the expression)
					-- but let's try to improve this ...
				Result := address_from_basic_dump_value (a_target)
			end
		end

	class_c_from_external_b_with_extension	(a_external_b: EXTERNAL_B): CLASS_C is
		require
			a_external_b /= Void and then a_external_b.extension /= Void
		do
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
				l_cursor.go_after
			end
		ensure
			same_name_if_found: (Result /= Void) implies (Result.name.is_equal (n))
		end

invariant
	dbg_handler_attached: dbg_error_handler /= Void

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
