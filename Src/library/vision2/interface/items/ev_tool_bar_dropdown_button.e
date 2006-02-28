indexing
	description:
		"[
			Press dropdown button for use with EV_TOOL_BAR
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_DROP_DOWN_BUTTON

inherit
	EV_TOOL_BAR_BUTTON
		export
			{ANY} drop_down_actions
		redefine
			create_implementation,
			implementation
		end

create
	default_create,
	make_with_text

feature -- Basic operations

	enable_whole_drop_down is
			-- Enable whole button to drop down style.
		do
		end

	disable_while_drop_down is
			-- Disable whole button drop down style.
		do
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_TOOL_BAR_DROP_DOWN_BUTTON_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TOOL_BAR_DROP_DOWN_BUTTON_IMP} implementation.make (Current)
		end

end
