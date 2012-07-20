note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_SHARED_PROMPT_PROVIDER

feature -- Access

	frozen prompts: ES_PROMPT_PROVIDER
			-- Shared access to a prompts provider
		do
			if attached prompts_cell.item as l_prompts then
				Result := l_prompts
			else
				create Result
				prompts_cell.put (Result)
			end
		end

feature -- Status Report

	is_prompts_set: BOOLEAN
			-- Has `prompts' been queried or set once?
		do
			Result := prompts_cell.item /= Void
		end

feature -- Element change

	set_prompts (a_prompt_provider: like prompts)
			-- Set `prompts' with `a_prompt_provider'.
		require
			not_set: not is_prompts_set
		do
			prompts_cell.put (a_prompt_provider)
		ensure
			prompts_set: prompts = a_prompt_provider
		end

feature {NONE} -- Storage

	prompts_cell: CELL [detachable ES_PROMPT_PROVIDER]
		once
			create Result.put (Void)
		end

;note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
