note
	description: "Helper routines for AST outputs."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_OUTPUT_HELPER

inherit
	ANY

	SHARED_TEXT_ITEMS
		export
			{NONE} all
		end

feature -- Feature names

	append_unqualified_feature_call (a_feat: E_FEATURE; a_text_formatter: TEXT_FORMATTER)
			-- Append unqualified feature call,
			-- taking infix/prefix into account.
		require
			a_feat_not_void: a_feat /= Void
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			if a_feat.is_infix then
				a_text_formatter.process_symbol_text (ti_l_parenthesis)
				a_text_formatter.process_keyword_text (ti_current, Void)
				a_text_formatter.add_space
				a_text_formatter.process_operator_text (a_feat.extract_symbol_from_infix (a_feat.name), a_feat)
				a_text_formatter.process_symbol_text (ti_r_parenthesis)
			elseif a_feat.is_prefix then
				a_text_formatter.process_symbol_text (ti_l_parenthesis)
				a_text_formatter.process_operator_text (a_feat.extract_symbol_from_prefix (a_feat.name), a_feat)
				a_text_formatter.add_space
				a_text_formatter.process_keyword_text (ti_current, Void)
				a_text_formatter.process_symbol_text (ti_r_parenthesis)
			else
				a_text_formatter.process_feature_text (a_feat.name, a_feat, False)
			end
		end

	append_feature_name (a_feat: E_FEATURE; a_text_formatter: TEXT_FORMATTER)
			-- Append name of feature `a_feat',
			-- taking infix/prefix into account.
		require
			a_feat_not_void: a_feat /= Void
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			if a_feat.is_infix then
				a_text_formatter.process_keyword_text (ti_infix_keyword, Void)
				a_text_formatter.add_space
				a_text_formatter.process_symbol_text (ti_double_quote)
				a_text_formatter.process_operator_text (a_feat.extract_symbol_from_infix (a_feat.name), a_feat)
				a_text_formatter.process_symbol_text (ti_double_quote)
			elseif a_feat.is_prefix then
				a_text_formatter.process_keyword_text (ti_prefix_keyword, Void)
				a_text_formatter.add_space
				a_text_formatter.process_symbol_text (ti_double_quote)
				a_text_formatter.process_operator_text (a_feat.extract_symbol_from_prefix (a_feat.name), a_feat)
				a_text_formatter.process_symbol_text (ti_double_quote)
			else
				a_text_formatter.process_feature_text (a_feat.name, a_feat, False)
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end
