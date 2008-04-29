indexing
	description: "Context for third pass that tracks variables usage. It is void-unsafe by default."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class AST_VARIABLE_CONTEXT

feature -- Status report

	is_attribute_set (feature_id: INTEGER): BOOLEAN
			-- Is an attribute identified by `feature_id' set (for the current compound)?
		require
			feature_id_positive: feature_id > 0
		do
			Result := True
		end

	is_attribute_initialized (feature_id: INTEGER): BOOLEAN
			-- Is attribute of `feature_id' initialized at end of a feature body?
		do
			Result := True
		end

feature -- Modification

	start_creation_procedure
			-- Start processing of a creation procedure.
		do
		end

	start_feature
			-- Start processing of a non-creation feature.
		do
		end

	enter_compound
			-- Record that a new compound is entered.
		do
		end

	leave_compound
			-- Record that a compound is terminated.
		do
		end

	set_attribute (feature_id: INTEGER)
			-- Mark that an attribute identified by `feature_id' is set.
		do
		ensure
			is_attribute_set: is_attribute_set (feature_id)
		end

	wipe_out
			-- Remove any information about variables usage.
		do
		end

indexing
	copyright:	"Copyright (c) 2007-2008, Eiffel Software"
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
