note
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

	initialize (f: like feature_names; b: like body; i: like indexes; an_id: like id; a_pos: like next_position)
			-- Create a new FEATURE AST node.
		require
			f_not_void: f /= Void
			f_not_empty: not f.is_empty
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

	process (v: AST_VISITOR)
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

	indexes: detachable INDEXING_CLAUSE_AS
			-- Indexing clause for IL to specify `custom attributes' and `alias' name.

feature -- Location

	next_position: INTEGER
			-- Position for the following construct after current.
			-- Useful to extract comments of an attribute

feature -- Roundtrip

	index: INTEGER
			-- <Precursor>
		do
			Result := body.index
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := feature_names.first_token (a_list)
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
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
			-- current feature is a constant or an attribute.

	set_break_included (b: BOOLEAN)
			-- Set `break_included' with `b'.
		do
			break_included := b
		ensure
			break_included_set: break_included = b
		end

feature -- Roundtrip/Comment

	comment (a_list: LEAF_AS_LIST): EIFFEL_COMMENTS
			-- Associated comment of current feature
			-- Result affected by `break_included'.
		require
			a_list_not_void: a_list /= Void
		local
			l_start_index, l_end_index: INTEGER
			l_retried: BOOLEAN
			l_region: detachable ERT_TOKEN_REGION
			l_routine_first_token: detachable LEAF_AS
		do
			if not l_retried then
				if is_constant or is_attribute then
					if attached first_token (a_list) and then attached last_token (a_list) then
						l_region := token_region (a_list)
					else
						create Result.make
					end
				elseif attached {ROUTINE_AS} body.content as l_routine then
					if attached {LEAF_AS} first_token (a_list) as l_first_token then
						l_routine_first_token := l_routine.first_token (a_list)
						if l_routine_first_token /= Void then
							l_start_index := l_first_token.index.max (1)
							l_end_index := l_routine_first_token.index - 1

							check l_first_token.index <= l_end_index end
							create l_region.make (l_start_index, l_end_index)
						end
					end
				end
				if l_region /= Void and then a_list.valid_region (l_region) then
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

	trailing_break_region (a_list: LEAF_AS_LIST): detachable ERT_TOKEN_REGION
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
			if attached last_token (a_list) as l_token then
				l_end_index1 := l_token.index
				set_break_included (True)
				if attached last_token (a_list) as l_token_with_break then
					l_end_index2 := l_token_with_break.index
					check
						index_valid: l_end_index1 + 1 <= l_end_index2
					end
					create Result.make (l_end_index1 + 1, l_end_index2)
				end
			end
			set_break_included (l_break_included)
		end

feature -- Property

	is_feature: BOOLEAN = True
			-- Does the Current AST represent a feature?

	is_attribute: BOOLEAN
			-- Does Current AST represent an attribute?
		do
			Result := body.content = Void
		end

	is_function: BOOLEAN
			-- Does Current AST represent a function?
		do
			Result := body.type /= Void and not is_attribute
		end

	is_procedure: BOOLEAN
			-- Does Current AST represent a procedure?
		do
			Result := body.type = Void
		end

	is_deferred: BOOLEAN
			-- Does Current AST represent a deferred feature?
		require
			body_has_content: body.content /= Void
		do
			Result := attached {ROUTINE_AS} body.content as l_routine_as and then l_routine_as.is_deferred
		end

	is_constant: BOOLEAN
			-- Does Current AST represent a constant?
		do
			Result := attached {CONSTANT_AS} body.content
		end

feature {COMPILER_EXPORTER} -- Setting

	set_feature_names (f: like feature_names)
			-- Set `feature_names' to `f'
		require
			f_not_void: f /= Void
			f_not_empty: not f.is_empty
		do
			feature_names := f
		ensure
			feature_names_set: feature_names = f
		end

feature -- Query

	is_named (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Determines if the feature is named `a_name'
			--
			-- `a_name': Feature name to check current feature against
			-- `Result': True if one of the feature names matches `a_name'; False otherwise.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_fn: like feature_name
			l_names: like feature_names
			l_name: FEATURE_NAME
			l_cursor: INTEGER
		do
			l_fn := feature_name
			Result := l_fn /= Void and then a_name.is_case_insensitive_equal (l_fn.name)
			if not Result then
					-- Check feature name list
				l_names := feature_names
				if l_names /= Void and then l_names.count > 1 or Result then
					l_cursor := l_names.index
					from l_names.start until l_names.after loop
						l_name := l_names.item
						if l_name /= Void then
							Result := a_name.is_case_insensitive_equal (l_name.visual_name)
						end
						l_names.forth
					end
					l_names.go_i_th (l_cursor)
				end
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (body, other.body) and
				equivalent (feature_names, other.feature_names)
		end

feature -- Access

	feature_name: ID_AS
			-- Feature name representing AST
		do
			Result := feature_names.first.feature_name
		end

	feature_with_name (n: INTEGER): detachable FEATURE_AS
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
				if n = l_area [i].feature_name.name_id then
					Result := Current
						-- Jump out of loop
					i := l_count - 1
				end
				i := i + 1
			end
		end

	has_feature_name (n: FEATURE_NAME): BOOLEAN
			-- Does this feature have the name `n'?
		local
			cur: INTEGER
			l_names: like feature_names
		do
			l_names := feature_names
			cur := l_names.index

			from
				l_names.start
			until
				l_names.after or else Result
			loop
				Result := l_names.item >= n and l_names.item <= n
				l_names.forth
			end

			l_names.go_i_th (cur)
		end

	has_instruction (i: INSTRUCTION_AS): BOOLEAN
			-- Does this feature has the instruction `i'?
		do
			Result := body.has_instruction (i)
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER
			-- Index of instruction `i' in this feature.
			-- Result is `0' if not found.
		do
			Result := body.index_of_instruction (i)
		end

	custom_attributes: detachable EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
			-- Custom attributes of current class if any.
		do
			if attached indexes as ids then
				Result := ids.custom_attributes
			end
		end

	class_custom_attributes: detachable EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
			-- Class custom attributes of current class if any.
		do
			if attached indexes as ids then
				Result := ids.class_custom_attributes
			end
		end

	interface_custom_attributes: detachable EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
			-- Interface custom attributes of current class if any.
		do
			if attached indexes as ids then
				Result := ids.interface_custom_attributes
			end
		end

	property_name: detachable STRING
			-- Name of the associated property (if any).
		do
			if attached indexes as ids then
				Result := ids.property_name
			end
		end

	property_custom_attributes: detachable EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
			-- Custom attributes of a property (if any).
		do
			if attached indexes as ids then
				Result := ids.property_custom_attributes
			end
		end


	once_as: detachable ONCE_AS
			-- Related Once part (if any).
		do
			if attached {ROUTINE_AS} body.content as l_routine_as then
				if attached {BUILT_IN_AS} l_routine_as.routine_body as l_rout_body then
					if attached l_rout_body.body as l_feat_as then
						Result := l_feat_as.once_as
					end
				else
					Result := l_routine_as.routine_body.as_once
				end
			end
		end

feature -- empty body

	is_empty : BOOLEAN
				-- Is body empty?
		do
			Result := (body = Void) or else (body.is_empty)
		end

feature -- default rescue

	create_default_rescue (def_resc_name_id: INTEGER)
				-- Create default rescue if necessary
		require
			valid_feature_name_id: def_resc_name_id > 0
		do
			body.create_default_rescue (def_resc_name_id)
		end

feature -- Conveniences

	is_less alias "<" (other: like Current): BOOLEAN
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

	is_body_equiv (other: like Current): BOOLEAN
			-- Is the current feature equivalent to `other' ?
		local
			is_process_context: BOOLEAN
			other_is_process_context: BOOLEAN
		do
			Result := body.is_body_equiv (other.body)
			if Result then
				if attached indexes as ids then
					is_process_context := ids.has_global_once
				end
				if attached other.indexes as o_ids then
					other_is_process_context := o_ids.has_global_once
				end
				Result := is_process_context = other_is_process_context
			end
		end

	is_assertion_equiv (other: like Current): BOOLEAN
			-- Is the current feature equivalent to `other' ?
		do
			Result := body.is_assertion_equiv (other.body)
		end

invariant
	feature_names_not_void: feature_names /= Void
	feature_names_not_empty: not feature_names.is_empty
	body_not_void: body /= Void
	next_position_non_negative: next_position >= 0

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class FEATURE_AS
