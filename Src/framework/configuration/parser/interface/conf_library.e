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

	is_library: BOOLEAN
			-- Is this a library?
		once
			Result := True
		end

	is_readonly: BOOLEAN
			-- Is this library readonly?
		do
			if is_readonly_set then
				Result := internal_read_only
			elseif library_target /= Void then
				Result := library_target.system.is_readonly
			else
				Result := True
			end
		end

feature -- Access, stored in configuration file

	use_application_options: BOOLEAN
			-- Should the library use the options of the application? (Instead of the library)

feature -- Access, in compiled only, not stored to configuration file

	library_target: CONF_TARGET
			-- The library target.

	mapping: EQUALITY_HASH_TABLE [STRING, STRING]
			-- We use the one from the target.
		do
			if library_target /= Void then
				Result := library_target.mapping
			else
				create Result.make (0)
			end
		end

feature -- Access queries

	sub_group_by_name (a_name: STRING): CONF_GROUP
			-- Return sub group with `a_name' if there is any.
		do
			if library_target /= Void then
				Result := library_target.groups.item (a_name)
			end
		end

	class_by_name (a_class: STRING; a_dependencies: BOOLEAN): LINKED_SET [CONF_CLASS]
			-- Get the class with the final (after renaming/prefix) name `a_class'
			-- (if `a_dependencies' then we check dependencies)
		local
			l_conf_class: CONF_CLASS
			l_class: STRING
			l_mapping: like mapping
		do
			l_mapping := mapping
			if l_mapping /= Void and then l_mapping.has_key (a_class) then
				l_class := l_mapping.found_item
			else
				l_class := a_class
			end
			create Result.make
			l_conf_class := classes.item (l_class)
			if l_conf_class /= Void and then not l_conf_class.does_override then
				Result.extend (l_conf_class)
			end
		end

	options: CONF_OPTION
			-- Options (Debuglevel, assertions, ...)
		do
				-- get local options
			if internal_options /= Void then
				Result := internal_options.twin
			else
				create Result
			end

				-- use options specified in the library
			if library_target /= Void then
				Result.merge (library_target.options)
			end
				-- use options of the application
			if use_application_options then
				Result.merge (target.options)
			end
		end

	class_options: HASH_TABLE [CONF_OPTION, STRING]
			-- Options for classes.
		do
				-- get local options
			if internal_class_options /= Void then
				Result := internal_class_options.twin
			end
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
			library_target.system.add_library_usage (Current)
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

invariant
	library_target_set: classes_set implies library_target /= Void

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
