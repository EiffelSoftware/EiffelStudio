note
	description: "Scanner skeleton class for COMMENT_SCANNER, based on UTF-8"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	INTERNAL_COMPILER_STRING_EXPORTER

	SHARED_ENCODING_CONVERTER

feature {NONE} -- Initialization

	make_with_text_formatter (a_text_formatter: like text_formatter; a_separate_comment: BOOLEAN)
			-- Initialization
		require
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			text_formatter := a_text_formatter
			separate_comment := a_separate_comment
			create buffer_string.make (100)
			for_comment := True
			make
		ensure
			text_formatter_not_void: text_formatter = a_text_formatter
		end

feature -- Element change

	reset
			-- Reset
		do
			Precursor {YY_COMPRESSED_SCANNER_SKELETON}
			reset_last_type
		end

	set_text_formatter (a_text_formatter: like text_formatter)
			-- Set `text_formatter' with `a_text_formatter'.
		require
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			text_formatter := a_text_formatter
		ensure
			text_formatter_not_void: text_formatter = a_text_formatter
		end

	set_for_comment (a_for_comment: BOOLEAN)
			-- Set `for_comment' with `a_for_comment'.
		do
			for_comment := a_for_comment
		ensure
			for_comment_set: for_comment = a_for_comment
		end

	set_separate (a_sep: BOOLEAN)
			-- Set `separate_comment' with `a_sep'
		do
			separate_comment := a_sep
		ensure
			separate_comment_set: separate_comment = a_sep
		end

	set_current_class (a_class: like current_class)
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

	separate_comment: BOOLEAN
			-- Separate into word?

feature -- Action

	default_action
		do
			-- Nothing to be done
		end

feature {NONE} -- Implementation

	add_email_tokens
			-- Email address encountered.
		local
			l_text : STRING_32
			l_mailto: STRING_32
		do
			l_text := unicode_text
			l_mailto := "mailto:"
			l_mailto.append (l_text)
			if for_comment then
				text_formatter.process_comment_text (l_text, l_mailto)
			else
				text_formatter.process_string_text (l_text, l_mailto)
			end
		end

	add_url_tokens
			-- URL encountered.
		local
			l_text : STRING_32
		do
			l_text := unicode_text
			if for_comment then
				text_formatter.process_comment_text (l_text, l_text.twin)
			else
				text_formatter.process_string_text (l_text, l_text.twin)
			end
		end

	add_dot_feature
			-- A feature like {CLASS}.feature encountered.
		local
			l_text : STRING_32
			l_feat_name: STRING_32
		do
			l_text := unicode_text
			l_feat_name := l_text.tail (l_text.count - 1)
			l_feat_name.to_lower
			if attached feature_by_name ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_feat_name)) as l_feat then
				text_formatter.process_symbol_text (ti_dot)
				text_formatter.process_feature_text (l_feat_name, l_feat, false)
				if l_feat.is_procedure then
					reset_last_type
				else
					last_type := l_feat.type.actual_type
				end
			else
				add_text (l_text, False)
				reset_last_type
			end
		end

	add_quote_feature
			-- A feature like `feature' encountered.
		local
			l_text : STRING_32
		do
			l_text := unicode_text
			check
				l_text.count >= 2
			end
			l_text := l_text.substring (2, l_text.count - 1)
			if current_class /= Void then
				last_type := current_class.actual_type
			end
				-- We try infix and prefix
			if not attached feature_by_name ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_text.as_lower)) as l_feat then
				add_text (l_text, True)
			elseif last_is_alias then
				l_feat.append_full_name (text_formatter)
			else
				l_feat.append_name (text_formatter)
			end
		end

	add_class (a_with_brace: BOOLEAN)
			-- A class like {CLASS} encountered.
		local
			l_text : STRING_32
			l_class_name: STRING_32
			l_class: CLASS_I
		do
			l_text := unicode_text
			check
				l_text.count >= 2
			end
			if l_text.item (l_text.count) = '}' then
					-- We only parsed a specimen of the form "{CLASS}"
				l_class_name := l_text.substring (2, l_text.count - 1)
			else
					-- We parsed a specimen of the form "{CLASS}.f"
					-- so we need to remove 3 characters from the end.
				l_class_name := l_text.substring (2, l_text.count - 3)
			end
			l_class_name.to_upper
			l_class := class_by_name (l_class_name)
			if l_class /= Void then
				if a_with_brace then
					text_formatter.process_symbol_text (ti_l_curly)
				end
				text_formatter.process_class_name_text (l_class_name, l_class, False)
				if a_with_brace then
					text_formatter.process_symbol_text (ti_r_curly)
				end
				if l_class.is_compiled then
					last_type := l_class.compiled_class.actual_type
				end
			else
				add_text (ti_l_curly, False)
				add_text (l_class_name, False)
				add_text (ti_r_curly, False)
				reset_last_type
			end
		end

	add_cluster
			-- A cluster like [cluster] encountered.
		local
			l_text : STRING_32
			l_cluster_name: STRING_32
			l_cluster: CONF_GROUP
			l_strings: LIST [STRING_32]
			l_groups: ARRAYED_LIST [CONF_GROUP]
			l_str: STRING_32
		do
			l_text := unicode_text
			check
				l_text.count >= 2
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

	add_normal_text
			-- Add `text' to `text_formatter'.
		do
			add_text (unicode_text, False)
		end

	add_text (a_text: STRING_GENERAL; a_basic_comment: BOOLEAN)
			-- Add `a_text' as normal text.
		require
			a_text_not_void: a_text /= Void
		do
			if not a_text.is_empty then
				if for_comment then
					if a_basic_comment then
						text_formatter.process_quoted_text (a_text)
					else
						text_formatter.process_comment_text (a_text, Void)
					end
				else
					text_formatter.process_string_text (a_text, Void)
				end
			end
		end

	append_buffer
			-- Append token to `text_formatter'
		do
			if not buffer_string.is_empty then
				add_text (encoding_converter.utf8_to_utf32 (buffer_string), False)
				buffer_string.wipe_out
			end
		end

	buffer_token
			-- Buffer token.
		do
			buffer_string.append (utf8_text)
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

	reset_last_type
			-- Reset `last_type'
		do
			last_type := Void
		end

	class_by_name (name: READABLE_STRING_GENERAL): CLASS_I
			-- Return class with `name'. `Void' if not in system.
		require
			name_not_void: name /= Void
			is_class_name: (create {EIFFEL_SYNTAX_CHECKER}).is_valid_class_name (name) and name.as_upper.is_equal (name)
		local
			cl: LIST [CLASS_I]
		do
			cl := Eiffel_universe.classes_with_name (name)
			if cl /= Void and then not cl.is_empty then
				Result := cl.first
			end
		end

	feature_by_name (name: STRING): E_FEATURE
			-- Return feature in current class with `name'. `Void' if not in system.
		local
			cc: CLASS_C
			l_feature_i: FEATURE_I
			l_f_table: FEATURE_TABLE
		do
			last_is_alias := False
			if last_type /= Void then
				cc := last_type.base_class
			end
			if cc /= Void then
				if not name.is_empty and then cc.has_feature_table then
					l_f_table := cc.feature_table
					if l_f_table.is_mangled_alias_name (name) then
							-- Lookup for alias feature
						l_feature_i := l_f_table.alias_item (name)
						last_is_alias := l_feature_i /= Void
					else
							-- Lookup for identifier feature
						l_feature_i := l_f_table.item (name)
						last_is_alias := False
					end
					if l_feature_i /= Void then
						Result := l_feature_i.api_feature (cc.class_id)
					end
				end
			end
		end

	last_is_alias: BOOLEAN;
			-- Is last feature by `feature_by_name' an alias?

invariant
	invariant_clause: True -- Your invariant here

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
