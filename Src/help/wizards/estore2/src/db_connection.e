indexing
	description: "Ask the user the data needed to connect a Database"
	author: "David S"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_CONNECTION

inherit
	WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

create
	make

feature -- basic Operations

	build is 
			-- Build entries.
		local
			h1: EV_HORIZONTAL_BOX
		do 

			create h1
			create handle_b.make_with_text (handle_name)
			handle_b.select_actions.extend(~set_handle_insensitive(FALSE))
			create db_name.make (Current)
			create username.make (Current)
			create password.make (Current)
			db_name.set_label_string_and_size ("Data Source Name", Label_size)
			username.set_label_string_and_size ("Username", Label_size)
			password.set_label_string_and_size ("Password", Label_size)
			password.enable_password
			db_name.set_textfield_string_and_capacity (wizard_information.data_source, Capacity)
			username.set_textfield_string_and_capacity (wizard_information.username, Capacity)
			password.set_textfield_string_and_capacity (wizard_information.password, Capacity)
			db_name.generate
			username.generate
			password.generate
			choice_box.extend(h1)
			h1.extend (handle_b)

			choice_box.extend (username.widget)
			choice_box.extend (create {EV_CELL})
			choice_box.extend (password.widget)
			choice_box.extend (create {EV_CELL})
			if handle_name.is_equal ("ODBC") then
				choice_box.extend (db_name.widget)
				choice_box.extend (create {EV_CELL})
				choice_box.disable_item_expand (db_name.widget)
			end
			choice_box.disable_item_expand (username.widget)
			choice_box.disable_item_expand (password.widget)
	

			set_updatable_entries (<<--oracle_b.select_actions,
									handle_b.select_actions,
									db_name.change_actions,
									username.change_actions,
									password.change_actions>>)
		end

	proceed_with_current_info is 
			-- Process user entries
		require else
			user_typed_something: entries_changed
		local
			b: BOOLEAN
			uname, pword, dname: STRING
		do
			Precursor
			if not b then
				set_database (database_type)
				if db_manager.is_connected then
					db_manager.disconnect
				end
				uname := username.text
				if uname = Void then
					uname := ""
				end
				pword := password.text
				if pword = Void then
					pword := ""
				end
				dname := db_name.text
				if dname = Void then
					dname := ""
				end
				db_manager.set_connection_information (uname, pword, dname)
				db_manager.establish_connection
			end
			if not b and then db_manager.is_connected then
				proceed_with_new_state(Create {DB_GENERATION}.make(wizard_information))
			else
				proceed_with_new_state(Create {WIZARD_NOT_CONNECTED_STATE}.make(wizard_information))
			end
		rescue
			b := TRUE
			retry
		end

	update_state_information is
			-- Check user entries
		do
			wizard_information.set_database_info (username.text,
				password.text, db_name.text, is_oracle)
			Precursor			
		end

	display_state_text is
		do
			title.set_text ("STEP 1: CONNECTION TO YOUR DATABASE")
			message.set_text ("%NEnter the:%NUsername, Password and Database Source%NIn order to connect to the database you are going to use with EiffelStore ")
		end


	set_handle_insensitive (b: BOOLEAN) is
			-- Set Handle description insensitive.
		require
			handle_field_exists: db_name /= Void
		do
		--FIXME	db_name.set_text("")
			if not b then
		--FIXME		db_name.enable_sensitive
			else
		--FIXME		db_name.disable_sensitive
			end
		end

feature -- Implementation

	username, password, db_name: WIZARD_SMART_TEXT_FIELD
		-- User text entries dealing with username, password and
		-- Database Handle name.

	Label_size: INTEGER is 10
		-- Label size for connection data text fields.
	
	Capacity: INTEGER is 20
		-- CApacity for connection data text fields.
		
end -- class DB_CONNECTION
