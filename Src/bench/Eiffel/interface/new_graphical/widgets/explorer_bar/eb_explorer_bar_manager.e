indexing
	description	: "Manager of one or more EB_EXPLORER_BAR"
	status		: "See notice at end of class"
	keywords	: "box, header, item, explorer, bar"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class 
	EB_EXPLORER_BAR_MANAGER

feature -- Element change

	close_bar (a_bar: EB_EXPLORER_BAR) is
			-- `a_bar' asks to be closed.
		require
			a_bar_valid: a_bar /= Void
		deferred
		end

	display_bar (a_bar: EB_EXPLORER_BAR) is
			-- Switch the current view to `a_bar'.
		require
			a_bar_valid: a_bar /= Void
		deferred
		end

	force_display_bar (a_bar: EB_EXPLORER_BAR) is
			-- Switch the current view to `a_bar'.
		require
			a_bar_valid: a_bar /= Void
		deferred
		end

	close_all_bars_except (a_bar: EB_EXPLORER_BAR) is
			-- An explorer bar item asks to be maximized.
		require
			a_bar_valid: a_bar /= Void
		deferred
		end

	restore_bars is
			-- A maximized item has been restored.
		deferred
		end

end -- class EB_EXPLORER_BAR_MANAGER

