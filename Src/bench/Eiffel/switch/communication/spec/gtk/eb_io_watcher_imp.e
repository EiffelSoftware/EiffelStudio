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

	IO_CONST
		undefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
		do
			create listen_to.make ("toto")
			listen_to.fd_open_read (Listen_to_const)
			create io_watcher.make_with_medium (listen_to)
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

			io_watcher.read_actions.wipe_out
			io_watcher.read_actions.extend (an_action)
			io_watcher.error_actions.wipe_out
			io_watcher.error_actions.extend (an_action)
			io_watcher.exception_actions.wipe_out
			io_watcher.exception_actions.extend (an_action)

		ensure
			agent_set: action = an_action
		end

	remove_action is
			-- Remove the current action
		do
			action := Void
			
			io_watcher.error_actions.wipe_out
			io_watcher.exception_actions.wipe_out
			io_watcher.read_actions.wipe_out
		ensure
			no_action: action = Void
		end

feature {NONE} -- Implementation

	io_watcher: IO_WATCHER
			-- Toolkit to watch for changes on a specific file.

	listen_to: RAW_FILE
			-- File used to listen.

end -- EB_IO_WATCHER_IMP


