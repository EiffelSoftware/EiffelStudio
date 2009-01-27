note
	description: "Detector of argument scopes for combined precondition."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_SCOPE_COMBINED_PRECONDITION

inherit
	AST_SCOPE_ASSERTION
		rename
			make as make_assertion
		redefine
			add_access_scope,
			add_argument_scope,
			add_local_scope,
			add_object_test_scope,
			add_result_scope,
			process_bool_as,
			process_require_as,
			process_require_else_as
		end

	SHARED_SERVER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Creation

	make (f: FEATURE_I; c: AST_CONTEXT)
			-- Analyze combined precondition of feature `f' and record attached arguments in `c'.
		require
			f_attached: f /= Void
			c_attached: c /= Void
		local
			n: INTEGER_32
			assert_id_set: ASSERT_ID_SET
			assertion_info: INH_ASSERT_INFO
			body_index: INTEGER
			precursor_feature: FEATURE_AS
			routine_body: ROUTINE_AS
			i: INTEGER
		do
			n := f.argument_count
			if n = 0 then
					-- Nothing to do as there are no arguments.
			else
				assert_id_set := f.assert_id_set
				if assert_id_set /= Void and then assert_id_set.has_precondition then
					create arguments.make (n)
					arguments.keeper.enter_realm
					from
						i := assert_id_set.count
					until
						i <= 0
					loop
						assertion_info := assert_id_set.item (i)
						check assertion_info_attached: assertion_info /= Void end
						if assertion_info.has_precondition then
							body_index := assertion_info.body_index
							precursor_feature := body_server.item (body_index)
							check
								precursor_feature_attached: precursor_feature /= Void
							end
							argument_list := precursor_feature.body.arguments
							check
								argument_list_attached: argument_list /= Void
							end
							routine_body ?= precursor_feature.body.content
							check routine_body_attached: routine_body /= Void end
							routine_body.precondition.process (Current)
							arguments.keeper.save_sibling
						end
						i := i - 1
					end
					if f.has_precondition then
							-- Process current feature assertion
						precursor_feature := body_server.item (f.body_index)
						check
							precursor_feature_attached: precursor_feature /= Void
						end
						argument_list := precursor_feature.body.arguments
						check
							argument_list_attached: argument_list /= Void
						end
						routine_body ?= precursor_feature.body.content
						check routine_body_attached: routine_body /= Void end
						routine_body.precondition.process (Current)
						arguments.keeper.save_sibling
					end
					arguments.keeper.leave_realm
					from
						i := n
					until
						i <= 0
					loop
						if arguments.keeper.is_attached (i) then
							c.add_argument_instruction_scope (f.arguments.argument_names.item (i - 1))
						end
						i := i - 1
					end
				end
			end
		end

feature {AST_EIFFEL} -- Visitor pattern

	process_bool_as (a: BOOL_AS)
		local
			i: INTEGER_32
		do
			if (is_negated = is_negation_expected) /= a.value then
					-- The complete assertion is constant False, so all arguments can be considered attached.
				from
					i := arguments.argument_count
				until
					i <= 0
				loop
					arguments.start_argument_scope (i)
					i := i - 1
				end
			end
		end

	process_require_as (a: REQUIRE_AS)
		do
			process_eiffel_list (a.assertions)
		end

	process_require_else_as (a: REQUIRE_ELSE_AS)
		do
			process_eiffel_list (a.assertions)
		end

feature {NONE} -- Context

	argument_list: EIFFEL_LIST [TYPE_DEC_AS]
			-- List of current arguments

	arguments: AST_ARGUMENT_SCOPE_TRACKER
			-- Attached due to CAPs arguments indexed by their position

	add_access_scope (a: ACCESS_INV_AS)
			-- Add scope for `a' if this is a recognized variable.
		do
			if a.is_argument then
					-- The entity is known to be an argument
				arguments.start_argument_scope (a.argument_position)
			elseif not a.is_local then
					-- It can still be an argument if not processed yet.
				add_argument_scope (a.feature_name.name_id)
			end
		end

	add_argument_scope (id: INTEGER_32)
			-- Add scope of a non-void argument.
		local
			a: like argument_list
			l: IDENTIFIER_LIST
			i: INTEGER
			j: INTEGER
			position: INTEGER_32
		do
			a := argument_list
			check a /= Void end
			from
				i := 1
			until
				i > a.count
			loop
				from
					l := a.i_th (i).id_list
					j := 1
				until
					j > l.count
				loop
					position := position + 1
					if l.i_th (j) = id then
							-- Argument is found.
						arguments.start_argument_scope (position)
							-- Exit loop.
						j := l.count
						i := a.count
					end
					j := j + 1
				end
				i := i + 1
			end
		end

	add_local_scope (id: INTEGER_32)
			-- Add scope of a non-void local.
		do
				-- Do not record scope.
		end

	add_object_test_scope (id: INTEGER_32)
			-- Add scope of an object test.
		do
				-- Do not record scope.
		end

	add_result_scope
			-- Add scope of a non-void Result.
		do
				-- Do not record scope.
		end

note
	copyright:	"Copyright (c) 2009, Eiffel Software"
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
