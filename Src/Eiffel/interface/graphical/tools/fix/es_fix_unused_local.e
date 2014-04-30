﻿note
	description: "Fix of an unused local warning."

class
	ES_FIX_UNUSED_LOCAL

inherit
	EB_CONSTANTS
	ES_SHARED_PROMPT_PROVIDER export {NONE} all end
	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (f: FIX_UNUSED_LOCAL)
			-- Initialize with a fix `f' that may be applied.
		require
			is_class_writable: not f.source_class.is_read_only
		do
			item := f
		ensure
			item_set: item = f
		end

feature {ES_ERROR_LIST_TOOL_PANEL} -- Access

	item: FIX_UNUSED_LOCAL
			-- The fix to apply.

feature -- Fixing

	apply
		local
			m: ES_FEATURE_TEXT_AST_MODIFIER
			s: TUPLE [start_position: INTEGER_32; end_position: INTEGER_32]
			r: ERT_TOKEN_REGION
		do
			create m.make (item.source_feature, item.source_feature.written_class.lace_class)
			if m.is_modifiable then
				m.prepare
				if m.is_ast_available and then attached m.ast_feature as a then
					s := m.ast_position (a)
					r := a.token_region (m.ast_match_list)
					item.apply (a, m.ast_match_list)
					if m.ast_match_list.is_text_modified (r) then
						m.replace_code (s.start_position, s.end_position, m.ast_match_list.text (r))
						m.commit
					end
				else
					prompts.show_error_prompt (interface_names.l_syntax_error, Void, Void)
				end
			else
				prompts.show_error_prompt (interface_names.l_class_is_not_editable, Void, Void)
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2014, Eiffel Software"
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
