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
			create messages.make
			create controller
			create viewer.make (messages, controller)
			create mover.make (messages, controller)
			create downloader.make (Current, controller)
		end

feature -- Access

	messages: LINKED_LIST [separate STRING]
			-- Email messages received.
			-- Note: The generic argument must be separate!

	downloader: detachable separate DOWNLOADER
			-- Downloading engine.

	viewer: separate VIEWER
			-- Viewing engine.

	mover: separate MOVER
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
