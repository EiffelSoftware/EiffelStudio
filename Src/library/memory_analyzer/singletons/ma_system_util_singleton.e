indexing
	description: "The objects whichs the whole Memory Analyzer System all use"
	date: "$Date$"
	revision: "$Revision$"

class
	MA_SYSTEM_UTIL_SINGLETON
	
inherit
	MA_SINGLETON_FACTORY
		
	
feature -- System functions

	collect is
			-- Perform a GC cycle.
		do
			memory.full_collect
			memory.full_coalesce
			memory.full_collect
		end
	
	toggle_gc (a_button: EV_TOOL_BAR_TOGGLE_BUTTON) is
			-- Disable or enable GC
		require
			a_button_not_void: a_button /= Void
		do
			if a_button.is_selected then
				memory.collection_off
				a_button.set_pixmap (icons.pixmap_file_content (icons.icon_gabage_clean_disable))
				a_button.set_tooltip ("Enable GC")
			else
				memory.collection_on
				a_button.set_pixmap (icons.pixmap_file_content (icons.icon_gabage_clean_enable))
				a_button.set_tooltip ("Disable GC")
			end
		ensure
			collection_state_changed: old memory.collecting implies not memory.collecting
			button_pixmap_changed: a_button.pixmap /= old a_button.pixmap
			button_tooltip_changed: a_button.tooltip /= old a_button.tooltip
		end
end
