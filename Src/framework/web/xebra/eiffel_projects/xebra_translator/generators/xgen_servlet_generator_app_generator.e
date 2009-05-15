note
	description: "[
		This class generates servlet generators for a xeb file. The generated file is a
		eiffel class and has to be compiled and executed together with the other servlet generator
		classes to generate the very servlets.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XGEN_SERVLET_GENERATOR_APP_GENERATOR

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			--
		do
			create {ARRAYED_LIST [XGEN_SERVLET_GENERATOR_GENERATOR]} servlet_generator_generators.make (10)
		end

feature {NONE} -- Access

feature -- Access

	put_servlet_generator_generator (a_servlet_gg: XGEN_SERVLET_GENERATOR_GENERATOR)
			-- Adds a servlet_generator_generator to the generator_app_generator
		require
			a_servlet_gg_valid: attached a_servlet_gg
		do
			servlet_generator_generators.extend (a_servlet_gg)
		ensure
			servlet_gg_added: servlet_generator_generators.count = old servlet_generator_generators.count + 1
		end

	put_servlet_generator_generators (a_servlet_ggs: LIST [XGEN_SERVLET_GENERATOR_GENERATOR])
			-- Sets the list of servlet_generator_generators
		require
			a_servlet_ggs_attached: attached a_servlet_ggs
		do
			servlet_generator_generators := a_servlet_ggs
		ensure
			serglet_ggs_set: servlet_generator_generators = a_servlet_ggs
		end

	servlet_generator_generators: LIST [XGEN_SERVLET_GENERATOR_GENERATOR]
		-- All the servlet_generator_generators

feature -- Basic functionality

	generate (a_path: FILE_NAME)
			-- Generates all the classes for the servlet_generator_app and links them together.
			--  1. {SERLVET_GENERATOR} All the servlet generators
			--  2. {APPLICATION} The root class
			--  3. The project file (.ecf)
		require
			path_is_valid: attached a_path and not a_path.is_empty
		local
			buf:XU_INDENDATION_STREAM
			servlet_generator_generator: XGEN_SERVLET_GENERATOR_GENERATOR
			application_class: XEL_CLASS_ELEMENT
			file: PLAIN_TEXT_FILE
			l_filename: FILE_NAME
		do
				-- Generate the servlet generator files
			from
				servlet_generator_generators.start
			until
				servlet_generator_generators.after
			loop
				servlet_generator_generator := servlet_generator_generators.item
				servlet_generator_generator.generate (a_path.twin)
				servlet_generator_generators.forth
			end

				-- Generate the {APPLICATION} class
			l_filename := a_path.twin
			l_filename.set_file_name (Application_name.as_lower +  ".e")
			create file.make (l_filename)
			if not file.is_creatable then
				error_manager.add_error (create {XERROR_FILE_NOT_CREATABLE}.make (l_filename), false)
			end
			file.open_write
			if not file.is_open_write then
				error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (l_filename), false)
			end

			create buf.make (file)
			create application_class.make (Application_name.as_upper)
			application_class.set_inherit ("KL_SHARED_ARGUMENTS%N%TXU_SHARED_OUTPUTTER")
			application_class.set_constructor_name ("make")
			application_class.add_feature (build_constructor_for_application)
			application_class.serialize (buf)
			file.close

				-- Generate the .ecf file
			l_filename := a_path.twin
			l_filename.set_file_name ("servlet_gen.ecf")
			create file.make (l_filename)
			if not file.is_creatable then
				error_manager.add_error (create {XERROR_FILE_NOT_CREATABLE}.make (l_filename), false)
			end
			file.open_write
			if not file.is_open_write then
				error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (l_filename), false)
			end
			file.put_string (servlet_gen_ecf)
			file.close
		end

feature {NONE} -- Implementation

	build_constructor_for_application: XEL_FEATURE_ELEMENT
			-- Builds the constructor feature for the APPLICATION class of servlet_gen
		local
			l_servlet_gg: XGEN_SERVLET_GENERATOR_GENERATOR
		do
			create Result.make ("make")
			Result.append_local ("l_path", "STRING")
			Result.append_local ("l_controller_table", "HASH_TABLE [STRING, STRING]")
			Result.append_expression ("o.set_name (%"XEBSRVLGEN%")")
			Result.append_expression ("o.set_debug_level (10)")
			Result.append_expression ("if  Arguments.argument_count /= 1 then")
			Result.append_expression ("print (%"usage:serlvet_gen output_path%%N%")")
			Result.append_expression ("else")
			Result.append_expression ("l_path := Arguments.argument (1)")

			from
				servlet_generator_generators.start
			until
				servlet_generator_generators.after
			loop
				l_servlet_gg := servlet_generator_generators.item
				build_controller_table (Result, l_servlet_gg)
				Result.append_expression ("(create {"
					+ Generator_Prefix.as_upper + l_servlet_gg.servlet_name.as_upper + "_SERVLET_GENERATOR}.make ("
					+ "l_path, %"" + l_servlet_gg.servlet_name + "%", l_controller_table, %""
				    + Generator_Prefix.as_lower + l_servlet_gg.servlet_name + "_servlet_generator.e%")).generate;")
				servlet_generator_generators.forth
			end
			Result.append_expression ("end")
		end

	build_controller_table (a_feature: XEL_FEATURE_ELEMENT; a_servlet_gg: XGEN_SERVLET_GENERATOR_GENERATOR)
			-- Builds the table [controller_uid, controller_type]
		require
			a_servlet_gg_attached: a_servlet_gg /= Void
			a_feature_attached: a_feature /= Void
		do
			a_feature.append_expression ("create l_controller_table.make (" + a_servlet_gg.controller_table.count.out + ")")
			from
				a_servlet_gg.controller_table.start
			until
				a_servlet_gg.controller_table.after
			loop
				a_feature.append_expression ("l_controller_table.put (%"" + a_servlet_gg.controller_table.item_for_iteration +"%", %""+ a_servlet_gg.controller_table.key_for_iteration+"%")")
				a_servlet_gg.controller_table.forth
			end
		end

feature -- Constants

	Generator_Prefix: STRING = "g_"
		-- Prefix of generated classes

	Application_name: STRING = "G_APPLICATION"

	servlet_gen_ecf: STRING = "[
<?xml version="1.0" encoding="ISO-8859-1"?>
<system xmlns="http://www.eiffel.com/developers/xml/configuration-1-5-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-5-0 http://www.eiffel.com/developers/xml/configuration-1-5-0.xsd" name="servlet_gen" uuid="E8B9E5AE-D395-4C15-8046-98D6BB466377">
	<target name="servlet_gen">
		<root class="G_APPLICATION" feature="make"/>
		<option warning="true" syntax="transitional">
		</option>
		<setting name="console_application" value="true"/>
		<library name="base" location="$ISE_LIBRARY\library\base\base.ecf"/>
		<library name="gobo_kernel" location="$ISE_LIBRARY\library\gobo\gobo_kernel.ecf"/>
		<library name="xebra_taglibrary_base" location="$XEBRA_DEV\eiffel_projects\library\xebra_taglibrary_base\xebra_taglibrary_base-voidunsafe.ecf"/>
		<library name="xebra_taglibrary_form" location="$XEBRA_DEV\eiffel_projects\library\xebra_taglibrary_form\xebra_taglibrary_form-voidunsafe.ecf"/>
		<library name="xebra_tags" location="$XEBRA_DEV\eiffel_projects\library\xebra_tags\xebra_tags-voidunsafe.ecf" readonly="false"/>
		<library name="xebra_utilities" location="$XEBRA_DEV\eiffel_projects\library\xebra_utilities\xebra_utilities-voidunsafe.ecf" readonly="false"/>
		<cluster name="servlet_gen" location=".\" recursive="true">
			<file_rule>
				<exclude>/EIFGENs$</exclude>
				<exclude>/.svn$</exclude>
				<exclude>/CVS$</exclude>
			</file_rule>
		</cluster>
	</target>
</system>
	]"
		-- The .ecf file

invariant
	servlet_generator_generators_attached: servlet_generator_generators /= Void
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
