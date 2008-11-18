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

	SHARED_VISIBLE_LEVEL

	REFACTORING_HELPER

	CONF_FILE_DATE

	HASHABLE

	CONF_CONSTANTS
		export
			{NONE}
		end

feature -- Access

	name: STRING is
			-- Class name
		deferred
		end

	date: INTEGER is
			-- Date of last modification.
		deferred
		end

	group: CONF_PHYSICAL_GROUP is
			-- Group this class belongs to.
		deferred
		ensure
			group_not_void: Result /= Void
		end

	options: CONF_OPTION is
			-- Options of this class.
		deferred
		ensure
			options_not_void: Result /= Void
		end

	target: CONF_TARGET is
			-- Target in which current class is being defined.
		do
			Result := group.target
		ensure
			target_not_void: Result /= Void
		end

	config_class: CONF_CLASS is
			-- Configuration class.
		deferred
		ensure
			config_class_not_void: Result /= Void
		end

	actual_class: CLASS_I is
			-- Return the actual class (takes overriding into account).
		deferred
		ensure
			actual_class_not_void: Result /= Void
		end

	visible: EQUALITY_TUPLE [TUPLE [class_renamed: STRING; features: EQUALITY_HASH_TABLE [STRING, STRING]]] is
			-- The visible features.
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

	compiled_class: CLASS_C
			-- Compiled class

	assertion_level: ASSERTION_I is
			-- Assertion checking level
		do
			Result ?= options.assertions
		ensure
			Result_not_void: Result /= Void
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
			l_options: like options
		do
			l_options := options
			l_d := l_options.debugs
			if l_options.is_debug and then l_d /= Void and then not l_d.is_empty then
				create Result
				from
					l_d.start
				until
					l_d.after
				loop
					if l_d.item_for_iteration then
						if l_d.key_for_iteration.is_equal (unnamed_debug) then
							Result.enable_unnamed
						else
							Result.enable_tag (l_d.key_for_iteration)
						end
					end
					l_d.forth
				end
			else
				Result := no_debug
			end
		end

	visible_level: VISIBLE_I is
			-- Visible level
		local
			l_vis: EQUALITY_HASH_TABLE [STRING, STRING]
			l_sel: VISIBLE_SELEC_I
			l_ren: HASH_TABLE [STRING, STRING]
			l_vis_feat: SEARCH_TABLE [STRING]
			l_feat, l_ren_feat: STRING
		do
			if visible /= Void then
				l_vis := visible.item.features
				if l_vis = Void then
					Result := create {VISIBLE_EXPORT_I}
				else
					from
						create l_ren.make (l_vis.count)
						create l_vis_feat.make (l_vis.count)
						l_vis.start
					until
						l_vis.after
					loop
						l_feat := l_vis.key_for_iteration
						if l_feat /= Void then
							l_ren_feat := l_vis.item_for_iteration
							if l_ren_feat /= Void then
								l_ren.force (l_ren_feat, l_feat)
							end
							l_vis_feat.force (l_feat)
						end
						l_vis.forth
					end
					l_sel := create {VISIBLE_SELEC_I}
					l_sel.set_visible_features (l_vis_feat)
					Result := l_sel
					Result.set_renamings (l_ren)
				end
			else
				create Result
			end
		end

	is_full_class_checking: BOOLEAN is
			-- Is full class being checked, i.e. including inherited features?
		do
			Result := options.is_full_class_checking
		end

	is_cat_call_detection: BOOLEAN is
			-- Is cat-call detection enabled, i.e. all feature calls are checked for potential cat-calls?
		do
			Result := options.is_cat_call_detection
		end

	is_attached_by_default: BOOLEAN
			-- Is class type without an explicit attachment mark
			-- considered as an attached one?
		do
			Result := options.is_attached_by_default
		end

	is_void_safe: BOOLEAN is
			-- Does class use void-safe constructs?
		do
			Result := options.is_void_safe
		end

	is_syntax_obsolete: BOOLEAN
			-- Is obsolete syntax used in the source code?
		do
			inspect
				options.syntax_level.item
			when
				{CONF_OPTION}.syntax_level_obsolete,
				{CONF_OPTION}.syntax_level_transitional
			then
				Result := True
			else
			end
		end

	is_syntax_standard: BOOLEAN
			-- Is obsolete syntax used in the source code?
		do
			inspect
				options.syntax_level.item
			when
				{CONF_OPTION}.syntax_level_standard,
				{CONF_OPTION}.syntax_level_transitional
			then
				Result := True
			else
			end
		end

	is_compiled: BOOLEAN is
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

	is_external_class: BOOLEAN is
			-- Is class defined outside current system.
		do
		end

	is_basic_class: BOOLEAN
			-- Is `Current' a basic class referenced in BASIC_SYSTEM_I?

	file_date: INTEGER is
			-- Date of last modification date of Current.
		do
			Result := file_modified_date (file_name)
		ensure
			file_date_valid: Result >= -1
		end

	compiled_representation: CLASS_C is
			-- Compiled representation of `Current'
			-- same as `compiled_class' for normal classes
			-- Void for classes that are overriden
			-- The first compiled class of an override if it is an overrider.
		local
			l_classi: CLASS_I
			l_classc: CLASS_C
			l_overrides: ARRAYED_LIST [CONF_CLASS]
		do
			if config_class.is_overriden then
				Result := Void
			elseif config_class.does_override then
				from
					l_overrides := config_class.overrides
					l_overrides.start
				until
					l_classc /= Void or l_overrides.after
				loop
					if l_overrides.item.is_compiled then
						l_classi ?= l_overrides.item
						check
							class_i: l_classi /= Void
						end
						l_classc := l_classi.compiled_class
					end
					l_overrides.forth
				end
				Result := l_classc
			else
				Result := compiled_class
			end
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
			l_cluster: CLUSTER_I
		do
			if compiled_class.is_precompiled then
				Result := internal_namespace
			else
				l_cluster ?= group
				if l_cluster /= Void then
					Result := l_cluster.actual_namespace.twin
				end

				if Result = Void then
					create Result.make_empty
				end

				if target.setting_use_all_cluster_name_as_namespace then
					l_path := path.twin
					l_path.replace_substring_all ("/", ".")
					if not l_path.is_empty and then l_path.item (1) = '.' then
						l_path.remove_head (1)
					end
					if not l_path.is_empty then
						if not Result.is_empty then
							Result.append_character ('.')
						end
						Result.append (l_path)
					end
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

	file_name: FILE_NAME is
			-- Full file name of the class
		do
			create Result.make_from_string (group.location.build_path (path, ""))
			Result.set_file_name (base_name)
		ensure
			file_name_not_void: Result /= Void
		end

	text: STRING_32 is
			-- Text of the Current lace file.
			-- Convert to UTF-32 if possible.
			-- Void if unreadable file
		require
			valid_file_name: file_name /= Void
		local
			a_file: RAW_FILE
			retried: BOOLEAN
			l_stream: STRING
			l_converter: ENCODING_CONVERTER
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
					l_stream := a_file.last_string
					l_converter := (create {SHARED_ENCODING_CONVERTER}).encoding_converter
					if l_converter /= Void then
						Result := l_converter.utf32_string (l_stream)
						encoding := l_converter.detected_encoding
					else
						Result := l_stream
					end
				end
			else
				Result := Void
			end
		rescue
			retried := True
			retry
		end

	encoding: ?ANY
			-- Encoding of original text.

feature -- Output

	append_name (st: TEXT_FORMATTER) is
			-- Append the name ot the current class in `a_clickable'
		require
			non_void_st: st /= Void
		do
			st.add_class (Current)
		end

feature {COMPILER_EXPORTER} -- Compiled class

	class_to_recompile: CLASS_C is
			-- Instance of a class to remcompile
		require
			name_exists: name /= Void
			not_override: not config_class.does_override
		deferred
		ensure
			Result_exists: Result /= Void
		end

feature {BASIC_SYSTEM_I} -- Setting

	set_as_basic_class is
			-- Set `is_basic_class' to True.
		do
			is_basic_class := True
		ensure
			is_basic_class_set: is_basic_class
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

	reset_options is
			-- Reset cached options of `Current'
		do
			-- By default do nothing
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

feature {NONE} -- Implementation

	no_debug: DEBUG_I is
			-- All debugs disabled debug level.
		once
			create Result
		end

invariant
	file_name_not_void: file_name /= Void
	name_not_void: name /= Void
	compiled_class_connection: is_compiled implies compiled_class.original_class = Current

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
