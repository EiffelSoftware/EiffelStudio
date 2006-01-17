indexing
	description : "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred 
class
	ES_NOTEBOOK_ATTACHABLE

feature -- Attachement

	attach_to_notebook (a_nb: ES_NOTEBOOK) is
		require
			notebook_exists: a_nb /= Void
			not_attached: notebook_item = Void			
		do
			if notebook_item = Void then
				build_notebook_item (a_nb)
			else
			end
		ensure
			notebook_item_exists: notebook_item /= Void
		end
		
	unattach_from_notebook is
		require
			attached: notebook_item /= Void
		do
			if not notebook_item.is_destroyed then
				notebook_item.close
			end
			notebook_item := Void
		ensure
			notebook_item = Void
		end
		
	change_attach_notebook (a_nb: ES_NOTEBOOK) is
		require
			a_nb_exists: a_nb /= Void
			attached: notebook_item /= Void
		do
			if notebook_item.parent /= a_nb then
				unattach_from_notebook
				attach_to_notebook (a_nb)
			end
		end

feature -- Access

	notebook_item: ES_NOTEBOOK_ITEM
			-- Associated note book tab.

feature {NONE} -- Build implementation

	build_notebook_item (a_nb: ES_NOTEBOOK) is
			-- Build associated notebook tab
			-- and add it to `a_nb'
		require
			a_nb /= Void
		deferred
		ensure
			notebook_item /= Void
		end

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

end
