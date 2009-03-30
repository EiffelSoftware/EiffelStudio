note
	description: "Summary description for {SERVLET_GENERATOR_APP_GENERATOR}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	SERVLET_GENERATOR_APP_GENERATOR

create
	make

feature -- Initialization

	make
		do
			create {ARRAYED_LIST [SERVLET_GENERATOR_GENERATOR]} servlet_generator_generators.make (10)
		end

feature -- Access

	put_servlet_generator_generator (servlet_gg: SERVLET_GENERATOR_GENERATOR)
			-- Adds a servlet_generator_generator to the generator_app_generator
		do
			servlet_generator_generators.extend (servlet_gg)
		end

	servlet_generator_generators: LIST [SERVLET_GENERATOR_GENERATOR]
		-- All the servlet_generator_generators

feature -- Basic functionality

	generate (a_path: STRING)
			-- Generates all the classes for the servlet_generator_app and links them together.
			--  1. {SERLVET_GENERATOR} All the servlet generators
			--  2. {APPLICATION} The root class
		require
			path_is_not_empty: not a_path.is_empty
		local
			buf: INDENDATION_STREAM
			servlet_generator_generator: SERVLET_GENERATOR_GENERATOR
			application_class: CLASS_ELEMENT
			file: PLAIN_TEXT_FILE
		do
				-- Generate the servlet generators
			from
				servlet_generator_generators.start
			until
				servlet_generator_generators.after
			loop
				servlet_generator_generator := servlet_generator_generators.item
				create file.make_open_write (a_path + servlet_generator_generator.servlet_name.as_lower + "_servlet_generator.e")
				create buf.make (file)
				servlet_generator_generator.generate (a_path)
				servlet_generator_generators.forth
			end

				-- Generate the {APPLICATION} class
			create file.make_open_write (a_path + "application.e")
			create buf.make (file)
			create application_class.make ("APPLICATION")
			application_class.set_constructor_name ("make")
			application_class.add_feature (build_constructor_for_application)
			application_class.serialize (buf)
			file.close
		end

	build_constructor_for_application: FEATURE_ELEMENT
		local
			l_servlet_gg: SERVLET_GENERATOR_GENERATOR
		do
			create Result.make ("make")
			from
				servlet_generator_generators.start
			until
				servlet_generator_generators.after
			loop
				l_servlet_gg :=  servlet_generator_generators.item
				Result.append_expression ("(create {"
					+ l_servlet_gg.servlet_name.as_upper + "_SERVLET_GENERATOR}.make (%""
					+ "./%", %"" + l_servlet_gg.servlet_name + "%", " + l_servlet_gg.stateful.out + ", %"" + l_servlet_gg.controller_type.as_upper + "%")).generate;")
				servlet_generator_generators.forth
			end
		end
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
