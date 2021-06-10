note
	description: "A library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LIBRARY

inherit
	CONF_VISIBLE

	CONF_VIRTUAL_GROUP
		redefine
			make,
			process,
			is_library,
			is_readonly,
			is_group_equivalent,
			class_by_name
		end

create {CONF_PARSE_FACTORY}
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_location: like location; a_target: CONF_TARGET)
			-- Create associated to `a_target'.
		do
			Precursor {CONF_VIRTUAL_GROUP}(a_name, a_location, a_target)
			internal_read_only := True
		ensure then
			readonly: is_readonly
		end

feature -- Status

	is_library: BOOLEAN = True
			-- Is this a library?

	is_readonly: BOOLEAN
			-- Is this library readonly?
		do
			if is_readonly_set then
				Result := internal_read_only
			elseif attached library_target as l_library_target then
				Result := l_library_target.system.is_readonly
			else
				Result := True
			end
		end

feature -- Access, stored in configuration file

	use_application_options: BOOLEAN
			-- Should the library use the options of the application? (Instead of the library)

feature -- Access, in compiled only, not stored to configuration file

	library_target: detachable CONF_TARGET
			-- The library target.

	mapping: STRING_TABLE [READABLE_STRING_32]
			-- We use the one from the target.
		do
			if attached library_target as l_library_target then
				Result := l_library_target.mapping
			else
				create Result.make_equal (0)
			end
		end

feature -- Access queries

	sub_group_by_name (a_name: READABLE_STRING_GENERAL): detachable CONF_GROUP
			-- Return sub group with `a_name' if there is any.
		do
			if attached library_target as l_library_target then
					-- It is ok for the time being to use `as_string_8_conversion' since
					-- names are just STRING_8 instances, but it would be better to update
					-- the configuration library to accept STRING_32 too.
				Result := l_library_target.groups.item (a_name)
			end
		end

	class_by_name (a_class: READABLE_STRING_GENERAL; a_dependencies: BOOLEAN): LINKED_SET [CONF_CLASS]
			-- Get the class with the final (after renaming/prefix) name `a_class'
			-- (if `a_dependencies' then we check dependencies)
		local
			l_class: READABLE_STRING_GENERAL
			l_mapping: like mapping
		do
			l_mapping := mapping
			if l_mapping /= Void and then attached l_mapping.item (a_class) as l_mapping_found_item then
				l_class := l_mapping_found_item
			else
				l_class := a_class
			end
			create Result.make
			if
				attached classes as l_classes and then
				attached l_classes.item (l_class) as l_conf_class and then
				not l_conf_class.does_override
			then
				Result.extend (l_conf_class)
			end
		end

	options: CONF_OPTION
			-- <Precursor>
		do
				-- Only options that can be overridden should be taken from the local definition,
				-- so `internal_options' cannot be used as a starting point, the clean object is used instead.
			Result := {CONF_OPTION}.create_from_namespace_or_latest (namespace)

				-- Apply local options if present.
			if attached internal_options as l_internal_options then
				Result.merge_client (l_internal_options)
			end

				-- Apply options of the application if required.
			if use_application_options then
				Result.merge_client (target.options)
			end

				-- Apply options specified in the library.
			if attached library_target as l_library_target then
				Result.merge (l_library_target.options)
			end
		end

	adapted_options: CONF_OPTION
			-- <Precursor>
		do
				-- Only options that can be overridden should be taken from the local definition,
				-- so `internal_options' cannot be used as a starting point, the clean object is used instead.
			Result := {CONF_OPTION}.create_from_namespace_or_latest (namespace)

				-- Apply local options if present.
			if attached forced_options as o then
				Result.merge_client (o)
			elseif attached internal_options as o then
				Result.merge_client (o)
			end

				-- Apply options of the application if required.
			if use_application_options then
				Result.merge_client (target.adapted_options)
			end

				-- Apply options specified in the library.
			if attached library_target as t then
				Result.merge (t.adapted_options)
			end
		end

	class_options: detachable STRING_TABLE [CONF_OPTION]
			-- <Precursor>
		do
				-- get local options
			if attached internal_class_options as o then
				Result := o.twin
			end
		end

	adapted_class_options: detachable STRING_TABLE [CONF_OPTION]
			-- <Precursor>
		do
				-- Get local options
			if attached forced_class_options as o then
				Result := o.twin
			elseif attached internal_class_options as o then
				Result := o.twin
			end
		end

	path: READABLE_STRING_32
			-- Path to the configuration file.
		do
			Result := resolver.resolved_library_path (location.evaluated_path.name)
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_use_application_options (a_flag: like use_application_options)
			-- Set `use_application_options' to `a_flag'.
		do
			use_application_options := a_flag
		ensure
			use_application_options_set: use_application_options = a_flag
		end

feature {CONF_ACCESS} -- Update, in compiled only, not stored to configuration file

	set_library_target (a_target: CONF_TARGET)
			-- Set `library_target' to `a_target'.
		require
			target_fully_parsed: a_target.system.is_fully_parsed
			a_target_not_void: a_target /= Void
		do
			library_target := a_target
			a_target.system.add_library_usage (Current)
		ensure
			library_target_set: library_target = a_target
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR)
			-- Process `a_visitor'.
		do
			Precursor (a_visitor)
			a_visitor.process_library (Current)
		end

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN
			-- Is `other' and `Current' the same with respect to the group layout?
		do
			Result := Precursor (other) and then equal (visible, other.visible) and then
				equal (name_prefix, other.name_prefix) and then equal (renaming, other.renaming)
		end

feature {NONE} -- File name processing

	resolver: CONF_PARSER_CONTROLLER
			-- File name resolver.
		once
			create Result
		end

invariant
	library_target_set: classes_set implies library_target /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
