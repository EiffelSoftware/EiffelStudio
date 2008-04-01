indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_POSTCONDITION_CONTRACT_EDITOR_CONTEXT

inherit
	ES_FEATURE_CONTRACT_EDITOR_CONTEXT

feature {NONE} -- Factory

	create_text_modifier: !ES_POSTCONDITION_CONTRACT_TEXT_MODIFIER
			-- <Precursor>
		do
			create Result.make (context_feature, context_class)
		end

feature {NONE} -- Population

	contract_keywords (a_origin: BOOLEAN): !ARRAYED_LIST [EDITOR_TOKEN]
			-- <Precursor>
		do
			if a_origin then
				create Result.make (1)
			else
				create Result.make (3)
			end
			Result.extend (create {EDITOR_TOKEN_KEYWORD}.make ("ensure"))
			if not a_origin then
				Result.extend (create {EDITOR_TOKEN_SPACE}.make (1))
				Result.extend (create {EDITOR_TOKEN_KEYWORD}.make ("then"))
			end
		end

feature -- Query

	has_contracts_in_class (a_class: !CLASS_C): BOOLEAN
			-- <Precursor>
		do
			Result := context_feature.has_postcondition
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
