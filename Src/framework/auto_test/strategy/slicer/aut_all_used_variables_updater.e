note
	description: "Processor that keeps track of all variables used in a minimized slice"
	copyright: "Copyright (c) 2008, Ilinca Ciupa and others"
	license: "Eiffel Forum License v2 (see forum.txt)"

class AUT_ALL_USED_VARIABLES_UPDATER

inherit

	AUT_REQUEST_PROCESSOR

	REFACTORING_HELPER

	AUT_SHARED_TYPE_FORMATTER

	AUT_SHARED_TYPE_FORMATTER

	AUT_SHARED_INTERPRETER_INFO

create

	make

feature {NONE} -- Initialization

	make (a_system: like system)
			-- Initialize.
		require
			a_system_attached: a_system /= Void
		do
			system := a_system
			create variables.make_default
			variables.set_key_equality_tester (create {AUT_VARIABLE_EQUALITY_TESTER}.make)
		end

feature -- Access

	variables: DS_HASH_TABLE [TUPLE [type: detachable TYPE_A; name: detachable STRING; check_dyn_type: BOOLEAN; use_void: BOOLEAN], ITP_VARIABLE]
			-- Set of used variables: keys are variables, items are tuples of static type of variable
			-- and a boolean flag showing if the static type should be checked against dynamic type
			-- (is only the case for variables returned as results of function calls and those whose type
			-- is left Void)
			-- If `use_void' is True, in the use site, the variable will be replaced by Void. This is OK because
			-- `use_void' is only True if the variable is detached in that use site.

	system: SYSTEM_I
			-- System

feature{AUT_REQUEST} -- Processing

	process_start_request (a_request: AUT_START_REQUEST)
		do
			variables.wipe_out
		end

	process_stop_request (a_request: AUT_STOP_REQUEST)
		do
			-- Do nothing.
		end

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST)
		local
			l_type: TYPE_A
			l_name: STRING
		do
			if not variables.has (a_request.target) then
				l_type := a_request.target_type
				l_name := type_name_with_context (l_type, interpreter_root_class, Void)
				variables.force ([l_type, l_name, False, False], a_request.target.deep_twin)
			end
			if a_request.argument_list /= Void then
				process_argument_list (a_request.argument_list)
			end
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST)
		local
			l_type: TYPE_A
			l_name: STRING
		do
			if a_request.receiver /= Void and then not variables.has (a_request.receiver) then
				l_type := a_request.feature_to_call.type.actual_type.instantiation_in (a_request.target_type, a_request.feature_to_call.written_in)
				l_name := type_name_with_context (l_type, interpreter_root_class, Void)
				variables.force ([l_type, l_name, True, False], a_request.receiver.deep_twin)
			end
			l_type := a_request.target_type
			l_name := type_name_with_context (l_type, interpreter_root_class, Void)
			variables.force ([l_type, l_name, False, False], a_request.target.deep_twin)
			process_argument_list (a_request.argument_list)
		end

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST)
		local
			l_rec: TUPLE [type: TYPE_A; name: STRING; a_check: BOOLEAN; a_use_void: BOOLEAN]
		do
			if not variables.has (a_request.receiver) then
				l_rec := [Void, Void, True, False]
				variables.force (l_rec, a_request.receiver.deep_twin)
			else
				l_rec := variables.item (a_request.receiver)
			end
			if attached {ITP_VARIABLE} a_request.expression as l_var then
				variables.force ([Void, Void, True, False], l_var.deep_twin)

					-- TODO: this is a workaround for variables containing `default_pointer', where the
					--       interpreter wrongly reports them to be Void
			elseif attached {ITP_CONSTANT} a_request.expression as l_const and then l_rec.name = Void then
				if attached {POINTER} l_const.value as l_pointer and then l_pointer = default_pointer then
					l_rec.name := "POINTER"
				end
			end
		end

	process_type_request (a_request: AUT_TYPE_REQUEST)
		local
			norm_response: AUT_NORMAL_RESPONSE
			l_name: STRING
			l_rec: TUPLE [type: TYPE_A; name: STRING; a_check: BOOLEAN]
		do
			-- Do nothing.
			if variables.has (a_request.variable) then
				l_rec := variables.item (a_request.variable)
				norm_response ?= a_request.response
				if norm_response /= Void then
					l_name := norm_response.text.twin
					l_name.right_adjust
					l_name.left_adjust

						-- TODO: following if-statement can be removed once pointer issue is fixed (see
						--       `process_assign_expression_request'. Currently interpreter returns NONE for objects
						--       representing a pointer.
					if not l_name.is_equal ("NONE") or l_rec.name = Void then
						variables.force ([Void, l_name, False, False], a_request.variable)
					end
				end
			end
		end

	process_argument_list (an_argument_list: DS_LINEAR [ITP_EXPRESSION])
			-- Add variables in `an_argument_list' to `variables'.
		require
			an_argument_list_not_void: an_argument_list /= Void
			no_argument_void: not an_argument_list.has (Void)
		local
			cs: DS_LINEAR_CURSOR [ITP_EXPRESSION]
			variable: ITP_VARIABLE
		do
			from
				cs := an_argument_list.new_cursor
				cs.start
			until
				cs.off
			loop
				variable ?= cs.item
				if variable /= Void and then not variables.has (variable) then
					variables.force ([Void, Void, True, False], variable.deep_twin)
				end
				cs.forth
			end
		end

invariant

	variables_not_void: variables /= Void
	no_variable_void: not variables.has (Void)

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
