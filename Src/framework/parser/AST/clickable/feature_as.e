indexing
	description	: "Abstract class for abstract description of Eiffel features."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class FEATURE_AS

inherit
	AST_EIFFEL

	COMPARABLE
		undefine
			is_equal
		end

	IDABLE

	CLICKABLE_AST
		undefine
			is_equal
		redefine
			is_feature, feature_name
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like feature_names; b: like body; i: like indexes; an_id: like id; a_pos: like next_position) is
			-- Create a new FEATURE AST node.
		require
			f_not_void: f /= Void
			b_not_void: b /= Void
			a_pos_non_negative: a_pos >= 0
		do
			feature_names := f
			body := b
			indexes := i
			id := an_id
			next_position := a_pos
			set_break_included (True)
		ensure
			feature_names_set: feature_names = f
			body_set: body = b
			indexes_set: indexes = i
			id_set: id = an_id
			next_position_set: next_position = a_pos
			break_included_set: break_included
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_feature_as (Current)
		end

feature -- Access

	feature_names: EIFFEL_LIST [FEATURE_NAME]
			-- Names of feature

	body: BODY_AS
			-- Feature body: this attribute will be compared during
			-- second pass of the compiler in order to see if a feature
			-- has change of body.

	indexes: INDEXING_CLAUSE_AS
			-- Indexing clause for IL to specify `custom attributes' and `alias' name.

feature -- Location

	next_position: INTEGER
			-- Position for the following construct after current.
			-- Useful to extract comments of an attribute

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := feature_names.first_token (a_list)
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := body.last_token (a_list)
				if Result = Void or else Result.is_null then
					Result := feature_names.last_token (a_list)
				end
			else
				if break_included and (is_attribute or is_constant) then
					Result := a_list.item_by_end_position (next_position - 1)
					if Result = Void then
						Result := body.last_token (a_list)
					end
				else
					Result := body.last_token (a_list)
				end
			end
		end

feature -- Roundtrip/Break token inclusion

	break_included: BOOLEAN
			-- Is trailing break included when `last_token' is computed?
			-- This will affect result of `last_token' and `comment' if
			-- curernt feature is a constant or an attribute.

	set_break_included (b: BOOLEAN) is
			-- Set `break_included' with `b'.
		do
			break_included := b
		ensure
			break_included_set: break_included = b
		end

feature -- Roundtrip/Comment

	comment (a_list: LEAF_AS_LIST): EIFFEL_COMMENTS is
			-- Associated comment of current feature
			-- Result affected by `break_included'.
		require
			a_list_not_void: a_list /= Void
		local
			l_routine: ROUTINE_AS
			l_end_index: INTEGER
			l_retried: BOOLEAN
			l_region: ERT_TOKEN_REGION
		do
			if not l_retried then
				if is_constant or is_attribute then
					l_region := token_region (a_list)
				else
					l_routine ?= body.content
					check l_routine /= Void end
					l_end_index := l_routine.first_token (a_list).index - 1
					check first_token (a_list).index <= l_end_index end
					create l_region.make (first_token (a_list).index, l_end_index)
				end
				if a_list.valid_region (l_region) then
					Result := a_list.extract_comment (l_region)
				else
					create Result.make
				end
			else
				create Result.make
			end
		ensure
			result_attached: Result /= Void
		rescue
			l_retried := True
			retry
		end

feature -- Roundtrip/Trailing break

	trailing_break_region (a_list: LEAF_AS_LIST): ERT_TOKEN_REGION is
			-- Break region after an attribute or a constant
		require
			a_list_not_void: a_list /= Void
			only_for_attribute_or_constant: is_attribute or is_constant
		local
			l_break_included: BOOLEAN
			l_end_index1, l_end_index2: INTEGER
		do
			l_break_included := break_included
			set_break_included (False)
			l_end_index1 := last_token (a_list).index
			set_break_included (True)
			l_end_index2 := last_token (a_list).index
			set_break_included (l_break_included)
			check
				index_valid: l_end_index1 + 1 <= l_end_index2
			end
			create Result.make (l_end_index1 + 1, l_end_index2)
		end

feature -- Property

	is_feature: BOOLEAN is True
			-- Does the Current AST represent a feature?

	is_attribute: BOOLEAN is
			-- Does Current AST represent an attribute?
		do
			Result := body.content = Void
		end

	is_function: BOOLEAN is
			-- Does Current AST represent a function?
		do
			Result := body.type /= Void and not is_attribute
		end

	is_deferred: BOOLEAN is
			-- Does Current AST represent a deferred feature?
		require
			body_has_content: body.content /= Void
		local
			rout: ROUT_BODY_AS
			routine_as: ROUTINE_AS
		do
			routine_as ?= body.content
			if routine_as /= Void then
				rout := routine_as.routine_body
				if rout /= Void then
					Result := rout.is_deferred
				end
			end
		end

	is_constant: BOOLEAN is
			-- Does Current AST represent a constant?
		local
			l_constant: CONSTANT_AS
		do
			l_constant ?= body.content
			Result := l_constant /= Void
		end

feature {COMPILER_EXPORTER} -- Setting

	set_feature_names (f: like feature_names) is
			-- Set `feature_names' to `f'
		require
			f_not_void: f /= Void
			f_not_empty: not f.is_empty
		do
			feature_names := f
		ensure
			feature_names_set: feature_names = f
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (body, other.body) and
				equivalent (feature_names, other.feature_names)
		end

feature -- Access

	feature_name: ID_AS is
			-- Feature name representing AST
		do
			Result := feature_names.first.internal_name
		end

	feature_with_name (n: INTEGER): FEATURE_AS is
			-- Feature ast with internal name `n'
		local
			l_area: SPECIAL [FEATURE_NAME]
			i, l_count: INTEGER
		do
			from
				l_area := feature_names.area
				l_count := feature_names.count
			until
				i = l_count
			loop
				if n = l_area [i].internal_name.name_id then
					Result := Current
						-- Jump out of loop
					i := l_count
				else
					i := i + 1
				end
			end
		end

	has_feature_name (n: FEATURE_NAME): BOOLEAN is
			-- Does this feature have the name `n'?
		local
			cur: CURSOR
		do
			cur := feature_names.cursor

			from
				feature_names.start
			until
				feature_names.after or else Result
			loop
				Result := feature_names.item >= n and feature_names.item <= n
				feature_names.forth
			end

			feature_names.go_to (cur)
		end

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does this feature has the instruction `i'?
		do
			Result := body.has_instruction (i)
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of instruction `i' in this feature.
			-- Result is `0' if not found.
		do
			Result := body.index_of_instruction (i)
		end

	custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Custom attributes of current class if any.
		do
			if indexes /= Void then
				Result := indexes.custom_attributes
			end
		end

	class_custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Class custom attributes of current class if any.
		do
			if indexes /= Void then
				Result := indexes.class_custom_attributes
			end
		end

	interface_custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Interface custom attributes of current class if any.
		do
			if indexes /= Void then
				Result := indexes.interface_custom_attributes
			end
		end

	property_name: STRING is
			-- Name of the associated property (if any).
		do
			if indexes /= Void then
				Result := indexes.property_name
			end
		end

	property_custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Custom attributes of a property (if any).
		do
			if indexes /= Void then
				Result := indexes.property_custom_attributes
			end
		end

feature -- Update

	assign_unique_values (counter: COUNTER; values: HASH_TABLE [INTEGER, STRING]) is
			-- Assign values to Unique features defined in the current class
		do
			if body.is_unique then
				from
					feature_names.start
				until
					feature_names.after
				loop
					values.put (counter.next, feature_names.item.internal_name.name)
					feature_names.forth
				end
			end
		end

feature -- empty body

	is_empty : BOOLEAN is
				-- Is body empty?
		do
			Result := (body = Void) or else (body.is_empty)
		end

feature -- default rescue

	create_default_rescue (def_resc_name_id: INTEGER) is
				-- Create default rescue if necessary
		require
			valid_feature_name_id: def_resc_name_id > 0
		do
			if body /= Void then
				body.create_default_rescue (def_resc_name_id)
			end
		end

feature -- Conveniences

	infix "<" (other: like Current): BOOLEAN is
		do
			if feature_names = Void then
				Result := False
			elseif other.feature_names = Void then
				Result := True
			else
				Result := feature_names.first < other.feature_names.first
			end
		end

feature {COMPILER_EXPORTER} -- Incrementality

	is_body_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		require
			valid_body: body /= Void
		local
			is_process_context: BOOLEAN
			other_is_process_context: BOOLEAN
		do
			Result := body.is_body_equiv (other.body)
			if Result then
				if indexes /= Void then
					is_process_context := indexes.has_global_once
				end
				if other.indexes /= Void then
					other_is_process_context := other.indexes.has_global_once
				end
				Result := is_process_context = other_is_process_context
			end
		end

	is_assertion_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		require
			valid_body: body /= Void
		do
			Result := body.is_assertion_equiv (other.body)
		end

invariant
	feature_names_not_void: feature_names /= Void
	feature_names_not_empty: not feature_names.is_empty
	body_not_void: body /= Void
	next_position_non_negative: next_position >= 0

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

end -- class FEATURE_AS
