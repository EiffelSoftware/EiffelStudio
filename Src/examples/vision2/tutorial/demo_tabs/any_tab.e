deferred class
	ANY_TAB


inherit
	EV_VERTICAL_BOX

feature -- Element change

	set_current_widget (wid: EV_WIDGET) is
			-- Make `wid' the new widget.
		do
			current_widget ?= wid
		end

	name:STRING is
		deferred
	end

feature -- Access

	current_widget: EV_WIDGET

end -- class ANY_TAB
