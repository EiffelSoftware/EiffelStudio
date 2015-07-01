note
	description: "Summary description for {PLAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLIENT

create
	make

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

feature
	make
		--Initialization
		do
			create messages.make
			create downloader.make
			create viewer.make
			create mover.make
			create controller
			wrap_mail_file_allocation(downloader, viewer, mover)
		end


feature
		--wrapper	
	wrap_mail_file_allocation(d: separate DOWNLOADER; v: separate VIEWER; m: separate MOVER)
		do
			d.wrap_mail_file_allocation (current)
			v.wrap_mail_file_allocation (current)
			m.wrap_mail_file_allocation (current)
		end


end
