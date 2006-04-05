indexing
	description:
		"Internal representation of a class. Instance of CLASS_I represent%
		%non-compiled classes, but instance of CLASS_C already compiled%
		%classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	EIFFEL_CLASS_I

inherit
	SHARED_WORKBENCH

	SYSTEM_CONSTANTS

	COMPARABLE
		undefine
			is_equal
		end

	COMPILER_EXPORTER

	DEBUG_OUTPUT
		rename
			debug_output as name_in_upper
		end

	CONF_CLASS
		rename
			file_name as base_name,
			name as original_name,
			renamed_name as name,
			check_changed as set_date,
			group as cluster
		export
			{COMPILER_EXPORTER} set_date
		undefine
			is_compiled
		redefine
			cluster,
			class_type
		end

	CLASS_I
		rename
			group as cluster
		end

create {CONF_COMP_FACTORY}
	make

feature -- Access

	cluster: CLUSTER_I
			-- Cluster to which the class belongs to

	config_class: CONF_CLASS is
			-- Configuration class.
		do
			Result := Current
		end

feature -- Setting

	set_base_name (s: STRING) is
			-- Assign `s' to `base_name'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			base_name := s
		ensure
			base_name_set: base_name = s
		end

feature {COMPILER_EXPORTER} -- Setting


	external_name: STRING is
			-- Name of the class for the external environment
		do
			if visible /= Void then
				Result ?= visible.item (1)
			else
				Result := name
			end
		ensure
			external_name_not_void: Result /= Void
			external_name_in_upper: Result.as_upper.is_equal (Result)
		end

feature {NONE} -- Type anchor

	class_type: EIFFEL_CLASS_I

invariant
	name_not_void: name /= Void
	name_in_upper: name.as_upper.is_equal (name)

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

end -- class CLASS_I
