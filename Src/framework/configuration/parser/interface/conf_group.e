indexing
	description: "Base class for configuration groups."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_GROUP

inherit
	CONF_CONDITIONED

	CONF_VISITABLE

	CONF_NOTABLE

	CONF_ACCESS

	COMPARABLE
		undefine
			is_equal
		end

	HASHABLE

	DEBUG_OUTPUT

feature {NONE} -- Initialization

	make (a_name: like name; a_location: like location; a_target: CONF_TARGET) is
			-- Create associated to `a_target'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_location_not_void: a_location /= Void
			a_target_not_void: a_target /= Void
		do
			target := a_target
			set_name (a_name.as_lower)
			set_location (a_location)
			is_valid := True
		ensure
			is_valid: is_valid
		end

feature -- Status

	is_error: BOOLEAN
			-- Was there an error during an operation?

	last_error: CONF_ERROR
			-- The last error.

	classes_set: BOOLEAN is
			-- Are the classes of this cluster set?
		do
			Result := classes /= Void
		end

	is_valid: BOOLEAN
			-- Is `Current' still valid and exists in the current system?

	is_library: BOOLEAN is
			-- Is this a library?
		once
		end

	is_precompile: BOOLEAN is
			-- Is this a precompile?
		once
		end

	is_assembly: BOOLEAN is
			-- Is this an assembly?
		once
		end

	is_physical_assembly: BOOLEAN is
			-- Is this a physical assembly?
		once
		end

	is_cluster: BOOLEAN is
			-- Is this a cluster?
		once
		end

	is_test_cluster: BOOLEAN is
			-- Is this a test cluster?
		once
		end

	is_override: BOOLEAN is
			-- Is this an override?
		once
		end

	is_used_in_library: BOOLEAN is
			-- Is this this cluster used in a library? (as opposed to directly in the application system)
		do
			if target.system.is_fully_parsed then
				Result := target.system.application_target.system /= target.system
			end
		end

	is_internal: BOOLEAN
			-- Is group used internally by the compiler?
			--
			-- Note: if `Current' is internal it is not stored in configuration and not visible to user.

feature -- Status update

	set_error (an_error: CONF_ERROR) is
			-- Set `an_error'.
		do
			is_error := True
			last_error := an_error
		end

	reset_error is
			-- Reset error.
		do
			is_error := False
			last_error := Void
		ensure
			not_is_error: not is_error
		end

	set_internal (a_is_internal: like is_internal)
			-- Set `is_internal' to `a_is_internal'.
		do
			is_internal := a_is_internal
		end

feature -- Access, stored in configuration file

	name: STRING
			-- The name of the group.

	description: STRING
			-- A description about the group.

	location: CONF_LOCATION
			-- The location of the group.

	is_readonly: BOOLEAN is
			-- Is this group read only?
		do
			Result := internal_read_only
		end

	target: CONF_TARGET
			-- The target where this group is written in.

feature -- Access, in compiled only, not stored to configuration file

	overriders: ARRAYED_LIST [CONF_OVERRIDE]
			-- The overriders that override this group.

	classes: HASH_TABLE [like class_type, STRING]
			-- All the classes in this group, indexed by the renamed class name.

	hash_code: INTEGER is
			-- Hash code value
		do
				-- compute hash code on demand
			if internal_hash_code = 0 then
				internal_hash_code := name.hash_code
			end
			Result := internal_hash_code
		end

feature -- Access queries

	is_overriden: BOOLEAN is
			-- Is this group overriden by an override cluster?
		do
			Result := overriders /= Void and then not overriders.is_empty
		end

	mapping: EQUALITY_HASH_TABLE [STRING, STRING] is
			-- Special classes name mapping (eg. STRING => STRING_32).
		deferred
		ensure
			result_not_void: Result /= Void
		end

	mapping_32: EQUALITY_HASH_TABLE [STRING_32, STRING_32] is
			-- Same as `mapping' but with STRING_32.
		do
			create Result.make (mapping.count)
			from
				mapping.start
			until
				mapping.after
			loop
				Result.extend (mapping.item_for_iteration, mapping.key_for_iteration)
				mapping.forth
			end
		ensure
			mapping_32_not_void: Result /= Void
		end

	options: CONF_OPTION is
			-- Options (Debuglevel, assertions, ...)
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	class_options: HASH_TABLE [CONF_OPTION, STRING] is
			-- Options for classes.
		deferred
		ensure
			Result_not_empty: Result /= Void implies not Result.is_empty
		end

	class_options_32: HASH_TABLE [CONF_OPTION, STRING_32] is
			-- Classes with specific options of this group itself.
		local
			l_options: like class_options
		do
			l_options := class_options
			if l_options /= Void then
				create Result.make (l_options.count)
				from
					l_options.start
				until
					l_options.after
				loop
					Result.extend (l_options.item_for_iteration, l_options.key_for_iteration)
					l_options.forth
				end
			end
		ensure
			class_options_32_not_empty: Result /= Void implies not Result.is_empty
		end

	get_class_options (a_class: STRING): CONF_OPTION is
			-- Get the options for `a_class'.
		local
			l_name: STRING
			l_map: like mapping
			l_class_options: like class_options
		do
			l_map := mapping
			if l_map.has_key (a_class) then
				l_name := l_map.found_item
			else
				l_name := a_class
			end
			l_class_options := class_options
			if l_class_options /= Void then
				Result := l_class_options.item (l_name)
				if Result /= Void then
					Result := Result.twin
					Result.merge (options)
				else
					Result := options.twin
				end
			else
				Result := options.twin
			end

		ensure
			Result_not_void: Result /= Void
		end

	class_by_name (a_class: STRING; a_dependencies: BOOLEAN): LINKED_SET [CONF_CLASS] is
			-- Get the class with the final (after renaming/prefix) name `a_class'
			-- (if `a_dependencies' then we check dependencies)
		require
			a_class_ok: a_class /= Void and then not a_class.is_empty
			a_class_upper: a_class.is_equal (a_class.as_upper)
			classes_set: classes_set
		local
			l_class: CONF_CLASS
		do
			create Result.make
			l_class := classes.item (a_class)
			if l_class /= Void and then not l_class.does_override then
				Result.extend (l_class)
			end
		ensure
			Result_not_void: Result /= Void
		end

	name_by_class (a_class: CONF_CLASS; a_dependencies: BOOLEAN): LINKED_SET [STRING] is
			-- Get name in this context of `a_class' (if `a_dependencies') then we check dependencies).
		require
			a_class_ok: a_class /= Void and then a_class.is_valid
			classes_set: classes_set
		local
			l_cursor: CURSOR
		do
			create Result.make
			if reverse_classes_cache = Void then
				create reverse_classes_cache.make (classes.count)
				from
					classes.start
					l_cursor := classes.cursor
				until
					classes.after
				loop
					reverse_classes_cache.force (classes.key_for_iteration, classes.item_for_iteration)
					classes.forth
				end
				classes.go_to (l_cursor)
			end
			if reverse_classes_cache.has_key (a_class) then
				Result.force (reverse_classes_cache.found_item)
			end
		ensure
			Result_not_void: Result /= Void
		end

	accessible_groups: DS_HASH_SET [CONF_GROUP] is
			-- Groups that are accessible within `Current'.
		require
			classes_set: classes_set
		once
			create Result.make_default
		ensure
			Result_not_void: Result /= Void
		end

	accessible_classes: like classes is
			-- Classes that are accessible within `Current'.
		require
			classes_set: classes_set
		local
			l_groups: like accessible_groups
			l_grp: CONF_GROUP
		do
			Result :=  classes.twin
			l_groups := accessible_groups
			if l_groups /= Void then
				from
					l_groups.start
				until
					l_groups.after
				loop
					l_grp := l_groups.item_for_iteration
					if l_grp.classes_set then
						Result.merge (l_grp.classes)
					end
					l_groups.forth
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	sub_group_by_name (a_name: STRING): CONF_GROUP is
			-- Return sub group with `a_name' if there is any.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		deferred
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Group name alphabetic order
		do
			Result := name < other.name
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	invalidate is
			-- Set `is_valid' to False.
		do
			is_valid := False
		ensure
			not_valid: not is_valid
		end

	revalidate is
			-- Set `is_valid' to True.
		do
			is_valid := True
		ensure
			is_valid: is_valid
		end

	set_name (a_name: like name) is
			-- Set `name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_description (a_description: like description) is
			-- Set `description' to `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

	set_location (a_location: like location) is
			-- Set `location' to `a_location'.
		require
			a_location_not_void: a_location /= Void
		do
			location := a_location
		ensure
			location_set: location = a_location
		end

	set_readonly (b: BOOLEAN) is
			-- Set `internal_readonly' bo `b'.
		do
			is_readonly_set := True
			internal_read_only := b
		ensure
			readonly_set: is_readonly_set
			internal_read_only_set: internal_read_only = b
		end

	set_readonly_set (b: BOOLEAN) is
			-- Set `is_readonly_set' bo `b'.
		do
			is_readonly_set := b
		ensure
			readonly_set: is_readonly_set = b
		end

	set_options (a_option: like internal_options) is
			-- Set `a_option'.
		do
			internal_options := a_option
		ensure
			option_set: internal_options = a_option
		end

	set_class_options (a_options: like class_options) is
			-- Set `a_options'.
		do
			internal_class_options := a_options
		ensure
			class_options_set: internal_class_options = a_options
		end

	set_class_options_32 (a_options_32: like class_options_32) is
			-- Set `a_options'.
		do
			if a_options_32 = Void then
				internal_class_options := Void
			else
				create internal_class_options.make (a_options_32.count)
				from
					a_options_32.start
				until
					a_options_32.after
				loop
					internal_class_options.extend (a_options_32.item_for_iteration, a_options_32.key_for_iteration)
					a_options_32.forth
				end
			end
		end

	add_class_options (a_option: CONF_OPTION; a_class: STRING) is
			-- Add class options.
		require
			a_option_not_void: a_option /= Void
			a_class_ok: a_class /= Void and then not a_class.is_empty
			a_class_upper: a_class.is_equal (a_class.as_upper)
		do
			if internal_class_options = Void then
				create internal_class_options.make (1)
			end
			internal_class_options.force (a_option, a_class)
		ensure
			added: internal_class_options.has (a_class) and then internal_class_options.item (a_class) = a_option
		end

feature {CONF_ACCESS} -- Update, in compiled only, not stored to configuration file

	set_classes (a_classes: like classes) is
			-- Set `classes' to `a_classes'
		require
			a_classes_not_void: a_classes /= Void
		do
			classes := a_classes
		ensure
			classes_set: classes = a_classes
		end

	set_classes_by_filename (a_classes: like classes_by_filename) is
			-- Set `classes_by_filename' to `a_classes'
		require
			classes_up_to_date: classes /= Void and classes.count = a_classes.count
			a_classes_not_void: a_classes /= Void
		do
			classes_by_filename := a_classes
		ensure
			classes_set: classes_by_filename = a_classes
			same_as_classes: classes.count = classes_by_filename.count
		end

	add_overriders (an_overrider: CONF_OVERRIDE; a_added_classes, a_modified_classes, a_removed_classes: DS_HASH_SET [CONF_CLASS]) is
			-- Add `an_overrider' to `overriders', track classes with a changed override in `a_modified_classes'
			-- and classes that where compiled but do now override something in `a_removed_classes'.
		require
			an_overrider_not_void: an_overrider /= Void
			a_added_classes_not_void: a_added_classes /= Void
			a_modified_classes_not_void: a_modified_classes /= Void
			a_removed_classes_not_void: a_removed_classes /= Void
			classes_set: classes_set
		local
			l_classes: like classes
			l_overridee, l_overrider: CONF_CLASS
			l_ovs: LINKED_SET [CONF_CLASS]
			l_er: CONF_ERROR_OVERRIDE
		do
			if is_override then
				create l_er
				l_er.set_group (name)
				set_error (l_er)
			else
				if overriders = Void then
					create overriders.make (1)
				end
				overriders.extend (an_overrider)

				from
					l_classes := an_overrider.classes
					l_classes.start
				until
					l_classes.after
				loop
					l_overrider := l_classes.item_for_iteration
					l_ovs := class_by_name (l_overrider.name, False)
					if l_ovs /= Void and then l_ovs.count > 0 then
						l_overridee := l_ovs.first
						if l_overridee.is_overriden then
							set_error (
								create {CONF_ERROR_MULOVER}.make (l_overridee.name,
								l_overridee.full_file_name,
								l_overridee.actual_class.full_file_name, l_overrider.full_file_name))
						else
							l_overridee.set_overriden_by (l_overrider)
							l_overrider.add_does_override (l_overridee)
							if l_overrider.is_modified then
								if not l_overridee.is_compiled then
									a_added_classes.force (l_overridee)
								else
									a_modified_classes.force (l_overridee)
								end
								l_overrider.set_up_to_date
							else
								a_added_classes.remove (l_overridee)
								a_modified_classes.remove (l_overridee)
							end
								-- Make sure that `l_overrider' is not referenced
								-- for normal compilation since it is now overriding `l_overidee'.
							if l_overrider.is_compiled then
								a_removed_classes.force (l_overrider)
							end
							a_added_classes.remove (l_overrider)
							a_modified_classes.remove (l_overrider)
						end
					end
					l_classes.forth
				end
			end
		ensure
			overrider_added: overriders.has (an_overrider)
		end

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN is
			-- Is `other' and `Current' the same with respect to the group layout?
		do
			Result := name.is_equal (other.name) and then location.is_equal (other.location) and then
						equal (internal_conditions, other.internal_conditions)
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_group (Current)
		end

feature -- Output

	debug_output: STRING is
			-- Generate a nice representation of Current to be seen
			-- in debugger.
		do
			Result := name
		end

feature {CONF_VISITOR, CONF_ACCESS} -- Implementation, attributes stored in configuration file

	is_readonly_set: BOOLEAN
			-- Has a readonly status been set on this group?

	internal_options: CONF_OPTION
			-- Options (Debuglevel, assertions, ...) of this group itself.

	internal_class_options: HASH_TABLE [CONF_OPTION, STRING]
			-- Classes with specific options of this group itself.

	changeable_internal_options: like internal_options is
			-- A possibility to change settings without knowing if we have some options already set.
		do
			if internal_options = Void then
				create internal_options
			end
			Result := internal_options
		ensure
			Result_not_void: Result /= Void
		end

	changeable_class_options (a_class: CONF_CLASS): like internal_options is
			-- A possibility to change settings of `a_class' without knowing if we have some options already set.
		require
			a_class_not_void: a_class /= Void
			valid_group_for_class: classes_set implies classes.has (a_class.name)
		do
			if internal_class_options /= Void then
				Result := internal_class_options.item (a_class.name)
			end
			if Result = Void then
				create Result
				add_class_options (Result, a_class.name)
			end
		end

feature {CONF_VISITOR, CONF_ACCESS} -- Implementation, not stored in configuration fi

	classes_by_filename: HASH_TABLE [like class_type, STRING]
			-- Classes index by filename

feature {NONE} -- Type anchors

	class_type: CONF_CLASS is
			-- Class type anchor.
		do
		end

feature {NONE} -- Implementation

	internal_hash_code: INTEGER
			-- Cached value of the hash_code

	reverse_classes_cache: HASH_TABLE [STRING, like class_type]
			-- Cache for speedup of `name_by_class' lookups.

	accessible_groups_cache: like accessible_groups
			-- Cached version of `accessible_groups'.

feature {CONF_ACCESS} -- Stored in configuration file

	internal_read_only: BOOLEAN
			-- Internal read only value

invariant
	name_ok: name /= Void and then not name.is_empty
	location_not_void: location /= Void
	target_not_void: target /= Void

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
