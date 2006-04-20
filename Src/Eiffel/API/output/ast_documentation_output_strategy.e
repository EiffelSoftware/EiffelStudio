indexing
	description: "Output strategy for documentation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AST_DOCUMENTATION_OUTPUT_STRATEGY

inherit
	AST_DECORATED_OUTPUT_STRATEGY
		rename
			make as make_old
		redefine
			process_class_as
		end

create
	make

feature {NONE} -- Initialization

	make (a_text_formatter: like text_formatter_decorator; a_doc: like documentation) is
			-- Format `a_node' in `a_text_formatter' in `a_is_simple' mode.
		require
			a_text_not_void: a_text_formatter /= Void
			a_doc_not_void: a_doc /= Void
		do
			make_old (a_text_formatter)
			documentation := a_doc
		end

feature -- Process

	process_class_as (l_as: CLASS_AS) is
		local
			l_creators: EIFFEL_LIST [CREATE_AS]
			l_create: CREATE_AS
			l_features: EIFFEL_LIST [FEATURE_NAME]
			l_feat: FEATURE_I
		do
			text_formatter_decorator.process_filter_item (f_class_declaration, true)

			text_formatter_decorator.process_filter_item (f_menu_bar, true)
			documentation.insert_class_menu_bar (text_formatter_decorator, current_class.name.as_lower)
			text_formatter_decorator.process_filter_item (f_menu_bar, false)

			text_formatter_decorator.process_before_class (current_class)
			safe_process (l_as.top_indexes)
			format_header (l_as)
			if text_formatter_decorator.is_clickable_format and l_as.obsolete_message /= Void then
				text_formatter_decorator.put_new_line
				text_formatter_decorator.process_filter_item (f_obsolete, true)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_keyword_text (ti_obsolete_keyword, Void)
				text_formatter_decorator.put_space
				l_as.obsolete_message.process (Current)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_filter_item (f_obsolete, false)
				text_formatter_decorator.put_new_line
			end
			if text_formatter_decorator.is_clickable_format and l_as.parents /= Void then
				text_formatter_decorator.put_new_line
				text_formatter_decorator.process_filter_item (f_inheritance, true)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_keyword_text (ti_inherit_keyword, Void)
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				text_formatter_decorator.set_new_line_between_tokens
				text_formatter_decorator.set_separator (ti_new_line)
				l_as.parents.process (Current)
				text_formatter_decorator.process_filter_item (f_inheritance, false)
				text_formatter_decorator.put_new_line
				text_formatter_decorator.exdent
			end
			text_formatter_decorator.put_new_line

			l_creators := l_as.creators
			if l_creators = Void and then current_class.has_feature_table then
				l_feat := current_class.default_create_feature
				if l_feat /= Void then
					create l_creators.make (1)
					create l_features.make (1)
					l_features.extend (create {FEAT_NAME_ID_AS}.initialize (
						create {ID_AS}.initialize (l_feat.feature_name)))
					create l_create.initialize (Void, l_features, Void)
					l_creators.extend (l_create)
				end
			end
			if l_creators /= Void then
				text_formatter_decorator.process_filter_item (f_creators, true)
				text_formatter_decorator.set_separator (ti_empty)
				text_formatter_decorator.set_new_line_between_tokens
				l_creators.process (Current)
				text_formatter_decorator.process_filter_item (f_creators, false)
				text_formatter_decorator.put_new_line
			end
			format_convert_clause (l_as.convertors)
			text_formatter_decorator.format_categories
			text_formatter_decorator.format_invariants
			safe_process (l_as.bottom_indexes)
			text_formatter_decorator.process_filter_item (f_class_end, false)
			text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
			text_formatter_decorator.process_after_class (current_class)
			text_formatter_decorator.process_filter_item (f_class_end, false)
			text_formatter_decorator.process_filter_item (f_menu_bar, true)
			documentation.insert_class_menu_bar (text_formatter_decorator, current_class.name.as_lower)
			text_formatter_decorator.process_filter_item (f_menu_bar, false)
			text_formatter_decorator.process_filter_item (f_class_declaration, false)
			text_formatter_decorator.put_new_line
		end

feature {NONE} -- Implementation

	documentation: DOCUMENTATION_ROUTINES;
			-- For documentation

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
end -- class AST_DOCUMENTATION_OUTPUT_STRATEGY
