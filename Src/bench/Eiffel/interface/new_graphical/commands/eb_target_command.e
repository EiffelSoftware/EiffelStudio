indexing
	description	: "Abstract notion of a command associated with a target"
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	EB_TARGET_COMMAND

inherit
	EB_COMMAND

feature {NONE} -- Initialization

	make (a_target: like target) is
			-- Initialize the command with target `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			target := a_target
			initialize
		ensure
			target_set: equal (a_target, target)
		end

	initialize is
			-- Initialize default values.
		deferred
		end

feature -- Properties

	target: ANY
			-- Target for the command.

invariant
	target_not_void: target /= Void

end -- class EB_FILEABLE_COMMAND
