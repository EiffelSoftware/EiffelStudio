note
	description: "Base class for configuration groups."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_GROUP

inherit
	CONF_CONDITIONED
		redefine
			add_condition,
			set_conditions
		end

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

	make (a_name: like name; a_location: like location; a_target: CONF_TARGET)
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
		do
			Result := last_error /= Void
		end

	last_error: detachable CONF_ERROR
			-- The last error.

	classes_set: BOOLEAN
			-- Are the classes of this cluster set?
		do
			Result := classes /= Void
		end

	is_valid: BOOLEAN
			-- Is `Current' still valid and exists in the current system?

	is_library: BOOLEAN
			-- Is this a library?
		once
		end

	is_precompile: BOOLEAN
			-- Is this a precompile?
		once
		end

	is_assembly: BOOLEAN
			-- Is this an assembly?
		once
		end

	is_physical_assembly: BOOLEAN
			-- Is this a physical assembly?
		once
		end

	is_cluster: BOOLEAN
			-- Is this a cluster?
		once
		end

	is_test_cluster: BOOLEAN
			-- Is this a test cluster?
		once
		end

	is_override: BOOLEAN
			-- Is this an override?
		once
		end

	is_used_in_library: BOOLEAN
			-- Is this cluster used in a library? (as opposed to directly in the application system)
		do
			if attached target.system.application_target as l_app_target then
				check is_fully_parsed: target.system.is_fully_parsed end
				Result := l_app_target.system /= target.system
			end
		end

feature -- Status update

	set_error (an_error: CONF_ERROR)
			-- Set `an_error'.
		require
			an_error_attached: an_error /= Void
		do
			last_error := an_error
		ensure
			last_error_when_is_error: is_error and (last_error = an_error)
		end

	reset_error
			-- Reset error.
		do
			last_error := Void
		ensure
			not_error: not is_error
			last_error_void: last_error = Void
		end

feature -- Access, stored in configuration file

	name: READABLE_STRING_32
			-- The name of the group.

	description: detachable READABLE_STRING_32
			-- A description about the group.

	location: CONF_LOCATION
			-- The location of the group.

	is_readonly: BOOLEAN
			-- Is this group read only?
		do
			Result := internal_read_only
		end

	target: CONF_TARGET
			-- The target where this group is written in.

feature -- Access, in compiled only, not stored to configuration file

	overriders: detachable ARRAYED_LIST [CONF_OVERRIDE]
			-- The overriders that override this group.

	classes: detachable STRING_TABLE [like class_type]
			-- All the classes in this group, indexed by the renamed class name.

	hash_code: INTEGER
			-- Hash code value
		do
				-- compute hash code on demand
			if internal_hash_code = 0 then
				internal_hash_code := name.hash_code
			end
			Result := internal_hash_code
		end

feature -- Access queries

	is_overriden: BOOLEAN
			-- Is this group overriden by an override cluster?
		do
			Result := attached overriders as l_overriders and then not l_overriders.is_empty
		end

	mapping: STRING_TABLE [READABLE_STRING_32]
			-- Special classes name mapping (eg. STRING => STRING_32).
		deferred
		ensure
			result_not_void: Result /= Void
		end

	options: CONF_OPTION
			-- Options (Debuglevel, assertions, ...)
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	adapted_options: CONF_OPTION
			-- Options adapted to the current project.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	class_options: detachable STRING_TABLE [CONF_OPTION]
			-- Options for classes.
		deferred
		ensure
			Result_not_empty: Result /= Void implies not Result.is_empty
		end

	adapted_class_options: detachable STRING_TABLE [CONF_OPTION]
			-- Options for classes adapted to the current project.
		deferred
		ensure
			Result_not_empty: Result /= Void implies not Result.is_empty
		end

	get_class_options (a_class: STRING): CONF_OPTION
			-- Get the options for `a_class'.
		local
			l_name: READABLE_STRING_GENERAL
		do
			l_name := mapping.item (a_class)
			if not attached l_name then
				l_name := a_class
			end
			if
				attached adapted_class_options as os and then
				attached os.item (l_name) as o
			then
				Result := o.twin
				Result.merge (adapted_options)
			else
				Result := adapted_options.twin
			end
		ensure
			Result_not_void: Result /= Void
		end

	default_options: CONF_OPTION
			-- Default options of the group in `namespace`.
		do
			Result := {CONF_OPTION}.create_from_namespace_or_latest (namespace)
		end

	class_by_name (a_class: READABLE_STRING_GENERAL; a_dependencies: BOOLEAN): LINKED_SET [CONF_CLASS]
			-- Get the class with the final (after renaming/prefix) name `a_class'
			-- (if `a_dependencies' then we check dependencies)
		require
			a_class_ok: a_class /= Void and then not a_class.is_empty
			a_class_upper: a_class.is_equal (a_class.as_upper)
			classes_set: classes_set
		do
			create Result.make
			if
				attached classes as l_classes and then
				attached l_classes.item (a_class) as l_class and then
				not l_class.does_override
			then
				Result.extend (l_class)
			end
		ensure
			Result_not_void: Result /= Void
		end

	name_by_class (a_class: CONF_CLASS; a_dependencies: BOOLEAN): LINKED_SET [READABLE_STRING_GENERAL]
			-- Get name in this context of `a_class' (if `a_dependencies') then we check dependencies).
		require
			a_class_ok: a_class /= Void and then a_class.is_valid
			classes_set: classes_set
		local
			l_reverse_classes_cache: like reverse_classes_cache
		do
			create Result.make
			if attached classes as l_classes then
				l_reverse_classes_cache := reverse_classes_cache
				if l_reverse_classes_cache = Void then
					create l_reverse_classes_cache.make (l_classes.count)
					reverse_classes_cache := l_reverse_classes_cache
					across
						l_classes as ic
					loop
						l_reverse_classes_cache.force (@ ic.key, ic)
					end
				end
				if attached l_reverse_classes_cache.item (a_class) as l_found_item then
					Result.force (l_found_item )
				end
			else
				check precondition__classes_set: False end
			end
		ensure
			Result_not_void: Result /= Void
		end

	accessible_groups: SEARCH_TABLE [CONF_GROUP]
			-- Groups that are accessible within `Current'.
		require
			classes_set: classes_set
		once
			create Result.make_map (0)
		ensure
			Result_not_void: Result /= Void
		end

	accessible_classes: like classes
			-- Classes that are accessible within `Current'.
		require
			classes_set: classes_set
		local
			l_grp: CONF_GROUP
		do
			if attached classes as l_classes then
				Result := l_classes.twin
				across accessible_groups as g loop
					l_grp := g
					if attached l_grp.classes as l_grp_classes then
						Result.merge (l_grp_classes)
					end
				end
			else
				check precondition__classes_set: False end
				create Result.make_equal (0)
			end
		ensure
			Result_not_void: Result /= Void
		end

	accessible_mapping: like mapping
			-- Class mappings that are accessible within `Current'.
		require
			classes_set: classes_set
		do
			Result :=  mapping.twin
			if attached accessible_groups as l_groups then
				⟳ g: l_groups ¦ Result.merge (g.mapping) ⟲
			end
		ensure
			Result_not_void: Result /= Void
		end

	sub_group_by_name (a_name: READABLE_STRING_GENERAL): detachable CONF_GROUP
			-- Return sub group with `a_name' if there is any.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.same_string (a_name.as_lower)
		deferred
		end

	namespace: like namespace_1_0_0
			-- The XML namespace associated with the group.
		do
			Result := target.namespace
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Group name alphabetic order
		do
			Result := name < other.name
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	invalidate
			-- Set `is_valid' to False.
		do
			is_valid := False
		ensure
			not_valid: not is_valid
		end

	revalidate
			-- Set `is_valid' to True.
		do
			is_valid := True
		ensure
			is_valid: is_valid
		end

	set_name (a_name: like name)
			-- Set `name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_description (a_description: detachable READABLE_STRING_GENERAL)
			-- Set `description' to `a_description'.
		do
			if a_description /= Void then
				create {STRING_32} description.make_from_string_general (a_description)
			else
				description := Void
			end
		ensure
			description_set: a_description /= Void implies attached description as d and then a_description.same_string (d)
		end

	set_location (a_location: like location)
			-- Set `location' to `a_location'.
		require
			a_location_not_void: a_location /= Void
		do
			location := a_location
		ensure
			location_set: location = a_location
		end

	set_readonly (b: BOOLEAN)
			-- Set `internal_readonly' bo `b'.
		do
			is_readonly_set := True
			internal_read_only := b
		ensure
			readonly_set: is_readonly_set
			internal_read_only_set: internal_read_only = b
		end

	set_readonly_set (b: BOOLEAN)
			-- Set `is_readonly_set' bo `b'.
		do
			is_readonly_set := b
		ensure
			readonly_set: is_readonly_set = b
		end

	set_options (a_option: like internal_options)
			-- Set `a_option'.
		do
			internal_options := a_option
		ensure
			option_set: internal_options = a_option
		end

	merge_options (an_option: like options)
			-- If `internal_options` is already set, merge `an_option` with it,
			-- otherwise set the options to `an_option`.
		require
			an_option_not_void: an_option /= Void
		do
			if attached internal_options as l_opts then
				l_opts.merge (an_option)
			else
				internal_options := an_option
			end
		ensure
			option_set: internal_options /= Void
		end

	set_class_options (a_options: like class_options)
			-- Set `a_options'.
		do
			internal_class_options := a_options
		ensure
			class_options_set: internal_class_options = a_options
		end

	add_class_options (a_option: CONF_OPTION; a_class: READABLE_STRING_GENERAL)
			-- Add class options.
		require
			a_option_not_void: a_option /= Void
			a_class_ok: a_class /= Void and then not a_class.is_empty
			a_class_upper: a_class.is_equal (a_class.as_upper)
		local
			l_internal_class_options: like internal_class_options
		do
			l_internal_class_options := internal_class_options
			if l_internal_class_options = Void then
				create l_internal_class_options.make_caseless (1)
				internal_class_options := l_internal_class_options
			end
			l_internal_class_options.force (a_option, a_class)
		ensure
			internal_class_options_set: attached internal_class_options as el_internal_class_options
			added: el_internal_class_options.has (a_class) and then el_internal_class_options.item (a_class) = a_option
		end

feature {CONF_ACCESS} -- Status update

	add_condition (a_condition: CONF_CONDITION)
			-- Add `a_condition'.
		do
			Precursor (a_condition)
			if attached target as tgt then
				a_condition.set_target (tgt)
			end
		end

	set_conditions (a_conditions: like internal_conditions)
			-- Set `internal_conditions' to `a_conditions'.
		do
			Precursor (a_conditions)
			if
				attached target as tgt and
				a_conditions /= Void and then not a_conditions.is_empty
			then
				across
					a_conditions as ic
				loop
					ic.set_target (tgt)
				end
			end
		end

feature {CONF_ACCESS} -- Update, in compiled only, not stored to configuration file

	set_classes (a_classes: like classes)
			-- Set `classes' to `a_classes'
		require
			a_classes_not_void: a_classes /= Void
		do
			classes := a_classes
		ensure
			classes_set: classes = a_classes
		end

	set_classes_by_filename (a_classes: attached like classes_by_filename)
			-- Set `classes_by_filename' to `a_classes'
		require
			a_classes_not_void: a_classes /= Void
			classes_up_to_date: attached classes as l_classes and then l_classes.count = a_classes.count
		do
			classes_by_filename := a_classes
		ensure
			classes_set: classes_by_filename = a_classes
			classes_by_filename_set: attached classes_by_filename as l_classes_by_filename
			same_as_classes: attached classes as el_classes and then el_classes.count = l_classes_by_filename.count
		end

	add_overriders (an_overrider: CONF_OVERRIDE; a_added_classes, a_modified_classes, a_removed_classes: SEARCH_TABLE [CONF_CLASS])
			-- Add `an_overrider' to `overriders', track classes with a changed override in `a_modified_classes'
			-- and classes that where compiled but do now override something in `a_removed_classes'.
		require
			an_overrider_not_void: an_overrider /= Void
			a_added_classes_not_void: a_added_classes /= Void
			a_modified_classes_not_void: a_modified_classes /= Void
			a_removed_classes_not_void: a_removed_classes /= Void
			classes_set: classes_set
		local
			l_overridee, l_overrider: detachable CONF_CLASS
			l_ovs: detachable LINKED_SET [CONF_CLASS]
			l_er: CONF_ERROR_OVERRIDE
			l_overriders: like overriders
		do
			if is_override then
				create l_er
				l_er.set_group (name)
				set_error (l_er)
			else
				l_overriders := overriders
				if l_overriders = Void then
					create l_overriders.make (1)
					overriders := l_overriders
				end
				l_overriders.extend (an_overrider)
				if attached an_overrider.classes as cs then
					across
						cs as c
					loop
						l_overrider := c
						l_ovs := class_by_name (l_overrider.name, False)
						if not l_ovs.is_empty then
							l_overridee := l_ovs.first
							if l_overridee.is_overriden then
								set_error (
									create {CONF_ERROR_MULOVER}.make (l_overridee.name,
									l_overridee.full_file_name.name,
									l_overridee.actual_class.full_file_name.name, l_overrider.full_file_name.name))
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
					end
				end
			end
		ensure
			overrider_added: attached overriders as el_overriders implies el_overriders.has (an_overrider)
		end

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN
			-- Is `other' and `Current' the same with respect to the group layout?
		do
			Result := name.is_equal (other.name) and then location.is_equal (other.location) and then
						equal (internal_conditions, other.internal_conditions)
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR)
			-- Process `a_visitor'.
		do
			a_visitor.process_group (Current)
		end

feature -- Output

	debug_output: STRING_32
			-- Generate a nice representation of Current to be seen
			-- in debugger.
		do
			Result := name
		end

feature {CONF_VISITOR, CONF_ACCESS} -- Implementation, attributes stored in configuration file

	is_readonly_set: BOOLEAN
			-- Has a readonly status been set on this group?

	internal_options: detachable CONF_OPTION
			-- Options (Debuglevel, assertions, ...) of this group itself.

	forced_options: like internal_options
			-- Same as `internal_options`, but forced by a third-party (client, precompile, etc.) project,
			-- not by the original one.

	internal_class_options: detachable STRING_TABLE [CONF_OPTION]
			-- Classes with specific options of this group itself.

	forced_class_options: like internal_class_options
			-- Same as `internal_class_options`, but forced by a third-party (client, precompile, etc.) project,
			-- not by the original one.

	changeable_internal_options: attached like internal_options
			-- A possibility to change settings without knowing if we have some options already set.
		do
			Result := internal_options
			if not attached Result then
				Result := {like internal_options}.create_from_namespace_or_latest (namespace)
				internal_options := Result
			end
		ensure
			Result_not_void: Result /= Void
		end

	changeable_class_options (a_class: CONF_CLASS): attached like internal_options
			-- A possibility to change settings of `a_class' without knowing if we have some options already set.
		require
			a_class_not_void: a_class /= Void
			valid_group_for_class: attached classes as l_classes implies l_classes.has (a_class.name)
		do
			if attached internal_class_options as l_internal_options then
				Result := l_internal_options.item (a_class.name)
			end
			if not attached Result then
				Result := {like internal_options}.create_from_namespace_or_latest (namespace)
				add_class_options (Result, a_class.name)
			end
		end

feature {CONF_VISITOR} -- Modification

	force_options (o: like options)
		require
			attached internal_options
		do
			forced_options := o
		ensure
			forced_options = o
		end

	force_class_options (o: attached like forced_class_options)
			-- Force class options `o` by a third-party project.
		require
			internal_class_options_attached: attached internal_class_options as i
			is_caseless: o.is_case_insensitive
			internal_includes_forced: across o as oc all i.has (@ oc.key) end
			forced_includes_internal: across i as ic all o.has (@ ic.key) end
		do
			forced_class_options := o
		ensure
			forced_class_options = o
		end

feature {CONF_VISITOR, CONF_ACCESS} -- Implementation, not stored in configuration fi

	classes_by_filename: detachable HASH_TABLE [like class_type, PATH]
			-- Classes index by filename

feature {NONE} -- Type anchors

	class_type: CONF_CLASS
			-- Class type anchor.
		require
			do_call: False
		do
			check False then
				-- This function is only for typing.
			end
		end

feature {NONE} -- Implementation

	internal_hash_code: INTEGER
			-- Cached value of the hash_code

	reverse_classes_cache: detachable HASH_TABLE [READABLE_STRING_GENERAL, like class_type]
			-- Cache for speedup of `name_by_class' lookups.

	accessible_groups_cache: detachable like accessible_groups
			-- Cached version of `accessible_groups'.

feature {CONF_ACCESS} -- Stored in configuration file

	internal_read_only: BOOLEAN
			-- Internal read only value

invariant
	name_ok: name /= Void and then not name.is_empty
	location_not_void: location /= Void
	target_not_void: target /= Void
	is_error_same_as_last_error: is_error = (last_error /= Void)

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
