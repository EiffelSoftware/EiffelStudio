indexing
	description: "Generate FL Kernel accordingly with DB Tables."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	KERNEL_GENERATOR

inherit
	WIZARD_SHARED

Creation
	make

feature -- Initialization

	make is
			-- Initialize
		local
			b: BOOLEAN
		do
			Create repositories.make
			notify_user("Connecting ...")
			b:= db_manager.try_to_connect ("manus@CLIENTSAP","manus")
			notify_user("Connection established ...")
			if b then
				b := db_manager.establish_connection
				if b then
					generate_classes
					if basic_facade then
						generate_basic_facade
						if example then
							generate_example
						end
					end
				end
			end
			notify_user("")
		end

feature -- Processing

	generate_classes is
			-- Generate classes corresponding to the database tables.
		local
			li: LINKED_LIST[CLASS_NAME]
			cl_name: CLASS_NAME
		do
			Create cl_name.make
			li := db_manager.load_list("select TABLE_NAME from USER_TABLES",cl_name)
			if li.count>0 then
				from
					li.start
				until
					li.after
				loop
					generate_class(li.item.table_name)
					li.forth
				end
			end
		end

	generate_class(s: STRING) is
			-- Generate class according to class whose name is 's'.
		require
			s /= Void
		local
			rep: DB_REPOSITORY
			f: PLAIN_TEXT_FILE
			f_name: FILE_NAME
			s1: STRING
		do
			notify_user("generating class "+s)
			Create rep.make(s)
			rep.load
			repositories.extend(rep)
			Create f_name.make_from_string(path)
			s1 := clone(s)
			s1.to_lower
			f_name.extend(s1)
			f_name.add_extension("e")
			Create f.make_open_write(f_name)
			rep.generate_class(f)
			f.close
		end

	generate_basic_facade is
			-- Generate basic facade.
		do
			generate_repositories	
			load_other_classes		
		end

	generate_repositories is
			-- Generate 'repositories' relative to the 
			-- user database.
		local
			f: PLAIN_TEXT_FILE
			f_name: FILE_NAME
			s,s2,repository_name: STRING
		do
			notify_user("generating Class REPOSITORIES ...")
			Create f_name.make_from_string(path)
			f_name.extend("repositories")
			f_name.add_extension("e")
			s := "indexing%N%Tdescription:%"Module which contains all the repositories information%""
			s.append("%N%Nclass%N%T%TREPOSITORIES%N%N")
			s.append("feature -- Access%N")
			from
				repositories.start
			until
				repositories.after
			loop
				s2 := repositories.item.repository_name
				repository_name := clone(s2)
				repository_name.to_lower
				s.append("%N%T"+repository_name+"_repository: DB_REPOSITORY is")
				s.append("%N%T%T%T-- Load the repository '"+repository_name+"'")
				s.append("%N%T%Tonce%N%T%T%TCreate Result.make(%""+s2+"%")")
				s.append("%N%T%T%TResult.load%N%T%Tensure%N%T%T%Tloaded: Result.loaded%N%T%Tend%N")
				repositories.forth
			end
			s.append("%N%Nend -- Class Repositories")
			Create f.make_open_write(f_name)
			f.put_string(s)
			f.close
		end

	load_other_classes is
			-- Load remaining classes
		local
			f1,f_name: FILE_NAME
			fi: PLAIN_TEXT_FILE
			s: STRING
		do
			notify_user("Importing files ...")
			copy_class("database_manager")
			copy_class("db_action")
			copy_class("db_shared")
			if example then
				copy_class("estore_example")
				copy_class("estore_root")
			end
		end

	copy_class(name: STRING) is
			-- Copy Class whose name is 'name'.
		require
			name /= Void
		local
			f1,f_name: FILE_NAME
			fi: PLAIN_TEXT_FILE
			s: STRING
		do
			Create f1.make_from_string(resource_path)
			f_name := clone(f1)
			f_name.extend(name)
			f_name.add_extension("e")
			Create fi.make_open_read(f_name)
			fi.read_stream(fi.count)
			s := fi.last_string
			fi.close
			Create f_name.make_from_string(path)
			f_name.extend(name)
			f_name.add_extension("e")
			Create fi.make_open_write(f_name)
			fi.put_string(s)
			fi.close
		end

	generate_example is
			-- Generate example of use.
		local
			f1,f_name: FILE_NAME
			fi: PLAIN_TEXT_FILE
			s: STRING
			example_generator: EXAMPLE_GENERATOR
			root_generator: ROOT_GENERATOR
		do
			notify_user("Generating Example...")
			Create example_generator.make(repositories)
			s := example_generator.result_string
			Create f1.make_from_string(path)
			f_name := clone(f1)
			f_name.extend("estore_example")
			f_name.add_extension("e")
			Create fi.make_open_read_append(f_name)
			fi.put_string(s)
			fi.close
			
			notify_user("Generating Root Class...")
			Create f1.make_from_string(path)
			f_name := clone(f1)
			f_name.extend("estore_root")
			f_name.add_extension("e")
			Create fi.make_open_read(f_name)
			fi.read_stream(fi.count)
			s := fi.last_string
			fi.close
			Create root_generator.make(example_generator,Current,s)
			s := root_generator.result_string
			Create fi.make_open_write(f_name)
			fi.put_string(s)
			fi.close
		end

feature -- Output

	notify_user(s: STRING) is
			-- Output
		require
			not_void: s /= Void
		do
			io.put_string(s)
			io.new_line
		end

feature -- Implementation

	repositories: LINKED_LIST[DB_REPOSITORY]
		-- Repositories relative to Current DB.

	path: STRING is "d:\tmp\att2"

	resource_path: STRING is "d:\wizards\resources"

	basic_facade: BOOLEAN is TRUE

	example: BOOLEAN is TRUE

	username: STRING is "manus@CLIENTSAP"

	password: STRING is "manus"

invariant
	path_exists: path /= Void
	repositories_exist: repositories /= Void
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
end -- class KERNEL_GENERATOR
