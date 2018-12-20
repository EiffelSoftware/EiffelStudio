note
	description: "Automated fix for an issue in a feature."

class
	ES_FIX_FEATURE

inherit

	EB_CONSTANTS

	ES_FIX
		redefine
			item
		end

	ES_SHARED_PROMPT_PROVIDER export {NONE} all end

create
	make

feature {NONE} -- Access

	item: FIX_FEATURE
			-- The fix to apply.

feature -- Fixing

	apply_to (m: ES_CLASS_TEXT_AST_MODIFIER)
			-- <Precursor>
		do
			if m.is_ast_available and then attached m.ast.feature_of_name_32 (item.source_feature.name_32, False) as a then
				item.apply (a, m.ast_match_list)
			else
				prompts.show_error_prompt (interface_names.l_syntax_error, Void, Void)
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2014-2017, Eiffel Software"
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
