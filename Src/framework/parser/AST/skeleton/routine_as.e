indexing
	description	: "Abstract description of the content of a standard %
				  %feature. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

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
		ot_locals: like object_test_locals) is
			-- Create a new ROUTINE AST node.
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
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_routine_as (Current)
		end

feature -- Roundtrip

	obsolete_keyword_index, rescue_keyword_index: INTEGER
			-- Index of keyword "obsolete" and "rescue" associated with this class

	obsolete_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keyword "obsolete" associated with this class
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := obsolete_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	rescue_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
			-- Keyword "rescue" associated with this class
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := rescue_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Roundtrip

	internal_locals: LOCAL_DEC_LIST_AS
			-- Local declarations, in which keyword "local" is stored

feature -- Attributes

	obsolete_message: STRING_AS
			-- Obsolete clause message
			-- (Void if was not present)

	precondition: REQUIRE_AS
			-- Precondition list

	locals: EIFFEL_LIST [TYPE_DEC_AS] is
			-- Local declarations
		do
			if
				internal_locals = Void or else
				internal_locals.locals = Void
		 	then
				Result := Void
			else
				Result := internal_locals.locals
			end
		end

	routine_body: ROUT_BODY_AS
			-- Routine body

	postcondition: ENSURE_AS
			-- Routine postconditions

	rescue_clause: EIFFEL_LIST [INSTRUCTION_AS]
			-- Rescue compound

	once_manifest_string_count: INTEGER
			-- Number of once manifest strings in precondition,
			-- body, postcondition and rescue clause

	end_keyword: KEYWORD_AS
			-- Location for `end' keyword

	object_test_locals: ARRAYED_LIST [TUPLE [name: ID_AS; type: TYPE_AS]]
			-- Object test locals mentioned in the routine

feature -- Location

	body_start_position: INTEGER
			-- Position at the start of the main body (after the comments and obsolete clause)

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= Void and obsolete_keyword_index /= 0 then
				Result := obsolete_keyword (a_list)
			elseif obsolete_message /= Void then
				Result := obsolete_message.first_token (a_list)
			elseif precondition /= Void then
				Result := precondition.first_token (a_list)
			elseif internal_locals /= Void then
				Result := internal_locals.first_token (a_list)
			else
				Result := routine_body.first_token (a_list)
				if Result = Void or else Result.is_null then
					if postcondition /= Void then
						Result := postcondition.first_token (a_list)
					elseif a_list /= Void and rescue_keyword_index /= 0 then
						Result := rescue_keyword (a_list)
					elseif rescue_clause /= Void then
						Result := rescue_clause.first_token (a_list)
					elseif end_keyword /= Void then
						Result := end_keyword.first_token (a_list)
					end
				end
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := end_keyword.last_token (a_list)
		end

feature -- Properties

	is_require_else: BOOLEAN is
			-- Is the precondition block of the content preceeded by
			-- `require else' ?
			--|Note: It is valid to not include a precondition in
			--|a redefined feature (it is equivalent to "require else False")
		do
			Result := precondition = Void or else precondition.is_else
		end

	is_ensure_then: BOOLEAN is
			-- Is the postcondition block of the content preceeded by
			-- `ensure then' ?
			--|Note: It is valid to not include a postcondition in
			--|a redefined feature (it is equivalent to "ensure then True"
		do
			Result := postcondition = Void or else postcondition.is_then
		end

	has_precondition: BOOLEAN is
			-- Has the routine content a preconditions ?
		do
			Result := not (	precondition = Void
							or else
							precondition.assertions = Void)
		end

	has_postcondition: BOOLEAN is
			-- Has the routine content postconditions ?
		do
			Result := not (	postcondition = Void
							or else
							postcondition.assertions = Void)
		end

	has_rescue: BOOLEAN is
			-- Has the routine a non-empty rescue clause ?
		do
			Result := (rescue_clause /= Void) and then
					  not rescue_clause.is_empty
		end

	is_deferred: BOOLEAN is
			-- Is the routine body a deferred one ?
		do
			Result := routine_body.is_deferred
		end

	is_once: BOOLEAN is
			-- Is the routine body a once one ?
		do
			Result := routine_body.is_once
		end

	is_external: BOOLEAN is
			-- Is the routine body an external one ?
		do
			Result := routine_body.is_external
		end

	is_built_in: BOOLEAN is
			-- Is the routine body a built_in one?
		do
			Result := routine_body.is_built_in
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER
			-- Number of stop points for AST (inherited pre/postconditions
			-- are taken into account)

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does this routine has instruction `i'?
		do
			Result := routine_body.has_instruction (i)
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this routine.
		do
			Result := routine_body.index_of_instruction (i)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_body_equiv (other) and is_assertion_equiv (other)
		end

	is_body_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		do
			Result := equivalent (routine_body, other.routine_body) and then
				equivalent (locals, other.locals) and then
				equivalent (rescue_clause, other.rescue_clause) and then
				equivalent (obsolete_message, other.obsolete_message)
		end

	is_assertion_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		require else
			valid_other: other /= Void
		do
			Result := equivalent (precondition, other.precondition) and then
				equivalent (postcondition, other.postcondition)
		end

feature -- test for empty body

	is_empty : BOOLEAN is
		do
			Result := (routine_body = Void) or else (routine_body.is_empty)
		end

feature {COMPILER_EXPORTER} -- Element Change

	set_locals (a_locals: like internal_locals) is
			-- Set locals with `a_locals'.
		do
			internal_locals := a_locals
		end

	set_rescue_clause (a_rescue_clause: like rescue_clause) is
			-- Set rescue_clause with `a_rescue_clause'.
		do
			rescue_clause := a_rescue_clause
		end

	set_routine_body (a_routine_body: like routine_body) is
			-- Set routine_body with `a_routine_body'.
		do
			routine_body := a_routine_body
		end

feature {AST_FEATURE_CHECKER_EXPORT} -- Setting

	set_number_of_breakpoint_slots (nr: INTEGER) is
			-- Set `number_of_breakpoint_slots' to `nr'
		do
			number_of_breakpoint_slots := nr
		ensure
			number_of_breakpoint_slots_set: number_of_breakpoint_slots = nr
		end

feature -- default rescue

	create_default_rescue (def_resc_name_id: INTEGER) is
		local
			def_resc_id   : ID_AS
			def_resc_call : ACCESS_ID_AS
			def_resc_instr: INSTR_CALL_AS
		do
			if rescue_clause = Void and then
			   not (routine_body.is_deferred or routine_body.is_external) then
				create def_resc_id.initialize_from_id (def_resc_name_id)
				def_resc_id.set_position (end_keyword.line, end_keyword.column,
					end_keyword.position, end_keyword.location_count)
				create def_resc_call.initialize (def_resc_id, Void)
				create def_resc_instr.initialize (def_resc_call)
				create rescue_clause.make (1)
				rescue_clause.extend (def_resc_instr)
			end
		end

invariant
	routine_body_not_void: routine_body /= Void
--	end_keyword_not_void: end_keyword /= Void

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

end -- class ROUTINE_AS
