note
	description: "A cancellable download task."
	author: "Alexey Kolesnichenko, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_TASK

inherit

	CP_DEFAULT_TASK

create
	make, make_from_separate

feature {NONE} -- Initialization

	make (a_url: like url)
			-- Initialization for `Current'.
		do
			url := a_url
		end

feature {CP_DYNAMIC_TYPE_IMPORTER} -- Initialization

	make_from_separate (other: separate DOWNLOAD_TASK)
			-- <Precursor>
		do
			create url.make_from_separate (other.url)
			promise := other.promise
		end

feature -- Access

	url: STRING

feature -- Basic operations

	run
			-- <Precursor>
		local
			download_fragments: ARRAYED_LIST [STRING]
			http_downloader: detachable HTTP_PROTOCOL
			size: INTEGER
		do
			create download_fragments.make (50)
			create http_downloader.make (create {HTTP_URL}.make(url))

			from
					-- Start the download
				http_downloader.set_read_mode
				http_downloader.open
				http_downloader.initiate_transfer
				size := http_downloader.count
			until
					-- Terminate when either the download is finished or the user cancels the download manually.
				http_downloader.bytes_transferred = size or attached promise as l_promise and then is_promise_cancelled (l_promise)
			loop
					-- Receive a single packet.
				http_downloader.read
				if attached http_downloader.last_packet as l_packet then
					download_fragments.extend (l_packet)
				end
					-- Update the progress information in the UI.
				if attached promise as l_promise then
					promise_set_progress (l_promise, http_downloader.bytes_transferred / size)
				end
			end

				-- A real application would do something with the code.
			download_fragments.wipe_out
			http_downloader.close

--			;(create {EXECUTION_ENVIRONMENT}).sleep (500000000)
		rescue
			if attached http_downloader as dl and then dl.is_open then
				dl.close
			end
		end
end
