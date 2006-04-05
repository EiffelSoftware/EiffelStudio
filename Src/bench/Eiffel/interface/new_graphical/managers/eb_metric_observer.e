indexing
	description: "Observer for EB_METRIC_TOOL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_OBSERVER

inherit
	EB_RECYCLABLE

feature -- Manager

	file_manager: EB_METRIC_FILE_MANAGER is
			-- Manager that handles `metric_file' for saving new metrics and measures.
		once
			create Result.make
		end

	notify_measure is
			-- The state of the manager has changed. Measures have been changed. Update `Current'.
		deferred
		end

	notify_new_metric (a_new_metric: EB_METRIC; new_metric_element: XM_ELEMENT; overwrite: BOOLEAN; index: INTEGER) is
			-- The state of the manager has changed. New metrics have been added. Update `Current'.
		deferred
		end

	notify_management_metric (metric_list: ARRAYED_LIST [EB_METRIC]; xml_list: ARRAYED_LIST [XM_ELEMENT]) is
			-- The state of the manager has changed. Metrics have been changed. Update `Current'.
		deferred
		end

	set_recompiled (bool: BOOLEAN) is
			-- Assign `bool' to `is_recompiled'.
		deferred
		end
		
	recycle is
			-- Remove all references to `Current', and leave `Current' in an 
			-- unstable state to make sure it is not referenced any more.
		do
			file_manager.remove_observer (Current)
		ensure then
			not file_manager.observer_list.has (Current)
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

end -- class EB_METRIC_OBSERVER
