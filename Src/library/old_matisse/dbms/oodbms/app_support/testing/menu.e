indexing
	description: "Simple menu class"
	keywords:    "menu"
	revision:    "%%A%%"
	source:      "%%P%%"
	copyright:   "See notice at end of class"

class MENU

creation
	make

feature -- Initialisation
	make(a_title:STRING) is
		require
			title_exists: a_title /= Void
		do
			title := a_title
			title.to_upper
			!!items.make
			all_item := clone(default_all_item)
			quit_item := clone(default_quit_item)
		ensure
			All_item_initialised: all_item.is_equal(default_all_item)
			Quit_item_initialised: quit_item.is_equal(default_quit_item)
		end

feature -- Modification
	add_item(s:STRING) is
			-- an empty string creates a blank line in the menu display
		require
			Item_Exists: s /= Void
		do
			items.extend(s)
		end

	set_all_item(s:STRING) is
			-- string to display for All option
		require
			Item_Exists: s /= Void
		do
			all_item := s
		end

	set_quit_item(s:STRING) is
			-- string to display for Quit option
		require
			Item_Exists: s /= Void
		do
			quit_item := s
		end

	clear is
			-- wipe out menu items and reset selection state
		do
			items.wipe_out
			selection := 0
			quit_selected := False
			all_selected := False
		end

feature -- Output
	display is
		local
			i:INTEGER
		do
			io.put_string("%N=====  ") io.put_string(title) io.put_string("  ===============%N%N")
			from 
				items.start 
				i := 1
			until 
				items.off 
			loop
				io.put_string("< ") io.put_integer(i) io.put_string(" >  ")
				io.put_string(items.item) io.new_line
				items.forth
				i := i + 1
			end

			io.new_line
			io.put_string("< A >  ") io.put_string(all_item) io.new_line
			io.put_string("< Q >  ") io.put_string(quit_item) io.new_line
			io.new_line
		end

feature -- commands
	choose is
			-- get an answer from the user; must be between 1 and number of items added;
			-- result in 'selection'
		local
			ans_in_range:BOOLEAN
			finished:BOOLEAN
			str:STRING
		do
			from
				selection := 0
				quit_selected := False
				all_selected := False
			until 
				quit_selected or all_selected or ans_in_range 
			loop
				io.put_string("       Choice (1-") io.put_integer(items.count) io.put_string(", a, q): ")
				io.read_line
				str := io.last_string
				str.to_lower
				if str.is_integer then
					if str.to_integer > 0 and str.to_integer <= items.count then
						ans_in_range := True
						selection := str.to_integer
					else
						io.put_string("Response out of range%N")
					end
				elseif str.is_equal("a") then
					all_selected := True
				elseif str.is_equal("q") then
					quit_selected := True
				else
					io.put_string("Invalid response%N")
				end
			end
			io.new_line
		end

feature -- Status
	selection:INTEGER
		-- last menu selection; 0 if all or quit is True

	all_selected:BOOLEAN
		-- True if last 'select' resulted in "All"

	quit_selected:BOOLEAN
		-- True if last 'select' resulted in "Quit"

feature {NONE} -- Implementation
	title:STRING
	items:LINKED_LIST[STRING]
	quit_item:STRING
	all_item:STRING

	default_quit_item:STRING is "Quit"
	default_all_item:STRING is "All"

invariant
	Title_exists: title /= Void
	Items_exists: items /= Void
	All_item_exists: all_item /= Void
	Quit_item_exists: quit_item /= Void
	All_consistency: all_selected implies selection = 0
	Quit_consistency: quit_selected implies selection = 0

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                 Copyright (c) 1998                |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication,   modification   and   distribution  |
--         | permitted with this notice  intact.  Please send  |
--         | modifications  and suggestions  to  Deep Thought  |
--         | Informatics, in  the  interests  of  maintenance  |
--         | and improvement.                                  |
--         |                                                   |
--         | Use of this software is on the understanding that |
--         | the  author(s)  accept no  liability of any kind. |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+

