indexing
	description : "Objects that ..."
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
			if not explorer_bar_item.is_visible then
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
			unattach_from_explorer_bar
			attach_to_explorer_bar (a_bar)
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

end -- class ES_TOOL_NOTEBOOK_TABABLE
