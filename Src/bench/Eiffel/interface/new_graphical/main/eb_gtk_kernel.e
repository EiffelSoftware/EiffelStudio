indexing
	description: "Core of the application for GTK application"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GTK_KERNEL

inherit
	EB_KERNEL

create
	make

feature

	io_watcher2: IO_WATCHER
			-- Request handler.

	listen_to: RAW_FILE
			-- File used to listen.

	create_handler is
		do
			create listen_to.make ("toto")
			listen_to.fd_open_read (Listen_to_const)

			create io_watcher2.make_with_medium (listen_to)
			io_watcher2.read_actions.wipe_out
			io_watcher2.error_actions.wipe_out
			io_watcher2.exception_actions.wipe_out
			io_watcher2.read_actions.extend (~execute (Void))
			io_watcher2.error_actions.extend (~execute (Void))
			io_watcher2.exception_actions.extend (~execute (Void))

		end

end -- class EB_KERNEL
