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

	CONF_CLASS
		rename
			file_name as base_name,
			check_changed as set_date,
			group as cluster
		export
			{COMPILER_EXPORTER} set_date
		undefine
			is_compiled
		redefine
			cluster,
			class_type,
			options
		end

	CLASS_I
		rename
			group as cluster
		redefine
			set_changed,
			reset_options
		end

create {CONF_COMP_FACTORY}
	make

feature -- Access

	options: CONF_OPTION is
			-- <Precursor>
		do
			if options_internal /= Void then
				Result := options_internal
			else
				Result := Precursor
			end
		end

	reset_options is
			-- <Precursor>
		do
				-- Reset any previous cached options.
			if options_internal /= Void then
				options_internal := Void
				options_internal := options
			end
		end

	cluster: CLUSTER_I
			-- Cluster to which the class belongs to

	config_class: CONF_CLASS is
			-- Configuration class.
		do
			Result := Current
		end

	class_to_recompile: EIFFEL_CLASS_C
		local
			local_system: SYSTEM_I
		do
			if is_basic_class then
				local_system := system
				if Current = local_system.boolean_class then
					create {BOOLEAN_B} Result.make (Current)

				elseif Current = local_system.integer_8_class then
					create {INTEGER_B} Result.make (Current, 8)

				elseif Current = local_system.integer_16_class then
					create {INTEGER_B} Result.make (Current, 16)

				elseif Current = local_system.integer_32_class then
					create {INTEGER_B} Result.make (Current, 32)

				elseif Current = local_system.integer_64_class then
					create {INTEGER_B} Result.make (Current, 64)

				elseif Current = local_system.character_8_class then
					create {CHARACTER_B} Result.make (Current, False)

				elseif Current = local_system.character_32_class then
					create {CHARACTER_B} Result.make (Current, True)

				elseif Current = local_system.pointer_class then
					create {POINTER_B} Result.make (Current, False)

				elseif Current = local_system.natural_8_class then
					create {NATURAL_B} Result.make (Current, 8)

				elseif Current = local_system.natural_16_class then
					create {NATURAL_B} Result.make (Current, 16)

				elseif Current = local_system.natural_32_class then
					create {NATURAL_B} Result.make (Current, 32)

				elseif Current = local_system.natural_64_class then
					create {NATURAL_B} Result.make (Current, 64)

				elseif Current = local_system.real_32_class then
					create {REAL_32_B} Result.make (Current)

				elseif Current = local_system.real_64_class then
					create {REAL_64_B} Result.make (Current)

				elseif Current = local_system.typed_pointer_class then
					create {POINTER_B} Result.make (Current, True)

				elseif Current = local_system.string_8_class then
					create {STRING_CLASS_B} Result.make (Current)

				elseif Current = local_system.array_class then
					create {ARRAY_CLASS_B} Result.make (Current)

				elseif Current = local_system.tuple_class then
					create {TUPLE_CLASS_B} Result.make (Current)

				elseif Current = local_system.special_class then
					create {SPECIAL_B} Result.make (Current)

				elseif Current = local_system.native_array_class then
					create {NATIVE_ARRAY_B} Result.make (Current)

				elseif Current = local_system.type_class then
					create {TYPE_CLASS_C} Result.make (Current)

				else
					create Result.make (Current)
				end
			else
				create Result.make (Current)
			end
		end

feature -- Status setting

	set_changed (b: BOOLEAN) is
			-- Assign `b' to `changed'.
		do
			if b then
					-- We can store the options of the class temporarily during compilation to prevent repeated creation.
				options_internal := options
			else
					-- This gets reset at the end of a successful compilation.
				options_internal := Void
			end
			changed := b
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

feature {NONE} -- Implementation

	options_internal: like options
		-- Temporary store for internal options.

feature {NONE} -- Type anchor

	class_type: EIFFEL_CLASS_I is
			-- <Precursor>
		do
		end

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
