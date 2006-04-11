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

	CONF_ACCESS

	COMPARABLE
		undefine
			is_equal
		end

	HASHABLE

feature {NONE} -- Initialization

	make (a_name: like name; a_location: like location; a_target: CONF_TARGET) is
			-- Create associated to `a_target'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
			a_location_not_void: a_location /= Void
			a_target_not_void: a_target /= Void
		do
			target := a_target
			set_name (a_name)
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

	is_cluster: BOOLEAN is
			-- Is this a cluster?
		once
		end

	is_override: BOOLEAN is
			-- Is this an override?
		once
		end

	is_used_library: BOOLEAN is
			-- Is this this cluster used in a library? (as opposed to directly in the application system)
		do
			Result := target.application_target.system /= target.system
		end

feature -- Access, stored in configuration file

	name: STRING
			-- The name of the group.

	description: STRING
			-- A description about the group.

	location: CONF_LOCATION
			-- The location of the group.

	name_prefix: STRING
			-- An optional name prefix for this group.

	renaming: CONF_HASH_TABLE [STRING, STRING]
			-- Mapping of renamed classes from the old name to the new name.

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


	options: CONF_OPTION is
			-- Options (Debuglevel, assertions, ...)
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	get_class_options (a_class: STRING): CONF_OPTION is
			-- Get the options for `a_class'.
		do
			if class_options /= Void then
				Result := class_options.item (a_class)
			end
			if Result /= Void then
				Result.merge (options)
			else
				Result := options
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
			if l_class /= Void then
				Result.extend (l_class)
			end
		ensure
			Result_not_void: Result /= Void
		end

	accessible_groups: LINKED_SET [CONF_GROUP] is
			-- Groups that are accessible within `Current'.
			-- Dependencies if we have them, else everything except `Current'.
		do
			create Result.make
		ensure
			Result_not_void: Result /= Void
		end

	accessible_classes: like classes is
			-- Classes that are accessible within `Current'.
		require
			classes_set: classes_set
		do
			Result :=  classes.twin
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

	set_name_prefix (a_name_prefix: like name_prefix) is
			-- Set `name_prefix' to `a_name_prefix'.
		do
			name_prefix := a_name_prefix
			if name_prefix /= Void then
				name_prefix.to_upper
			end
		ensure
			name_prefix_set: name_prefix = a_name_prefix
		end

	set_renaming (a_renaming: like renaming) is
			-- Set `renaming' to `a_renaming'.
		do
			renaming := a_renaming
		ensure
			renaming_set: renaming = a_renaming
		end

	add_renaming (an_old_name, a_new_name: STRING) is
			-- Add a renaming.
		require
			an_old_name_ok: an_old_name /= Void and then not an_old_name.is_empty
			an_old_name_upper: an_old_name.is_equal (an_old_name.as_upper)
			a_new_name_ok: a_new_name /= Void and then not a_new_name.is_empty
			a_new_name_upper: a_new_name.is_equal (a_new_name.as_upper)
		do
			if renaming = Void then
				create renaming.make (1)
			end
			renaming.force (a_new_name, an_old_name)
		ensure
			added: renaming.has (an_old_name) and then renaming.item (an_old_name) = a_new_name
		end


	enable_readonly is
			-- Set `internal_readonly' to true.
		do
			internal_read_only := True
		ensure
			is_readonly: is_readonly
		end

	set_readonly (b: BOOLEAN) is
			-- Set `internal_readonly' bo `b'.
		do
			internal_read_only := b
		ensure
			internal_read_only_set: internal_read_only = b
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
			class_options := a_options
		ensure
			class_options_set: class_options = a_options
		end

	add_class_options (a_option: CONF_OPTION; a_class: STRING) is
			-- Add class options.
		require
			a_option_not_void: a_option /= Void
			a_class_ok: a_class /= Void and then not a_class.is_empty
			a_class_upper: a_class.is_equal (a_class.as_upper)
		do
			if class_options = Void then
				create class_options.make (1)
			end
			class_options.force (a_option, a_class)
		ensure
			added: class_options.has (a_class) and then class_options.item (a_class) = a_option
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

	clean_classes is
			-- Clean the classes.
		do
			classes := Void
		ensure
			not_classes_set: not classes_set
		end


	set_overriders (an_overriders: like overriders) is
			-- Set `overriders' to `an_overriders'.
		do
			overriders := an_overriders
		ensure
			overriders_set: overriders = an_overriders
		end

	add_overriders (an_overrider: CONF_OVERRIDE; a_modified_classes: DS_HASH_SET [CONF_CLASS]) is
			-- Add `an_overrider' to `overriders', track classes with a changed override in `a_modified_classes'.
		require
			an_overrider_not_void: an_overrider /= Void
			a_modified_classes_not_void: a_modified_classes /= Void
			classes_set: classes_set
		local
			l_classes: like classes
			l_overridee, l_overrider: CONF_CLASS
			l_ovs: LINKED_SET [CONF_CLASS]
			l_er: CONF_ERROR_OVERRIDE
		do
			if is_override then
				is_error := True
				create l_er
				l_er.set_group (name)
				last_error := l_er
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
					l_ovs := class_by_name (l_overrider.renamed_name, False)
					if l_ovs /= Void and then l_ovs.count > 0 then
						l_overridee := l_ovs.first
						if l_overridee.is_overriden then
							is_error := True
							last_error := create {CONF_ERROR_MULOVER}.make (l_overridee.name)
						else
							l_overridee.set_overriden_by (l_overrider)
							l_overrider.add_does_override (l_overridee)
							if l_overridee.is_modified then
								a_modified_classes.force (l_overridee)
							else
								a_modified_classes.remove (l_overridee)
							end
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
						equal (name_prefix, other.name_prefix) and then equal (renaming, other.renaming)
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_group (Current)
		end

feature {CONF_VISITOR} -- Implementation, attributes stored in configuration file

	internal_options: CONF_OPTION
			-- Options (Debuglevel, assertions, ...) of this group itself.

	class_options: HASH_TABLE [CONF_OPTION, STRING]
			-- Classes with specific options.

feature {NONE} -- Class type anchor

	class_type: CONF_CLASS

feature {NONE} -- Implementation

	internal_hash_code: INTEGER
			-- Cashed value of the hash_code

feature {CONF_ACCESS} -- Stored in configuration file

	internal_read_only: BOOLEAN
			-- Internal read only value

invariant
	name_ok: name /= Void and then not name.is_empty
	location_not_void: location /= Void
	target_not_void: target /= Void
	name_prefix_upper: name_prefix /= Void implies name_prefix.is_equal (name_prefix.as_upper)

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
