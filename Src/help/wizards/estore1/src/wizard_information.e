indexing
	description: "Collected Information by the wizard."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			Create table_list.make
			is_oracle := FALSE
			example := TRUE
		end

feature {WIZARD_STATE_WINDOW} -- Settings

	set_database_info(s1,s2,s3: STRING;oracle_selected: BOOLEAN) is
			-- Set the database information.
		do
			username := s1
			password := s2
			data_source := s3
			is_oracle := oracle_selected
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

	is_oracle: BOOLEAN

	location: STRING
		-- Generation location.

	project_location: STRING
		-- Project location.

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

	generate_every_table: BOOLEAN

invariant
	default_exist :username /= Void
				  and password /= Void 
				  and data_source /= Void
			      and location /= Void 
				  and project_location /= Void
				  and table_list /= Void
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class WIZARD_INFORMATION
