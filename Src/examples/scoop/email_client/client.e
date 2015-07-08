note
	description: "An email client that concurrently downloads and displays messages."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	CLIENT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create {LINKED_LIST [STRING]} messages.make
			create <NONE> controller
			create mover.make (Current)
			create viewer.make (Current)
			create downloader.make (Current)
		end

feature -- Access

	messages: LIST [STRING]
			-- Email messages received.

	downloader: detachable separate DOWNLOADER
			-- Downloading engine.

	viewer: detachable separate VIEWER
			-- Viewing engine.

	mover: detachable separate MOVER
			-- Archiving engine.

	controller: separate CONTROLLER
			-- A shared controller to signal a stop message.

feature -- Access

	first: separate STRING
			-- First message if any, otherwise empty.	
		do
			Result := ""
			if not messages.is_empty then
				Result := messages [1]
			end
		end

feature -- Basic operations

	extend (email: separate STRING)
			-- Add `email' to the email storage.
		local
			l_email: STRING
		do
			create l_email.make_from_separate (email)
			messages.extend (l_email)
		end

end
