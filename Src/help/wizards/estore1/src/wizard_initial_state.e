indexing
	description: "Ask the user the data needed to connect a Database"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INITIAL_STATE

inherit
	WIZARD_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info
		end

creation
	make

feature -- basic Operations

	display is 
			-- Display user entries
		do
			build
		end

	build is 
			-- Build entries.
		local
			h1: EV_HORIZONTAL_BOX
		do 

			Create h1
			Create oracle_b.make_with_text("Oracle")
			Create odbc_b.make_with_text("ODBC")
			odbc_b.press_actions.extend(~set_handle_insensitive(FALSE))
			if not wizard_information.is_oracle then
				odbc_b.enable_select 
			else
				oracle_b.enable_select
			end
			oracle_b.press_actions.extend(~set_handle_insensitive(TRUE))
			Create db_name.make("Data Source Name",wizard_information.data_source,10,20,Current)
			Create username.make("username",wizard_information.username,10,20,Current)
			Create password.make("Password",wizard_information.password,10,20,Current)
			
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(h1)
			h1.extend(odbc_b)
			h1.extend(oracle_b)
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(username)
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(password)
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(db_name)
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.disable_child_expand(username)
			main_box.disable_child_expand(password)
			main_box.disable_child_expand(db_name)	

			set_updatable_entries(<<oracle_b.press_actions,
									odbc_b.press_actions,
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
			message: EV_ERROR_DIALOG
			db_generation: DB_GENERATION
		do
			precursor
			if not b then
				if odbc_b.is_selected then
--					set_database(odbc)
					set_database(oracle)
				else
					set_database(oracle)
--					set_database(odbc)
				end
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
				password.text,db_name.text,oracle_b.is_selected)
			precursor			
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

	oracle_b,odbc_b: EV_RADIO_BUTTON
		-- Database Type selection thanks to radio buttons.

	pixmap_location: FILE_NAME is
			-- Pixmap location
		once
			create Result.make_from_string ("essai")
			Result.add_extension ("bmp")
		end

end -- class WIZARD_INITIAL_STATE
