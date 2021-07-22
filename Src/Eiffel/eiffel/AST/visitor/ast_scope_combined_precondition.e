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
			add_readonly_scope,
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
			-- Analyze combined precondition of feature `f' and record attached arguments and attributes in `c'.
		require
			f_attached: f /= Void
			c_attached: c /= Void
		local
			n: INTEGER_32
			m: INTEGER_32
			assert_id_set: ASSERT_ID_SET
			assertion_info: INH_ASSERT_INFO
			body_index: INTEGER
			precursor_feature: FEATURE_AS
			i: INTEGER
			k: AST_INITIALIZATION_KEEPER
		do
			make_assertion (c)
			n := f.argument_count
			if c.has_stable_attributes then
				m := c.attributes.count
			end
			if n /= 0 or else m /= 0 then
					-- There are arguments ot stable attributes.
				assert_id_set := f.assert_id_set
				if assert_id_set /= Void and then assert_id_set.has_precondition then
					create arguments.make (n)
					if m > 0 then
						create attributes.make (m)
						k := attributes.keeper
					end
					arguments.keeper.enter_realm
					if k /= Void then
						k.enter_realm
					end
					from
						i := assert_id_set.count
					until
						i <= 0
					loop
						assertion_info := assert_id_set.item (i)
						check assertion_info_attached: assertion_info /= Void end
						if assertion_info.has_precondition then
							body_index := assertion_info.body_index
							written_class := assertion_info.written_class
							precursor_feature := body_server.item (written_class.class_id, body_index)
							check
								precursor_feature_attached: precursor_feature /= Void
							end
							argument_list := precursor_feature.body.arguments
							if attached {ROUTINE_AS} precursor_feature.body.content as routine_body then
								routine_body.precondition.process (Current)
							else
								check has_routine_body: False end
							end
							arguments.keeper.save_sibling
							if k /= Void then
								k.save_sibling
							end
						end
						i := i - 1
					end
					if f.has_precondition then
							-- Process current feature assertion.
						written_class := f.written_class
						precursor_feature := f.body
						check
							precursor_feature_attached: precursor_feature /= Void
						end
						argument_list := precursor_feature.body.arguments
						if attached {ROUTINE_AS} precursor_feature.body.content as routine_body then
							routine_body.precondition.process (Current)
						else
							check has_routine_body: False end
						end
						arguments.keeper.save_sibling
						if k /= Void then
							k.save_sibling
						end
					end
					arguments.keeper.leave_realm
					from
						i := n
					until
						i <= 0
					loop
						if arguments.keeper.is_attached (i) then
							c.add_readonly_instruction_scope (f.arguments.argument_names [i - 1])
						end
						i := i - 1
					end
					if k /= Void then
						k.leave_realm
						from
							i := m
						until
							i <= 0
						loop
							if k.is_set (i) then
								c.attribute_initialization.set_attribute (i)
							end
							i := i - 1
						end
					end
				end
			end
		end

feature {AST_EIFFEL} -- Visitor pattern

	process_bool_as (a: BOOL_AS)
			-- <Precursor>
		local
			i: INTEGER_32
			f: FEATURE_I
		do
			if (is_negated = is_negation_expected) /= a.value then
					-- The complete assertion is constant False, so all variables can be considered attached.
				from
					i := arguments.argument_count
				until
					i <= 0
				loop
					arguments.start_argument_scope (i)
					i := i - 1
				end
				if attached attributes as s then
					from
						context.attributes.start
					until
						context.attributes.after
					loop
						f := current_class.feature_of_feature_id (context.attributes.key_for_iteration)
						if f.is_attribute and then f.is_stable then
							s.set_attribute (context.attributes.item_for_iteration)
						end
						context.attributes.forth
					end
				end
			end
		end

	process_require_as (a: REQUIRE_AS)
			-- <Precursor>
		do
			process_eiffel_list (a.assertions)
		end

	process_require_else_as (a: REQUIRE_ELSE_AS)
			-- <Precursor>
		do
			process_eiffel_list (a.assertions)
		end

feature {NONE} -- Context

	current_class: CLASS_C
			-- Class for which the precondition is evaluated.
		do
			Result := context.current_class
		end

	written_class: CLASS_C
			-- Class where the code being processed is written.

	argument_list: EIFFEL_LIST [TYPE_DEC_AS]
			-- List of current arguments.

	arguments: AST_ARGUMENT_SCOPE_TRACKER
			-- Attached due to CAPs arguments indexed by their position.

	attributes: AST_ATTRIBUTE_INITIALIZATION_TRACKER
			-- Initialized due to CAPs attributes indexed by their position in the skeleton of the original class.

	add_access_scope (a: ACCESS_INV_AS)
			-- Add scope for `a' if this is a recognized variable.
		local
			f: FEATURE_I
		do
			if a.is_argument then
					-- The entity is known to be an argument
				arguments.start_argument_scope (a.argument_position)
			elseif a.is_feature and then not a.is_qualified then
					-- Look for a feature with the given name.
				if attached attributes as s then
					f := written_class.feature_of_name_id (a.feature_name.name_id)
					if f /= Void then
							-- This is indeed a feature rather than a local or an argument.
						if written_class /= current_class then
								-- Find feature in the current class if it is different from the written class.
							f := current_class.feature_of_rout_id (f.rout_id_set.first)
						end
						if f.is_attribute and then f.is_stable then
							s.set_attribute (context.attributes.item (f.feature_id))
						end
					end
				end
				if f = Void then
						-- It can still be an argument if not processed yet.
					add_readonly_scope (a.feature_name.name_id)
				end
			end
		end

	add_readonly_scope (id: INTEGER_32)
			-- Add scope of a non-void argument.
		local
			l: IDENTIFIER_LIST
			i: INTEGER
			j: INTEGER
			position: INTEGER_32
		do
			if attached argument_list as a then
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
		end

	add_local_scope (id: INTEGER_32)
			-- Add scope of a non-void local.
		do
				-- Do not record scope.
		end

	add_object_test_scope (id: ID_AS)
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
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
