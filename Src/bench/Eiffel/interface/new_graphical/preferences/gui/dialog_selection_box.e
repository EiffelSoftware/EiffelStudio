indexing
	description: "Dialog Selection Box"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Pascal Freund and Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DIALOG_SELECTION_BOX

inherit
	SELECTION_BOX

feature -- Commands

	change is
			-- Change the value 
		do
			check
				resource_exists: resource /= Void
			end
			create_tool
			dialog_tool.ok_actions.extend (agent update_changes)
			dialog_tool.show_modal_to_window (caller)
		end 

	update_changes is
			-- Dialog Committing.
		require
			dialog_tool_exists: dialog_tool /= Void
		deferred 
		end

	create_tool is
		deferred 
		ensure
			tool_created: dialog_tool /= Void
		end

feature -- Implementation

	dialog_tool: EV_STANDARD_DIALOG 
		-- Tool which may be popuped from Current.

	change_b: EV_BUTTON;
		-- Button

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class DIALOG_SELECTION_BOX
