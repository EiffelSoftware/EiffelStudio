note
	description: "[
		Objects representing root creation procedures.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_ROOT

create
	make_with_class

feature {NONE} -- Initialization

	make_with_class (a_class: like root_class; a_name: like procedure_name)
			-- Initialize `Current'
			--
			-- `a_class': Class representing root class of system
			-- `a_name': Name of root creation procedure
		require
			a_class_attached: a_class /= Void
			not_an_override_class: a_class.config_class.overrides = Void or else a_class.config_class.overrides.is_empty
			a_name_attached: a_name /= Void
		do
			root_class := a_class
			procedure_name := a_name
		ensure
			root_class_set: root_class = a_class
			procedure_name_set: procedure_name = a_name
		end

feature -- Access

	root_class: CLASS_I
			-- Root class

	procedure_name: STRING
			-- Name of root creation procedure in `root_class'

	class_type: TYPE_A
			-- Corresponding type of `root_class'
		require
			type_set: is_class_type_set
		do
			Result := internal_class_type
		end

	class_type_as: CLASS_TYPE_AS
			-- Corresponding type as of `root_class'
		require
			type_set: is_class_type_as_set
		do
			Result := internal_class_type_as
		end

feature -- Query

	cluster: CONF_GROUP
			-- Group of `root_class'
		do
			Result := root_class.group
		end

feature {NONE} -- Access

	internal_class_type: detachable like class_type
			-- Internal storage for `class_type'

	internal_class_type_as: detachable like class_type_as
			-- Internal storage for `class_type_as'

feature -- Status report

	is_class_type_set: BOOLEAN
			-- Has `class_type' been set yet?
		do
			Result := internal_class_type /= Void
		end

	is_class_type_as_set: BOOLEAN
			-- Has `class_type_as' been set yet?
		do
			Result := internal_class_type_as /= Void
		end

	is_explicit: BOOLEAN
			-- Has `Current' been added through {SYSTEM_I}.add_explicit_root?
			--
			-- Note: explicit roots are not part of the configuration and therefore
			--       should not be compiled into the finalized system.

feature -- Status setting

	set_class_type (a_type: like class_type)
			-- Set `class_type' to `a_type'.
		do
			internal_class_type := a_type
		ensure
			class_type_set: is_class_type_set and then class_type = a_type
		end

	set_class_type_as (a_type: like class_type_as)
			-- Set `class_type_as' to `a_type'.
		do
			internal_class_type_as := a_type
		ensure
			class_type_as_set: is_class_type_as_set and then class_type_as = a_type
		end

	set_explicit
			-- Set `is_explicit' to True.
		do
			is_explicit := True
		ensure
			explicit: is_explicit
		end

invariant
	root_class_attached: root_class /= Void
	not_an_override: root_class.config_class.overrides = Void or else root_class.config_class.overrides.is_empty
	procedure_name_attached: procedure_name /= Void

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
