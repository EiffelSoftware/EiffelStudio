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
			new_project:= True
			username:= ""
			password:= ""
			data_source:= ""
			location:= ""
			project_name:= "sample"
			create table_list.make
			is_oracle:= False
			compile_project:= True
			precompiled_base:= False
			vision_example:= True
		end

feature {WIZARD_STATE_WINDOW} -- Settings

	set_database_info (s1, s2, s3: STRING; oracle_selected: BOOLEAN) is
			-- Set the database information.
		do
			username:= s1
			password:= s2
			data_source:= s3
			is_oracle:= oracle_selected
		end

	set_generation_type (b: BOOLEAN) is
			-- Set generation type information.
		do
			new_project := b			
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

	set_location (loc: STRING) is
			-- Set the location corresponding to 
			-- the generation.
		do
			location := loc
		end

	set_generate_all_table (b: BOOLEAN) is
		do
			generate_every_table := b
		end

	set_project_name (proj: STRING) is
			-- Set the project Name.
		do
			project_name := proj
		end

	set_compile_project (b: BOOLEAN) is
			-- Set whether the user want to compile project or not.
		do
			compile_project := b
		end

	set_precompiled_base (b: BOOLEAN) is
			-- Set whether the user want to use 
			-- the precompiled base library or not.
		do
			precompiled_base := b
		end

	set_vision_example (b: BOOLEAN) is
			-- Set whether the user want to create 
			-- the Vision2 example.
		do
			vision_example := b
		end

feature -- Access

	is_oracle: BOOLEAN

	location: STRING
		-- Generation location.

	project_name: STRING
		-- Project Name

	username: STRING
		-- User Name.

	password: STRING
		-- User Password.

	data_source: STRING
		-- User datasource. (Useful with ODBC)

	new_project: BOOLEAN
		-- Does the user want to generate a new projet ?

	vision_example: BOOLEAN
		-- Does the user want to generate an example using the EiffelVision2 library ?

	table_list: LINKED_LIST[CLASS_NAME]
		-- List of the selected database tables.

	unselected_table_list: LINKED_LIST [CLASS_NAME]
		-- List of the unselected database tables.

	generate_every_table: BOOLEAN

	compile_project: BOOLEAN
		-- Does the user want to compile the project ?

	precompiled_base: BOOLEAN
		-- Does the user want to use the precompiled base library when compiling?

invariant
	default_exist: username /= Void
				  and password /= Void 
				  and data_source /= Void
			      and location /= Void 
				  and table_list /= Void

end -- class WIZARD_INFORMATION
