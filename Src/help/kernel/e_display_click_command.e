indexing
	description: "Gets calles when the user clicks on a hyperlink."
	author: "Vincent Brendel"

class
	E_DISPLAY_CLICK_COMMAND

inherit
	EV_COMMAND

creation
	make

feature -- Initialization

	make(displ:E_TOPIC_DISPLAY; ht:HASH_TABLE[E_TOPIC, STRING]) is
			-- Initialize
		do
			display := displ
			table := ht
		ensure
			display_set: display = displ
			table_set: table = ht
		end

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- args: Void;
		local
			md: EV_BUTTON_EVENT_DATA
			link: E_TOPIC_LINK
			
		do
			-- Check if there is a link on this position.
			md ?= data
			link := display.get_link_from_position(md.x, md.y)
			if link /= Void then
				table.item(link.topic_id).display(display)
			end
		end

	display: E_TOPIC_DISPLAY

	table:HASH_TABLE[E_TOPIC, STRING]

end -- class E_TOPIC_LINK_COMMAND
