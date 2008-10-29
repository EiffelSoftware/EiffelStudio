indexing
	description: "Validator of creation procedures that ensures they set all the attributes as required."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_CREATION_PROCEDURE_CHECKER

inherit
	AST_ITERATOR
		redefine
			process_access_assert_as,
			process_access_id_as,
			process_access_inv_as,
			process_assign_as,
			process_case_as,
			process_creation_as,
			process_creation_expr_as,
			process_current_as,
			process_debug_as,
			process_eiffel_list,
			process_elseif_as,
			process_if_as,
			process_inspect_as,
			process_like_cur_as,
			process_loop_as,
			process_nested_expr_as,
			process_nested_as,
			process_precursor_as
		end

	SHARED_ERROR_HANDLER
		export {NONE}
			all
		end

	SHARED_SERVER
		export {NONE}
			all
		end

	SHARED_WORKBENCH
		export {NONE}
			all
		end

create
	make

feature {NONE} -- Creation

	make (f: FEATURE_I; c: AST_CONTEXT)
			-- Create a new validator for creation procedure `f' and check it.
		require
			f_attached: f /= Void
			c_attached: c /= Void
		do
			creation_procedure := f
			context := c
			create {ARRAYED_STACK [INTEGER_32]} bodies.make (1)
			variables.start_creation_procedure
			variables.enter_compound
			process (f)
			check_attributes (f.body.last_token (Void))
			variables.leave_compound
		end

feature {NONE} -- Processing

	process (f: FEATURE_I)
			-- Process AST of the feature `f'.
		require
			f_attached: f /= Void
			f_not_processed: not bodies.has (f.body_index)
		local
			g: FEATURE_I
			s: ASSERT_ID_SET
			a: INH_ASSERT_INFO
			p: FEATURE_AS
			b: ROUTINE_AS
			i: INTEGER
			q: BOOLEAN
		do
			g := context.current_feature
			q := is_qualified
			is_qualified := False
			context.set_current_feature (f)
				-- Put body index to stack to avoid recursion
			bodies.put (f.body_index)
				-- Process preconditions
			s := f.assert_id_set
			if s /= Void then
				from
					i := s.count
				until
					i <= 0
				loop
					a := s.item (i)
					check a_attached: a /= Void end
					if a.has_precondition then
						p := body_server.item (a.body_index)
						check
							p_attached: p /= Void
						end
						b ?= p.body.content
						check b_attached: b /= Void end
						context.set_written_class (system.class_of_id (a.written_in))
						b.precondition.process (Current)
					end
					i := i - 1
				end
			end
				-- Process routine body
			context.set_written_class (f.written_class)
			f.body.process (Current)
				-- Process postcondition
			if s /= Void then
				from
					i := s.count
				until
					i <= 0
				loop
					a := s.item (i)
					check a_attached: a /= Void end
					if a.has_postcondition then
						p := body_server.item (a.body_index)
						check
							p_attached: p /= Void
						end
						b ?= p.body.content
						check b_attached: b /= Void end
						context.set_written_class (system.class_of_id (a.written_in))
						b.postcondition.process (Current)
					end
					i := i - 1
				end
			end
				-- Remove body index
			bodies.remove
			is_qualified := q
			context.set_current_feature (g)
			context.set_written_class (g.written_class)
		end

	check_attributes (l: LOCATION_AS)
			-- Verify that all attributes are properly initialized at location `l'.
		require
			l_attached: l /= Void
		local
			s: GENERIC_SKELETON
		do
			from
				s := current_class.skeleton
				s.start
			until
				s.after
			loop
				check_attribute (current_class.feature_of_feature_id (s.item_for_iteration.feature_id), l)
				s.forth
			end
		end

	check_attribute (f: FEATURE_I; l: LOCATION_AS)
			-- Verify that the attribute `f' is initialized if required at location `l'
			-- including recursive check of self-initializing attribute body and
			-- report error if the attribute is not set and is not self-initializing.
		require
			f_attached: f /= Void
			l_attached: l /= Void
		do
			if f.type.is_initialization_required and then not variables.is_attribute_set (f.feature_id) then
				if {d: ATTRIBUTE_I} f and then d.has_body then
						-- Attribute is self-initializing.
					process (f)
				else
						-- Attribute is not properly initialized.
					error_handler.insert_error (create {VEVI}.make_attribute (f, current_class.class_id, creation_procedure, context, l))
				end
					-- Mark that the attribute is initialized because it is self-initializing
					-- or just to avoid repeated errors.
				variables.set_attribute (f.feature_id)
			end
		end

feature {AST_EIFFEL} -- Visitor: access to features

	process_access_assert_as (a: ACCESS_ASSERT_AS)
		do
			process_access_inv_as (a)
		end

	process_access_id_as (a: ACCESS_ID_AS)
		do
			process_access_inv_as (a)
		end

	process_access_inv_as (a: ACCESS_INV_AS)
		local
			f: FEATURE_I
		do
			if not is_qualified then
				f := written_class.feature_of_name_id (a.feature_name.name_id)
				if f /= Void then
						-- This is indeed a feature rather than a local or an argument.
						-- Find it in the current class.
					if current_class /= written_class then
						f := current_class.feature_of_rout_id (f.rout_id_set.first)
					end
					if not bodies.has (f.body_index) then
							-- This feature has not been processed yet.
						if f.is_routine then
							process (f)
						elseif f.is_attribute then
							if is_attachment then
								variables.set_attribute (f.feature_id)
							else
								check_attribute (f, a.feature_name)
							end
						end
					end
				end
			end
			safe_process (a.internal_parameters)
		end

	process_precursor_as (a: PRECURSOR_AS)
		local
			c: CLASS_C
			f: FEATURE_I
			i: CLASS_I
			j: INTEGER_32
			k: INTEGER_32
			n: STRING
			p: LIST [CLASS_C]
			r: ROUT_ID_SET
			rc: INTEGER_32
			t: CLASS_TYPE_AS
		do
			t := a.parent_base_class
			if t /= Void then
				i := Universe.class_named (t.class_name.name, context.current_class.group)
				if i /= Void then
					n := i.name
				else
					-- A class of name `t.class_name.name' does not exist in the universe.
					-- The error is reported elsewhere, use empty name, so that the loop
					-- below does not find any matching parent.
					n := ""
				end
			end
			r := context.current_feature.rout_id_set
			rc := r.count
			from
				p := current_class.parents_classes
				k := p.count
			until
				k <= 0
			loop
				c := p [k]
				if n = Void or else c.name.is_equal (n) then
						-- Check if parent has an effective precursor.
					from
						j := 1
					until
						j > rc
					loop
						f := c.feature_of_rout_id (r.item (j))
						if f /= Void and then not f.is_deferred then
							process (f)
						end
						j := j + 1
					variant
						rc - j + 1
					end
				end
				k := k - 1
			variant
				k
			end
		end

feature {AST_EIFFEL} -- Visitor: Current

	process_current_as (a: CURRENT_AS)
		do
				-- All attributes have to be set before `Current' can be used.
			check_attributes (a)
		end

	process_like_cur_as (a: LIKE_CUR_AS)
		do
				-- `Current' used as an anchor is safe.
		end

feature {AST_EIFFEL} -- Visitor: reattachment

	process_assign_as (a: ASSIGN_AS)
		do
			a.source.process (Current)
			is_attachment := True
			a.target.process (Current)
			is_attachment := False
		end

	process_creation_as (a: CREATION_AS)
		local
			q: BOOLEAN
		do
			q := is_qualified
			is_qualified := True
			safe_process (a.call)
			is_qualified := q
			is_attachment := True
			a.target.process (Current)
			is_attachment := False
		end

feature {AST_EIFFEL} -- Visitor: compound

	process_compound (c: EIFFEL_LIST [INSTRUCTION_AS])
		do
			if c /= Void then
				variables.enter_compound
				c.process (Current)
				variables.leave_compound
			end
		end

	process_case_as (a: CASE_AS) is
		do
			a.interval.process (Current)
			process_compound (a.compound)
		end

	process_debug_as (a: DEBUG_AS)
		do
			process_compound (a.compound)
		end

	process_elseif_as (a: ELSIF_AS)
		do
			a.expr.process (Current)
			process_compound (a.compound)
		end

	process_if_as (a: IF_AS)
		do
			a.condition.process (Current)
			process_compound (a.compound)
			safe_process (a.elsif_list)
			process_compound (a.else_part)
		end

	process_inspect_as (a: INSPECT_AS)
		do
			a.switch.process (Current)
			safe_process (a.case_list)
			process_compound (a.else_part)
		end

	process_loop_as (a: LOOP_AS)
		do
			safe_process (a.from_part)
			safe_process (a.invariant_part)
			a.stop.process (Current)
			process_compound (a.compound)
			safe_process (a.variant_part)
		end

feature {AST_EIFFEL} -- Nested call

	process_creation_expr_as (a: CREATION_EXPR_AS)
		local
			q: BOOLEAN
		do
			q := is_qualified
			is_qualified := True
			Precursor (a)
			is_qualified := q
		end

	process_nested_expr_as (a: NESTED_EXPR_AS)
		local
			q: BOOLEAN
		do
			q := is_qualified
			a.target.process (Current)
			is_qualified := True
			a.message.process (Current)
			is_qualified := q
		end

	process_nested_as (a: NESTED_AS)
		local
			q: BOOLEAN
		do
			q := is_qualified
			a.target.process (Current)
			is_qualified := True
			a.message.process (Current)
			is_qualified := q
		end

	process_eiffel_list (a: EIFFEL_LIST [AST_EIFFEL])
		local
			q: BOOLEAN
		do
			q := is_qualified
			is_qualified := False
			Precursor (a)
			is_qualified := q
		end

feature {NONE} -- Status report

	is_attachment: BOOLEAN
			-- Is attachment being performed?

	is_qualified: BOOLEAN
			-- Is qualified call being performed?

feature {NONE} -- Access

	context: AST_CONTEXT
			-- Associated context

	current_class: CLASS_C
			-- Class for which the validation is performed
		do
			Result := context.current_class
		end

	creation_procedure: FEATURE_I
			-- Creation procedure that is being checked

	written_class: CLASS_C
			-- Class where the code is written
		do
			Result := context.written_class
		end

	variables: AST_VARIABLE_CONTEXT
			-- Storage to track variables usage
		do
			Result := context.variables
		end

	bodies: STACK [INTEGER_32];
			-- Bodies that are being processed

indexing
	copyright:	"Copyright (c) 2008, Eiffel Software"
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
