indexing
	description: "[
		A shim for EiffelStudio debugger tools, providing access to information required without having to actually initialize the tool.
		
		Note: Descendant shim implementation are created dynamically as such:
              (A) No creation routine should be used, so please mark `default_create' as a non exported creation routine.
              (B) All initialization of the shim should be done by redefining `initialize', where `window' will be available
                  as an attached entity carrying the hosted development window, as will the `edition' number.
              (C) Recycle memory management is handled automatically so there is no need to call `recycle' on this shim or on
                  the created tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_DEBUGGER_TOOL [G -> EB_TOOL]

inherit
	ES_TOOL [G]
		redefine
			profile_kind
		end

feature -- Access

	profile_kind: !UUID
			-- <Precursor>
		once
			Result := (create {ES_TOOL_PROFILE_KINDS}).debugger
		end

feature -- Access

	frozen debugger_manager: !EB_DEBUGGER_MANAGER
			-- Debugger manager to use for tool creation
		require
			is_interface_usable: is_interface_usable
			window_is_interface_usable: window.is_interface_usable
		do
			Result ?= window.debugger_manager
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
