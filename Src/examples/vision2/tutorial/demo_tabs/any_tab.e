deferred class
	ANY_TAB


inherit
	EV_VERTICAL_BOX

feature -- Element change

	set_current_widget (wid: like current_widget) is
			-- Make `wid' the new widget.
		do
			current_widget ?= wid
		end

	name:STRING is
			-- Title of the current tab. 
		deferred
		end

feature -- Access

	current_widget: EV_WIDGET
			-- Current widget we are working on.

end -- class ANY_TAB
