note
	description : "The SCOOP email downloader tutorial root class."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	PLAYER

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			tutorial: INTEGER
		do
			create <NONE> client.make

			separate client as c do
				downloader := c.downloader
				viewer := c.viewer
				mover := c.mover
				messages := c.messages
			end

			if argument_count = 1 then
				tutorial := argument (1).to_integer
				inspect tutorial
				when 1 then
					play1
				when 2 then
					play2
				when 3 then
					play3
				when 4 then
					play4
				when 5 then
					play5
				when 10 then
					play10
				else
					print ("Invalid number.%N")
				end
			else
				play1
			end
		end

feature -- Access

	client: separate CLIENT
			-- The email downloader client managing the list of messages.

	downloader: separate DOWNLOADER
			-- The download engine.

	viewer: separate VIEWER
			-- The viewer engine.

	mover: separate MOVER
			-- The mover engine.

	messages: separate LINKED_LIST[separate STRING]
			-- To be removed...

feature -- Tutorial: Main execution feature.

	play1
			-- Start the downloader, viewer and mover concurrently.
		do
			live_all (downloader, viewer, mover)
		end

	live_all(d: separate DOWNLOADER; v: separate VIEWER; m: separate MOVER)
			-- Run d, v, and m concurrently.
		do
			d.live
			v.live
			m.live
		end


feature -- Tutorial: Order preservation and synchronization.

	play2
			-- Download two messages.
		do
			separate downloader as d do
				d.download_one_fixed
				d.download_one_fixed
			end
		end

	play3
			-- Download a message, view a message.
		do
			separate downloader as d, viewer as v do
				d.download_one_fixed
				v.view_one (messages)
			end
		end

	play4
			-- Download two messages, find out how many were downloaded.
		local
			n: INTEGER
		do
			separate downloader as d do
				d.download_one_fixed
				d.download_one_fixed
				n := d.count
				print (n)
			end
		end

	play5
			-- Download two messages, find out how many are in the list.
		local
			n: INTEGER
		do
			separate downloader as d do
				d.download_one_fixed
				d.download_one_fixed
				n := d.computed_count
				print (n)
			end
		end

feature -- Tutorial: Type system

	play6
			-- Show characteristics of the SCOOP typesystem.
		local
			c: CLIENT
		do
				-- Uncomment to get a compiler error.
--			c := client
		end

	play7(c: CLIENT)
			-- Show characteristics of the SCOOP typesystem.
		do
				-- Empty body OK, the signature is enough.
		end

	play8
			-- Show characteristics of the SCOOP typesystem.
		do
				-- Uncomment to get a compiler error.
--			play7 (client)
		end

feature -- Tutorial: Traitors

	close_friend: detachable PLAYER

	set_close_friend (p: PLAYER)
			-- Set `close_friend' to `p'.
		do
			close_friend := p
		end

	play9
			-- Show characteristics of the SCOOP typesystem.
		local
			remote_friend: separate PLAYER
		do
			create remote_friend.make
			separate remote_friend as l_friend do
					-- Uncomment to get a compiler error.
--				l_friend.set_close_friend (Current)
			end
		end

feature -- Tutorial: automatic conversion

	play10
			-- Print first client message if any.
		do
			separate client as c do
					-- Note: Automatic string conversion isn't implemented yet.
--				io.put_string (c.first)
			end
		end

end

