
			indexing
	description	: "A tool that displays a text."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_TEXTABLE_TOOL

inherit
	EB_TOOL
		redefine
			widget,
			make
		end

	EB_STONABLE

	EB_TEXTABLE

feature -- Initialization

	make (a_manager: EB_DEVELOPMENT_WINDOW; an_explorer_bar: like explorer_bar) is
			-- Create a new tool with `a_manager' as manager.
		require else
			a_manager_exists: a_manager /= Void
			an_explorer_bar_exists: an_explorer_bar /= Void
		do
			Precursor (a_manager, an_explorer_bar)
			text_area.drop_actions.extend (a_manager~set_stone)
		end

feature -- Access

	stone: STONE is
			-- Stone for Current
		local
			stonable_manager: EB_STONABLE
		do
			stonable_manager ?= manager
			if stonable_manager /= Void then
				Result := stonable_manager.stone
			end
		end

feature -- Element change

	set_stone (new_stone: STONE) is
			-- Set `stone' to `new_stone'
		local
			stonable_manager: EB_STONABLE
		do
			stonable_manager ?= manager
			if stonable_manager /= Void then
				stonable_manager.set_stone (new_stone)
					-- `refresh' will be called by the manager.
			end
		end

feature -- Update

	refresh is
			-- Update screen according to `stone'.
			-- do not touch history.
			-- Nothing to do in default case.
		do
		end

	update_graphical_resources is
			-- Synchronize clickable elements with text, if possible
			-- and update the graphical values in text area.
		do
			refresh
		end

feature -- Pick and Throw Implementation

	drop_stone (s: STONE) is
			-- Drop a stone in Current.
		do
			if s /= Void then
				set_stone (s)
			end
		end

	reset is
			-- Reset the window contents.
		do
			text_area.clear_window
		end

end -- class EB_TEXT_TOOL
