indexing
	description: "Scanner skeleton class for COMMENT_SCANNER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMMENT_SCANNER_SKELETON

inherit

	YY_COMPRESSED_SCANNER_SKELETON
			redefine
				reset, default_action
			end

	SHARED_EIFFEL_PROJECT

	SHARED_TEXT_ITEMS

	CONF_REFACTORING

feature {NONE} -- Initialization

	make_with_text_formatter (a_text_formatter: like text_formatter; a_seperate_comment: BOOLEAN) is
			-- Initialization
		require
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			text_formatter := a_text_formatter
			seperate_comment := a_seperate_comment
			create buffer_string.make (100)
			for_comment := True
			make
		ensure
			text_formatter_not_void: text_formatter = a_text_formatter
		end

feature -- Element change

	reset is
			-- Reset
		do
			Precursor {YY_COMPRESSED_SCANNER_SKELETON}
			reset_last_type
		end

	set_text_formatter (a_text_formatter: like text_formatter) is
			-- Set `text_formatter' with `a_text_formatter'.
		require
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			text_formatter := a_text_formatter
		ensure
			text_formatter_not_void: text_formatter = a_text_formatter
		end

	set_for_comment (a_for_comment: BOOLEAN) is
			-- Set `for_comment' with `a_for_comment'.
		do
			for_comment := a_for_comment
		ensure
			for_comment_set: for_comment = a_for_comment
		end

	set_seperate (a_sep: BOOLEAN) is
			-- Set `seperate_comment' with `a_sep'
		do
			seperate_comment := a_sep
		ensure
			seperate_comment_set: seperate_comment = a_sep
		end

	set_current_class (a_class: like current_class) is
			-- Set `a_class' to `current_class'.
		do
			current_class := a_class
		ensure
			current_class_not_void: current_class = a_class
		end

feature -- Access

	current_class : CLASS_C
			-- Current class for analyze context.

	last_condition: INTEGER
			-- Last start condition.

feature -- Status report

	seperate_comment: BOOLEAN
			-- Seperate into word?

feature -- Action

	default_action is
		do
			-- Nothing to be done
		end

feature {NONE} -- Implementation

	add_email_tokens is
			-- Email address encountered.
		local
			l_text : like text
		do
			l_text := text
			if for_comment then
				text_formatter.process_comment_text (l_text, "mailto:" + l_text)
			else
				text_formatter.process_string_text (l_text, "mailto:" + l_text)
			end
		end

	add_url_tokens is
			-- URL encountered.
		local
			l_text : like text
		do
			l_text := text
			if for_comment then
				text_formatter.process_comment_text (l_text, l_text.twin)
			else
				text_formatter.process_string_text (l_text, l_text.twin)
			end
		end

	add_dot_feature is
			-- A feature like {CLASS}.feature encountered.
		local
			l_text : like text
			l_feat_name: STRING
			l_feat: E_FEATURE
		do
			l_text := text
			l_feat_name := l_text.twin
			l_feat_name.keep_tail (l_text.count - 1)
			l_feat := feature_by_name (l_feat_name)
			if l_feat /= Void then
				text_formatter.process_symbol_text (ti_dot)
				text_formatter.process_feature_text (l_feat_name, l_feat, false)
				if not l_feat.is_procedure then
					last_type := l_feat.type.actual_type
				else
					reset_last_type
				end
			else
				add_text (l_text, False)
				reset_last_type
			end
		end

	add_quote_feature is
			-- A feature like `feature' encountered.
		local
			l_text : like text
			l_feat_name: STRING
			l_feat: E_FEATURE
		do
			l_text := text
			check
				l_text.count > 2
			end
			l_feat_name := l_text
			l_feat_name := l_text.substring (2, l_text.count - 1)
			if current_class /= Void then
				last_type := current_class.actual_type
			end
			l_feat := feature_by_name (l_feat_name)
			if l_feat /= Void then
				text_formatter.process_feature_text (l_feat_name, l_feat, false)
			else
				add_text (l_text, True)
			end
		end

	add_class is
			-- A class like {CLASS} encountered.
		local
			l_text : like text
			l_class_name: STRING
			l_class: CLASS_I
		do
			l_text := text
			check
				l_text.count > 2
			end
			l_class_name := l_text.substring (2, l_text.count - 1)
			l_class := class_by_name (l_class_name)
			if l_class /= Void then
				text_formatter.process_symbol_text (ti_l_curly)
				text_formatter.process_class_name_text (l_class_name, l_class, False)
				text_formatter.process_symbol_text (ti_r_curly)
				if l_class.is_compiled then
					last_type := l_class.compiled_class.actual_type
				end
			else
				add_text (l_text, False)
				reset_last_type
			end
		end

	add_cluster is
			-- A cluster like [cluster] encountered.
		local
			l_text : like text
			l_cluster_name: STRING
			l_cluster: CONF_GROUP
			l_strings: LIST [STRING]
			l_groups: ARRAYED_LIST [CONF_GROUP]
			l_str: STRING
		do
			l_text := text
			check
				l_text.count > 2
			end
			l_cluster_name := l_text.substring (2, l_text.count - 1)
			l_strings := l_cluster_name.split ('.')
			l_groups := eiffel_universe.groups
			if not l_strings.is_empty and then not l_strings.first.is_empty then
				l_str := l_strings.first
				l_cluster := eiffel_universe.target.groups.item (l_str)
			end
			if l_cluster /= Void then
				text_formatter.process_cluster_name_text (l_cluster.name, l_cluster, False)
				from
					l_strings.start
					if not l_strings.after then
						l_strings.forth
					end
				until
					l_strings.after
				loop
					if not l_strings.item.is_empty then
						l_cluster_name := l_strings.item
						add_text (".", False)
						if l_cluster /= Void then
							l_cluster := l_cluster.sub_group_by_name (l_cluster_name)
						end
						if l_cluster /= Void then
							text_formatter.process_cluster_name_text (l_cluster.name, l_cluster, False)
						else
							add_text (l_cluster_name, False)
						end
					else
						add_text (".", False)
					end
					l_strings.forth
				end
			else
				add_text (l_text, False)
			end
		end

	add_normal_text is
			-- Add `text' to `text_formatter'.
		do
			add_text (text, False)
		end

	add_text (a_text: STRING; a_basic_comment: BOOLEAN) is
			-- Add `a_text' as normal text.
		require
			a_text_not_void: a_text /= Void
		do
			if not a_text.is_empty then
				if for_comment then
					if not a_basic_comment then
						text_formatter.process_comment_text (a_text, Void)
					else
						text_formatter.process_basic_text (a_text)
					end
				else
					text_formatter.process_string_text (a_text, Void)
				end
			end
		end

	append_buffer is
			-- Append token to `text_formatter'
		do
			if not buffer_string.is_empty then
				add_text (buffer_string.twin, False)
				buffer_string.clear_all
			end
		end

	buffer_token is
			-- Buffer token.
		do
			buffer_string.append (text)
		end

	buffer_string : STRING
			-- Buffered string

	text_formatter: TEXT_FORMATTER
			-- Output text formatter.

	for_comment: BOOLEAN;
			-- Texts are for comment?
			-- Or verbatim string

feature {NONE} -- Helpers

	last_type: TYPE_A
			-- Class context where feature should be analysed.

	reset_last_type is
			-- Reset `last_type'
		do
			last_type := Void
		end

	class_by_name (name: STRING): CLASS_I is
			-- Return class with `name'. `Void' if not in system.
		require
			name_not_void: name /= Void
			is_class_name: (create {IDENTIFIER_CHECKER}).is_valid_upper (name)
		local
			cl: LIST [CLASS_I]
		do
			cl := Eiffel_universe.classes_with_name (name)
			if cl /= Void and then not cl.is_empty then
				Result := cl.first
			end
		end

	feature_by_name (name: STRING): E_FEATURE is
			-- Return feature in current class with `name'. `Void' if not in system.
		local
			cc: CLASS_C
		do
			if last_type /= Void then
				cc := last_type.associated_class
			end
			if cc /= Void then
				Result := cc.feature_with_name (name)
			end
		end

invariant
	invariant_clause: True -- Your invariant here

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
