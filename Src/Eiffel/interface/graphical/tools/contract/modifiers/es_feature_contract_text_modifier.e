indexing
	description: "[
		A feature contract text modifier for changing contracts on features.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_FEATURE_CONTRACT_TEXT_MODIFIER [G -> AST_EIFFEL]

inherit
	ES_CONTRACT_TEXT_MODIFIER [G]
		rename
			make as make_with_class
		redefine
			modified_data,
			new_modified_data
		end

	ES_FEATURE_TEXT_AST_MODIFIER
		redefine
			modified_data,
			new_modified_data
		end

feature {NONE} -- Access

	modified_data: !ES_FEATURE_TEXT_AST_MODIFIER_DATA
			-- <Precursor {ES_FEATURE_TEXT_AST_MODIFIER}>

feature {NONE} -- Factory

	new_modified_data: !like modified_data
			-- <Precursor {ES_FEATURE_TEXT_AST_MODIFIER}>
		do
			Result := Precursor {ES_FEATURE_TEXT_AST_MODIFIER}
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
