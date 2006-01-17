indexing
	description: "Objects that is a base class for all Eiffel Studio models."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_ITEM
	
feature -- Status report

	is_needed_on_diagram: BOOLEAN
			-- Is `Current' needed on diagram.
			-- False when the item was inserted and then
			-- removed with the undo command. The undo
			-- insert command (EIFFEL_WORLD) does not
			-- remove the item from the graph, but hide it
			-- in the world. A new view should not show
			-- this item.
			
feature -- Access

	needed_on_diagram_changed_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Called when `is_needed_on_diagram' changed.
		do
			if internal_needed_on_diagram_changed = Void then
				create internal_needed_on_diagram_changed
				internal_needed_on_diagram_changed.compare_objects
			end
			Result := internal_needed_on_diagram_changed
		end
			
feature -- Status settings.

	enable_needed_on_diagram is
			-- Set `is_needed_on_diagram' to True.
		do
			if not is_needed_on_diagram then
				is_needed_on_diagram := True
				needed_on_diagram_changed_actions.call (Void)
			end
		ensure
			set: is_needed_on_diagram
		end
		
	disable_needed_on_diagram is
			-- Set `is_needed_on_diagram' to False.
		do
			if is_needed_on_diagram then
				is_needed_on_diagram := False
				needed_on_diagram_changed_actions.call (Void)
			end
		ensure
			set: not is_needed_on_diagram
		end
		
feature -- Element change
		
	synchronize is
			-- Some properties may have changed due to recompilation.
		deferred
		end
		
feature {NONE} -- Implementation

	internal_needed_on_diagram_changed: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation for `needed_on_diagram_changed'.
			
invariant
	needed_on_diagram_changed_actions_not_void: needed_on_diagram_changed_actions /= Void

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

end -- class ES_ITEM
