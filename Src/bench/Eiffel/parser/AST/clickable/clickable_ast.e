indexing
	description: "An ast that has a position and associated api class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

deferred class
	CLICKABLE_AST
	
inherit
	AST_EIFFEL
		undefine
			number_of_breakpoint_slots
		end

feature -- Properties

	is_class: BOOLEAN is
			-- Does the Current AST represent a class?
		do
		end

	is_feature: BOOLEAN is
			-- Does the Current AST represent a feature?
		do
		end

	is_precursor: BOOLEAN is
			-- Does the Current AST represent a Precursor construct?
		do
		end

feature -- Access

	feature_name: ID_AS is
			-- Associated `feature_name' if Current represents a feature
		require
			is_feature: is_feature
		do
		ensure
			feature_name_not_void: Result /= Void
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

end -- class CLICKABLE_AST
