indexing
	description: "[
		The configuration system. Every configuration file corresponds to one CONF_SYSTEM object.
		It can be loaded from a configuration file by using CONF_LOAD and stored to a configuration file
		by using the store feature.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_SYSTEM

inherit
	CONF_VISITABLE

	CONF_NOTABLE

	CONF_FILE_DATE
		export
			{NONE} all
		end

	DEBUG_OUTPUT

create {CONF_PARSE_FACTORY}
	make_with_uuid

feature {NONE} -- Initialization

	make_with_uuid (a_name: STRING; a_uuid: UUID) is
			-- Creation with `a_name' and `a_uuid'.
		require
			a_name_ok: a_name /= Void and not a_name.is_empty
			a_uuid_ok: a_uuid /= Void
		do
			create targets.make (1)
			create target_order.make (1)
			name := a_name.as_lower
			uuid := a_uuid
			is_readonly := True
		ensure
			name_set: name /= Void and then name.is_equal (a_name.as_lower)
			uuid_set: uuid = a_uuid
			is_readonly: is_readonly
		end

feature -- Status

	store_successful: BOOLEAN
			-- Was the last `store' operation successful?

	date_has_changed: BOOLEAN is
			-- Did the file modification date of the configuration file change?
		require
			is_location_set: is_location_set
		do
			Result := file_modified_date (file_name) /= file_date
		end

	is_fully_parsed: BOOLEAN
			-- Has the complete system (incl. all libraries) been parsed?
		do
			Result := application_target /= Void
		end

	is_location_set: BOOLEAN
			-- Has the location of the configuration file been set?
		do
			Result := file_name /= Void and then not file_name.is_empty
		end

	deep_date_has_changed: BOOLEAN is
			-- Did the date on any configuration file used in this system change?
		require
			fully_parsed: is_fully_parsed
			filenames_set: all_libraries.linear_representation.for_all (agent (a_target: CONF_TARGET): BOOLEAN
				local
					l_fn: STRING
				do
					l_fn := a_target.system.file_name
					 Result := l_fn /= Void and then not l_fn.is_empty
				end)
		do
			from
				all_libraries.start
			until
				Result or all_libraries.after
			loop
				Result := all_libraries.item_for_iteration.system.date_has_changed
				all_libraries.forth
			end
		end

feature -- Access, stored in configuration file

	name: STRING
			-- Name of the system.

	description: STRING
			-- A description about the system.

	uuid: UUID
			-- Universal unique identifier that identifies this system.

	is_readonly: BOOLEAN
			-- Is this system readonly per default if it is used as a library?

	targets: HASH_TABLE [CONF_TARGET, STRING]
			-- The configuration targets.

	library_target: CONF_TARGET
			-- The target to use if this is used as a library.

feature -- Access, in compiled only

	directory: STRING
			-- Directory where the configuration file is stored in platform specific format.

	file_name: STRING
			-- File name of config file.

	file_date: INTEGER
			-- File modification date of config file.

	application_target: CONF_TARGET
			-- Target of application this system is part of.

	level: NATURAL_32
			-- Level, used for path finding to root of configuration system.

	all_libraries: HASH_TABLE [CONF_TARGET, UUID]
			-- All libraries in current system.

	all_assemblies: HASH_TABLE [CONF_PHYSICAL_ASSEMBLY_INTERFACE, STRING]
			-- All assemblies in current system.

	used_in_libraries: ARRAYED_LIST [CONF_LIBRARY]
			-- Libraries this system is used in.

	lowest_used_in_library: CONF_LIBRARY
			-- Library which uses this system and has the lowest level.

	application_target_library: CONF_LIBRARY
			-- Library which uses this system and is written in the application target.

feature -- Update, in compiled only

	set_file_name (a_file_name: like file_name) is
			-- Set `file_name' to `a_file_name' and set `directory'.
		require
			a_file_name_ok: a_file_name /= Void and then not a_file_name.is_empty
		local
			i, cnt: INTEGER
		do
			file_name := a_file_name

			cnt := file_name.count
			i := file_name.last_index_of (operating_environment.directory_separator, cnt)
			if i <= 0 then
				i := cnt
			end

			directory := file_name.substring (1, i-1)
		ensure
			is_location_set: is_location_set
			name_set: file_name = a_file_name
		end

	set_file_date is
			-- Set `file_date' to last modified date of `file_name'.
		require
			is_location_set: is_location_set
		do
			file_date := file_modified_date (file_name)
		end

feature {CONF_ACCESS} -- Access, in compiled only

	set_application_target (a_target: CONF_TARGET) is
			-- Set `application_target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			application_target := a_target
		ensure
			application_target_set: application_target = a_target
		end

	set_level (a_level: like level) is
			-- Set `level' to `level'.
		do
			level := a_level
		ensure
			level_set: level = a_level
		end

	set_all_libraries (a_libraries: like all_libraries) is
			-- Set `all_libraries' to `a_libraries'.
		require
			a_libraries_not_void: a_libraries /= Void
		do
			all_libraries := a_libraries
		ensure
			libraries_set: all_libraries = a_libraries
		end

	set_all_assemblies (an_assemblies: like all_assemblies) is
			-- Set `all_assemlibes' to `an_assemblies'.
		require
			an_assemblies_not_void: an_assemblies /= Void
		do
			all_assemblies := an_assemblies
		ensure
			assemblies_set: all_assemblies = an_assemblies
		end

	add_library_usage (a_library: CONF_LIBRARY) is
			-- Current system is library of `a_library'.
		require
			fully_parsed: is_fully_parsed
			a_library_not_void: a_library /= Void
			a_library_target: a_library.library_target.system = Current
		do
			if used_in_libraries = Void then
				create used_in_libraries.make (1)
			end
			used_in_libraries.force (a_library)
			if lowest_used_in_library = Void or else lowest_used_in_library.target.system.level > a_library.target.system.level then
				lowest_used_in_library := a_library
			end
			if application_target_library = Void and then a_library.target.system = application_target.system then
				application_target_library := a_library
			end
		ensure
			added_libs: used_in_libraries.has (a_library)
		end

feature -- Store to disk

	store is
			-- Store system back to its config file (only system itself is stored, libraries are not stored).
		require
			is_location_set: is_location_set
		local
			l_print: CONF_PRINT_VISITOR
			l_file: PLAIN_TEXT_FILE
		do
			store_successful := False
			create l_print.make
			process (l_print)
			if not l_print.is_error then
				create l_file.make (file_name)
				if (l_file.exists and then l_file.is_writable) or else l_file.is_creatable then
					l_file.open_write
					l_file.put_string (l_print.text)
					l_file.close
					store_successful := True
				end
			end
		end

feature -- Access queries

	compilable_targets: like targets is
			-- The compilable targets.
		local
			l_target: CONF_TARGET
		do
			create Result.make (targets.count)
			from
				targets.start
			until
				targets.after
			loop
				l_target := targets.item_for_iteration
				if l_target.root /= Void and not l_target.is_abstract then
					Result.force (l_target, l_target.name)
				end
				targets.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_external_include: ARRAYED_LIST [CONF_EXTERNAL_INCLUDE] is
			-- All external include files including the ones from libraries.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (10)
			from
				all_libraries.start
			until
				all_libraries.after
			loop
				Result.append (all_libraries.item_for_iteration.external_include)
				all_libraries.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_external_object: ARRAYED_LIST [CONF_EXTERNAL_OBJECT] is
			-- All external object files including the ones from libraries.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (10)
			from
				all_libraries.start
			until
				all_libraries.after
			loop
				Result.append (all_libraries.item_for_iteration.external_object)
				all_libraries.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_external_library: ARRAYED_LIST [CONF_EXTERNAL_LIBRARY] is
			-- All external library files including the ones from libraries.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (10)
			from
				all_libraries.start
			until
				all_libraries.after
			loop
				Result.append (all_libraries.item_for_iteration.external_library)
				all_libraries.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_external_resource: ARRAYED_LIST [CONF_EXTERNAL_RESOURCE] is
			-- All external ressource files including the ones from libraries.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (10)
			from
				all_libraries.start
			until
				all_libraries.after
			loop
				Result.append (all_libraries.item_for_iteration.external_resource)
				all_libraries.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_external_make: ARRAYED_LIST [CONF_EXTERNAL_MAKE] is
			-- All external make files including the ones from libraries.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (10)
			from
				all_libraries.start
			until
				all_libraries.after
			loop
				Result.append (all_libraries.item_for_iteration.external_make)
				all_libraries.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_pre_compile_action: ARRAYED_LIST [CONF_ACTION] is
			-- All Aactions to be executed before compilation.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (10)
			from
				all_libraries.start
			until
				all_libraries.after
			loop
				Result.append (all_libraries.item_for_iteration.pre_compile_action)
				all_libraries.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_post_compile_action: ARRAYED_LIST [CONF_ACTION] is
			-- All Aactions to be executed after compilation.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (10)
			from
				all_libraries.start
			until
				all_libraries.after
			loop
				Result.append (all_libraries.item_for_iteration.post_compile_action)
				all_libraries.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_name (a_name: like name) is
			-- Set `name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			name := a_name.as_lower
		ensure
			name_set: name.is_case_insensitive_equal (a_name)
		end

	set_readonly (a_readonly: like is_readonly) is
			-- Set `is_readonly' to `a_readonly'.
		do
			is_readonly := a_readonly
		ensure
			is_readonly_set: is_readonly = a_readonly
		end

	set_description (a_description: like description) is
			-- Set `description' to `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

	set_uuid (an_uuid: like uuid) is
			-- Set `uuid' to `a_uuid'.
		require
			an_uuid_valid: an_uuid /= Void
		do
			uuid := an_uuid
		ensure
			uuid_set: uuid = an_uuid
		end

	add_target (a_target: CONF_TARGET) is
			-- Add `a_target' to `targets'.
		require
			a_target_not_void: a_target /= Void
		do
			targets.force (a_target, a_target.name.twin)
			target_order.force (a_target)
		end

	remove_target (a_name: STRING) is
			-- Remove the target with name `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			if targets.has_key (a_name) then
				target_order.start
				target_order.search (targets.found_item)
				target_order.remove
				targets.remove (a_name)
			end

			if library_target /= Void and then library_target.name.is_equal (a_name) then
				library_target := Void
			end
		end

	set_library_target (a_target: like library_target) is
			-- Set `library_target' to `a_target'.
		require
			no_overrides: a_target /= Void implies a_target.overrides.is_empty
		do
			library_target := a_target
		end

	set_library_target_by_name (a_target: STRING) is
			-- Set `library_target' to `a_target'.
		require
			a_target_valid: a_target /= Void and then not a_target.is_empty implies targets.has (a_target)
		do
			if a_target /= Void and then not a_target.is_empty then
				set_library_target (targets.item (a_target))
			else
				set_library_target (Void)
			end
		end

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN is
			-- Is `other' and `Current' the same with respect to the group layout?
		local
			l_o_targets: like targets
			l_o_target: CONF_TARGET
		do
			if targets.count = other.targets.count then
				Result := (library_target = Void and other.library_target = Void) or
					(library_target /= Void and other.library_target /= Void and then library_target.name.is_equal (other.library_target.name) )
				from
					targets.start
					l_o_targets := other.targets
				until
					not Result or targets.after
				loop
					l_o_target := l_o_targets.item (targets.key_for_iteration)
					Result := l_o_target /= Void and then targets.item_for_iteration.is_group_equivalent (l_o_target)
					targets.forth
				end
			end
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_system (Current)
		end

feature -- Output

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := name
		end

feature {CONF_VISITOR, CONF_ACCESS} -- Implementation

	target_order: ARRAYED_LIST [CONF_TARGET]
			-- Order the targets appear in configuration file.

feature {NONE} -- Contract helper

	same_targets: BOOLEAN is
			-- Do targets and target_order have the same content?
		do
			Result := targets.count = target_order.count and then target_order.for_all (agent (a_target: CONF_TARGET): BOOLEAN
				do
					Result := targets.has_key (a_target.name) and then targets.found_item = a_target
				end)
		end

	valid_level: BOOLEAN is
			-- Is the current level valid?
			-- It has to be either 0 or the target has to be used in a library whose system has a lower level.
		do
			if level = 0 then
				Result := True
			elseif used_in_libraries /= Void then
				Result := used_in_libraries.there_exists (agent (a_lib: CONF_LIBRARY): BOOLEAN
					do
						Result := a_lib.target.system.level < level
					end)
			end
		end

invariant
	name_ok: name /= Void and then not name.is_empty
	name_lower: name.is_equal (name.as_lower)
	targets_not_void: targets /= Void
	target_order_not_void: target_order /= Void
	target_and_order_same_content: same_targets
	fully_parsed: is_fully_parsed implies application_target /= Void
	location_set: is_location_set implies file_name /= Void and then not file_name.is_empty and directory /= Void
	lowest_in_used: lowest_used_in_library /= Void implies used_in_libraries /= Void and then used_in_libraries.has (lowest_used_in_library)
	application_target_library_in_used: application_target_library /= Void implies used_in_libraries /= Void and then used_in_libraries.has (application_target_library)
	valid_level: valid_level

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
end
