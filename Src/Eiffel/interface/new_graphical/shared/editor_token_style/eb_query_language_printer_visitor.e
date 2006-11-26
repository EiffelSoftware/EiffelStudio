indexing
	description: "[
					Visitor to print query language items into editor tokens					
					Every time before generating text, call `wipe_out_text' to clean `text', and then generated.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_QUERY_LANGUAGE_PRINTER_VISITOR

inherit
	QL_VISITOR

	EB_SHARED_WRITER

	SHARED_TEXT_ITEMS

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize Current.
		do
			create_default_style
			create_default_class_style
			create_default_feature_style
			create {LINKED_LIST [EDITOR_TOKEN]} text_internal.make
		end

feature -- Access

	text: LIST [EDITOR_TOKEN] is
			-- Generated text
		do
			Result := text_internal.twin
		ensure
			result_attached: Result /= Void
		end

	item_text (a_item: QL_ITEM): like text is
			-- Text of `a_item'
			-- This will overwrite original `text'.
		require
			a_item_attached: a_item /= Void
		do
			wipe_out_text
			a_item.process (Current)
			Result := text
		ensure
			result_attached: Result /= Void
		end

feature -- Style

	class_style: like default_class_style is
			-- Style to print class item
		do
			if class_style_internal = Void then
				Result := default_class_style
			else
				Result := class_style_internal
			end
		ensure
			result_attached: Result /= Void
		end

	feature_style: like default_feature_style is
			-- Style to print feature item
		do
			if feature_style_internal = Void then
				Result := default_feature_style
			else
				Result := feature_style_internal
			end
		ensure
			result_attached: Result /= Void
		end

	target_style: like default_style is
			-- Style to print target item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

	group_style: like default_style is
			-- Style to print group item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

	quantity_style: like default_style is
			-- Style to print quantity item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

	line_style: like default_style is
			-- Style to print line item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

	generic_style: like default_style is
			-- Style to print generic item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

	local_style: like default_style is
			-- Style to print local item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

	argument_style: like default_style is
			-- Style to print argument item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

	assertion_style: like default_style is
			-- Style to print assertion item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	set_class_style (a_class_style: like class_style) is
			-- Set `class_style' with `a_class_style'.
			-- If `a_class_style' is Void, `default_class_style' will be returned when `class_style' is quired.
		do
			class_style_internal := a_class_style
		ensure
			class_style_set: (a_class_style /= Void implies (class_style = a_class_style)) and then
							 (a_class_style = Void) implies (class_style = default_class_style)
		end

	set_feature_style (a_feature_style: like feature_style) is
			-- Set `feature_style' with `a_feature_style'.
			-- If `a_feature_style' is Void, `default_feature_style' will be returned when `feature_style' is quired.
		do
			feature_style_internal := a_feature_style
		ensure
			feature_style_set: (a_feature_style /= Void implies (feature_style = a_feature_style)) and then
							 (a_feature_style = Void) implies (feature_style = default_feature_style)
		end

	wipe_out_text is
			-- Wipe out `text_internal'.
		do
			text_internal.wipe_out
		ensure
			text_is_empty: text_internal.is_empty
		end

feature -- Process

	process_domain (a_item: QL_DOMAIN) is
			-- Process `a_item'.
		do
			-- Do nothing.
		end

	process_target (a_item: QL_TARGET) is
			-- Process `a_item'.
		local
			l_target_style: like target_style
		do
			l_target_style := target_style
			l_target_style.set_item (a_item)
			text_internal.append (l_target_style.text)
		end

	process_group (a_item: QL_GROUP) is
			-- Process `a_item'.
		local
			l_group_style: like group_style
		do
			l_group_style := group_style
			l_group_style.set_item (a_item)
			text_internal.append (l_group_style.text)
		end

	process_class (a_item: QL_CLASS) is
			-- Process `a_item'.
		local
			l_class_style: like class_style
		do
			l_class_style := class_style
			l_class_style.set_ql_class (a_item)
			text_internal.append (l_class_style.text)
		end

	process_feature (a_item: QL_FEATURE) is
			-- Process `a_item'.
		local
			l_feature_style: like feature_style
		do
			l_feature_style := feature_style
			l_feature_style.set_ql_feature (a_item)
			text_internal.append (l_feature_style.text)
		end

	process_real_feature (a_item: QL_REAL_FEATURE) is
			-- Process `a_item'.
		do
			process_feature (a_item)
		end

	process_invariant (a_item: QL_INVARIANT) is
			-- Process `a_item'.
		do
			process_feature (a_item)
		end

	process_quantity (a_item: QL_QUANTITY) is
			-- Process `a_item'.
		local
			l_quantity_style: like quantity_style
		do
			l_quantity_style := quantity_style
			l_quantity_style.set_item (a_item)
			text_internal.append (l_quantity_style.text)
		end

	process_line (a_item: QL_LINE) is
			-- Process `a_item'.
		local
			l_line_style: like line_style
		do
			l_line_style := line_style
			l_line_style.set_item (a_item)
			text_internal.append (l_line_style.text)
		end

	process_generic (a_item: QL_GENERIC) is
			-- Process `a_item'.
		local
			l_generic_style: like generic_style
		do
			l_generic_style := generic_style
			l_generic_style.set_item (a_item)
			text_internal.append (l_generic_style.text)
		end

	process_local (a_item: QL_LOCAL) is
			-- Process `a_item'.
		local
			l_local_style: like local_style
		do
			l_local_style := local_style
			l_local_style.set_item (a_item)
			text_internal.append (l_local_style.text)
		end

	process_argument (a_item: QL_ARGUMENT) is
			-- Process `a_item'.
		local
			l_argument_style: like argument_style
		do
			l_argument_style := argument_style
			l_argument_style.set_item (a_item)
			text_internal.append (l_argument_style.text)
		end

	process_assertion (a_item: QL_ASSERTION) is
			-- Process `a_item'.
		local
			l_assertion_style: like assertion_style
		do
			l_assertion_style := assertion_style
			l_assertion_style.set_item (a_item)
			text_internal.append (l_assertion_style.text)
		end

	process_path (a_item: QL_ITEM; a_self_included: BOOLEAN; a_parent_included: BOOLEAN; a_indirect_parent_included: BOOLEAN; a_target_included: BOOLEAN) is
			-- Process `a_item' and write path of `a_item' into `text_internal' in form of "grand_parent.parent.item"
			-- If `a_self_included' is True, including `a_item' itself.
			-- If `a_parent_included' is True, including direct parent of `a_item'.
			-- If `a_indirect_parent_included" is True, including indirect parent of `a_item'.
			-- If `a_target_included' is True, including target parents, otherwise, target parents will be omited. Has no effect if `a_self_included' is True and
			-- `a_item' is a target.
		require
			a_item_attached: a_item /= Void
		local
			l_writer: like token_writer
			l_list: LINKED_LIST [QL_ITEM]
			l_parent: QL_ITEM
			l_count: INTEGER
			l_curr_item: QL_ITEM
			l_dot_token: EDITOR_TOKEN
		do
			l_curr_item := a_item
			l_writer := token_writer
			l_writer.new_line

			create l_list.make

				-- Insert `a_item' itself.
			if a_self_included then
				l_list.extend (l_curr_item)
			end

				-- Insert direct parent.
			if a_parent_included and then l_curr_item.parent /= Void then
				if not l_curr_item.parent.is_target or else a_target_included then
					l_list.put_front (l_curr_item.parent)
				end
			end
			l_curr_item := l_curr_item.parent

				-- Insert indirect parent.
			if a_indirect_parent_included and then l_curr_item /= Void then
				from
					l_parent := l_curr_item.parent
				until
					l_parent = Void
				loop
					if not l_parent.is_target or else a_target_included then
						l_list.put_front (l_parent)
					end
					l_parent := l_parent.parent
				end
			end

				-- Print.
			if not l_list.is_empty then
				if l_list.count = 1 then
					l_list.first.process (Current)
				else
					l_dot_token := editor_token_for_dot
					from
						l_list.start
						l_count := l_list.count
					until
						l_list.after
					loop
						l_list.item.process (Current)
						if l_list.index < l_list.count then
							text_internal.extend (l_dot_token)
						end
						l_list.forth
					end
				end
			end
		end

feature{NONE} -- Implementation

	class_style_internal: like class_style
			-- Internal storage for `class_style'

	feature_style_internal: like feature_style;
			-- Internal storage for `feature_style'

	default_class_style: EB_CLASS_EDITOR_TOKEN_STYLE
			-- Default `class_style'

	default_feature_style: EB_FEATURE_EDITOR_TOKEN_STYLE
			-- Default `feature_style'

	default_style: EB_SIMPLE_QL_NAME_STYLE
			-- Default style for query language items other than class and feature

	create_default_class_style is
			-- Create `default_class_style'.
		do
			create default_class_style
			default_class_style.enable_complete_generic_form
			default_class_style.disable_curly
		ensure
			default_class_style_attached: default_class_style /= Void
		end

	create_default_feature_style is
			-- Create `default_feature_style'
		do
			create default_feature_style
			default_feature_style.disable_class
			default_feature_style.disable_return_type
			default_feature_style.disable_argument
			default_feature_style.disable_comment
			default_feature_style.disable_value_for_constant
		ensure
			default_feature_style_attached: default_feature_style /= Void
		end

	create_default_style is
			-- Create `default_style'.
		do
			create default_style
		ensure
			result_attached: default_style /= Void
		end

	editor_token_for_dot: EDITOR_TOKEN is
			-- Editor token reprensentation for dot "."
		local
			l_writer: like token_writer
		do
			l_writer := token_writer
			l_writer.new_line
			l_writer.process_symbol_text (ti_dot)
			Result := l_writer.last_line.content.first
		ensure
			reslt_attached: Result /= Void
		end

		text_internal: LIST [EDITOR_TOKEN];
			-- Text generated

invariant
	text_attached: text_internal /= Void
	default_class_style_attached: default_class_style /= Void
	default_feature_style_attached: default_feature_style /= Void
	default_style_attached: default_style /= Void

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


end
