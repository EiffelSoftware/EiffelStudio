deferred class
	ANY_TAB


inherit
	EV_VERTICAL_BOX

feature -- Element change

	set_current_widget (value: like current_widget) is

			-- Make `wid' the new widget.
		do
			current_widget ?= value
		end

	name:STRING is
			-- Title of the current tab. 
		deferred
		end

feature -- Access

	current_widget: EV_ANY

end -- class ANY_TAB
