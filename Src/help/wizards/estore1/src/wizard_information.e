indexing
	description: "Collected Information by the wizard."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INFORMATION

creation {WIZARD_WINDOW}
	make 

feature {NONE} -- Initialization

	make is
			-- Initialize Current with Default Values
		do
			username := ""
			password := ""
			handle := ""
			location := ""
			project_location := ""
			Create table_list.make
		end

feature {STATE_WINDOW} -- Settings

	set_database_info(s1,s2,s3: STRING) is
			-- Set the database information.
		do
			username := s1
			password := s2
			handle := s3
		end

	set_generation_type(b1,b2: BOOLEAN) is
			-- Set generation type information.
		do
			generate_facade := b1
			new_project := b2			
		end

	set_table_list(li: LINKED_LIST[CLASS_NAME]) is
			-- Set table to be generated.
		do
			table_list := li
		end

	set_locations (loc,proj: STRING) is
			-- Set the locations corresponding to 
			-- the generation(s).
		do
			location := loc
			project_location := proj
		end

	set_generate_all_table(b: BOOLEAN) is
		do
			generate_every_table := b
		end

feature -- Access

	location: STRING
		-- Generation location.

	project_location: STRING
		-- Project location.

	username: STRING
		-- User Name.

	password: STRING
		-- User Password.

	handle: STRING
		-- Database Name.

	generate_facade: BOOLEAN
		-- Does the user want to generate a facade ?

	new_project: BOOLEAN
		-- Does the user want to generate a new projet ?

	example: BOOLEAN is TRUE
		-- Does the user want to generate an example ?

	table_list: LINKED_LIST[CLASS_NAME]
		-- List of the selected database tables.

	generate_every_table: BOOLEAN

invariant
	default_exist :username /= Void
				  and password /= Void 
				  and handle /= Void
			      and location /= Void 
				  and project_location /= Void
				  and table_list /= Void
end -- class WIZARD_INFORMATION
