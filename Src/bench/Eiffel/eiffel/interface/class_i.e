indexing
	description: 
		"Internal representation of a class. Instance of CLASS_I represent%
		%non-compiled classes, but instance of CLASS_C already compiled%
		%classes."
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

creation {COMPILER_EXPORTER}
	make

feature {NONE} -- Initialization

	make (a_name: like name) is
			-- Create new CLASS_I object with name `a_name'.
		require
			a_name_not_void: a_name /= Void
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
	
	old_cluster_name: STRING
			-- Cluster name to which a class in the override cluster used
			-- to belong to.

	old_base_name: like base_name
			-- `base_name' of previous location of Current class.

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
				l_namespace := clone (namespace)
				
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
							Result := clone (cluster.top_of_recursive_cluster.cluster_name)
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
						
						Result := clone (cluster.cluster_name)

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
						Result := clone (System.system_namespace)
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
			Result := clone (name)
			if Result /= Void then
				Result.to_upper
			else
				Result := "Name not yet set"
			end
		ensure
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
					a_file.readstream (a_file.count)
					a_file.close
					Result := clone (a_file.laststring)
				end
			else
				Result := Void
			end
		rescue
			retried := True
			retry
		end

	class_name_changed: BOOLEAN is
			-- Is stored `class_name' identical to one in associated class?
		require
			file_exists: exists
		local
			class_file: PLAIN_TEXT_FILE
			new_class_name: STRING
		do
			create class_file.make_open_read (file_name)
			Classname_finder.parse (class_file)
			new_class_name := Classname_finder.classname
			class_file.close

			if new_class_name /= Void then
				new_class_name.to_lower
				Result := not new_class_name.is_equal (name)
			else
				Result := True
			end
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
	
	set_file_details (s: like name; b: like base_name) is 
			-- Assign `s' to name, `b' to base_name, and
			-- set date of insertion.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
			b_not_void: b /= Void
			b_not_empty: not b.is_empty
		do
			set_name (s)
			set_base_name (b)
			set_date
		ensure
			name_set: name = s
			base_name_set: base_name = b
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

	append_name (st: STRUCTURED_TEXT) is
			-- Append the name ot the current class in `a_clickable'
		require
			non_void_st: st /= Void
		local
			c_name: STRING
		do
			c_name := clone (name)
			c_name.to_upper
			st.add_classi (Current, c_name) 
		end

feature {COMPILER_EXPORTER} -- Properties

	visible_name: STRING
			-- Visible name

	changed: BOOLEAN
			-- Must the class be recompiled ?

feature {COMPILER_EXPORTER, EB_CLUSTERS} -- Setting

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

	set_date is
			-- Assign `d' to `date'
		local
			str: ANY
		do
			str := file_name.to_c
			date := eif_date ($str)
		end

	set_cluster (c: like cluster) is
			-- Assign `c' to `cluster'.
		do
			cluster := c
		ensure
			cluster_set: cluster = c
		end

	set_old_location_info (c: like cluster; n: like base_name) is
			-- This applies for classes in override cluster and
			-- set `c' to `old_cluster_name'
		require
			cluster_valid_non_void_assignment: c /= Void implies old_cluster_name = Void
			cluster_valid_void_assignment: c = Void implies old_cluster_name /= Void
			name_valid_non_void_assignment: n /= Void implies old_base_name = Void
			name_valid_void_assignment: n = Void implies old_base_name /= Void
		do
			old_cluster_name := c.cluster_name
			old_base_name := n
		ensure
			old_cluster_name_set: old_cluster_name = c.cluster_name
			old_base_name_set: old_base_name = n
		end

	restore_class_i_information is
			-- Restore CLASS_I object so that we can move it from its current
			-- location to old one.
		require
			old_cluster_name_not_void: old_cluster_name /= Void
			in_universe: Lace.old_universe.has_cluster_of_name (old_cluster_name)
		do
			if Lace.old_universe /= Void then
				cluster := Lace.old_universe.cluster_of_name (old_cluster_name)

				check
					cluster_not_void: cluster /= Void
				end

					-- Insert class to new cluster `c'.
				cluster.classes.put (Current, name)
			end

				-- Reset `override_cluster' info since it has been moved back to its previous
				-- location.
			base_name := old_base_name
			old_base_name := Void
			old_cluster_name := Void
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
			elseif Current = local_system.integer_8_class then
				create {INTEGER_B} Result.make (Current, 8)
			elseif Current = local_system.integer_16_class then
				create {INTEGER_B} Result.make (Current, 16)
			elseif Current = local_system.integer_32_class then
				create {INTEGER_B} Result.make (Current, 32)
			elseif Current = local_system.integer_64_class then
				create {INTEGER_B} Result.make (Current, 64)
			elseif Current = local_system.real_class then
				create {REAL_B} Result.make (Current)
			elseif Current = local_system.double_class then
				create {DOUBLE_B} Result.make (Current)
			elseif Current = local_system.pointer_class then
				create {POINTER_B} Result.make (Current)
			elseif Current = local_system.special_class then
				create {SPECIAL_B} Result.make (Current)
			elseif Current = local_system.to_special_class then
				create {TO_SPECIAL_B} Result.make (Current)
			elseif Current = local_system.array_class then
				create {ARRAY_CLASS_B} Result.make (Current)
			elseif Current = local_system.string_class then
				create {STRING_CLASS_B} Result.make (Current)
			elseif Current = local_system.character_ref_class then
				create {CHARACTER_REF_B} Result.make (Current, False)
			elseif Current = local_system.wide_char_ref_class then
				create {CHARACTER_REF_B} Result.make (Current, True)
			elseif Current = local_system.boolean_ref_class then
				create {BOOLEAN_REF_B} Result.make (Current)
			elseif Current = local_system.integer_8_ref_class then
				create {INTEGER_REF_B} Result.make (Current, 8)
			elseif Current = local_system.integer_16_ref_class then
				create {INTEGER_REF_B} Result.make (Current, 16)
			elseif Current = local_system.integer_32_ref_class then
				create {INTEGER_REF_B} Result.make (Current, 32)
			elseif Current = local_system.integer_64_ref_class then
				create {INTEGER_REF_B} Result.make (Current, 64)
			elseif Current = local_system.real_ref_class then
				create {REAL_REF_B} Result.make (Current)
			elseif Current = local_system.double_ref_class then
				create {DOUBLE_REF_B} Result.make (Current)
			elseif Current = local_system.pointer_ref_class then
				create {POINTER_REF_B} Result.make (Current)
			elseif Current = local_system.tuple_class then
				create {TUPLE_CLASS_B} Result.make (Current)
			elseif Current = local_system.native_array_class then
				create {NATIVE_ARRAY_B} Result.make (Current)
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
		end

	copy_options (other: CLASS_I) is
			-- Copy compilation options from `other' into Current.
		require
			good_argument: not (other = Void)
		do
			debug_level := other.debug_level
			trace_level := other.trace_level
			profile_level := other.profile_level
			optimize_level := other.optimize_level
			assertion_level := other.assertion_level
			visible_level := other.visible_level
			visible_name := other.visible_name
		end

feature {TEXT_FILTER} -- Document processing

	document_file_name: FILE_NAME is
			-- File name specified for the document
			-- (.e is removed from end)
		local
			bname: STRING
			d_name: DIRECTORY_NAME
			i: INTEGER
		do
			d_name := cluster.document_path
			if d_name /= Void then
				create Result.make_from_string (d_name)
				bname := clone (base_name)
				i := bname.count
				if 
					i > 2 and then
					bname.item (i - 1) = Dot and then
					valid_class_file_extension (bname.item (i))
				then
					bname.keep_head (i - 2)
				end
				Result.set_file_name (bname)
			end
		end

	document_file_relative_path (sep: CHARACTER): EB_FILE_NAME is
			-- Generate the relative path of the file
			-- where Current should be generated.
			-- Is relative to documentation root directory.
			-- Use `sep' as platform specific file separator.
		do
			Result := cluster.relative_path (sep)
			Result.extend (name)
		ensure
			Result_exists: Result /= Void
		end

feature {NONE} -- Document processing

	No_word: STRING is "no"

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

end -- class CLASS_I
