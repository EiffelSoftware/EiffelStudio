indexing
	description: "Root Window for the application"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW
 
inherit
	EV_TITLED_WINDOW

	DB_CONNECTION
		undefine
			default_create
		end
		
		-- Inherit DB_SHARED to have an access to the Database Manager
	DB_SHARED
		undefine
			default_create
		end
	
create
	make_window

feature -- Initialization

	make_window (appli: APPLICATION) is
			-- Initialize
		require
			not_void: appli /= Void
		do
			default_create
			application := appli		
			create_widgets
			retrieve_info
			init_connect
		ensure
			application_set: appli = application
		end

	init_connect is
			-- Connect to the database.
		require
			not_void: username /= Void and password /= Void and data_source /= Void
		local
			b: BOOLEAN
		do
			if not b then
				if not initialized then
					db_manager.log_and_connect (username, password, data_source)
				end
				b := db_manager.session_control.is_connected 
				if b then
					initialized := TRUE
				end
			end
			if not b then
				io.put_string ("Connection Failed.%NPlease Check UserName and Password")
			end
		rescue
			b := TRUE
 			retry
		end

	create_widgets is
			-- Design of the window, creation of buttons.
		local
			v0: EV_VERTICAL_BOX
			cell: EV_CELL
			h1: EV_HORIZONTAL_BOX
			b1: EV_BUTTON
			lab: EV_LABEL
		do

			create v0
			v0.set_border_width (5)
			extend (v0)

			create cell
			cell.set_minimum_height (5)
			--cell.set_background_color (white)
			v0.extend (cell)
			v0.disable_item_expand (cell)

			create h1
			h1.set_border_width (2)
			create cell
			cell.set_minimum_width (10)
			h1.extend (cell)
			h1.disable_item_expand (cell)
			create cell
			cell.set_minimum_size (60, 20)
			create lab.make_with_text ("Choose an operation:")
			--lab.set_background_color (white)
			lab.align_text_left
			--lab.set_minimal_size
			--lab.set_border_width (5)
			cell.extend (lab)
			h1.extend (cell)
			v0.extend (h1)
			v0.disable_item_expand (h1)

			create cell
			cell.set_minimum_height (10)
			--cell.set_background_color (white)
			v0.extend (cell)

			create h1
			h1.set_border_width (2)
			create b1.make_with_text_and_action ("Select", ~popup_select)
			b1.set_minimum_size (50, 20)
			h1.extend (b1)
			h1.disable_item_expand (b1)
			create cell
			cell.set_minimum_width (10)
			h1.extend (cell)
			h1.disable_item_expand (cell)
			create cell
			cell.set_minimum_size (200, 15)
			create lab.make_with_text ("Display information from the database")
			lab.align_text_left
			cell.extend (lab)
			h1.extend (cell)
			v0.extend (h1)
			v0.disable_item_expand (h1)

				-- Use this part to add an Update query.
				
--			create h1
--			h1.set_border_width (2)
--			create b1.make_with_text_and_action ("Update", ~exit)
--			b1.set_minimum_size (50, 20)
--			h1.extend (b1)
--			h1.disable_item_expand (b1)
--			create cell
--			cell.set_minimum_width (10)
--			h1.extend (cell)
--			h1.disable_item_expand (cell)
--			create cell
--			cell.set_minimum_size (120, 15)
--			create lab.make_with_text ("Modify information in the database")
--			lab.align_text_left
--			cell.extend (lab)
--			h1.extend (cell)
--			v0.extend (h1)
--			v0.disable_item_expand (h1)

			create h1
			h1.set_border_width (2)
			create b1.make_with_text_and_action ("Insert", ~popup_insert)
			b1.set_minimum_size (50, 20)
			h1.extend (b1)
			h1.disable_item_expand (b1)
			create cell
			cell.set_minimum_width (10)
			h1.extend (cell)
			h1.disable_item_expand (cell)
			create cell
			cell.set_minimum_size (120, 15)
			create lab.make_with_text ("Add a row to a table")
			lab.align_text_left
			cell.extend (lab)
			h1.extend (cell)
			v0.extend (h1)
			v0.disable_item_expand (h1)

			create h1
			h1.set_border_width (2)
			create b1.make_with_text_and_action ("Exit", ~exit)
			b1.set_minimum_size (50, 20)
			h1.extend (b1)
			h1.disable_item_expand (b1)
			create cell
			cell.set_minimum_width (10)
			h1.extend (cell)
			h1.disable_item_expand (cell)
			create cell
			cell.set_minimum_size (120, 15)
			create lab.make_with_text ("Quit the application")
			lab.align_text_left
			cell.extend (lab)
			h1.extend (cell)
			v0.extend (h1)
			v0.disable_item_expand (h1)
		end

feature -- Actions

	popup_select is
			-- Pop up select window.
		require
			appli_not_void: application /= Void
			initialized: initialized
		do
			application.popup_select_window
		end

	popup_insert is
			-- Pop up insert window.
		require
			appli_not_void: application /= Void
			initialized: initialized
		do
			application.popup_insert_window
		end

	exit is
			-- Exit the current window.
		require
			appli_not_void: application /= Void
		do
			current.destroy
			application.destroy_windows
		end



feature -- Implementation
	
	initialized: BOOLEAN
		-- Is the connection with the DB initialized ?
		
	application: APPLICATION
		-- Contains features for windows' management.

end -- class MAIN_WINDOW
