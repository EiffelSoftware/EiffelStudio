indexing
	description: "Ask the user the data needed to connect a Database"
	author: "David S"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_CONNECTION

inherit
	INTERMEDIARY_STATE_WINDOW
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
--			create oracle_b.make_with_text("Oracle")
--			create odbc_b.make_with_text("ODBC")
			create handle_b.make_with_text (handle_name)
			handle_b.select_actions.extend(~set_handle_insensitive(FALSE))
--			if wizard_information.is_oracle then
--				odbc_b.enable_select 
--			else
--				oracle_b.enable_select
--			end
--			oracle_b.enable_select
--			oracle_b.select_actions.extend(~set_handle_insensitive(TRUE))
			Create db_name.make("Data Source Name",wizard_information.data_source,10,20,Current, FALSE)
			Create username.make("Username",wizard_information.username,10,20,Current, FALSE)
			Create password.make("Password",wizard_information.password,10,20,Current, TRUE)
			

			choice_box.extend(h1)
			h1.extend (handle_b)
--			h1.extend(odbc_b)
--			h1.extend(oracle_b)

			choice_box.extend (username)
			choice_box.extend (create {EV_CELL})
			choice_box.extend (password)
			choice_box.extend (create {EV_CELL})
			if handle_name.is_equal ("ODBC") then
				choice_box.extend (db_name)
				choice_box.extend (create {EV_CELL})
				choice_box.disable_item_expand (db_name)
			end
			choice_box.disable_item_expand (username)
			choice_box.disable_item_expand (password)
	

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
			db_generation: DB_GENERATION
		do
			precursor
			if not b then
--				if odbc_b.is_selected then
					set_database(database_type)
--					set_database(oracle)
--				else
--					set_database(oracle)
--					set_database(database_type)
--				end
				if db_manager.connected then
					db_manager.disconnect
				end
				db_manager.log_and_connect (username.text,password.text,db_name.text)
			end
			if not b and then db_manager.connected then
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
			wizard_information.set_database_info(username.text,
				password.text,db_name.text,is_oracle)--oracle_b.is_selected)
			precursor			
		end

	display_state_text is
		do
			title.set_text ("STEP 1: CONNECTION TO YOUR DATABASE")
			message.set_text ("%NEnter the:%NUsername, Password and Database Source%NIn order to connect to the database you are going to use with EiffelStore ")
		end


	set_handle_insensitive(b: BOOLEAN) is
			-- Set Handle description insensitive.
		require
			handle_field_exists: db_name /= Void
		do
			db_name.set_text("")
			if not b then
				db_name.enable_sensitive
			else
				db_name.disable_sensitive
			end
		end

feature -- Implementation

	username,password,db_name: WIZARD_SMART_TEXT_FIELD
		-- User text entries dealing with username, password and
		-- Database Handle name.

--	oracle_b,odbc_b: EV_RADIO_BUTTON
		-- Database Type selection thanks to radio buttons.

end -- class DB_CONNECTION
