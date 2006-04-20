indexing
	description: "Criterion to test if a feature is a creator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_FEAT_CREATOR_CRITERION

inherit
	EQL_CRITERION

	SHARED_EIFFEL_PROJECT

feature -- Evaluation

	evaluate (a_context: EQL_CONTEXT): BOOLEAN is
		local
			l_creators: HASH_TABLE [EXPORT_I, STRING]
		do
			if  a_context.is_e_feature_set then
				l_creators := a_context.e_feature.associated_class.creators
				if l_creators = Void then
						-- Simply search for the version of `{ANY}.default_create'.
					Result := a_context.e_feature.rout_id_set.has (eiffel_system.system.default_create_id)
				elseif not l_creators.is_empty then
					Result := l_creators.has (a_context.e_feature.name)
				end
			end
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
