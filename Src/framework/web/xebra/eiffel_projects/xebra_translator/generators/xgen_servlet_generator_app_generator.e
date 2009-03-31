note
	description: "Summary description for {SERVLET_GENERATOR_APP_GENERATOR}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	XGEN_SERVLET_GENERATOR_APP_GENERATOR

create
	make

feature -- Initialization

	make
		do
			create {ARRAYED_LIST [XGEN_SERVLET_GENERATOR_GENERATOR]} servlet_generator_generators.make (10)
		end

feature -- Access

	put_servlet_generator_generator (servlet_gg: XGEN_SERVLET_GENERATOR_GENERATOR)
			-- Adds a servlet_generator_generator to the generator_app_generator
		do
			servlet_generator_generators.extend (servlet_gg)
		end

	servlet_generator_generators: LIST [XGEN_SERVLET_GENERATOR_GENERATOR]
		-- All the servlet_generator_generators

feature -- Basic functionality

	generate (a_path: STRING)
			-- Generates all the classes for the servlet_generator_app and links them together.
			--  1. {SERLVET_GENERATOR} All the servlet generators
			--  2. {APPLICATION} The root class
			--  3. The project file (.ecf)
		require
			path_is_not_empty: not a_path.is_empty
		local
			buf:XU_INDENDATION_STREAM
			servlet_generator_generator: XGEN_SERVLET_GENERATOR_GENERATOR
			application_class: XEL_CLASS_ELEMENT
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
			application_class.set_inherit ("KL_SHARED_ARGUMENTS")
			application_class.set_constructor_name ("make")
			application_class.add_feature (build_constructor_for_application)
			application_class.serialize (buf)
			file.close

				-- Generate the .ecf file

			create file.make_open_write (a_path + "servlet_gen.ecf")
			file.put_string ("[
		<?xml version="1.0" encoding="ISO-8859-1"?>
<system xmlns="http://www.eiffel.com/developers/xml/configuration-1-4-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-4-0 http://www.eiffel.com/developers/xml/configuration-1-4-0.xsd" name="servlet_gen" uuid="E8B9E5AE-D395-4C15-8046-98D6BB466377">
	<target name="servlet_gen">
		<root class="APPLICATION" feature="make"/>
		<option warning="true" full_class_checking="true" is_attached_by_default="false" is_void_safe="false" syntax_level="1">
			<assertions precondition="true" postcondition="true" check="true" invariant="true" loop="true" supplier_precondition="true"/>
		</option>
		<library name="base" location="$ISE_LIBRARY\library\base\base.ecf"/>
		<library name="gobo_kernel" location="$ISE_LIBRARY\library\gobo\gobo_kernel.ecf"/>
		<cluster name="servlet_gen" location=".\" recursive="true">
			<option is_attached_by_default="false" is_void_safe="false">
			</option>
			<file_rule>
				<exclude>/EIFGENs$</exclude>
				<exclude>/.svn$</exclude>
				<exclude>/CVS$</exclude>
			</file_rule>
		</cluster>
		<cluster name="utilities" location="$XEBRA_DEV\eiffel_projects\utilities\"/>
		<cluster name="xebra_ast_elements" location="$XEBRA_DEV\eiffel_projects\xebra_ast_elements\"/>
		<cluster name="xebra_base" location="$XEBRA_DEV\eiffel_projects\xebra_base\"/>
		<cluster name="xebra_tag" location="$XEBRA_DEV\eiffel_projects\xebra_tag\" recursive="true"/>
	</target>
</system>	
			]")
			file.close
		end

	build_constructor_for_application: XEL_FEATURE_ELEMENT
		local
			l_servlet_gg: XGEN_SERVLET_GENERATOR_GENERATOR
		do
			create Result.make ("make")
			Result.append_local ("path", "STRING")
			Result.append_expression ("if  Arguments.argument_count /= 1 then")
			Result.append_expression ("print (%"usage:serlvet_gen output_path%%N%")")
			Result.append_expression ("else")
			Result.append_expression ("path := Arguments.argument (1)")
			from
				servlet_generator_generators.start
			until
				servlet_generator_generators.after
			loop
				l_servlet_gg :=  servlet_generator_generators.item
				Result.append_expression ("(create {"
					+ l_servlet_gg.servlet_name.as_upper + "_SERVLET_GENERATOR}.make ("
					+ "path, %"" + l_servlet_gg.servlet_name + "%", " + l_servlet_gg.stateful.out + ", %"" + l_servlet_gg.controller_type.as_upper + "%")).generate;")
				servlet_generator_generators.forth
			end
			Result.append_expression ("end")
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
