indexing
	description: "Text in the SNEAK_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class
	SNEAK_TEXT

inherit
	CLICKABLE_AREA
		-- note that we use this inheritance in order
		-- to be able go use the generate_chart of class_data...

creation
	make

feature -- Initialization

	make ( sn : SNEAK_WINDOW ) is
			-- Creation routine
		do
			sneak_w := sn
			init ( sneak_w , 10 )
			hide_horizontal_scrollbar
			hide_vertical_scrollbar
		end

feature -- attributes

	sneak_w : SNEAK_WINDOW

feature -- for compatibility ...
		-- this has to removed in the next future

	focus_label: CASE_FOCUS_LABEL  
			-- Label where focus_string is displayed


end -- class SNEAK_TEXT
