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
			lab: EV_LABEL
			hbox: EV_HORIZONTAL_BOX
			empty_space: EV_CELL
		do 
			create dbms_cbox
			fill_dbms_cbox
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
			if is_oracle (wizard_information.dbms_code) then
				db_name.widget.disable_sensitive
			end

			create hbox
			choice_box.extend (hbox)
			create lab.make_with_text (" DBMS:")
			lab.align_text_left
			hbox.extend (lab)
			hbox.extend (create {EV_CELL})	
			hbox.extend (dbms_cbox)
			create empty_space
			empty_space.set_minimum_height (dialog_unit_to_pixels(2))
			choice_box.extend (empty_space)
			choice_box.extend (create {EV_CELL})
			choice_box.extend (username.widget)
			choice_box.extend (create {EV_CELL})
			choice_box.extend (password.widget)
			choice_box.extend (create {EV_CELL})
			choice_box.extend (db_name.widget)
			choice_box.extend (create {EV_CELL})
			choice_box.disable_item_expand (hbox)
			choice_box.disable_item_expand (db_name.widget)
			choice_box.disable_item_expand (username.widget)
			choice_box.disable_item_expand (password.widget)

			set_updatable_entries (<<dbms_cbox.select_actions,
									db_name.change_actions,
									username.change_actions,
									password.change_actions>>)
		end

	fill_dbms_cbox is
			-- Set values of `dbms_cbox'.
		require
			not_void: dbms_cbox /= Void
		local
			it: EV_LIST_ITEM
			av_dbms_list: ARRAYED_LIST [STRING]
		do
			av_dbms_list := Available_dbms.db_display_name_list
			from
				av_dbms_list.start
			until
				av_dbms_list.after
			loop
				create it.make_with_text (av_dbms_list.item)
				it.set_data (av_dbms_list.index)
				dbms_cbox.extend (it)
				if av_dbms_list.index = wizard_information.dbms_code then
					it.enable_select
				end
				av_dbms_list.forth
			end
			dbms_cbox.select_actions.extend (~update_fields)
		end

	proceed_with_current_info is 
			-- Process user entries
		require else
			user_typed_something: entries_changed
		local
			b: BOOLEAN
			uname, pword, dname: STRING
			db_man: DATABASE_MANAGER [DATABASE]
		do
			Precursor
			if not b then
				db_man := db_manager (wizard_information.dbms_code)
				if db_man.is_connected then
					db_man.disconnect
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
				db_man.set_connection_information (uname, pword, dname)
				db_man.establish_connection
			end
			if not b and then db_man.is_connected then
				proceed_with_new_state (create {DB_GENERATION}.make (wizard_information))
			else
				proceed_with_new_state (create {WIZARD_NOT_CONNECTED_STATE}.make (wizard_information))
			end
		rescue
			b := True
			retry
		end

	update_state_information is
			-- Check user entries
		local
			integer_value: INTEGER_REF
		do
			integer_value ?= dbms_cbox.selected_item.data
			check
					-- Data of `dbms_cbox' must carry dbms codes.
				not_void: integer_value /= Void
			end
			wizard_information.set_database_info (username.text,
				password.text, db_name.text, integer_value.item)
			Precursor			
		end

	display_state_text is
		do
			title.set_text ("STEP 1: CONNECTION TO YOUR DATABASE")
			message.set_text ("Select first a DBMS.%N%NEnter then the Username, Password and Database Source%NIn order to connect to the database you are going to use with EiffelStore ")
		end

	update_fields is
			-- Update fields according to new DBMS selected.
		local
			integer_value: INTEGER_REF
		do
			username.remove_text
			password.remove_text
			db_name.remove_text
			integer_value ?= dbms_cbox.selected_item.data
			check
					-- Data of `dbms_cbox' must carry dbms codes.
				not_void: integer_value /= Void
			end
			if is_oracle (integer_value.item) then
				db_name.widget.disable_sensitive
			else
				db_name.widget.enable_sensitive
			end
		end

feature -- Implementation

	username, password, db_name: WIZARD_SMART_TEXT_FIELD
		-- User text entries dealing with username, password and
		-- Database Handle name.

	dbms_cbox: EV_COMBO_BOX
		-- Combo-box to select a DBMS.

	Label_size: INTEGER is 10
		-- Label size for connection data text fields.
	
	Capacity: INTEGER is 20
		-- Capacity for connection data text fields.
		
end -- class DB_CONNECTION
