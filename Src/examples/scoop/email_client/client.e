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
			create downloader.make (messages)
			create viewer.make (messages)
			create mover.make (messages)
		end

feature
	messages: LINKED_LIST[STRING]
	downloader: separate DOWNLOADER
	viewer: separate VIEWER
	mover: separate MOVER
	controller: separate CONTROLLER

feature
	first: STRING
			-- First message if any, otherwise empty.	
		do
			Result := ""
			if not messages.is_empty then Result := messages [1] end
		end


end
