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
	CLASS_I

inherit
	SHARED_OPTION_LEVEL

	SHARED_OPTIMIZE_LEVEL

	SHARED_DEBUG_LEVEL

	SHARED_VISIBLE_LEVEL

	SHARED_WORKBENCH

	SYSTEM_CONSTANTS

	SHARED_LACE_PARSER

	COMPARABLE
		undefine
			is_equal
		end

	COMPILER_EXPORTER

	DEBUG_OUTPUT
		rename
			debug_output as name_in_upper
		end

create {COMPILER_EXPORTER}
	make

feature {NONE} -- Initialization

	make (a_name: like name) is
			-- Create new CLASS_I object with name `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_in_upper: a_name.as_upper.is_equal (a_name)
		do
			reset_options
			if not System.first_compilation then
					-- Time check and genericity (a generic parameter cannot
					-- have the same name as a class)
				System.record_new_class_i (Current)
			end
			name := a_name
		ensure
			name_set: name = a_name
		end

feature -- Access

	name: STRING
			-- Class name

	cluster: CLUSTER_I
			-- Cluster to which the class belongs to

	base_name: STRING
			-- Base file name of the class

	is_read_only: BOOLEAN
			-- Is class editable?

	date: INTEGER
			-- Date of last modification of class

	compiled_class: CLASS_C
			-- Compiled class

	assertion_level: ASSERTION_I
			-- Assertion checking level

	trace_level: OPTION_I
			-- Tracing level

	profile_level: OPTION_I
			-- Profile level

	optimize_level: OPTIMIZE_I
			-- Optimization level

	debug_level: DEBUG_I
			-- Debug level

	visible_level: VISIBLE_I
			-- Visible level

feature {NONE} -- Access

	namespace: STRING
			-- Namespace specified for a class in Ace file.
			-- Used for IL code generation.

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
			l_start_name: STRING
			l_namespace: STRING
		do
			if compiled_class.is_precompiled then
				Result := internal_namespace
			else
					-- We need to clone as the result maybe used for string operation and we do not
					-- want it to change some internal data from Current.
				l_namespace := namespace
				if namespace /= Void then
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

					if not System.use_all_cluster_as_namespace then
							-- In this case, it means that `System.use_cluster_as_namespace' is True.
						if l_namespace /= Void then
							Result := l_namespace
						else
							Result := cluster.top_of_recursive_cluster.cluster_name.twin
						end
					else
						if cluster.belongs_to_all then
							l_start_name := cluster.top_of_recursive_cluster.cluster_name
						else
							l_start_name := cluster.cluster_name
						end

						check
							l_start_name_exists:
								cluster.cluster_name.substring (1, l_start_name.count).
									is_equal (l_start_name)
						end

						Result := cluster.cluster_name.twin

						if l_namespace /= Void then
							Result.replace_substring (l_namespace, 1, l_start_name.count)
						elseif not System.use_cluster_as_namespace then
							Result.remove_head (l_start_name.count)
						end
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
			create Result.make_from_string (cluster.path)
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

feature -- Access

	is_external_class: BOOLEAN is
			-- Is class defined outside current system.
		do
		end

	is_compiled, compiled: BOOLEAN is
			-- Is the class already compiled ?
		do
			Result := compiled_class /= Void
		ensure
			is_compiled: Result implies compiled_class /= Void
		end;

	date_has_changed: BOOLEAN is
		local
			str: ANY
		do
			str := file_name.to_c
			Result := eif_date ($str) /= date
		end

	exists: BOOLEAN is
		local
			file: RAW_FILE
		do
			create file.make (file_name)
			Result := file.exists
		end

feature -- Setting

	set_name (s: like name) is
			-- Assign `s' to `name'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
			s_upper: s.as_upper.is_equal (s)
		do
			name := s
		ensure
			set: name = s
		end

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

	set_namespace (s: STRING) is
			-- Assign `s' to `namespace'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			namespace := s
		ensure
			namespace_set: namespace = s
		end

	set_actual_namespace is
			-- Compute `actual_namespace' and store its value in `internal_namespace'.
		local
			l_name: STRING
		do
			l_name := actual_namespace
		end

	set_read_only (v: BOOLEAN) is
			-- Assign `v' to `is_read_only'.
		do
			is_read_only := v
		ensure
			is_read_only_set: is_read_only = v
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Class name alphabetic order
		do
			Result := name < other.name
		end

feature -- Output

	append_name (a_text_formatter: TEXT_FORMATTER) is
			-- Append the name ot the current class in `a_clickable'
		require
			non_void_st: a_text_formatter /= Void
		do
			a_text_formatter.add_classi (Current, name)
		end

feature {COMPILER_EXPORTER} -- Properties

	visible_name: STRING
			-- Visible name

	changed: BOOLEAN
			-- Must the class be recompiled ?

feature {COMPILER_EXPORTER, EB_FILEABLE} -- Setting

	set_date is
			-- Assign `d' to `date'
		local
			str: ANY
		do
			str := file_name.to_c
			date := eif_date ($str)
		end

feature {COMPILER_EXPORTER, EB_CLUSTERS} -- Setting

	set_cluster (c: like cluster) is
			-- Assign `c' to `cluster'.
		do
			cluster := c
		ensure
			cluster_set: cluster = c
		end

feature {COMPILER_EXPORTER} -- Setting

	reset_options is
			-- Reset option values of class.
		do
			create assertion_level.make_no
			trace_level := No_option
			profile_level := No_option
			optimize_level := No_optimize
			debug_level := No_debug
			visible_level := Visible_default
			namespace := Void
		end

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
				cl.set_lace_class (Current)
				set_compiled_class (cl)
			end
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
					create Result.make (Current)
				end
			end
		ensure
			Result_exists: Result /= Void
		end

feature {COMPILER_EXPORTER} -- Setting

	set_assertion_level (l: like assertion_level) is
			-- Merge `l' to `assertion_level'.
		do
			assertion_level.merge (l)
		end

	set_trace_level (t: like trace_level) is
			-- Assign `t' to `trace_level'.
		do
			trace_level := t
		ensure
			trace_level_set: trace_level = t
		end

	set_profile_level (t: like profile_level) is
			-- Assign `t' to `trace_level'.
		do
			profile_level := t
		ensure
			profile_level_set: profile_level = t
		end

	set_optimize_level (o: like optimize_level) is
			-- Assign `o' to `optimize_level'.
		do
			optimize_level := o
		ensure
			optimize_level_set: optimize_level = o
		end

	set_debug_level (d: like debug_level) is
			-- Assign `d' to `debug_level'.
		local
			other_partial, partial: DEBUG_TAG_I
			new_partial: DEBUG_TAG_I
		do
			if d.is_partial then
				if debug_level.is_partial then
					partial ?= debug_level
					other_partial ?= d
					create new_partial.make
					new_partial.merge (partial)
					new_partial.merge (other_partial)
					debug_level := new_partial
				else
					debug_level := d
				end
			else
				debug_level := d
			end
		end

	set_visible_level (v: like visible_level) is
			-- Assign `v' to `visible_level'.
		do
			visible_level := v
		ensure
			visible_level_set: visible_level = v
		end

	set_visible_name (s: like visible_name) is
			-- Assign `s' to `visible_name'.
		require
			visible_name_in_upper: s /= Void implies (s.as_upper.is_equal (s))
		do
			visible_name := s
		ensure
			visible_name_set: visible_name = s
		end

	external_name: STRING is
			-- Name of the class for the external environment
		do
			if visible_name = Void then
				Result := name
			else
				Result := visible_name
			end
		ensure
			external_name_not_void: Result /= Void
			external_name_in_upper: Result.as_upper.is_equal (Result)
		end

feature {TEXT_FILTER} -- Document processing

	document_file_relative_path (sep: CHARACTER): EB_FILE_NAME is
			-- Generate the relative path of the file
			-- where Current should be generated.
			-- Is relative to documentation root directory.
			-- Use `sep' as platform specific file separator.
		do
			Result := cluster.relative_path (sep)
			Result.extend (name.as_lower)
		ensure
			Result_exists: Result /= Void
		end

feature {NONE} -- Implementation

	valid_class_file_extension (c: CHARACTER): BOOLEAN is
			-- Is `c' a valid class file extension?
		do
			Result := c = 'e' or c = 'E'
		end

feature {NONE} -- Externals

	eif_date (s: POINTER): INTEGER is
			-- Date of file of name `str'.
		external
			"C"
		end

invariant
	name_not_void: name /= Void
	name_in_upper: name.as_upper.is_equal (name)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
