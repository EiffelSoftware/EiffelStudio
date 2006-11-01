indexing
	description: "The main window of the application"
	author: "Jocelyn FIAT"
	version: "1.2"
	date: "$Date$"
	revision: "$Revision$"

class 
	MINER_WINDOW

inherit
	EV_TITLED_WINDOW

 	MINER_CONSTANTS
		undefine
			default_create, copy
		end

creation
	default_create

feature -- Initialization

	initialize_with (nx,ny:INTEGER; trans: BOOLEAN) is
		do
			set_transparent (trans)
			nb_x := nx
			nb_y := ny

			set_title ("MineSweeper  -- ZaDoR (c) --")
			init_menu
			init_window
		end

	new_menu_item: EV_MENU_ITEM
	end_menu_item: EV_MENU_ITEM
	debug_menu_item: EV_CHECK_MENU_ITEM
	init_menu is
		local
			mbar: EV_MENU_BAR
			menu: EV_MENU
			menu_item: EV_MENU_ITEM
		do
			create mbar
			set_menu_bar (mbar)

			create menu.make_with_text ("&Game")
			mbar.extend (menu)

			create new_menu_item.make_with_text ("New Game")
			menu.extend (new_menu_item)
			create end_menu_item.make_with_text ("End Game")
			menu.extend (end_menu_item)
			
			new_menu_item.select_actions.extend (~new_game_action)
			end_menu_item.select_actions.extend (~end_game_action)

			debug ("SHOW_MINE")
				if is_debuggable then
					create debug_menu_item.make_with_text ("Debug (On/Off)")
					menu.extend (debug_menu_item)
					debug_menu_item.select_actions.extend (~toggle_debug_action)
					if debug_menu_item.is_selected /= debugging then
						debug_menu_item.toggle
					end
				end
			end

			create menu.make_with_text ("&?")
			mbar.extend (menu)

			create menu_item.make_with_text ("About")
			menu.extend (menu_item)
			menu_item.select_actions.extend (~show_about_action)
		end
	
	init_window is
			-- Initialize the window.
		local
			game_frame:EV_FRAME
			control_frame:EV_FRAME
			global_zone:EV_VERTICAL_BOX
			delai:INTEGER
			timer: EV_TIMEOUT
		do
			set_level (Level_default)
			set_title ("MineSweeper ["+nb_x.out+"x"+nb_y.out+"] -- ZaDoR (c) --")
			set_background_color (bg_color)

				--| global zone
			create global_zone
			extend (global_zone)

				--| game zone
			create game_frame
			global_zone.extend (game_frame)
			create_game_zone (game_frame, nb_x, nb_y )

				--| control zone
			create control_frame
			global_zone.extend (control_frame)
			global_zone.disable_item_expand (control_frame)
 			create_control_zone ( control_frame )

				--| Timer creation
			create miner_timer.make (label_time)
			delai := 500
			create timer.make_with_interval (delai)
			timer.actions.extend (miner_timer~execute (delai))
			miner_timer.start

				--| prepare the battle field ... the field of mines
			reset_mine_field
		end;

feature -- About box

	about_dlg: EV_TITLED_WINDOW is
			-- About box
		local
			pixbox: EV_FRAME
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			lab: EV_LABEL
			color: EV_COLOR
			logo: EV_BUTTON
		once
			create Result.make_with_title ("About")

			Result.close_request_actions.extend (~hide_about_action)
			Result.disable_user_resize

			create hbox
			Result.extend (hbox)

			create vbox
			hbox.extend (vbox)

			create pixbox
			hbox.extend (pixbox)

			hbox.disable_item_expand (pixbox)

			create logo
			logo.set_pixmap (pix_about)
			pixbox.extend (logo)


			create lab
			vbox.extend (lab)
			vbox.disable_item_expand (lab)
			lab.set_minimum_height (40)
			create color
			color.set_rgb_with_8_bit (200,200,255)
			lab.align_text_center
			lab.set_background_color (color)
			lab.set_foreground_color (colors.dark_blue)
			lab.set_text ("%N%
					%MineSweeper%N%
					%")

			create hbox
			vbox.extend (hbox)

			create lab
			hbox.extend (lab)
			hbox.disable_item_expand (lab)
			lab.set_minimum_width (140)
			lab.align_text_center
			lab.set_background_color (colors.dark_blue)
			lab.set_foreground_color (colors.yellow)
			lab.set_text ("%N%
					%> ZaDoR <%N%N%
					%version 1.2%N%N%
					%by Jocelyn Fiat%N%
					%Jocelyn.Fiat@ifrance.com%N%
					%")

			create lab
			hbox.extend (lab)
			create color; color.set_rgb_with_8_bit (255,255,222)
			lab.set_background_color (colors.black)
			lab.set_foreground_color (color)
			lab.set_text ("%N%
					%   -- Help --%N%
					%   %N%
					%   usage: (-x value) (-y value) (-t)%N%
					%   %N%
					%   try a square%T%T-> left click          %N%
					%   auto try around%T%T-> double left click   %N%
					%   mark / unmark%T%T-> right click        %N%
					%")
		end

	show_about_box is
		do
			about_dlg.set_size (390,160)
			about_dlg.restore
			about_dlg.show
		end

	hide_about_box is
		do
			about_dlg.hide
		end

feature -- Mines and Field

	nb_x: INTEGER
			-- nb of columns
	nb_y: INTEGER
			-- nb of rows

	is_debuggable: BOOLEAN
			-- is debugging allowed ?

	debugging: BOOLEAN
			-- is in debugging state ?

	game_over: BOOLEAN
			-- is game over ?

	miner_timer: MINER_TIMER
			-- command time
			-- objet to manage the timer...

	random:RANDOM is
			-- Initialize a randon number
		local
			time: TIME
		once
			!! time.make_now
			!! Result.make
			random.set_seed(time.seconds)
			random.start
		ensure
			result_not_void : Result /= Void
		end


	mines: ARRAY2[MINER_BUTTON] is
			-- Table of mine buttons
			-- created once.
		once
			!! Result.make(nb_x,nb_y)
			create_mine_field
		end

	create_game_zone (ev:EV_CONTAINER; h_max,v_max:INTEGER) is
			-- Create the game zone.
		local
			game_box:EV_VERTICAL_BOX
			v_index, h_index :INTEGER
			line:EV_HORIZONTAL_BOX
			mine_b:MINER_BUTTON
		do
			create game_box
			ev.extend (game_box)

			from
				v_index := 1
			until
				v_index > v_max
			loop
				create line
				game_box.extend (line)
				from
					h_index := 1
				until
					h_index > h_max
				loop
					
					mine_b := mines.item (h_index,v_index)
					line.extend (mine_b)
					mine_b.set_pixmap (pix_first)

					mine_b.pointer_button_press_actions.extend (~show_button_action (h_index, v_index, ?,?,?,?,?,?,?,?) )
					mine_b.pointer_double_press_actions.extend (~auto_action (h_index, v_index, ?,?,?,?,?,?,?,?) )
					h_index := h_index + 1
				end
				v_index := v_index + 1
			end

		end

feature -- Game info

	label: EV_LABEL is
			-- Label widget to display various information
		once
			create Result.make_with_text ("Label")
			Result.set_background_color (bg_color)
			Result.set_foreground_color (fg_color)
			Result.align_text_center
		end

	label_time: EV_LABEL is
			-- Label widget to display the time
		once
			create Result.make_with_text ("Label Time")
			Result.set_background_color (bg_color)
			Result.set_foreground_color (fg_time_color)
			Result.set_text ("00:00:00")
			Result.align_text_center
		end

	set_label_text (txt: STRING) is
		do
			label.set_text (txt)
		end

	set_label_time_text (txt: STRING) is
		do
			label_time.set_text (txt)
		end

feature -- Game level

	level: INTEGER
			-- Internal value for the level

	set_level (val: INTEGER) is
			-- Set the level of the game.
		do
			level := val
			if level > Level_max then
				level := Level_max
			end
			if level < Level_min then
				level := Level_min
			end
		end

feature -- Game status

	new_game is
			-- Start a new game.
		do
			set_game_over (False)
			reset_mine_field
			set_label_text (start_message)
		end

	win_game is
			-- End the game with success.
		do
			set_game_over (True)
			set_label_text ("%NBRAVO")
		end

	end_game is
			-- End the game.
		do
			set_game_over (True)
			show_mine_field
			set_label_text ("%NGAME OVER")
			set_label_time_text ("NEW GAME ?")
		end

	set_game_over (val: BOOLEAN) is
			-- Set the game Over.
		do
			game_over := val
			if game_over then
				miner_timer.stop
				new_menu_item.disable_sensitive
				end_menu_item.enable_sensitive
			else
				miner_timer.start
				new_menu_item.enable_sensitive
				end_menu_item.disable_sensitive
			end
		end


	mine_nb (i,j: INTEGER): INTEGER is
			-- Mine with coordonates (i,j)
		local
			nb: INTEGER
		do
			nb:=0
			if (i>1) and then (j>1) 		then nb:=nb + mines.item(i-1,j-1).code 	end
			if (i>1) 						then nb:=nb + mines.item(i-1,j).code 	end
			if (i>1) and then (j<nb_y) 		then nb:=nb + mines.item(i-1,j+1).code 	end
			if (j>1) 						then nb:=nb + mines.item(i,j-1).code 	end
			if (j<nb_y) 					then nb:=nb + mines.item(i,j+1).code 	end
			if (i<nb_x) and then (j>1) 		then nb:=nb + mines.item(i+1,j-1).code 	end
			if (i<nb_x) 					then nb:=nb + mines.item(i+1,j).code 	end
			if (i<nb_x) and then (j<nb_y) 	then nb:=nb + mines.item(i+1,j+1).code 	end
			Result := nb
		end

	show_button (i,j: INTEGER) is
			-- Show the button reality.
			-- flag, mine, or free
		require
			correct_i: i>0 and then i <= nb_x
			correct_j: j>0 and then j <= nb_y
			button_exist: mines.item(i,j) /= Void
		local
			nb:INTEGER
			mine:MINER_BUTTON
		do
			mine := mines.item(i,j)

			if game_over and mine.is_flagged then
				mine.discover_it
			elseif mine.is_trapped and not mine.is_flagged then
				mine.show_it
				if not game_over then
					end_game
				end
			
			elseif not (mine.is_shown or else mine.is_flagged) then
  				nb_marked := nb_marked+1
				set_label_text ("%N" + mine_todo.out)
				mine.show_it

				nb := mine_nb (i,j)

				inspect nb
					when 0 then mine.set_pixmap (pix_but @ 0)
						if (i>1) and then (j>1) 		then show_button (i-1, j-1) end
						if (i>1) 						then show_button (i-1, j  ) end
						if (i>1) and then (j<nb_y) 		then show_button (i-1, j+1) end
						if (j>1) 						then show_button (i  , j-1) end
						if (j<nb_y) 					then show_button (i  , j+1) end
						if (i<nb_x) and then (j>1) 		then show_button (i+1, j-1) end
						if (i<nb_x) 					then show_button (i+1, j  ) end
						if (i<nb_x) and then (j<nb_y) 	then show_button (i+1, j+1) end
					when 1 then mines.item(i,j).set_pixmap (pix_but @ 1)
					when 2 then mines.item(i,j).set_pixmap (pix_but @ 2)
					when 3 then mines.item(i,j).set_pixmap (pix_but @ 3)
					when 4 then mines.item(i,j).set_pixmap (pix_but @ 4)
					when 5 then mines.item(i,j).set_pixmap (pix_but @ 5)
					when 6 then mines.item(i,j).set_pixmap (pix_but @ 6)
					when 7 then mines.item(i,j).set_pixmap (pix_but @ 7)
					when 8 then mines.item(i,j).set_pixmap (pix_but @ 8)
				end
			end
		end

	create_mine_field is
			-- create the field of mines.
		local
			i,j:INTEGER
			but: MINER_BUTTON
		do
			nb_mine := 0
			nb_marked := 0

			from i:=1
			until i> nb_x
			loop
				from
					j:=1
				until
					j> nb_y
				loop
					create but
					but.init_mine

					mines.force( but,i,j )
					but.set_pixmap(pix_first)
					but.set_trapped(False)
					nb_mine:= nb_mine+1
					j:= j+1
				end
				i := i+1
			end
		end

	reset_mine_field is
			-- Reset the field of mines.
			-- (random generation of mine)
		local
			i,j:INTEGER
		do
			nb_mine:=0
			nb_marked:=0
			from
				i:=1
			until
				i> nb_x
			loop
				from
					j:=1
				until
					j> nb_y
				loop
					mines.item (i,j).reset
					random.forth
					if (random.item \\ level = 1) then
						mines.item (i,j).set_trapped (True)
						nb_mine := nb_mine+1
						if debugging then
							mines.item (i,j).set_pixmap (pix_boum)
						end
					else
						mines.item (i,j).set_trapped (False)
					end
					j:= j+1
				end
				i:= i+1
			end
		end

	nb_mine: INTEGER
			-- number of mines

	nb_marked: INTEGER
			-- number of marked mines

	show_mine_field is
			-- Discover and show the whole field.
		local
			i,j:INTEGER
		do
			from
				i:=1
			until
				i>nb_x
			loop
				from
					j:=1
				until
					j>nb_y
				loop
					show_button (i,j)
					j:= j+1
				end
				i:= i+1
			end
		end

	mine_todo: INTEGER is
			-- Number of mine to discover
		do 
			Result :=nb_x * nb_y - nb_mine - nb_marked
		end

	create_control_zone (ev: EV_CONTAINER) is
			-- Create the control box.
		local
			control_zone_label: EV_VERTICAL_BOX
			control_zone: EV_HORIZONTAL_BOX
			control_zone_level: EV_VERTICAL_BOX
			control_zone_restart: EV_BUTTON
			control_zone_level_up: EV_BUTTON
			control_zone_level_down: EV_BUTTON
		do
			create control_zone
			ev.extend (control_zone)
			create control_zone_label
			control_zone.extend (control_zone_label)

			create control_zone_level
			control_zone.extend (control_zone_level)

 			control_zone.disable_item_expand (control_zone_level)

			create control_zone_level_up
			control_zone_level.extend (control_zone_level_up)
			control_zone_level_up.set_pixmap (pix_levelup)

			create control_zone_level_down
			control_zone_level.extend (control_zone_level_down)
			control_zone_level_down.set_pixmap (pix_leveldown)

			create control_zone_restart
			control_zone.extend (control_zone_restart)
			control_zone_restart.set_pixmap (pix_restart)
 			control_zone.disable_item_expand (control_zone_restart)

			set_label_text (start_message)
			control_zone_label.extend (label)
			set_label_time_text ( "00:00:00" )
			control_zone_label.extend (label_time)

			control_zone_restart.select_actions.extend (~restart_action)
			control_zone_level_up.select_actions.extend (~change_level_action (+1) )
			control_zone_level_down.select_actions.extend (~change_level_action (-1) )

		end

	

	start_message:STRING is
			-- First message of the game
		do
			Result := "%NGOOD LUCK (";
			inspect level 
				when 2 then 
					Result.append ("Very Hard")
				when 3 then 
					Result.append ("Hard")
				when 4 then 
					Result.append ("Medium")
				when 5 then 
					Result.append ("Easy")
				when 6 then 
					Result.append ("Very Easy")
				else
					Result.append (level.out)
			end
			Result.append (")")
		end

feature -- command action

	show_about_action is
		do
			show_about_box
		end

	hide_about_action is
		do
			hide_about_box
		end

	new_game_action is
		do
			new_game
		end

	end_game_action is
		do
			end_game
		end

	set_debuggable is
			-- Toggle debugging allowed.
		do
			is_debuggable := True
		end

	toggle_debug_action (z_key: EV_KEY) is
			-- Toggle debugging action.
		do
			debugging := not debugging
			debug ("SHOW_MINE")
				if debug_menu_item.is_selected /= debugging then
					debug_menu_item.toggle
				end
			end
		end

	change_level_action (arg: INTEGER) is
			-- Change the level.
		do
			set_level (level - arg)
			new_game
		end

	restart_action is
			-- Restart the game or End it.
		do
			if game_over then
				new_game
			else
				end_game
			end
		end

	show_button_action (h_i, v_i: INTEGER; 
					z_x, z_y: INTEGER;
					z_button: INTEGER;
					z_x_tilt, z_y_tilt: DOUBLE;
					z_pressure: DOUBLE;
					z_screen_x, z_screen_y: INTEGER) is
			-- Show_button callback
		do
			if z_button = 1 then
				show_button (h_i, v_i)
				if mine_todo = 0 and then not game_over then
					win_game
				end
			end
		end

	auto_action (h_i, v_i: INTEGER; 
					z_x, z_y: INTEGER;
					z_button: INTEGER;
					z_x_tilt, z_y_tilt: DOUBLE;
					z_pressure: DOUBLE;
					z_screen_x, z_screen_y: INTEGER) is
			-- Automatic click on the possible safe mines around.
		local
			i,j: INTEGER
			nb: INTEGER
		do
			if z_button = 1 then
				i := h_i
				j := v_i
				if mines.item (i,j).is_shown then
					nb := 0 -- nb of marked mine
					if (i>1) and then (j>1) 	then nb:=nb+ mines.item(i-1,j-1).flagcode end
					if (i>1) 					then nb:=nb + mines.item(i-1,j).flagcode end
					if (i>1) and then (j<nb_y) 	then nb:=nb + mines.item(i-1,j+1).flagcode end
					if (j>1) 					then nb:=nb + mines.item(i,j-1).flagcode end
					if (j<nb_y) 				then nb:=nb + mines.item(i,j+1).flagcode end
					if (i<nb_x) and then (j>1) 	then nb:=nb + mines.item(i+1,j-1).flagcode end
					if (i<nb_x) 				then nb:=nb + mines.item(i+1,j).flagcode end
					if (i<nb_x) and then (j<nb_y) then nb:=nb + mines.item(i+1,j+1).flagcode end

					if nb = mine_nb (i,j) then
						if i>1 and then j>1 	then show_button (i-1,j-1) end
						if i>1 					then show_button (i-1,j) end
						if i>1 and then j<nb_y 	then	show_button (i-1,j+1) end

						if j<nb_y 				then show_button (i,j+1) end


						if j>1 					then show_button (i,j-1) end

						if i<nb_x and then j<nb_y 	then show_button (i+1,j+1) end
						if i<nb_x 					then show_button (i+1,j) end
						if i<nb_x and then j>1 		then show_button (i+1,j-1) end

					end

					if mine_todo = 0 and then not game_over then
						win_game
					end
				end
			end
		end


end -- class MINER_WINDOW

--|-------------------------------------------------------------------------
--| Eiffel Mine Sweeper -- ZaDoR (c) -- 
--| version 1.2 (July 2001)
--|
--| by Jocelyn FIAT
--| email: jocelyn.fiat@ifrance.com
--| 
--| freely distributable
--|-------------------------------------------------------------------------

