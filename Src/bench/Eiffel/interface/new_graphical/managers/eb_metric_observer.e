indexing
	description: "Observer for EB_METRIC_TOOL"
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

	notify_new_metric (a_new_metric: EB_METRIC; new_metric_element: XML_ELEMENT; overwrite: BOOLEAN; index: INTEGER) is
			-- The state of the manager has changed. New metrics have been added. Update `Current'.
		deferred
		end

	notify_management_metric (metric_list: LINKED_LIST [EB_METRIC]; xml_list: LINKED_LIST [XML_ELEMENT]) is
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

end -- class EB_METRIC_OBSERVER
