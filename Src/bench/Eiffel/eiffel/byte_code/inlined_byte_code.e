indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class INLINED_BYTE_CODE

inherit

	STD_BYTE_CODE
		redefine
			has_inlined_code
		end

feature

	fill_from (std: STD_BYTE_CODE) is
		do
			arguments := std.arguments
			body_index := std.body_index
			feature_name_id := std.feature_name_id
			locals := std.locals
			old_expressions := std.old_expressions
			pattern_id := std.pattern_id
			postcondition := std.postcondition
			precondition := std.precondition
			real_body_id := std.real_body_id
			rescue_clause := std.rescue_clause
			result_type := std.result_type
			rout_id := std.rout_id
			compound := std.compound
			once_manifest_string_count := std.once_manifest_string_count
		end

	has_inlined_code: BOOLEAN is
		do
			Result := True
		end

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
