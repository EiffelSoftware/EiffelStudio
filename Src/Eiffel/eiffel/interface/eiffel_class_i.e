note
	description:
		"Internal representation of a class. Instance of CLASS_I represent%
		%non-compiled classes, but instance of CLASS_C already compiled%
		%classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

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
			group as cluster
		undefine
			is_compiled
		redefine
			check_changed_options,
			class_type,
			cluster,
			invalidate,
			options,
			rebuild
		end

	CLASS_I
		rename
			group as cluster
		redefine
			set_changed,
			reset_options,
			reset_class_c_information
		end

	SHARED_DEGREES

create {CONF_COMP_FACTORY}
	make

feature -- Access

	options: CONF_OPTION
			-- <Precursor>
		do
			if options_internal /= Void then
				Result := options_internal
			else
				Result := Precursor
				if workbench.is_compiling then
					options_internal := Result
						-- We can cache the result as we know that it will be reset after compilation.
				end
			end
		end

	cluster: CLUSTER_I
			-- Cluster to which the class belongs to

	config_class: CONF_CLASS
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
					create {STRING_CLASS_B} Result.make (Current, False)

				elseif Current = local_system.string_32_class then
					create {STRING_CLASS_B} Result.make (Current, True)

				elseif Current = local_system.immutable_string_8_class then
					create {STRING_CLASS_B} Result.make_immutable (Current, False)

				elseif Current = local_system.immutable_string_32_class then
					create {STRING_CLASS_B} Result.make_immutable (Current, True)

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

	set_changed (b: BOOLEAN)
			-- Assign `b' to `changed'.
		do
			changed := b
		end

feature -- Setting

	set_base_name (s: like base_name)
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

	reset_options
			-- <Precursor>
		do
				-- Preserve `options_internal' for recompilation.
			if attached compiled_class as c and then c.is_precompiled then
					-- But for precompiled classes there is nothing to recompile.
				options_internal := Void
			end
		end

	reset_class_c_information (cl: CLASS_C)
			-- <Precursor>
		do
			Precursor {CLASS_I} (cl)
				-- If the class used to be only in an override cluster, then its `overriden_by'
				-- entry will also hold a compiled version of the class, and we cannot allow that,
				-- since only the class outside the override cluster has the compiled class information.
				-- This fixes eweasel test#config009.
			if overriden_by /= Void then
				overriden_by.reset_compiled_class
			end
		end

	check_changed_options
			-- <Precursor>
			-- Trigger recompilation if necessary.
		local
			new_options: like options
			c: like compiled_class
		do
			Precursor
			c := compiled_class
				-- Take new options into account.
			if not is_removed and then attached options_internal as old_options then
					-- `options_internal' will be set on the next access to `options'.
				options_internal := Void
					-- Do not trigger recompilation for precompiled classes,
					-- but allow `options' to be recomputed to take assertion settings into account.
				if attached c implies not c.is_precompiled then
					new_options := options
					if
						new_options.is_attached_by_default /= old_options.is_attached_by_default or else
						new_options.is_obsolete_routine_type /= old_options.is_obsolete_routine_type or else
						new_options.syntax.index /= old_options.syntax.index
					then
							-- Class should be reparsed.
						is_modified := True
					end
					if
						new_options.void_safety.index /= old_options.void_safety.index or else
						new_options.catcall_detection.index /= old_options.catcall_detection.index or else
						new_options.is_obsolete_iteration /= old_options.is_obsolete_iteration
					then
							-- Class should be reparsed and rechecked for validity of interface and code.
						is_modified := True
						if attached c then
							degree_4.insert_class (c)
							degree_3.insert_class (c)
						end
					end
					if
						(new_options.is_full_class_checking and then not old_options.is_full_class_checking or else
						new_options.array.index /= old_options.array.index or else
						new_options.warning.index /= old_options.warning.index) and then
						attached c
					then
							-- Class should be rechecked.
						degree_3.insert_class (c)
					end
				end
			end
		end

feature {CONF_ACCESS} -- Recompilation

	rebuild (a_file_name: like path; a_group: like cluster; a_path: like path)
			-- <Precursor>
		do
			Precursor (a_file_name, a_group, a_path)
			if old_overriden_by /= overriden_by then
					-- Options may be taken from a different source.
				options_internal := Void
			end
		end

feature {CONF_ACCESS} -- Update, in compiled only, not stored to configuration file

	invalidate
			-- Mark class as invalid if applicable.
		do
				-- Avoid marking precompiled classes as invalid.
			if not attached compiled_class as c or else not c.is_precompiled then
				Precursor
			end
		end

feature {NONE} -- Implementation

	options_internal: like options
		-- Temporary store for internal options.

feature {NONE} -- Type anchor

	class_type: EIFFEL_CLASS_I
			-- <Precursor>
		do
		end

invariant
	name_not_void: name /= Void
	name_in_upper: name.as_upper.is_equal (name)

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
