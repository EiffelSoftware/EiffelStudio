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
			data_source := ""
			location := ""
			project_location := ""
			project_name := "sample"
			Create table_list.make
			is_oracle := FALSE
			compile_project := TRUE
			example := TRUE
		end

feature {WIZARD_STATE_WINDOW} -- Settings

	set_database_info (s1,s2,s3: STRING; oracle_selected: BOOLEAN) is
			-- Set the database information.
		do
			username := s1
			password := s2
			data_source := s3
			is_oracle := oracle_selected
		end

	set_generation_type (b1,b2: BOOLEAN) is
			-- Set generation type information.
		do
			generate_facade := b1
			new_project := b2			
		end

	set_table_list (li: LINKED_LIST [CLASS_NAME]) is
			-- Set table to be generated.
		do
			table_list := li
		end

	set_unselected_table_list (li: LINKED_LIST [CLASS_NAME]) is
			-- Table not to be generated
		do
			unselected_table_list := li
		end

	set_locations (loc,proj: STRING) is
			-- Set the locations corresponding to 
			-- the generation(s).
		do
			location := loc
			project_location := proj
		end

	set_generate_all_table (b: BOOLEAN) is
		do
			generate_every_table := b
		end

	set_project_name (proj: STRING) is
			-- Set the project Name
		do
			project_name := proj
		end

	set_compile_project (b: BOOLEAN) is
		do
			compile_project := b
		end

feature -- Access

	is_oracle: BOOLEAN

	location: STRING
		-- Generation location.

	project_location: STRING
		-- Project location.

	project_name: STRING
		-- Project Name

	username: STRING
		-- User Name.

	password: STRING
		-- User Password.

	data_source: STRING
		-- User datasource. (Useful with ODBC)

	generate_facade: BOOLEAN
		-- Does the user want to generate a facade ?

	new_project: BOOLEAN
		-- Does the user want to generate a new projet ?

	example: BOOLEAN
		-- Does the user want to generate an example ?

	table_list: LINKED_LIST[CLASS_NAME]
		-- List of the selected database tables.

	unselected_table_list: LINKED_LIST [CLASS_NAME]
		-- List of the unselected database tables.

	generate_every_table: BOOLEAN

	compile_project: BOOLEAN
		-- Does the user want to compile the project ?

invariant
	default_exist :username /= Void
				  and password /= Void 
				  and data_source /= Void
			      and location /= Void 
				  and project_location /= Void
				  and table_list /= Void
end -- class WIZARD_INFORMATION
