indexing
	description	: "Mechanism to call an action when a file/pipe is changed.%N%
				  %GTK Implementation."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	EB_IO_WATCHER_IMP

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
		do
			--create io_watcher
			--io_watcher.set_medium(a_medium)
		end

feature -- Access

	action: PROCEDURE [ANY, TUPLE] -- is
			-- Callback feature called with the file/pipe is changed.
--		do
--			if io_watcher.read_actions.empty then
--				Result := Void
--			else
--				Result := io_watcher.read_actions.first
--			end
--		end

feature -- Element change

	set_action (an_action: like action) is
			-- Set `an_action' as callback feature.
		require
			an_agent_not_void: an_action /= Void
		do
			action := an_action

			--io_watcher.read_actions.wipe_out
			--io_watcher.extend (an_action)
		ensure
			agent_set: action = an_action
		end

	remove_action is
			-- Remove the current action
		do
			action := Void

			-- io_watcher.read_actions.wipe_out
		ensure
			no_action: action = Void
		end

end -- EB_IO_WATCHER_IMP


