indexing
	description: "Ask the user the data needed to connect a Database"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_INITIALIZATION

inherit
	STATE_WINDOW
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
			h1,h2,h3,h4,h5,h6: EV_HORIZONTAL_BOX
		do 
			Create db_name.make("Handle",state_information.handle,10,20,Current)
			Create username.make("username",state_information.username,10,20,Current)
			Create password.make("Password",state_information.password,10,20,Current)
			main_box.extend(db_name)
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(username)
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(password)
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.disable_child_expand(username)
			main_box.disable_child_expand(password)
			main_box.disable_child_expand(db_name)	
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
				Create db_generation.make(state_information)
				if db_manager.connected then
					db_manager.disconnect
				end
				db_manager.log_and_connect (username.text,password.text)
			end
			if not b and then db_manager.connected then
				proceed_with_new_state(db_generation)
			else
				Create message.make_with_text("Connection Failed")
				entries_checked := FALSE
				entries_changed := TRUE
				message.show_modal
			end
		rescue
			b := TRUE
			retry
		end

	update_state_information is
			-- Check user entries
		do
			state_information.set_database_info(username.text,
				password.text,db_name.text)
			precursor			
		end

feature -- Implementation

	username,password,db_name: SMART_TEXT_FIELD

end -- class DB_INITIALIZATION
