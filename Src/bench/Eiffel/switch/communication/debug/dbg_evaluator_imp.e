indexing
	description: "Class used for EB_EXPRESSION, to evaluate functions and ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	DBG_EVALUATOR_IMP

inherit
	REFACTORING_HELPER

	COMPILER_EXPORTER	

	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		end

	SHARED_DEBUG
		export
			{ANY} Application
			{NONE} all
		end	

	SHARED_WORKBENCH
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_evaluator: like evaluator) is
			-- Initialize `Current'.
		do
			evaluator := a_evaluator
			init
		end
		
	evaluator: DBG_EVALUATOR
			-- For now, it is used while we don't redesign DBG_EVALUATOR

feature -- Concrete initialization

	init is
			-- Retrieve new value for evaluation mecanism.
		do
			create error_messages.make
		end

feature -- Change

	reset_error is
		do
			error := 0
			error_messages.wipe_out
		end

feature -- Status

	error: INTEGER
			-- Error code in case of evaluation error

	error_occurred: BOOLEAN is
			-- Did an error occurred during processing ?
		do
			Result := error /= 0
		end

	evaluation_aborted: BOOLEAN is
			-- Did the evaluation aborted ?
		do
			Result := error & cst_error_evaluation_aborted /= 0
		end
			
	error_message: STRING is
		local
			details: TUPLE [INTEGER, STRING]
			l_msg: STRING
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
					l_code := details.integer_32_item (1)
					l_msg ?= details.item (2)
					if l_msg = Void and l_code /= 0 then
						l_msg := cst_error_messages.item (l_code)
					end
					if l_msg /= Void then
						Result.append_string (l_msg)
					end
					error_messages.forth
					if not error_messages.after then
						Result.append_String (once "%N--------------------------%N")
					end
				end
--				Result := Cst_error_messages @ error
			end
		end

	error_messages: LINKED_LIST [TUPLE [INTEGER, STRING]]
			-- List of [Code, Tag, Message]
			-- Error's message if any otherwise Void
			
	notify_error (a_code: INTEGER; a_msg: STRING) is
		require
			a_code /= 0
		do
			error := error | a_code
			error_messages.extend ([a_code, a_msg])
		end
		
	notify_error_evaluation	(a_msg: STRING) is
		do
			notify_error (cst_error_occurred, a_msg)
		end

feature {NONE} -- Error code id

	Cst_error_occurred: INTEGER is 0x1
	Cst_error_evaluation_aborted: INTEGER is 0x2
	Cst_error_exception_during_evaluation: INTEGER is 0x4
	Cst_error_unable_to_get_target_object: INTEGER is 0x8
	Cst_error_occurred_during_parameters_preparation: INTEGER is 0x10

	Cst_error_messages: HASH_TABLE [STRING, INTEGER] is
		once
			create Result.make (6)
			Result.force ("Evaluation aborted", Cst_error_evaluation_aborted)
			Result.force ("Exception occurred during evaluation", Cst_error_exception_during_evaluation)
			Result.force ("Error occurred", Cst_error_occurred)
			Result.force ("Unable to get target object", Cst_error_unable_to_get_target_object)
			Result.force ("Error during parameters preparation", Cst_error_occurred_during_parameters_preparation)
		end
	
feature {NONE} -- reversed bridge

	evaluate_function (a_addr: STRING; a_target: DUMP_VALUE; cl: CLASS_C; f: E_FEATURE; params: LIST [DUMP_VALUE]) is
		do
			evaluator.evaluate_function (a_addr, a_target, Void, f, params)
		end

feature {DBG_EVALUATOR} -- Interface

	effective_evaluate_function (a_addr: STRING; a_target: DUMP_VALUE; f, realf: E_FEATURE; 
			ctype: CLASS_TYPE; params: LIST [DUMP_VALUE]) is
		deferred
		end

	effective_evaluate_function_with_name (a_addr: STRING; a_target: DUMP_VALUE;
				a_feature_name, a_external_name: STRING; 
				params: LIST [DUMP_VALUE]) is
		require
			a_feature_name_not_void: a_feature_name /= Void
			a_external_name_not_void: a_external_name /= Void
		do
		end

	effective_evaluate_static_function (f: FEATURE_I; ctype: CLASS_TYPE; params: LIST [DUMP_VALUE]) is
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		do
			--| only for dotnet for now
		end

	effective_evaluate_once (a_addr: STRING; a_target: DUMP_VALUE; f: E_FEATURE; params: LIST [DUMP_VALUE]) is
		require
			feature_not_void: f /= Void
			f.written_class.types.count <= 1
			f_is_once: f.associated_feature_i.is_once
		deferred
		end	

	associated_reference_basic_class_type (cl: CLASS_C): CLASS_TYPE is
			-- Associated _REF classtype for type `cl'
			--| for instance return INTEGER_REF for INTEGER
		require
			cl_not_void: cl /= Void
			cl_is_basic: cl.is_basic
		deferred
		ensure
			associated_reference_basic_class_type_not_void: Result /= Void
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

	address_from_basic_dump_value (a_target: DUMP_VALUE): STRING is
		require
			a_target /= Void and then a_target.address = Void
		do
		end

feature {DBG_EVALUATOR} -- Parameters Implementation

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
									f.arguments.i_th (params.index).type_i
									).is_basic
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
			if bak_ct /= Void then
				Byte_context.set_class_type (bak_ct)				
			end
			if bak_cc /= Void then
				System.set_current_class (bak_cc)
			end
		end

feature {NONE} -- Implementation

	adapted_class_type (ctype: CLASS_TYPE; f: FEATURE_I): CLASS_TYPE is
			-- Adapated class_type receiving the call of `f'
		local
			l_f_class_c: CLASS_C
			l_cl_type_a: CL_TYPE_A
		do
			if ctype.associated_class.is_basic then
					-- FIXME JFIAT: maybe we should return the associated _REF type ...
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

feature -- Access

	last_result_value: DUMP_VALUE
	
	last_result_static_type: CLASS_C

	prepare_evaluation (trv: DUMP_VALUE; trs: CLASS_C) is
		do
			reset_error
			last_result_value := trv
			last_result_static_type := trs
		end

	clear_evaluation is
		do
			last_result_value := Void
			last_result_static_type := Void
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
