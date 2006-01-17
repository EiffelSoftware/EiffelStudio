indexing
	description : "Objects used to evaluate concrete feature ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	DBG_EVALUATOR

inherit

	REFACTORING_HELPER
	
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

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			build_evaluator
		end
		
	build_evaluator is
		do
			fixme ("try to make this decision between dotnet or classic before")
			if application.is_dotnet then
					--| Soon or later .. change this by creating descendant of Current
				create {DBG_EVALUATOR_DOTNET} implementation.make (Current)
			else
				create {DBG_EVALUATOR_CLASSIC} implementation.make (Current)
			end
		end

feature {SHARED_DBG_EVALUATOR} -- Init

	reset is
		do
			implementation.parameters_reset
			implementation.clear_evaluation
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

feature {SHARED_DBG_EVALUATOR, DBG_EVALUATOR_IMP} -- Variables preparation

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
		do
			l_dyntype := f.associated_class.types.first
				--| FIXME jfiat: we deal only non generic types
			
			prepare_evaluation
			implementation.effective_evaluate_static_function (f.associated_feature_i, l_dyntype, params)
			retrieve_evaluation
			
			if last_result_value /= Void then
				last_result_static_type := f.type.associated_class
			else
				notify_error_evaluation ("Unable to evaluate {" + f.associated_class.name_in_upper + "}." + f.name)
			end
		end

	evaluate_once (a_addr: STRING; a_target: DUMP_VALUE; f: E_FEATURE; params: LIST [DUMP_VALUE]) is
			-- 
		require
			feature_not_void: f /= Void
		do
			check
				f_is_once: f.associated_feature_i.is_once
			end
			if f.written_class.types.count > 1 then
				if f.written_class.is_generic then
					notify_error_evaluation ("Once evaluation on generic class {" + f.written_class.name_in_upper + "} not available")
				else
					notify_error_evaluation ("Evaluation on expanded class {" + f.written_class.name_in_upper + "} is not supported")
				end
			else
				prepare_evaluation
				implementation.effective_evaluate_once (a_addr, a_target, f, params)
				retrieve_evaluation
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
				dv := find_item_in_list (f.name, lst)
				
				last_result_static_type := f.type.actual_type.associated_class
				if dv = Void then
					if f.name.is_equal ("Void") then
						create last_result_value.make_void (last_result_static_type)
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
				notify_error_evaluation ("Cannot evaluate an attribute ["+ f.name +"] of a expanded value")
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
			l_err_msg: STRING
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

				--| Get target data ...
			if cl /= Void then
				l_dynclass := cl
			elseif a_target /= Void then
				l_dynclass := a_target.dynamic_class
			end
			if l_dynclass /= Void and then l_dynclass.is_basic then
				l_dyntype := implementation.associated_reference_basic_class_type (l_dynclass)
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
				elseif f.is_once then
					notify_error_evaluation ("Due to recent changes on once implementation,%N It is not possible to evaluate once function on Class context.")
				else
						--| Shouldn't happen: basic types are not generic.
					notify_error_evaluation ("Cannot find complete dynamic type of an expanded type")
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

				effective_evaluate_function (a_addr, a_target, f, realf, l_dyntype, params)
				if last_result_value = Void then
					l_err_msg := "Unable to evaluate {" + l_dyntype.associated_class.name_in_upper + "}." + f.name
					if a_addr /= Void then
						l_err_msg.append_string (" on <" + a_addr + ">")
					end
					notify_error_evaluation (l_err_msg)
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

	evaluate_function_with_name (a_addr: STRING; a_target: DUMP_VALUE;
				a_feature_name, a_external_name: STRING; 
				params: LIST [DUMP_VALUE]) is
		require
			a_feature_name_not_void: a_feature_name /= Void
			a_external_name_not_void: a_external_name /= Void
		do
			prepare_evaluation
			implementation.effective_evaluate_function_with_name (a_addr, a_target, a_feature_name, a_external_name, params)
			retrieve_evaluation
		end

	effective_evaluate_function (a_addr: STRING; a_target: DUMP_VALUE; f, realf: E_FEATURE; 
			ctype: CLASS_TYPE; params: LIST [DUMP_VALUE]) is
		do
			prepare_evaluation
			implementation.effective_evaluate_function (
								a_addr, a_target,f, realf, ctype, params
							)
			retrieve_evaluation
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

	current_object_from_callstack (cse: EIFFEL_CALL_STACK_ELEMENT): DUMP_VALUE is
		require
			cse_not_void: cse /= Void
		do
			Result := implementation.current_object_from_callstack (cse)
		end

	dump_value_at_address (addr: STRING): DUMP_VALUE is
		require
			addr /= Void
		do
			Result := implementation.dump_value_at_address (addr)
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
				Result := implementation.address_from_basic_dump_value (a_target)
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

	associated_reference_basic_class_type (cl: CLASS_C): CLASS_TYPE is
			-- Associated _REF classtype for type `cl'
			--| for instance return INTEGER_REF for INTEGER
		require
			cl_not_void: cl /= Void
			cl_is_basic: cl.is_basic
		do
			fixme ("[
						jfiat 2004-10-06 : why do we have two different behaviors
						depending if we are on dotnet or classic ?
				]")
			Result := implementation.associated_reference_basic_class_type (cl)
		ensure
			associated_reference_class_type_not_void: Result /= Void
		end		

feature {NONE} -- Implementation

	prepare_evaluation is
			-- Initialization before effective evaluation
		do
			implementation.prepare_evaluation (last_result_value, last_result_static_type)
		end
	
	retrieve_evaluation is
			-- Get the effective evaluation's result and info
		do
			last_result_value       := implementation.last_result_value
			last_result_static_type := implementation.last_result_static_type			
			if implementation.error_occurred then
				notify_error_evaluation (implementation.error_message)
			end
			implementation.clear_evaluation
		end

	implementation: DBG_EVALUATOR_IMP;

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
