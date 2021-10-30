note
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

	CONF_FILE

	CONF_FILE_CONSTANTS

	DEBUG_OUTPUT

create {CONF_PARSE_FACTORY}
	make_with_uuid

feature {NONE} -- Initialization

	make_with_uuid (a_file_name: READABLE_STRING_GENERAL; a_name: like name; a_uuid: UUID; a_namespace: READABLE_STRING_32)
			-- Creation with `a_name' and `a_uuid'.
		require
			a_file_name_valid: a_file_name /= Void and then not a_file_name.is_empty
			a_name_ok: a_name /= Void and not a_name.is_empty
			a_uuid_ok: a_uuid /= Void
			a_namespace_valid: is_namespace_known (a_namespace)
		do
				-- TODO: remove case conversion when working with keys of `targets`.
			create targets.make_caseless (1)
			create target_order.make (1)
			create all_libraries.make_equal (0)
			name := a_name.as_lower
			set_file_name (a_file_name)
			uuid := a_uuid
			namespace := a_namespace
			is_readonly := True
		ensure
			name_set: name /= Void and then name.is_equal (a_name.as_lower)
			file_name_set: a_file_name.same_string (file_name)
			uuid_set: uuid = a_uuid
			namespace_set: namespace = a_namespace
			is_readonly: is_readonly
		end

feature -- Status

	same_as (cfg: CONF_SYSTEM): BOOLEAN
			-- Are `Current` and `cfg` same system?
		do
			Result := (Current = cfg) or else (uuid ~ cfg.uuid)
		end

	is_fully_parsed: BOOLEAN
			-- Has the complete system (incl. all libraries) been parsed?
		do
			Result := application_target /= Void
		end

	deep_date_has_changed: BOOLEAN
			-- Did the date on any configuration file used in this system change?
		require
			fully_parsed: is_fully_parsed
			filenames_set: across all_libraries as l_libs all attached l_libs.system.file_name as l_fn and then not l_fn.is_empty end
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

	name: READABLE_STRING_32
			-- Name of the system.

	description: detachable READABLE_STRING_32
			-- A description about the system.

	uuid: UUID
			-- Universal unique identifier that identifies this system.

	is_generated_uuid: BOOLEAN
			-- Is `uuid' internally generated?
			-- i.e the original ecf has no uuid value.

	namespace: READABLE_STRING_32
			-- The namespace used when loading the system.
			-- It is used to compute settings with different defaults in different versions.

	is_readonly: BOOLEAN
			-- Is this system readonly per default if it is used as a library?

	targets: STRING_TABLE [CONF_TARGET]
			-- The configuration targets.

	target (a_name: READABLE_STRING_GENERAL): detachable CONF_TARGET
			-- Configuration target named `a_name`, if any.
		do
			Result := targets.item (a_name)
		end

	library_target: detachable CONF_TARGET
			-- The target to use if this is used as a library.

feature -- Access, in compiled only

	application_target: detachable CONF_TARGET
			-- Target of application this system is part of.

	level: NATURAL_32
			-- Level, used for path finding to root of configuration system.

	all_libraries: HASH_TABLE [CONF_TARGET, UUID]
			-- All libraries in current system.

	all_assemblies: detachable STRING_TABLE [CONF_PHYSICAL_ASSEMBLY_INTERFACE]
			-- All assemblies in current system.

	used_in_libraries: detachable ARRAYED_LIST [CONF_LIBRARY]
			-- Libraries this system is used in.

	lowest_used_in_library: detachable CONF_LIBRARY
			-- Library which uses this system and has the lowest level.

	application_target_library: detachable CONF_LIBRARY
			-- Library which uses this system and is written in the application target.

feature {CONF_ACCESS} -- Access, in compiled only

	set_application_target (a_target: CONF_TARGET)
			-- Set `application_target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			application_target := a_target
		ensure
			application_target_set: application_target = a_target
		end

	set_level (a_level: like level)
			-- Set `level' to `level'.
		do
			level := a_level
		ensure
			level_set: level = a_level
		end

	set_all_libraries (a_libraries: attached like all_libraries)
			-- Set `all_libraries' to `a_libraries'.
		require
			a_libraries_not_void: a_libraries /= Void
		do
			all_libraries := a_libraries
		ensure
			libraries_set: all_libraries = a_libraries
		end

	set_all_assemblies (an_assemblies: like all_assemblies)
			-- Set `all_assemlibes' to `an_assemblies'.
		require
			an_assemblies_not_void: an_assemblies /= Void
		do
			all_assemblies := an_assemblies
		ensure
			assemblies_set: all_assemblies = an_assemblies
		end

	add_library_usage (a_library: CONF_LIBRARY)
			-- Current system is library of `a_library'.
		require
			fully_parsed: is_fully_parsed
			a_library_not_void: a_library /= Void
			a_library_target: attached a_library.library_target as l_lib_target and then l_lib_target.system = Current
		local
			l_used_in_libraries: like used_in_libraries
		do
			l_used_in_libraries := used_in_libraries
			if l_used_in_libraries = Void then
				create l_used_in_libraries.make (1)
				used_in_libraries := l_used_in_libraries
			end
			l_used_in_libraries.force (a_library)

			if
				not attached lowest_used_in_library as l_lowest_used_in_library
				or else l_lowest_used_in_library.target.system.level > a_library.target.system.level
			then
				lowest_used_in_library := a_library
			end

			if
				application_target_library = Void and then
				attached application_target as l_application_target and then
				a_library.target.system = l_application_target.system
			then
				application_target_library := a_library
			end
		ensure
			used_in_libraries_set: attached used_in_libraries as el_used_in_libraries
			added_libs: el_used_in_libraries.has (a_library)
		end

feature -- Access queries

	compilable_targets: like targets
			-- Compilable targets.
			--| note: in order to satisfy precondition, see {CONF_PARENT_TARGET_CHECKER}.resolve_system to resolve the eventual parent.
		require
			no_unresolved_parents: across targets as ic all not ic.has_unresolved_parent end
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

	all_external_include: ARRAYED_LIST [CONF_EXTERNAL_INCLUDE]
			-- All external include files including the ones from libraries.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (10)
			across
				all_libraries as ic
			loop
				Result.append (ic.external_include)
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_external_cflag: ARRAYED_LIST [CONF_EXTERNAL_CFLAG]
			-- All external C flags including the ones from libraries.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (10)
			across all_libraries as ic loop
				Result.append (ic.external_cflag)
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_external_object: ARRAYED_LIST [CONF_EXTERNAL_OBJECT]
			-- All external object files including the ones from libraries.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (all_libraries.count)
			across all_libraries as ic loop
				Result.append (ic.external_object)
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_external_library: ARRAYED_LIST [CONF_EXTERNAL_LIBRARY]
			-- All external library files including the ones from libraries.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (all_libraries.count)
			across all_libraries as ic loop
				Result.append (ic.external_library)
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_external_resource: ARRAYED_LIST [CONF_EXTERNAL_RESOURCE]
			-- All external ressource files including the ones from libraries.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (all_libraries.count)
			across all_libraries as ic loop
				Result.append (ic.external_resource)
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_external_linker_flag: ARRAYED_LIST [CONF_EXTERNAL_LINKER_FLAG]
			-- All external linker flags including the ones from libraries.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (all_libraries.count)
			across all_libraries as ic loop
				Result.append (ic.external_linker_flag)
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_external_make: ARRAYED_LIST [CONF_EXTERNAL_MAKE]
			-- All external make files including the ones from libraries.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (all_libraries.count)
			across all_libraries as ic loop
				Result.append (ic.external_make)
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_pre_compile_action: ARRAYED_LIST [CONF_ACTION]
			-- All Aactions to be executed before compilation.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (all_libraries.count)
			across all_libraries as ic loop
				Result.append (ic.pre_compile_action)
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_post_compile_action: ARRAYED_LIST [CONF_ACTION]
			-- All Aactions to be executed after compilation.
		require
			fully_parsed: is_fully_parsed
		do
			create Result.make (all_libraries.count)
			across all_libraries as ic loop
				Result.append (ic.post_compile_action)
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Status setting

	set_is_generated_uuid (b: BOOLEAN)
			-- Set `is_generated_uuid' to `b'.
		do
			is_generated_uuid := b
		ensure
			is_generated_uuid_set: is_generated_uuid = b
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_name (a_name: like name)
			-- Set `name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			name := a_name.as_lower
		ensure
			name_set: name.is_case_insensitive_equal_general (a_name)
		end

	set_readonly (a_readonly: like is_readonly)
			-- Set `is_readonly' to `a_readonly'.
		do
			is_readonly := a_readonly
		ensure
			is_readonly_set: is_readonly = a_readonly
		end

	set_description (a_description: like description)
			-- Set `description' to `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

	set_uuid (an_uuid: like uuid)
			-- Set `uuid' to `a_uuid'.
		require
			an_uuid_valid: an_uuid /= Void
		do
			uuid := an_uuid
		ensure
			uuid_set: uuid = an_uuid
		end

	add_target (a_target: CONF_TARGET)
			-- Add `a_target' to `targets'.
		require
			a_target_not_void: a_target /= Void
		do
			targets.force (a_target, a_target.name.twin)
			target_order.force (a_target)
		end

	remove_target (a_name: READABLE_STRING_GENERAL)
			-- Remove the target with name `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			if attached targets.item (a_name) as l_found_item then
				target_order.start
				target_order.search (l_found_item)
				target_order.remove
				targets.remove (a_name)
			end

			if attached library_target as l_target and then l_target.name.same_string_general (a_name) then
				library_target := Void
			end
		end

	set_library_target (a_target: like library_target)
			-- Set `library_target' to `a_target'.
		require
			no_overrides: a_target /= Void implies a_target.overrides.is_empty
		do
			library_target := a_target
		end

	set_library_target_by_name (a_target: detachable READABLE_STRING_32)
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

	is_group_equivalent (other: like Current): BOOLEAN
			-- Is `other' and `Current' the same with respect to the group layout?
		local
			l_o_targets: like targets
			l_o_target: detachable CONF_TARGET
			l_library_target, l_other_library_target: like library_target
		do
			if targets.count = other.targets.count then
				l_library_target := library_target
				l_other_library_target := other.library_target
				Result := (l_library_target = Void and l_other_library_target = Void) or
					((l_library_target /= Void and l_other_library_target /= Void) and then l_library_target.name.is_case_insensitive_equal (l_other_library_target.name) )
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

	process (a_visitor: CONF_VISITOR)
			-- Process `a_visitor'.
		do
			a_visitor.process_system (Current)
		end

feature -- Output

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := name
		end

feature {CONF_VISITOR, CONF_ACCESS} -- Implementation

	target_order: ARRAYED_LIST [CONF_TARGET]
			-- Order the targets appear in configuration file.

feature {NONE} -- Contract helper

	same_targets: BOOLEAN
			-- Do targets and target_order have the same content?
		do
			Result := targets.count = target_order.count and then target_order.for_all (agent (a_target: CONF_TARGET): BOOLEAN
				do
					Result := targets.has_key (a_target.name) and then targets.found_item = a_target
				end)
		end

	valid_level: BOOLEAN
			-- Is the current level valid?
			-- It has to be either 0 or the target has to be used in a library whose system has a lower level.
		do
			if level = 0 then
				Result := True
			elseif attached used_in_libraries as l_used_in_libraries then
				Result := l_used_in_libraries.there_exists (agent (a_lib: CONF_LIBRARY): BOOLEAN
					do
						Result := a_lib.target.system.level < level
					end)
			end
		end

invariant
	name_ok: name /= Void and then not name.is_empty
	name_lower: name.same_string (name.as_lower)
	targets_not_void: targets /= Void
	target_order_not_void: target_order /= Void
	target_and_order_same_content: same_targets
	fully_parsed: is_fully_parsed implies application_target /= Void
	lowest_in_used: attached lowest_used_in_library as inv_lowest_used_in_library implies attached used_in_libraries as inv_used_in_libraries and then inv_used_in_libraries.has (inv_lowest_used_in_library)
	application_target_library_in_used: attached application_target_library as inv_application_target_library implies attached used_in_libraries as inv_used_in_libraries and then inv_used_in_libraries.has (inv_application_target_library)
	valid_level: valid_level

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
