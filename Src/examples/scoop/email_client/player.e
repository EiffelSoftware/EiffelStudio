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

feature
	make
		local
			str: STRING_8
		do
			create client.make
			wrap_downloader_viewer_mover(client)

			if
				argument_count = 1
			then
				str := argument(1)
				inspect str.to_integer
					when 1 then play1
					when 2 then play2
					when 3 then play3
					when 4 then play4
					when 5 then play5
					when 10 then play10
				end
			else
				play1
			end
		end

feature
		--wrapper
	wrap_downloader_viewer_mover(c: separate CLIENT)
		do
			downloader := c.downloader
			viewer := c.viewer
			mover := c.mover
			messages := c.messages
		end

feature
	play1
		do
			live_all(downloader, viewer, mover)
		end

feature
	play2
		do
			download_two(downloader, messages)
		end

feature
	play3
		do
			download_one_view_one(downloader, viewer, messages)
		end

feature
	play4
		do
			count_downloads_first_type(downloader, messages)
		end

feature
	play5
		do
			count_downloads_second_type(downloader, messages)
		end

feature
	play7(c: CLIENT)
		do

		end


feature
	play10
		do
			first_message_printer (client)
		end

feature
		--wrapper
	live_all(d: separate DOWNLOADER; v: separate VIEWER; m: separate MOVER)
		do
			d.live
			m.live
			v.live

		end

feature
		--wrapper
	download_two(d: separate DOWNLOADER; msg: separate LINKED_LIST[separate STRING])
		do
			d.download_one (msg)
			d.download_one (msg)
		end

feature
		--wrapper
	download_one_view_one(d: separate DOWNLOADER; v: separate VIEWER; msg: separate LINKED_LIST[separate STRING])
		do
			d.download_one(msg)
			v.view_one(msg)
		end
feature
		--wrapper
	count_downloads_first_type(d: separate DOWNLOADER; msg: separate LINKED_LIST[separate STRING])
		local
			n: INTEGER
		do
			d.download_one (msg)
			d.download_one (msg)
			n := d.count
			print(n)
		end

feature
		--wrapper
	count_downloads_second_type(d: separate DOWNLOADER; msg: separate LINKED_LIST[separate STRING])
		local
			n: INTEGER
		do
			d.download_one (msg)
			d.download_one (msg)
			n := d.computed_count
			print(n)
		end

feature
		--wrapper
	first_message_printer(c: separate CLIENT)
		local
			str: STRING
		do
			create str.make_from_separate (c.first)
			io.put_string (str)
		end

feature
	client: separate CLIENT
	downloader: separate DOWNLOADER
	viewer: separate VIEWER
	mover: separate MOVER
	messages: separate LINKED_LIST[separate STRING]


------------------------------------------------- TRAITOR EXAMPLE --------------------------------------------------------------------
--feature
--	close_friend: PLAYER
--	remote_friend: separate PLAYER

--feature
--	set_close_friend(p: PLAYER)
--		do
--			close_friend := p
--		end

--feature
--	play9
--		do
--			create remote_friend.make
--			remote_friend.set_close_friend(current)
--		end

------------------------------------COMPILATION ERROR EXAMPLE ILLUSTRATING THE SCOOP TYPE SYSTEM ---------------------------------------
--feature
--	play6
--		local
--			c: CLIENT
--		do
--			c := client
--		end
--feature
--	play8
--		do
--			play7(client)
--		end

--------------------------------------------- PARTS OF THE TUTORIAL WITH INLINE SEPARATE --------------------------------------
--feature
--	play2
--		do
--			separate downloader as d do
--				d.download_one (messages)
--				d.download_one (messages)
--			end

--		end

--feature
--	play3
--		do
--			separate downloader as d, viewer as v do
--				d.download_one(messages)
--				v.view_one(messages)
--			end
--		end

--feature
--	play4
--		local
--			n: INTEGER
--		do
--			separate downloader as d do
--				d.download_one (messages)
--				d.download_one (messages)
--				n := d.count
--				print(n)
--			end
--		end

--feature
--	play10
--		do
--			separate client as c do
--				io.put_new_line(c.first)
--			end
--		end


end

