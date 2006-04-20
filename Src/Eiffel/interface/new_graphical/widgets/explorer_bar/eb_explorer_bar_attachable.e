indexing
	description : "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred 
class
	EB_EXPLORER_BAR_ATTACHABLE

feature -- Attachement

	attach_to_explorer_bar (a_bar: EB_EXPLORER_BAR) is
			-- Set `explorer_bar' to `a_bar'.
		require
			a_bar_exists: a_bar /= Void
			not_attached: explorer_bar_item = Void
		do
			if explorer_bar_item = Void then
				build_explorer_bar_item (a_bar)
			else
				set_explorer_bar (a_bar)
			end
		ensure
			explorer_bar_item_exists: explorer_bar_item /= Void
		end
		
	unattach_from_explorer_bar is
		require
			attached: explorer_bar_item /= Void
		do
			if explorer_bar_item.is_closeable then
				explorer_bar_item.close
			end
			explorer_bar_item.recycle
			explorer_bar_item := Void
		ensure
			explorer_bar_item = Void
		end
		
	change_attach_explorer (a_bar: EB_EXPLORER_BAR) is
		require
			a_bar_exists: a_bar /= Void
			attached: explorer_bar_item /= Void
		do
			if a_bar /= explorer_bar_item.parent then
				unattach_from_explorer_bar
				attach_to_explorer_bar (a_bar)
			end
		end

	set_explorer_bar (a_bar: EB_EXPLORER_BAR) is
			-- Set `explorer_bar' to `a_bar'.
		require
			explorer_bar_item /= Void
		do
			explorer_bar_item.set_parent (a_bar)
		end

feature -- Access

	explorer_bar_item: EB_EXPLORER_BAR_ITEM
			-- Associated explorer bar item.

feature {NONE} -- Build implementation

	build_explorer_bar_item (an_explorer_bar: EB_EXPLORER_BAR) is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		require
			an_explorer_bar_exists: an_explorer_bar /= Void
		deferred
		ensure
			explorer_bar_item_created: explorer_bar_item /= Void
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

end -- class ES_TOOL_NOTEBOOK_TABABLE
