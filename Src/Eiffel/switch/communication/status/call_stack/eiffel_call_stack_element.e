indexing
	description : "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	EIFFEL_CALL_STACK_ELEMENT

inherit
	CALL_STACK_ELEMENT

	COMPILER_EXPORTER

	DEBUGGER_COMPILER_UTILITIES
		export
			{NONE} all
		end

feature -- Properties

	is_eiffel_call_stack_element: BOOLEAN is True
		-- Is Current an Eiffel Call Stack Element ?

	body_index: INTEGER is
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

	dynamic_class: CLASS_C
			-- Dynamic class where routine is called from

	dynamic_type: CLASS_TYPE
			-- Dynamic class type where routine is called from

	written_class: CLASS_C
			-- Class where routine is written in

	routine_i: FEATURE_I is
		local
			ef: E_FEATURE
		do
			ef := routine
			if ef /= Void then
				Result := ef.associated_feature_i
			end
		end

	routine: E_FEATURE is
			-- Routine being called
			-- Note from Arnaud: Computation has been deferred for optimisation purpose
		deferred
		end

	has_result: BOOLEAN is
			-- Does this routine has a Result ?
			-- ie: function or once
		local
			r: like routine
		do
			r := routine
			Result := r /= Void and then r.is_function
		end

	has_rescue: BOOLEAN is
		do
			Result := routine_i /= Void and then routine_i.has_rescue_clause
		end

	result_value: ABSTRACT_DEBUG_VALUE is
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

	current_object_value: ABSTRACT_DEBUG_VALUE is
			-- Current object's value.
		deferred
		end

	local_value (i: INTEGER): ABSTRACT_DEBUG_VALUE is
			-- Local value at position `i'
		require
			routine_attached: routine /= Void
		local
			locs: like locals
		do
			locs := locals
			if locs /= Void then
				Result := locs.i_th (i)
			end
		end

	object_test_local_value (i: INTEGER): ABSTRACT_DEBUG_VALUE is
			-- Local value at position `i'
		require
			routine_attached: routine /= Void
		local
			locs: like locals
		do
			locs := locals
			if locs /= Void then
				if {lst: EIFFEL_LIST [TYPE_DEC_AS]} routine.locals then
					Result := locs.i_th (lst.count + i)
				end
			end
		end

	locals: LIST [ABSTRACT_DEBUG_VALUE] is
			-- Value of local variables
		local
			l_locals: EIFFEL_LIST [TYPE_DEC_AS]
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

	arguments: LIST [ABSTRACT_DEBUG_VALUE] is
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

	argument (pos: INTEGER): ABSTRACT_DEBUG_VALUE is
			-- Argument at position `pos'
		do
			if {args: like arguments} arguments then
				if args.valid_index (pos) then
					Result := args.i_th (pos)
				end
			end
		end

feature -- Stack reset

	reset_stack is
			-- Reset stack data (locals, arguments, result, ..)
		do
			initialized := False
			private_arguments := Void
			private_locals := Void
			private_result := Void
		ensure
			not_initialized: not initialized
		end

feature {NONE} -- Implementation

	initialize_stack is
			-- Initialize stack data (locals, arguments, result, ..)
		require
			not_initialized: not initialized
		deferred
		ensure
			initialized: initialized
		end

	local_decl_grps_from (feat: E_FEATURE): EIFFEL_LIST [TYPE_DEC_AS] is
			-- Locals declaration groups for `feat'.
		do
			Result := feat.locals
		end

	object_test_locals_from (feat: E_FEATURE): LIST [TUPLE [id: ID_AS; type: TYPE_AS]] is
			-- Locals declaration groups for `feat'.
		do
			Result := feat.object_test_locals
		end

feature {NONE} -- Implementation Properties

	private_locals: ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]
			-- Associated locals

	private_arguments: FIXED_LIST [ABSTRACT_DEBUG_VALUE]
			-- Associated arguments

	private_result: like result_value
			-- Associated result

	initialized: BOOLEAN
			-- Is the stack initialized

	private_body_index: like body_index
			-- Associated body index

feature {NONE} -- Implementation helper

	error_value (a_name, a_mesg: STRING): DUMMY_MESSAGE_DEBUG_VALUE is
		do
			create Result.make_with_name (a_name)
			Result.set_message (a_mesg)
		end

invariant
--
--	non_empty_args_if_exists: private_arguments /= Void implies
--				not private_arguments.is_empty
--	non_empty_locs_if_exists: private_locals /= Void implies
--				not private_locals.is_empty
--	valid_level: level_in_stack >= 1

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

end -- class EIFFEL_CALL_STACK_ELEMENT
