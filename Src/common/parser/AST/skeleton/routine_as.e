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
			create_default_rescue, is_empty,
			number_of_precondition_slots,
			number_of_postcondition_slots,
			number_of_breakpoint_slots
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (o: like obsolete_message; pr: like precondition;
		l: like internal_locals; b: like routine_body; po: like postcondition;
		r: like rescue_clause; ek: like end_keyword;
		oms_count: like once_manifest_string_count; a_pos: like body_start_position; k_as, r_as: like obsolete_keyword) is
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
			obsolete_keyword := k_as
			rescue_keyword := r_as
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
			obsolete_keyword_set: obsolete_keyword = k_as
			rescue_keyword_set: rescue_keyword = r_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_routine_as (Current)
		end

feature -- Roundtrip

	obsolete_keyword, rescue_keyword: KEYWORD_AS
			-- keyword "obsolete" and "rescue" associated with this class

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

feature -- Location

	body_start_position: INTEGER
			-- Position at the start of the main body (after the comments and obsolete clause)

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				if obsolete_message /= Void then
					Result := obsolete_message.first_token (a_list)
				elseif precondition /= Void then
					Result := precondition.first_token (a_list)
				elseif internal_locals /= Void then
					Result := internal_locals.first_token (a_list)
				elseif not routine_body.first_token (a_list).is_null then
					Result := routine_body.first_token (a_list)
				elseif postcondition /= Void then
					Result := postcondition.first_token (a_list)
				elseif rescue_clause /= Void then
					Result := rescue_clause.first_token (a_list)
				else
					Result := end_keyword.first_token (a_list)
				end
			else
				if obsolete_keyword /= Void then
					Result := obsolete_keyword.first_token (a_list)
				elseif precondition /= Void then
					Result := precondition.first_token (a_list)
				elseif internal_locals /= Void then
					Result := internal_locals.first_token (a_list)
				else
					Result := routine_body.first_token (a_list)
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

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST (pre/post condition
			-- included but the ones inherited)
		do
				-- At least one stoppoint, the one corresponding
				-- to the feature end.
			Result := 1

				-- Add the body stop points
			if routine_body /= Void then
				Result := Result + routine_body.number_of_breakpoint_slots
			end

				-- Add the rescue stop points
			if has_rescue then
				Result := Result + rescue_clause.number_of_breakpoint_slots
			end

				-- Add the pre/postconditions slots
			Result := Result + number_of_precondition_slots + number_of_postcondition_slots
		end

	number_of_precondition_slots: INTEGER is
			-- Number of preconditions
			-- (inherited assertions are not taken into account)
		do
			if has_precondition then
				Result := precondition.number_of_breakpoint_slots
			end
		end

	number_of_postcondition_slots: INTEGER is
			-- Number of postconditions
			-- (inherited assertions are not taken into account)
		do
			if has_postcondition then
				Result := postcondition.number_of_breakpoint_slots
			end
		end

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

feature -- default rescue

	create_default_rescue (def_resc_name : STRING) is
		local
			def_resc_id   : ID_AS
			def_resc_call : ACCESS_ID_AS
			def_resc_instr: INSTR_CALL_AS
		do
			if rescue_clause = Void and then
			   not (routine_body.is_deferred or routine_body.is_external) then
				create def_resc_id.initialize (def_resc_name)
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
	end_keyword_not_void: end_keyword /= Void

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

end -- class ROUTINE_AS
