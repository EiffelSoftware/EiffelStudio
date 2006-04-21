indexing
	description:"[
				Abstract class that is used for the internal representation
				of a class. Descendants of `ABSTRACT_CLASS' represent
				non compiled classes.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CLASS_I

inherit
	SHARED_WORKBENCH

	COMPARABLE
		undefine
			is_equal
		end

	SHARED_OPTION_LEVEL

	SHARED_OPTIMIZE_LEVEL

	SHARED_DEBUG_LEVEL

	SHARED_VISIBLE_LEVEL

	REFACTORING_HELPER

	CONF_FILE_DATE

	HASHABLE

feature -- Access

	name: STRING is
			-- Final class name, after all renaming, prefix.
		deferred
		end

	date: INTEGER is
			-- Date of last modification.
		deferred
		end

	group: CONF_PHYSICAL_GROUP is
			-- Group this class belongs to.
		deferred
		end

	options: CONF_OPTION is
			-- Options of this class.
		deferred
		end

	config_class: CONF_CLASS is
			-- Configuration class.
		deferred
		end

	actual_class: CLASS_I is
			-- Return the actual class (takes overriding into account).
		deferred
		end

	visible: TUPLE [class_renamed: STRING; features: HASH_TABLE [STRING, STRING]] is
			-- The visible features, "*" = all, mapped to their renamed name (if any).
		deferred
		end

	path: STRING is
			-- Path of the class, relative to the group, in unix format.
		deferred
		end

	base_name: STRING is
			-- File name of the class.
		deferred
		end

	changed: BOOLEAN
			-- Has this class been modified? (as seen from the compiler)

	set_date is
			-- Set the new date.
		deferred
		end

	compiled_class: CLASS_C
			-- Compiled class

	assertion_level: ASSERTION_I is
			-- Assertion checking level
		local
			l_a: CONF_ASSERTIONS
		do
			create Result.make_no
			l_a := options.assertions
			if l_a /= Void then
				if l_a.is_check then
					Result.enable_check
				end
				if l_a.is_invariant then
					Result.enable_invariant
				end
				if l_a.is_loop then
					Result.enable_loop
				end
				if l_a.is_postcondition then
					Result.enable_ensure
				end
				if l_a.is_precondition then
					Result.enable_require
				end
			end
		end

	trace_level: OPTION_I is
			-- Tracing level
		do
			if options.is_trace then
				Result := all_option
			else
				Result := no_option
			end
		end

	profile_level: OPTION_I is
			-- Profile level
		do
			if options.is_profile then
				Result := all_option
			else
				Result := no_option
			end
		end

	optimize_level: OPTIMIZE_I is
			-- Optimization level
		do
			if options.is_optimize then
				Result := yes_optimize
			else
				Result := no_optimize
			end
		end

	debug_level: DEBUG_I is
			-- Debug level
		local
			l_d: HASH_TABLE [BOOLEAN, STRING]
			l_dp: DEBUG_TAG_I
		do
			if options.is_debug then
				l_d := options.debugs
				if l_d /= Void and then not l_d.is_empty then
					create l_dp.make
					from
						l_d.start
					until
						l_d.after
					loop
						if l_d.item_for_iteration then
							l_dp.tags.extend (l_d.key_for_iteration)
						end
						l_d.forth
					end
					if l_dp.tags.is_empty then
						Result := no_debug
					else
						Result := l_dp
					end
				else
					Result := yes_debug
				end
			else
				Result := no_debug
			end
		end

	visible_level: VISIBLE_I is
			-- Visible level
		local
			l_vis: HASH_TABLE [STRING, STRING]
			l_sel: VISIBLE_SELEC_I
			l_ren: HASH_TABLE [STRING, STRING]
			l_vis_feat: SEARCH_TABLE [STRING]
			l_feat, l_ren_feat: STRING
		do
			if visible /= Void then
				l_vis ?= visible.features
			end
			if l_vis /= Void then
				from
					create l_ren.make (l_vis.count)
					create l_vis_feat.make (l_vis.count)
					l_vis.start
				until
					l_vis.after
				loop
					l_feat := l_vis.key_for_iteration
					if not l_feat.is_equal ("*") then
						l_ren_feat := l_vis.item_for_iteration
						l_ren.force (l_ren_feat, l_feat)
						l_vis_feat.force (l_feat)
					end
					l_vis.forth
				end
				if l_vis.has ("*") then
					Result := create {VISIBLE_EXPORT_I}
				else
					l_sel := create {VISIBLE_SELEC_I}
					l_sel.set_visible_features (l_vis_feat)
					Result := l_sel
				end
				Result.set_renamings (l_ren)
			else
				create Result
			end
		end

	is_compiled, compiled: BOOLEAN is
			-- Is the class already compiled ?
		do
			Result := compiled_class /= Void
		ensure then
			is_compiled: Result implies compiled_class /= Void
		end

	is_read_only: BOOLEAN is
			-- Is class in read-only mode?
		deferred
		end

	is_valid: BOOLEAN is
			-- Is class still reachable from the configuration system?
		deferred
		end

	exists: BOOLEAN is
		local
			file: RAW_FILE
		do
			create file.make (file_name)
			Result := file.exists
		end

	is_external_class: BOOLEAN is
			-- Is class defined outside current system.
		do
		end

	date_has_changed: BOOLEAN is
		local
			str: ANY
			l_date: INTEGER
		do
			str := file_name.to_c
			eif_date ($str, $l_date)
			Result := l_date /= date
		end

feature {NONE} -- Access

	internal_namespace: STRING
			-- Stored associated namespace of Current.
			-- Used for IL code generation.

feature -- Status report

	actual_namespace: STRING is
			-- Associated namespace of current class. Result depends
			-- on settings from `System.use_cluster_as_namespace' and
			-- from `System.use_all_cluster_as_namespace'.
		require
			il_generation: System.il_generation
			compiled_class: is_compiled
		local
			l_path: STRING
			l_namespace: STRING
		do
			if compiled_class.is_precompiled then
				Result := internal_namespace
			else
					-- We need to clone as the result maybe used for string operation and we do not
					-- want it to change some internal data from Current.
				l_namespace := options.namespace
				if l_namespace /= Void then
					l_namespace := l_namespace.twin
				end

				if
					not System.use_all_cluster_as_namespace and then
					not System.use_cluster_as_namespace
				then
						-- Simply use given namespace if any.
					Result := l_namespace
				else
						-- Now either one or both of `System.use_cluster_as_namespace' or
						-- `System.use_all_cluster_as_namespace' is True.
					if l_namespace /= Void then
						Result := l_namespace
					else
						Result := group.name.twin
					end

					if System.use_all_cluster_as_namespace then
						l_path := path.twin
						l_path.replace_substring_all ("/", ".")
						Result.append (l_path)
					end
				end

				if System.system_namespace /= Void then
					if Result /= Void then
						Result.prepend_character ('.')
						Result.prepend (System.system_namespace)
					else
						Result := System.system_namespace.twin
					end
				end

				if Result = Void then
					Result := ""
				end
				internal_namespace := Result
			end
		ensure
			result_not_void: Result /= Void
		end

	set_actual_namespace is
			-- Compute `actual_namespace' and store its value in `internal_namespace'.
		local
			l_name: STRING
		do
			l_name := actual_namespace
		end

	name_in_upper: STRING is
			-- Class name in upper case.
		do
			Result := name
			if Result = Void then
				Result := "Name not yet set"
			end
		ensure then
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end

	file_name: FILE_NAME is
			-- Full file name of the class
		do
			create Result.make_from_string (group.location.build_path (path, ""))
			Result.set_file_name (base_name)
		ensure
			file_name_not_void: Result /= Void
		end

	text: STRING is
			-- Text of the Current lace file.
			-- Void if unreadable file
		require
			valid_file_name: file_name /= Void
		local
			a_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create a_file.make (file_name)
				if a_file.exists and then a_file.is_readable then
					a_file.open_read
					a_file.read_stream (a_file.count)
					a_file.close
						-- No need to duplicate `last_string' since
						-- its owner, the file will not go outside this
						-- routine and therefore there will be no aliasing.
					Result := a_file.last_string
				end
			else
				Result := Void
			end
		rescue
			retried := True
			retry
		end

feature -- Output

	append_name (st: TEXT_FORMATTER) is
			-- Append the name ot the current class in `a_clickable'
		require
			non_void_st: st /= Void
		do
			st.add_classi (Current, name)
		end

feature {COMPILER_EXPORTER} -- Compiled class

	class_to_recompile: CLASS_C is
			-- Instance of a class to remcompile
		require
			name_exists: name /= Void
		local
			local_system: SYSTEM_I
		do
			local_system := system
			if Current = local_system.boolean_class then
				create {BOOLEAN_B} Result.make (Current)

			elseif Current = local_system.character_class then
				create {CHARACTER_B} Result.make (Current, False)

			elseif Current = local_system.wide_char_class then
				create {CHARACTER_B} Result.make (Current, True)

			elseif Current = local_system.natural_8_class then
				create {NATURAL_B} Result.make (Current, 8)

			elseif Current = local_system.natural_16_class then
				create {NATURAL_B} Result.make (Current, 16)

			elseif Current = local_system.natural_32_class then
				create {NATURAL_B} Result.make (Current, 32)

			elseif Current = local_system.natural_64_class then
				create {NATURAL_B} Result.make (Current, 64)

			elseif Current = local_system.integer_8_class then
				create {INTEGER_B} Result.make (Current, 8)

			elseif Current = local_system.integer_16_class then
				create {INTEGER_B} Result.make (Current, 16)

			elseif Current = local_system.integer_32_class then
				create {INTEGER_B} Result.make (Current, 32)

			elseif Current = local_system.integer_64_class then
				create {INTEGER_B} Result.make (Current, 64)

			elseif Current = local_system.real_32_class then
				create {REAL_32_B} Result.make (Current)

			elseif Current = local_system.real_64_class then
				create {REAL_64_B} Result.make (Current)

			elseif Current = local_system.pointer_class then
				create {POINTER_B} Result.make (Current, False)

			elseif Current = local_system.typed_pointer_class then
				create {POINTER_B} Result.make (Current, True)

			elseif Current = local_system.special_class then
				create {SPECIAL_B} Result.make (Current)

			elseif Current = local_system.array_class then
				create {ARRAY_CLASS_B} Result.make (Current)

			elseif Current = local_system.string_class then
				create {STRING_CLASS_B} Result.make (Current)

			elseif Current = local_system.tuple_class then
				create {TUPLE_CLASS_B} Result.make (Current)

			elseif Current = local_system.native_array_class then
				create {NATIVE_ARRAY_B} Result.make (Current)

			elseif Current = local_system.type_class then
				create {TYPE_CLASS_C} Result.make (Current)

			else
				if is_external_class then
					create {EXTERNAL_CLASS_C} Result.make (Current)
				else
					create {EIFFEL_CLASS_C} Result.make (Current)
				end
			end
		ensure
			Result_exists: Result /= Void
		end

feature {COMPILER_EXPORTER} -- Setting

	set_changed (b: BOOLEAN) is
			-- Assign `b' to `changed'.
		do
			changed := b
		ensure
			changed_set: changed = b
		end

	set_compiled_class (c: CLASS_C) is
			-- Assign `c' to `compiled_class'.
		require
			non_void_c: c /= Void
		do
			compiled_class := c
		ensure
			compiled_class = c
		end

	reset_compiled_class is
			-- Reset `compiled_class' to Void.
		do
			compiled_class := Void
		ensure
			void_compiled_class: compiled_class = Void
		end

	reset_class_c_information (cl: CLASS_C) is
			-- Set Current as `lace_class' of `cl' since file has been moved to override
			-- cluster
		do
				-- If `cl' not void, it means that we are handling a class which is
				-- in the system and therefore we update its info, otherwise we do nothing.
			if cl /= Void then
				cl.set_original_class (Current)
				set_compiled_class (cl)
			end
		end

invariant
	file_name_not_void: file_name /= Void
	name_not_void: name /= Void
	options_not_void: options /= Void
	compiled_class_connection: is_compiled implies compiled_class.original_class = Current

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
