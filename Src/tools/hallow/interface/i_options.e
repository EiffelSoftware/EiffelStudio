note
	description: "[
		Interface for WiX generation options.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	I_OPTIONS

inherit
	ANY
		export
			{NONE} all
		undefine
			copy,
			default_create,
			is_equal
		end

feature -- Access

	directory: SYSTEM_STRING
			-- Start directory to scan for directories files
		require
			can_read_options: can_read_options
		deferred
		ensure
			not_result_is_empty: not {SYSTEM_STRING}.is_null_or_empty (Result)
		end

	generate_single_file_components: BOOLEAN
			-- Indicates if components should contain only one file
		require
			can_read_options: can_read_options
		deferred
		end

	use_semantic_names: BOOLEAN
			-- Indicates if semantic, verbal names should be generated for components, directories or files
		require
			can_read_options: can_read_options
		deferred
		end

	semantic_name_prefix: SYSTEM_STRING
			-- The user specified semantic name prefix
		require
			can_read_options: can_read_options
			has_semantic_name_prefix: has_semantic_name_prefix
		deferred
		ensure
			not_result_is_empty: not {SYSTEM_STRING}.is_null_or_empty (Result)
		end

	include_subdirectories: BOOLEAN
			-- Indicates if all subdirectories and files should be included.
		require
			can_read_options: can_read_options
		deferred
		end

	directory_alias: SYSTEM_STRING
			-- The user specified directory alias
		require
			can_read_options: can_read_options
			use_directory_alias: use_directory_alias
		deferred
		ensure
			not_result_is_empty: not {SYSTEM_STRING}.is_null_or_empty (Result)
		end

	disk_id: NATURAL_8
			-- The user specified media disk id
		require
			can_read_options: can_read_options
			use_disk_id: use_disk_id
		deferred
		ensure
			result_positive: Result > 0
		end

	file_include_pattern: REGEX
			-- Pattern to use to include files
		require
			can_read_options: can_read_options
			use_file_include_pattern: use_file_include_pattern
		deferred
		ensure
			result_attached: Result /= Void
		end

	file_excluded_pattern: REGEX
			-- Pattern to use to exclude files
		require
			can_read_options: can_read_options
			use_file_exclude_pattern: use_file_exclude_pattern
		deferred
		ensure
			result_attached: Result /= Void
		end

	directory_include_pattern: REGEX
			-- Pattern to use to include directories
		require
			can_read_options: can_read_options
			use_directory_include_pattern: use_directory_include_pattern
		deferred
		ensure
			result_attached: Result /= Void
		end

	directory_excluded_pattern: REGEX
			-- Pattern to use to exnclude directories
		require
			can_read_options: can_read_options
			use_directory_exclude_pattern: use_directory_exclude_pattern
		deferred
		ensure
			result_attached: Result /= Void
		end

	use_exclude_pattern_priority: BOOLEAN
			-- Indicates if the exclude pattern should take priority over the include pattern
		require
			can_read_options: can_read_options
		deferred
		end

	for_merge_modules: BOOLEAN
			-- Indicates if the content is to be generated for use with merge modules
		require
			can_read_options: can_read_options
		deferred
		end

	component_group_name: SYSTEM_STRING
			-- The component group name
		require
			can_read_options: can_read_options
			use_grouped_components: use_grouped_components
		deferred
		ensure
			not_result_is_empty: not {SYSTEM_STRING}.is_null_or_empty (Result)
		end

	generate_x64_preprocessors: BOOLEAN
			-- Indicates if x64 specific preprocessors should be generated
		require
			can_read_options: can_read_options
		deferred
		end

	generate_include: BOOLEAN
			-- Indicates if generated code should be a WiX include instead of a fragment
		require
			can_read_options: can_read_options
		deferred
		end

	root_directory_ref_id: SYSTEM_STRING
			-- Root directories reference name
		require
			can_read_options: can_read_options
			use_root_directory_ref: use_root_directory_ref
		deferred
		ensure
			not_result_is_empty: not {SYSTEM_STRING}.is_null_or_empty (Result)
		end

	conditional_expressions: NATIVE_ARRAY [SYSTEM_STRING]
			-- Conditional expression used in a preprocessor, which wraps all generated meaniful content
		require
			can_read_options: can_read_options
			use_conditional_expressions: use_conditional_expressions
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: Result.length > 0
		end

feature -- Status report

	can_read_options: BOOLEAN
			-- Determins if options can be read
		deferred
		end

	has_semantic_name_prefix: BOOLEAN
			-- Indicates if user specified a semantic name prefix
		require
			can_read_options: can_read_options
		deferred
		end

	use_directory_alias: BOOLEAN
			-- Indicates if user specified a directory alias
		require
			can_read_options: can_read_options
		deferred
		end

	use_disk_id: BOOLEAN
			-- Indicates if user specified a disk id
		require
			can_read_options: can_read_options
		deferred
		end

	use_file_include_pattern: BOOLEAN
			-- Indicates if a file include pattern should be used.
		require
			can_read_options: can_read_options
		deferred
		end

	use_file_exclude_pattern: BOOLEAN
			-- Indicates if a file exclude pattern should be used.
		require
			can_read_options: can_read_options
		deferred
		end

	use_directory_include_pattern: BOOLEAN
			-- Indicates if a directory include pattern should be used.
		require
			can_read_options: can_read_options
		deferred
		end

	use_directory_exclude_pattern: BOOLEAN
			-- Indicates if a directory exclude pattern should be used.
		require
			can_read_options: can_read_options
		deferred
		end

	use_grouped_components: BOOLEAN
			-- Indicates if a ComponentGroup element should be added to group all generated components
		require
			can_read_options: can_read_options
		deferred
		end

	use_root_directory_ref: BOOLEAN
			-- Indicates if a root DirectoryRef should be used
		require
			can_read_options: can_read_options
		deferred
		end

	use_conditional_expressions: BOOLEAN
			-- Indicates if a conditional expression preprocessor should be used
		deferred
		end

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
