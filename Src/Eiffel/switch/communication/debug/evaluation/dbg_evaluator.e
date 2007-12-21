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

--create
--	make

feature {NONE} -- Initialization

	make (dm: like debugger_manager) is
			-- Initialize `Current'.
		require
			dm_not_void: dm /= Void
		do
			debugger_manager := dm
			create error_messages.make
		end

feature {DEBUGGER_MANAGER, DBG_EXPRESSION_EVALUATOR} -- Init

	reset is
		do
			reset_error
			clear_evaluation
			parameters_reset
		end

	clear_evaluation is
		do
			last_result_value := Void
			last_result_static_type := Void
		end

feature {NONE} -- Internal properties

	debugger_manager: DEBUGGER_MANAGER

feature {DBG_EXPRESSION_EVALUATOR} -- Variables

	last_result_value: DUMP_VALUE

	last_result_static_type: CLASS_C

	error: INTEGER
			-- Error code

	error_messages: LINKED_LIST [TUPLE [code: INTEGER; msg: STRING_32]]
			-- List of [Code, Message]
			-- Error's message if any otherwise Void

	error_message: STRING_32 is
		do
			Result := error_message_by (0) -- All
		end

	error_message_by (a_code_filter: INTEGER): STRING_32 is
			-- Error message filter by `a_code_filter'.
			-- if `a_code_filter' is zero => all messages
			-- if `a_code_filter' is positive => all messages associated with `a_code_filter'
			-- if `a_code_filter' is negative => all messages except the ones associated with - `a_code_filter'
		local
			details: TUPLE [code: INTEGER; msg: STRING_32]
			l_msg: STRING_GENERAL
			l_code: INTEGER
		do
			if error /= 0 and not error_messages.is_empty then
				from
					create Result.make (10)
					error_messages.start
				until
					error_messages.after
				loop
					details := error_messages.item
					l_code := details.code
					if
						a_code_filter = 0
						or else (a_code_filter > 0 and l_code = a_code_filter )
						or else (a_code_filter < 0 and l_code /= -a_code_filter)
					then
						l_msg := details.msg
						if l_msg = Void and l_code /= 0 then
							l_msg := error_code_to_message (l_code)
						end
						if l_msg /= Void then
							Result.append_string_general (l_msg)
						end
						error_messages.forth
						if not error_messages.after then
							Result.append ("%N--------------------------%N")
						end
					else
						error_messages.forth
					end
				end
				if Result.is_empty then
					Result := Void
				end
			end
		end

	error_evaluation_message: STRING_32 is
		do
			if evaluation_error_occurred then
				Result := error_message_by (Cst_error_occurred)
			end
		end

	error_but_exception_message: STRING_32 is
		do
			if error_but_exception_occurred then
				Result := error_message_by (-Cst_error_exception_during_evaluation)
			end
		end

	error_exception_message: STRING_32 is
		do
			if exception_occurred then
				Result := error_message_by (Cst_error_exception_during_evaluation)
			end
		end

	error_occurred: BOOLEAN is
			-- Did an error occurred during processing ?
		do
			Result := error /= 0
		end

	evaluation_error_occurred: BOOLEAN is
			-- Did the evaluation raised an error ?
		do
			Result := error & Cst_error_occurred /= 0
		end

	evaluation_aborted: BOOLEAN is
			-- Did the evaluation aborted ?
		do
			Result := error & cst_error_evaluation_aborted /= 0
		end

	exception_occurred: BOOLEAN is
			-- Did the evaluation raised an exception ?
		do
			Result := error & cst_error_exception_during_evaluation /= 0
		end

	error_but_exception_occurred: BOOLEAN is
			-- Error other than Exception occurred ?
		do
			Result := error_occurred and then error /= cst_error_exception_during_evaluation
		end

feature -- Error values

	Cst_error_occurred: INTEGER is 0x1
	Cst_error_evaluation_aborted: INTEGER is 0x2
	Cst_error_exception_during_evaluation: INTEGER is 0x4
	Cst_error_unable_to_get_target_object: INTEGER is 0x8
	Cst_error_occurred_during_parameters_preparation: INTEGER is 0x10

	error_code_to_message (a_code: INTEGER): STRING_GENERAL
		require
			code_not_zero: a_code /= 0
		do
			inspect a_code
				when Cst_error_evaluation_aborted then
					Result := Debugger_names.cst_error_evaluation_aborted
				when Cst_error_exception_during_evaluation then
					Result := Debugger_names.cst_error_exception_during_evaluation
				when Cst_error_occurred then
					Result := Debugger_names.cst_error_occurred
				when Cst_error_unable_to_get_target_object then
					Result := Debugger_names.cst_error_unable_to_get_target_object
				when Cst_error_occurred_during_parameters_preparation then
					Result := Debugger_names.cst_error_occurred_during_parameters_preparation
				else
			end
		end

feature {DBG_EXPRESSION_EVALUATOR} -- Variables preparation

	set_last_variables (trv: DUMP_VALUE; trs: CLASS_C) is
		do
			reset_error
			last_result_value := trv
			last_result_static_type := trs
		end

	reset_error is
		do
			error := 0
			error_messages.wipe_out
		end

	notify_error (a_code: INTEGER; a_msg: STRING_GENERAL) is
		require
			a_code /= 0
		local
			m: STRING_32
		do
			if a_msg /= Void then
				m := a_msg.as_string_32
			end
			error := error | a_code
			error_messages.extend ([a_code, m])
		end

	notify_error_evaluation	(a_msg: STRING_GENERAL) is
		do
			notify_error (Cst_error_occurred, a_msg)
		end

	notify_error_exception (a_msg: STRING_GENERAL) is
		do
			notify_error (Cst_error_exception_during_evaluation, a_msg)
		end

feature {NONE} -- Query		

	address_from_basic_dump_value (a_target: DUMP_VALUE): STRING is
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
			params /= Void and then not params.is_empty
		local
			dmp: DUMP_VALUE
			bak_cc: CLASS_C
		do
				--| Prepare parameters ...
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
						and dt /= Void
						and then (not Byte_context.real_type_in (
									f.arguments.i_th (params.index).type_i
									, dt).is_basic
								)
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
			if bak_cc /= Void then
				System.set_current_class (bak_cc)
			end
		end

feature -- Concrete evaluation

	evaluate_static_function (f: FEATURE_I; cl: CLASS_C; params: LIST [DUMP_VALUE]) is
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
			cl_not_void: cl /= Void
		local
			l_dyntype: CLASS_TYPE
		do
			l_dyntype := cl.types.first
				--| FIXME jfiat: we deal only non generic types

			effective_evaluate_static_function (f, l_dyntype, params)

			if last_result_value /= Void then
				last_result_static_type := class_c_from_type_a (f.type, cl)
			else
				notify_error_evaluation (Debugger_names.msg_error_unable_to_evaluate_call (cl.name_in_upper, f.feature_name, Void, Void))
			end
		end

	evaluate_once (f: FEATURE_I) is
			-- Evaluate once feature
		require
			feature_not_void: f /= Void
		do
			check
				f_is_once: f.is_once
			end
			effective_evaluate_once_function (f)
		end

	evaluate_attribute (a_addr: STRING; a_target: DUMP_VALUE; c: CLASS_C; f: FEATURE_I) is
			-- Evaluate attribute feature
		local
			lst: DS_LIST [ABSTRACT_DEBUG_VALUE]
			dv: ABSTRACT_DEBUG_VALUE
			l_address: STRING
		do
			if a_target /= Void then
				l_address := a_target.address
			end
			if l_address = Void then
				l_address := a_addr
			end
			if l_address = Void and a_target /= Void then
					--| cannot evaluate attribute on manifest value
					--| (such as "foo", 1 or True .. in the expression)
					-- but let's try to improve this ...
				l_address := address_from_dump_value (a_target)
			end
			if l_address /= Void then
				lst := attributes_list_from_object (l_address)
				dv := find_item_in_list (f.feature_name, lst)

				last_result_static_type := class_c_from_type_a (f.type, c)
				if dv = Void then
					if f.feature_name.is_equal (once "Void") then
						last_result_value := Debugger_manager.Dump_value_factory.new_void_value (last_result_static_type)
					else
						notify_error_evaluation (Debugger_names.msg_error_cannot_find_attribute (f.feature_name))
					end
				else
					last_result_value := dv.dump_value
				end
--			elseif f.name.is_equal ("item") then
--				result_object := a_target
--				result_static_type := a_target.dynamic_class
			else
				if a_target /= Void and then a_target.is_type_manifest_string then
						-- Manifest string
					notify_error_evaluation (Debugger_names.msg_error_cannot_evaluate_attribute_of_manifest_string (f.feature_name))
				else
					notify_error_evaluation (Debugger_names.msg_error_cannot_evaluate_attribute_of_expanded (f.feature_name))
				end
			end
		end

	evaluate_routine (a_addr: STRING; a_target: DUMP_VALUE; cl: CLASS_C; f: FEATURE_I; params: LIST [DUMP_VALUE]; is_static_call: BOOLEAN) is
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		local
			l_target_dynclass: CLASS_C
			l_dyntype: CLASS_TYPE
			realf: FEATURE_I
		do
			debug ("debugger_trace_eval")
				print (generating_type + ".evaluate_routine :%N")
				print ("%Taddr="); print (a_addr); print ("%N")
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
				if a_addr /= Void then
						-- The type has generic derivations: we need to find the precise type.
					l_dyntype := class_type_from_object_relative_to (a_addr, l_target_dynclass)
					if l_dyntype = Void then
						notify_error_evaluation (Debugger_names.msg_error_cannot_find_context_object (a_addr))
					elseif l_target_dynclass = Void then
						l_target_dynclass := l_dyntype.associated_class
					end
				elseif f.is_once then
						--| Useless for once
					l_target_dynclass := Void
					l_dyntype := Void
				else
						--| Shouldn't happen: basic types are not generic.
					notify_error_evaluation (Debugger_names.cst_error_cannot_find_complete_dynamic_type_of_expanded_type)
				end
			else
				check l_target_dynclass /= Void and then l_target_dynclass.types.count = 0 end
			end
			if f.is_once then
				effective_evaluate_once_function (f)
				if last_result_value = Void then
					notify_error_evaluation (Debugger_names.msg_error_unable_to_evaluate_once_call (f.written_class.name_in_upper, f.feature_name))
				end
			elseif not error_occurred then
				check l_target_dynclass /= Void end
				if l_dyntype = Void then
					notify_error_evaluation (
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
						notify_error_evaluation (Debugger_names.msg_error_unable_to_evaluate_deferred_call (f.written_class.name_in_upper, f.feature_name))
					else
						effective_evaluate_routine (a_addr, a_target, f, realf, l_dyntype, l_target_dynclass, params, is_static_call)
						if last_result_value = Void then
							notify_error_evaluation (
										Debugger_names.msg_error_unable_to_evaluate_call (l_dyntype.associated_class.name_in_upper, f.feature_name, a_addr, Void)
									)
						end
					end
				end
				if not error_occurred and then last_result_value /= Void then
					if f.is_function then
						check l_target_dynclass /= Void end
						last_result_static_type := class_c_from_type_a (f.type, l_target_dynclass)
						if last_result_static_type = Void then
							last_result_static_type := Workbench.Eiffel_system.Any_class.compiled_class
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
					else
						-- `f' is a procedure, so we keep the last_result_value as it is
						-- i.e: a procedure return value
					end
				end
			end
		end

	evaluate_function_with_name (a_addr: STRING; a_target: DUMP_VALUE;
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
		deferred
		end

	effective_evaluate_routine (a_addr: STRING; a_target: DUMP_VALUE; f, realf: FEATURE_I;
				ctype: CLASS_TYPE; orig_class: CLASS_C;
				params: LIST [DUMP_VALUE];
				is_static_call: BOOLEAN
			) is
		require
			realf /= Void
		deferred
		end

	create_empty_instance_of (a_type_i: CL_TYPE_I) is
		require
			a_type_i_not_void: a_type_i /= Void
			a_type_i_compiled: a_type_i.has_associated_class_type
		deferred
		end

	create_special_any_instance (a_type_i: CL_TYPE_I; a_count: INTEGER) is
		require
			a_type_i_not_void: a_type_i /= Void
			a_type_i_compiled: a_type_i.has_associated_class_type
			is_special: a_type_i.base_class.is_special
		deferred
		end

feature -- Implementation

	effective_evaluate_static_function (f: FEATURE_I; ctype: CLASS_TYPE; params: LIST [DUMP_VALUE]) is
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		do
			--| only for dotnet for now
		end

	effective_evaluate_function_with_name (a_addr: STRING; a_target: DUMP_VALUE;
				a_feature_name, a_external_name: STRING;
				params: LIST [DUMP_VALUE]) is
			-- Note: this feature is used only for external function				
		require
			a_feature_name_not_void: a_feature_name /= Void
			a_external_name_not_void: a_external_name /= Void
		do
		end

feature -- Query

	adapted_class_type (ctype: CLASS_TYPE; f: FEATURE_I): CLASS_TYPE is
			-- Adapted class_type receiving the call of `f'
		local
			l_f_class_c: CLASS_C
			l_cl_type_a: CL_TYPE_A
		do
			if ctype.associated_class.is_basic then
				Result := associated_reference_basic_class_type (ctype.associated_class)
			else
					--| Get the real class_type
				l_f_class_c := f.written_class
				if ctype.associated_class.is_equal (l_f_class_c) then
						--| The feature is not inherited
					Result := ctype
				else
					if l_f_class_c.types.count = 1 then
						Result := l_f_class_c.types.first
					elseif l_f_class_c.is_basic then
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

	attributes_list_from_object (a_addr: STRING): DS_LIST [ABSTRACT_DEBUG_VALUE] is
		do
			Result := debugger_manager.object_manager.attributes_at_address (a_addr, 0, 0)
		end

	class_type_from_object (a_addr: STRING): CLASS_TYPE is
		do
			Result := debugger_manager.object_manager.class_type_at_address (a_addr)
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

	current_object_from_callstack (cse: EIFFEL_CALL_STACK_ELEMENT): DUMP_VALUE is
		require
			cse_not_void: cse /= Void
		deferred
		end

	dump_value_at_address (addr: STRING): DUMP_VALUE is
		require
			addr /= Void
		deferred
		end

	address_from_dump_value (a_target: DUMP_VALUE): STRING is
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
			end
		ensure
			same_name_if_found: (Result /= Void) implies (Result.name.is_equal (n))
		end

feature {DBG_EXPRESSION_EVALUATOR} -- compiler helpers

	ancestor_version_of (fi: FEATURE_I; an_ancestor: CLASS_C): FEATURE_I is
			-- Feature in `an_ancestor' of which `Current' is derived.
			-- `Void' if not present in that class.
		require
			fi_not_void: fi /= Void
			an_ancestor_not_void: an_ancestor /= Void
		local
			n, nb: INTEGER
			ris: ROUT_ID_SET
			rout_id: INTEGER
		do
			if
				an_ancestor.is_valid
				and then an_ancestor.has_feature_table
			then
				ris := fi.rout_id_set
				from
					n := ris.lower
					nb := ris.count
				until
					n > nb or else Result /= Void
				loop
					rout_id := ris.item (n)
					if rout_id > 0 then
						Result := an_ancestor.feature_table.feature_of_rout_id (rout_id)
					end
					n := n + 1
				end
			end
		end

	associated_basic_class_type (cl: CLASS_C): CLASS_TYPE is
			-- Associated classtype for type `cl'
		require
			cl_not_void: cl /= Void
			cl_is_basic: cl.is_basic
		local
			t: CL_TYPE_I
		do
			t := cl.actual_type.type_i
			if t.has_associated_class_type then
				Result := t.associated_class_type
			end
		ensure
			associated_basic_class_type_not_void: Result /= Void
		end

	associated_reference_basic_class_type (cl: CLASS_C): CLASS_TYPE is
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
			Result := l_basic.associated_reference_class_type
		ensure
			associated_reference_basic_class_type_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	class_c_from_type_a (t: TYPE_A; a_ctx_class: CLASS_C): CLASS_C is
		require
			t_not_void: t /= Void
			a_ctx_class_not_void: a_ctx_class /= Void
		local
			l_type: TYPE_A
			l_formal: FORMAL_A
--			l_last_type_set: TYPE_SET_A
		do
			if t.has_associated_class then
				Result := t.associated_class
			else
				l_type := t.actual_type
				if l_type.is_formal then
					l_formal ?= l_type
					if l_formal.is_multi_constrained (a_ctx_class) then
						fixme("Handle multi constrained type...")
--						l_last_type_set := l_type.to_type_set.constraining_types (a_ctx_class)
--						l_type := l_last_type_set.instantiated_in (a_ctx_class.actual_type)
--						if l_type.is_formal then
--							l_formal ?= l_type
--							l_type := l_formal.constrained_type (a_ctx_class)
--						end
						l_type := Void
					else
						l_type := l_formal.constrained_type (a_ctx_class)
					end
				end
				if l_type /= Void and then not l_type.is_none then
					Result := l_type.associated_class
				else
					Result := Void
				end
			end
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
