indexing
	description: "The configuration descriptor for one business object type."
	keywords:    ""
	revision:    "%%A%%"
	source:      "%%P%%"
	requirements:""

class BUS_OBJ_DESC

creation
	make, make_from_string

feature -- Initialisation
	make(a_name:STRING; user_mod_flag, rep_mod_flag, rep_ref_flag:BOOLEAN) is
			-- initialise from config file entry items
		require
			Name_valid: a_name /= Void and then not a_name.empty
		do
			name := a_name
			name.to_upper
			user_modifiable := user_mod_flag
			rep_modifiable := rep_mod_flag
			rep_reference := rep_ref_flag

			is_valid := True

			debug("archetype")
			    io.put_string("BUS_OBJ_CONFIG_ITEM ") io.put_string(name)
			    io.put_string(", ") io.put_boolean(user_modifiable)
			    io.put_string(", ") io.put_boolean(rep_modifiable)
			    io.put_string(", ") io.put_boolean(rep_reference)
			    io.new_line
			end
		end

	make_from_string(a_str:STRING) is
			-- initialise database config file TAB-separated entry
		require
			Str_exists: a_str /= Void and then not a_str.empty
		local
			cfg_entry:STRING_EX
			a_name:STRING
			user_mod_flag_str, rep_mod_flag_str, rep_ref_flag_str:STRING
			user_mod_flag, rep_mod_flag, rep_ref_flag:BOOLEAN
		do
			!!invalid_reason.make(0)

			!!cfg_entry.make(0)
			cfg_entry.make_from_string(a_str)
			cfg_entry.use_whitespace_parsing

			-- check nr tokens
			if cfg_entry.token_count /= entry_tokens_expected then
				invalid_reason.append("Db_config_item: invalid number tokens ")
				invalid_reason.append_integer(cfg_entry.token_count)
				invalid_reason.append(" in entry. ")
			else
	 			cfg_entry.token_start
	
				-- get name
				a_name := cfg_entry.token_item
				cfg_entry.token_forth

				-- get user modifiable flag
				user_mod_flag_str := cfg_entry.token_item
				if user_mod_flag_str.is_boolean then
					user_mod_flag := user_mod_flag_str.to_boolean
				else
					invalid_reason.append("Db_config_item: invalid user_mod_flag for entry ")
					invalid_reason.append(a_name)
					invalid_reason.append(". ")
				end
				cfg_entry.token_forth

				-- get repository modifiable flag
				rep_mod_flag_str := cfg_entry.token_item
				if rep_mod_flag_str.is_boolean then
					rep_mod_flag := rep_mod_flag_str.to_boolean
				else
					invalid_reason.append("Db_config_item: invalid rep_mod_flag for entry ")
					invalid_reason.append(a_name)
					invalid_reason.append(". ")
				end
				cfg_entry.token_forth

				-- get repository reference flag
				rep_ref_flag_str := cfg_entry.token_item
				if rep_ref_flag_str.is_boolean then
					rep_ref_flag := rep_ref_flag_str.to_boolean
				else
					invalid_reason.append("Db_config_item: invalid rep_ref_flag for entry ")
					invalid_reason.append(a_name)
					invalid_reason.append(". ")
				end
				cfg_entry.token_forth

				make(a_name, user_mod_flag, rep_mod_flag, rep_ref_flag)
			end
		end

feature -- Access
	Entry_tokens_expected:INTEGER is 4

	Null_entry:STRING is "-"
		    -- string for empty entries in table

	name:STRING
	user_modifiable:BOOLEAN
	rep_modifiable:BOOLEAN
	rep_reference:BOOLEAN

	is_valid:BOOLEAN
	invalid_reason:STRING

feature -- Status
	is_valid_for_rep_item:BOOLEAN is
			-- True if the BUS_OBJ_DESC can be used with a REP_ITEM
		do
			Result := True
		end

invariant
	Invalid_reason_given: not is_valid implies invalid_reason /= Void 
			      and then not invalid_reason.empty

end 
