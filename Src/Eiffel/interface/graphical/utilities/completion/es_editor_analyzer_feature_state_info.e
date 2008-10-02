indexing
	description: "[
			A specialized editor analyzer state info object, specifically for use within features.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_ANALYZER_FEATURE_STATE_INFO

inherit
	ES_EDITOR_ANALYZER_STATE_INFO

create
	make

feature -- Access

	feature_name: ?STRING_32 assign set_feature_name
			-- The name of the located feature

feature -- Element change

	set_feature_name (a_name: ?like feature_name)
			-- Set the current state result's feature name
			--
			-- `a_name': The name of the feature.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			feature_name := a_name.twin
		ensure
			feature_name_set: feature_name.is_equal (a_name)
		end

feature -- Status report

	is_inline_agent: BOOLEAN assign set_is_inline_agent
			-- Indicates if the located feature is an inline agent.

feature -- Status setting

	set_is_inline_agent (a_inline: like is_inline_agent)
			-- Sets the state to indicate if the current state result represents an inline agent.
			--
			-- `a_inline': True to indicate an inline agent; False otherwise.
		do
			is_inline_agent := a_inline
		ensure
			is_inline_agent_set: is_inline_agent = a_inline
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
