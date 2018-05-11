note
	description: "Abstract description of the content of a standard feature"
	ca_ignore: "CA011", "CA011 — too many arguments"

class ROUTINE_AS

inherit
	CONTENT_AS
		redefine
			is_require_else, is_ensure_then,
			has_rescue, has_precondition, has_postcondition,
			create_default_rescue, is_empty
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (o: like obsolete_message; pr: like precondition;
		l: like internal_locals; b: like routine_body; po: like postcondition;
		r: like rescue_clause; ek: like end_keyword;
		oms_count: like once_manifest_string_count; a_pos: like body_start_position; k_as, r_as: like obsolete_keyword;
		ot_locals: like object_test_locals;
		n, a, u: BOOLEAN)
			-- Create a new ROUTINE AST node.
			-- Arguments:
			-- 	• `n`	Does routine has a non-object call?
			-- 	• `a`	Do routine precondition or postcondition have a non-object call?
			-- 	• `u`	Do routine precondition or postcondition have an unqualified call?
		require
			b_not_void: b /= Void
			ek_not_void: ek /= Void
			valid_oms_count: oms_count >= 0
			a_pos_positive: a_pos > 0
		do
			obsolete_message := o
			precondition := pr
			internal_locals := l
			routine_body := b
			postcondition := po
			rescue_clause := r
			end_keyword := ek
			once_manifest_string_count := oms_count
			body_start_position := a_pos
			if k_as /= Void then
				obsolete_keyword_index := k_as.index
			end
			if r_as /= Void then
				rescue_keyword_index := r_as.index
			end
			object_test_locals := ot_locals
			has_non_object_call := n
			has_non_object_call_in_assertion := a
			has_unqualified_call_in_assertion := u
		ensure
			obsolete_message_set: obsolete_message = o
			precondition_set: precondition = pr
			internal_locals_set: internal_locals = l
			routine_body_set: routine_body = b
			postcondition_set: postcondition = po
			rescue_clause_set: rescue_clause = r
			end_keyword_set: end_keyword = ek
			once_manifest_string_count_set: once_manifest_string_count = oms_count
			body_start_position_set: body_start_position = a_pos
			obsolete_keyword_set: k_as /= Void implies obsolete_keyword_index = k_as.index
			rescue_keyword_set: r_as /= Void implies rescue_keyword_index = r_as.index
			object_test_locals_set: object_test_locals = ot_locals
			has_non_object_call_set: has_non_object_call = n
			has_non_object_call_in_assertion_set: has_non_object_call_in_assertion = a
			has_unqualified_call_in_assertion_set: has_unqualified_call_in_assertion = u
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_routine_as (Current)
		end

feature -- Roundtrip

	obsolete_keyword_index, rescue_keyword_index: INTEGER
			-- Index of keyword "obsolete" and "rescue" associated with this class

	obsolete_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "obsolete" associated with this class
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := obsolete_keyword_index
			if a_list.valid_index (i) and then attached {like obsolete_keyword} a_list.i_th (i) as l_keyword then
				Result := l_keyword
			end
		end

	rescue_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "rescue" associated with this class
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := rescue_keyword_index
			if a_list.valid_index (i) and then attached {like rescue_keyword} a_list.i_th (i) as l_keyword then
				Result := l_keyword
			end
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := routine_body.index
		end

	internal_locals: detachable LOCAL_DEC_LIST_AS
			-- Local declarations, in which keyword "local" is stored

feature -- Attributes

	obsolete_message: detachable STRING_AS
			-- Obsolete clause message
			-- (Void if was not present)

	precondition: detachable REQUIRE_AS
			-- Precondition list

	locals: detachable EIFFEL_LIST [LIST_DEC_AS]
			-- Local declarations
		do
			if
				attached internal_locals as l_internal_locals and then
				attached l_internal_locals.locals as l_locals
			then
				Result := l_locals
			else
				Result := Void
			end
		end

	routine_body: ROUT_BODY_AS
			-- Routine body

	postcondition: detachable ENSURE_AS
			-- Routine postconditions

	rescue_clause: detachable EIFFEL_LIST [INSTRUCTION_AS]
			-- Rescue compound

	once_manifest_string_count: INTEGER
			-- Number of once manifest strings in precondition,
			-- body, postcondition and rescue clause

	end_keyword: detachable KEYWORD_AS
			-- Location for `end' keyword

	object_test_locals: detachable ARRAYED_LIST [TUPLE [name: ID_AS; type: TYPE_AS]]
			-- Object test locals mentioned in the routine

feature -- Location

	body_start_position: INTEGER
			-- Position at the start of the main body (after the comments and obsolete clause)

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and obsolete_keyword_index /= 0 then
				Result := obsolete_keyword (a_list)
			elseif attached obsolete_message as l_message then
				Result := l_message.first_token (a_list)
			elseif attached precondition as l_prec then
				Result := l_prec.first_token (a_list)
			elseif attached internal_locals as l_locals then
				Result := l_locals.first_token (a_list)
			end
			if Result = Void or else Result.is_null then
				Result := routine_body.first_token (a_list)
				if Result = Void or else Result.is_null then
					if attached postcondition as l_post then
						Result := l_post.first_token (a_list)
					elseif a_list /= Void and rescue_keyword_index /= 0 then
						Result := rescue_keyword (a_list)
					elseif attached rescue_clause as l_rescue then
						Result := l_rescue.first_token (a_list)
					elseif attached end_keyword as l_keyword then
						Result := l_keyword.first_token (a_list)
					end
				end
			end
		end

	last_token (a_list:detachable  LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached end_keyword as l_keyword then
				Result := l_keyword.last_token (a_list)
			end
		end

feature -- Status report

	is_require_else: BOOLEAN
			-- Is the precondition block of the content preceded by
			-- `require else' ?
			--|Note: It is valid to not include a precondition in
			--|a redefined feature (it is equivalent to "require else False")
		do
			Result := not attached precondition as l_prec or else l_prec.is_else
		end

	is_ensure_then: BOOLEAN
			-- Is the postcondition block of the content preceded by
			-- `ensure then' ?
			--|Note: It is valid to not include a postcondition in
			--|a redefined feature (it is equivalent to "ensure then True"
		do
			Result := not attached postcondition as l_post or else l_post.is_then
		end

	has_precondition: BOOLEAN
			-- Has the routine content a preconditions ?
		do
			Result := not (not attached precondition as l_prec or else
							not attached l_prec.assertions as l_assertions or else
							l_assertions.count = 1 and then
							attached {BOOL_AS} l_assertions.first.expr as b and then
							b.value /= l_prec.is_else)
		end

	has_postcondition: BOOLEAN
			-- Has the routine content postconditions ?
		do
			Result := attached postcondition as l_post and then l_post.assertions /= Void
		end

	has_false_postcondition: BOOLEAN
			-- Does postcondition evaluate to false?
		do
				-- Check if there are assertion clauses of the form "[tag:] false".
			if attached postcondition as p and then attached p.assertions as a and then a.count > 0 then
				Result := a.there_exists (
					agent (c: TAGGED_AS): BOOLEAN
						do
							Result := attached {BOOL_AS} c.expr as b and then not b.value
						end
				)
			end
		end

	has_rescue: BOOLEAN
			-- Has the routine a non-empty rescue clause ?
		do
			Result := attached rescue_clause as l_rescue and then not l_rescue.is_empty
		end

	is_attribute: BOOLEAN
			-- Is it an attribute?
		do
			Result := routine_body.is_attribute
		end

	is_deferred: BOOLEAN
			-- Is the routine body a deferred one ?
		do
			Result := routine_body.is_deferred
		end

	is_once: BOOLEAN
			-- Is the routine body a once one ?
		do
			Result := routine_body.is_once
		end

	is_external: BOOLEAN
			-- Is the routine body an external one ?
		do
			Result := routine_body.is_external
		end

	is_built_in: BOOLEAN
			-- Is the routine body a built_in one?
		do
			Result := routine_body.is_built_in
		end

	has_class_postcondition: BOOLEAN
			-- Is there a class postcondition?
		do
			Result := attached postcondition as p and then p.is_class
		end

	has_non_object_call: BOOLEAN
			-- Is there a non-object call in the routine?

	has_non_object_call_in_assertion: BOOLEAN
			-- Is there a non-object call in the routine precondition or postcondition?

	has_unqualified_call_in_assertion: BOOLEAN
			-- Is there an unqualified object call in the routine precondition or postcondition?

feature -- Access

	number_of_breakpoint_slots: INTEGER
			-- Number of stop points for AST (inherited pre/postconditions
			-- are taken into account)

	has_instruction (i: INSTRUCTION_AS): BOOLEAN
			-- Does this routine has instruction `i'?
		do
			Result := routine_body.has_instruction (i)
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER
			-- Index of `i' in this routine.
		do
			Result := routine_body.index_of_instruction (i)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := is_body_equiv (other) and is_assertion_equiv (other)
		end

	is_body_equiv (other: like Current): BOOLEAN
			-- Is the current feature equivalent to `other' ?
		do
			Result := equivalent (routine_body, other.routine_body) and then
				equivalent (locals, other.locals) and then
				equivalent (rescue_clause, other.rescue_clause) and then
				equivalent (obsolete_message, other.obsolete_message)
		end

	is_assertion_equiv (other: like Current): BOOLEAN
			-- Is the current feature equivalent to `other' ?
		require else
			valid_other: other /= Void
		do
			Result := equivalent (precondition, other.precondition) and then
				equivalent (postcondition, other.postcondition)
		end

feature -- test for empty body

	is_empty : BOOLEAN
		do
			Result := attached routine_body as b implies b.is_empty
		end

feature {COMPILER_EXPORTER} -- Element Change

	set_locals (a_locals: like internal_locals)
			-- Set locals with `a_locals'.
		do
			internal_locals := a_locals
		end

	set_rescue_clause (a_rescue_clause: like rescue_clause)
			-- Set rescue_clause with `a_rescue_clause'.
		do
			rescue_clause := a_rescue_clause
		end

	set_routine_body (a_routine_body: like routine_body)
			-- Set routine_body with `a_routine_body'.
		do
			routine_body := a_routine_body
		end

feature {AST_FEATURE_CHECKER_EXPORT} -- Setting

	set_number_of_breakpoint_slots (nr: INTEGER)
			-- Set `number_of_breakpoint_slots' to `nr'
		do
			number_of_breakpoint_slots := nr
		ensure
			number_of_breakpoint_slots_set: number_of_breakpoint_slots = nr
		end

feature -- default rescue

	create_default_rescue (def_resc_name_id: INTEGER)
		local
			def_resc_id: ID_AS
			l_result: like rescue_clause
		do
			if rescue_clause = Void and then
			   not (routine_body.is_deferred or routine_body.is_external) then
				create def_resc_id.initialize_from_id (def_resc_name_id)
				if attached end_keyword as l_end_keyword then
					def_resc_id.set_position (l_end_keyword.line, l_end_keyword.column,
						l_end_keyword.position, l_end_keyword.location_count,
						l_end_keyword.character_column, l_end_keyword.character_position,
						l_end_keyword.character_count)
				end
				create l_result.make (1)
				l_result.extend (create {INSTR_CALL_AS}.initialize (create {ACCESS_ID_AS}.initialize (def_resc_id, Void)))
				rescue_clause := l_result
			end
		end

invariant
	routine_body_not_void: routine_body /= Void
--	end_keyword_not_void: end_keyword /= Void

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
