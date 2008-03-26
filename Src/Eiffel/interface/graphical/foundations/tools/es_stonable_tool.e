indexing
	description: "[
		A shim, allowing a context stone to be pushed, for EiffelStudio tools, providing access to information required without having to actually initialize the tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_STONABLE_TOOL [G -> ES_DOCKABLE_STONABLE_TOOL_PANEL [EV_WIDGET]]

inherit
	ES_TOOL [G]

	ES_STONABLE_I
		undefine
			out
		redefine
			set_stone
		end

feature -- Access

	stone: STONE assign set_stone
			-- Last set stone

feature -- Element change

	set_stone (a_stone: like stone)
			-- Sets last stone.
			--
			-- `a_stone': Stone to set.
		do
			stone := a_stone
			if is_tool_instantiated then
				panel.set_stone (a_stone)
			end
		end

feature -- Synchronization

	synchronize
			-- Synchronizes any new data (compiled or other wise)
		do
			if is_tool_instantiated then
				panel.synchronize
			end
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
