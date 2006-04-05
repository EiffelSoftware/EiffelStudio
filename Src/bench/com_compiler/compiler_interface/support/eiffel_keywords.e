indexing
	description: "Eiffel keywords information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_KEYWORDS

feature -- Access

	Agent_keyword: STRING is "agent"
			-- Eiffel agent keyword

	Feature_keyword: STRING is "feature"
			-- Eiffel feature keyword

	Precursor_keyword: STRING is "precursor"
			-- Eiffel precursor keyword

	Create_keyword: STRING is "create"
			-- Eiffel create keyword

	agent_keyword_length: INTEGER is
			-- Eiffel agent keyword character count
		once
			Result := agent_keyword.count
		end

	feature_keyword_length: INTEGER is
			-- Eiffel feature keyword character count
		once
			Result := feature_keyword.count
		end

	precursor_keyword_length: INTEGER is
			-- Eiffel precursor keyword character count
		once
			Result := precursor_keyword.count
		end

	create_keyword_length: INTEGER is
			-- Eiffel create keyword character count
		once
			Result := create_keyword.count
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
end -- class EIFFEL_KEYWORDS
