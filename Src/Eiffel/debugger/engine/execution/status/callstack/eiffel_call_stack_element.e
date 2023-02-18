note
	description: "Element of a call stack."

deferred class
	EIFFEL_CALL_STACK_ELEMENT

inherit
	CALL_STACK_ELEMENT

	COMPILER_EXPORTER

	DEBUGGER_COMPILER_UTILITIES
		export
			{NONE} all
		end

	SHARED_DEBUGGER_MANAGER

feature -- Properties

	is_eiffel_call_stack_element: BOOLEAN = True
			-- Is Current an Eiffel Call Stack Element ?

	is_hidden: BOOLEAN
			-- Is hidden for debugger?
		do
			if attached routine_i as f then
				Result := f.is_hidden_in_debugger_call_stack
			end
		end

	is_invariant_call_stack_element: BOOLEAN
		do
			Result := attached routine_name as n and then not n.is_empty and then
					is_invariant_feature_name (n)
		end

	body_index: INTEGER
			-- body index of the associated routine
		require
			routine_not_void: routine /= Void
		do
			if private_body_index = -1 then
				private_body_index := routine.body_index
			end
			Result := private_body_index
		end

	is_melted: BOOLEAN
			-- Is the associated routine melted.
			-- Only in that case can we request the locals
			-- and the arguments.

	is_class_feature: BOOLEAN
		do
			Result := attached routine_i as f and then f.is_class
		end

	dynamic_class: CLASS_C
			-- Dynamic class where routine is called from

	dynamic_type: CLASS_TYPE
			-- Dynamic class type where routine is called from

	written_class: CLASS_C
			-- Class where routine is written in

	routine_i: FEATURE_I
		local
			ef: E_FEATURE
		do
			ef := routine
			if ef /= Void then
				Result := ef.associated_feature_i
			end
		end

	routine: E_FEATURE
			-- Routine being called
			-- Note from Arnaud: Computation has been deferred for optimisation purpose
		deferred
		end

	is_attribute: BOOLEAN
			-- Does the related routine is an attribute?
		local
			r: like routine
		do
			r := routine
			Result := r /= Void and then r.is_attribute
		end

	has_result: BOOLEAN
			-- Does this routine has a Result ?
			-- ie: function or once
		local
			r: like routine
		do
			r := routine
			Result := r /= Void and then r.has_return_value
		end

	has_rescue: BOOLEAN
		do
			Result := routine_i /= Void and then routine_i.has_rescue_clause
		end

	result_value: ABSTRACT_DEBUG_VALUE
			-- Result value of routine
		do
			if not initialized then
				initialize_stack
			end
			Result := private_result
			if
				Result = Void
				and then has_result
			then
				Result := error_value ("Result", "unable to get the value")
			end
		ensure
			is_function_non_void: routine.is_function implies Result /= Void
		end

	current_object_value: ABSTRACT_DEBUG_VALUE
			-- Current object's value.
		deferred
		end

	local_value (i: INTEGER): ABSTRACT_DEBUG_VALUE
			-- Local value at position `i'
		require
			routine_attached: routine /= Void
		do
			if attached locals as locs then
				if locs.valid_index (i) then
					Result := locs.i_th (i)
				end
			end
		end

	object_test_local_value (i: INTEGER): ABSTRACT_DEBUG_VALUE
			-- Local value at position `i'
		require
			routine_attached: routine /= Void
		do
			if attached object_test_locals as locs then
				if locs.valid_index (i) then
					Result := locs.i_th (i)
				end
			end
		end

	local_table: HASH_TABLE [LOCAL_INFO, INTEGER]
			-- Local variables table
		local
			l_result: detachable like local_table
		do
			l_result := private_local_table
			if l_result = Void then
				if routine /= Void and dynamic_type /= Void then
					l_result := debugger_manager.debugger_ast_server.local_table (routine)
				end
				if l_result = Void then
					l_result := empty_local_table
				end
				private_local_table := l_result
			end
			Result := l_result
		ensure
			Result_attached: Result /= Void
		end

	object_test_locals_info: LIST [TUPLE [id: ID_AS; li: LOCAL_INFO]]
			-- List of object test local's info
		local
			l_result: detachable like object_test_locals_info
		do
			l_result := private_object_test_locals_info
			if l_result = Void then
				if routine /= Void then -- and dynamic_type /= Void then
					l_result := debugger_manager.debugger_ast_server.object_test_locals (routine, break_index, break_nested_index)
				end
				if l_result = Void then
					create {ARRAYED_LIST [TUPLE [ID_AS, LOCAL_INFO]]} l_result.make (0)
				end
				private_object_test_locals_info := l_result
			end
			Result := l_result
		ensure
			Result_attached: Result /= Void
		end

	locals: LIST [ABSTRACT_DEBUG_VALUE]
			-- Value of local variables
		local
			l_locals: EIFFEL_LIST [LIST_DEC_AS]
			f: E_FEATURE
		do
			if not initialized then
				initialize_stack
			end
			Result := private_locals
			if Result = Void then
				f := routine
				if f /= Void then
					l_locals := local_decl_grps_from (f)
					if
						l_locals /= Void
						and then not l_locals.is_empty
					then
						create {LINKED_LIST [ABSTRACT_DEBUG_VALUE]} Result.make
						Result.extend (error_value ("...", "Unable to get the locals"))
					end
				end
			end
		end

	object_test_locals: LIST [ABSTRACT_DEBUG_VALUE]
			-- Value of object_test_local variables
		do
			if not initialized then
				initialize_stack
			end
			Result := private_object_test_locals
		end

	arguments: LIST [ABSTRACT_DEBUG_VALUE]
			-- Value of arguments
		local
			l_args: E_FEATURE_ARGUMENTS
			r: E_FEATURE
		do
			if not initialized then
				initialize_stack
			end
			Result := private_arguments
			if Result = Void then
				r := routine
				if r /= Void then
					l_args := r.arguments
					if
						l_args /= Void
						and then not l_args.is_empty
					then
						create {LINKED_LIST [ABSTRACT_DEBUG_VALUE]} Result.make
						Result.extend (error_value ("...", "Unable to get the arguments"))
					end
				end
			end
		ensure
			non_void_implies_not_empty: Result /= Void implies not Result.is_empty
		end

	argument (pos: INTEGER): ABSTRACT_DEBUG_VALUE
			-- Argument at position `pos'
		do
			if attached arguments as args then
				if args.valid_index (pos) then
					Result := args.i_th (pos)
				end
			end
		end

feature -- Stack reset

	reset_stack
			-- Reset stack data (locals, arguments, result, ..)
		do
			initialized := False
			private_arguments := Void
			private_locals := Void
			private_object_test_locals := Void
			private_result := Void
			private_object_test_locals_info := Void
		ensure
			not_initialized: not initialized
		end

feature {NONE} -- Implementation

	initialize_stack
			-- Initialize stack data (locals, arguments, result, ..)
		require
			not_initialized: not initialized
		deferred
		ensure
			initialized: initialized
		end

	local_decl_grps_from (feat: E_FEATURE): EIFFEL_LIST [LIST_DEC_AS]
			-- Locals declaration groups for `feat'.
		do
			Result := feat.locals
		end

feature {NONE} -- Implementation Properties

	private_locals: ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]
			-- Associated locals

	private_object_test_locals: ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]
			-- Associated object test locals

	private_arguments: FIXED_LIST [ABSTRACT_DEBUG_VALUE]
			-- Associated arguments

	private_result: like result_value
			-- Associated result

	private_local_table: like local_table
			-- Associated local variables table

	private_object_test_locals_info: like object_test_locals_info
			-- Associated list of object test local's resolved info

	initialized: BOOLEAN
			-- Is the stack initialized

	private_body_index: like body_index
			-- Associated body index

feature {NONE} -- Implementation helper

	error_value (a_name: STRING_32; a_mesg: STRING): DUMMY_MESSAGE_DEBUG_VALUE
		do
			create Result.make_with_name (a_name)
			Result.set_message (a_mesg)
		end

feature {NONE} -- Implementation

	empty_local_table: HASH_TABLE [LOCAL_INFO, INTEGER]
			-- Empty local table
		once
			create Result.make (0)
		end

invariant
--
--	non_empty_args_if_exists: private_arguments /= Void implies
--				not private_arguments.is_empty
--	non_empty_locs_if_exists: private_locals /= Void implies
--				not private_locals.is_empty
--	valid_level: level_in_stack >= 1

note
	date        : "$Date$"
	revision    : "$Revision$"
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
