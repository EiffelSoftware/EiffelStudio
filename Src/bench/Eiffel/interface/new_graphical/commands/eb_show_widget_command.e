indexing
	description	: "Command to show/hide a widget"
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	EB_SHOW_WIDGET_COMMAND

inherit
	EB_TARGET_COMMAND
		redefine
			target,
			initialize
		end

creation
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize default values.
		do
			is_visible := target.is_show_requested
		end

feature -- Access

	is_visible: BOOLEAN
			-- Is current target visible?
	
feature -- Execution

	execute is
			-- toggle between show and hide.
		do
			if is_visible then
				disable_visible
			else
				enable_visible
			end
		end

	enable_visible is
			-- Set `is_visible' to True
		do
			if not is_visible then
				is_visible := True
				target.show
			end
		end

	disable_visible is
			-- Set `is_visible' to True
		do
			if is_visible then
				is_visible := False
				target.hide
			end
		end

feature {NONE} -- Implementation

	target: EV_WIDGET
			-- Target that can be shown or hidden.

end -- class EB_SHOW_COMMAND
