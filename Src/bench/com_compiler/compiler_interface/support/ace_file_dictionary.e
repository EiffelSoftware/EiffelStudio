indexing
	description: "Dictionary of all of the Ace file keywords"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ACE_FILE_DICTIONARY

feature -- Basic Operations

	is_reserved_word (word: STRING): BOOLEAN is
			-- Is 'word' a reserved ace file keyword?
		require
			word_exists: word /= Void
			valid_word: not word.is_empty
		do
			from 
				reserved_keywords.start
			until
				reserved_keywords.after or Result
			loop
				if reserved_keywords.item.is_equal (word) then
					Result := true
				end
			end
		end

feature -- Access

	reserved_keywords: LINKED_LIST [STRING] is
			-- List of all of the word reserved by the ace file
		once
			create Result.make
			Result.extend (all_keyword)
			Result.extend (arguments_keyword)
			Result.extend (array_optimization_keyword)
			Result.extend (assemblies_keyword)
			Result.extend (assembly_keyword)
			Result.extend (assertion_keyword)
			Result.extend (check_keyword)
			Result.extend (check_vape_keyword)
			Result.extend (cls_compliant_keyword)
			Result.extend (cluster_keyword)
			Result.extend (console_application_keyword)
			Result.extend (dead_code_removal_keyword)
			Result.extend (debug_keyword)
			Result.extend (default_keyword)
			Result.extend (namespace_keyword)
			Result.extend (disable_keyword)
			Result.extend (disabled_debug_keyword)
			Result.extend (dotnet_naming_convention_keyword)
			Result.extend (end_keyword)
			Result.extend (ensure_keyword)
			Result.extend (exception_trace_keyword)
			Result.extend (exclude_keyword)
			Result.extend (external_keyword)
			Result.extend (il_verifiable_keyword)
			Result.extend (include_keyword)
			Result.extend (inlining_keyword)
			Result.extend (invariant_keyword)
			Result.extend (library_keyword)
			Result.extend (line_generation_keyword)
			Result.extend (loop_keyword)
			Result.extend (msil_generation_keyword)
			Result.extend (msil_generation_type_keyword)
			Result.extend (no_keyword)
			Result.extend (object_keyword)
			Result.extend (optimize_keyword)
			Result.extend (override_keyword)
			Result.extend (precompile_keyword)
			Result.extend (profile_keyword)
			Result.extend (require_keyword)
			Result.extend (root_keyword)
			Result.extend (system_keyword)
			Result.extend (trace_keyword)
			Result.extend (use_keyword)
			Result.extend (visible_keyword)
			Result.extend (adapt_keyword)
			Result.extend (as_keyword)
			Result.extend (creation_keyword)
			Result.extend (create_keyword)
			Result.extend (depend_keyword)
			Result.extend (export_keyword)
			Result.extend (generate_keyword)
			Result.extend (ignore_keyword)
			Result.extend (rename_keyword)
			Result.extend (yes_keyword)
			Result.extend (working_directory_keyword)
			--Result.extend ("")
		end
		
		adapt_keyword: STRING is "adapt"
		
		as_keyword: STRING is "as"
		
		creation_keyword: STRING is "creation"
		
		create_keyword: STRING is "create"
		
		depend_keyword: STRING is "depend"
		
		export_keyword: STRING is "export"
		
		generate_keyword: STRING is "generate"
		
		ignore_keyword: STRING is "ignore"
		
		rename_keyword: STRING is "rename"
		
		yes_keyword: STRING is "yes"

		all_keyword: STRING is "all"
		
		arguments_keyword: STRING is "arguments"
		
		array_optimization_keyword: STRING is "array_optimization"
		
		assemblies_keyword: STRING is "assemblies"
		
		assembly_keyword: STRING is "assembly"
		
		assertion_keyword: STRING is "assertion"
		
		check_keyword: STRING is "check"
		
		check_vape_keyword: STRING is "check_vape"
		
		cls_compliant_keyword: STRING is "cls_compliant"
		
		cluster_keyword: STRING is "cluster"
		
		console_application_keyword: STRING is "console_application"
		
		dead_code_removal_keyword: STRING is "dead_code_removal"
		
		debug_keyword: STRING is "debug"
		
		default_keyword: STRING is "default"
		
		namespace_keyword: STRING is "namespace"
		
		disable_keyword: STRING is "disable"
		
		disabled_debug_keyword: STRING is "disabled_debug"
		
		dotnet_naming_convention_keyword: STRING is "dotnet_naming_convention"
		
		end_keyword: STRING is "end"
		
		ensure_keyword: STRING is "ensure"
		
		exception_trace_keyword: STRING is "exception_trace"
		
		exclude_keyword: STRING is "exclude"
		
		external_keyword: STRING is "external"
		
		il_verifiable_keyword: STRING is "il_verifiable"
		
		include_keyword: STRING is "include"
				
		inlining_keyword: STRING is "inlining"
		
		invariant_keyword: STRING is "invariant"
		
		library_keyword: STRING is "library"
	
		line_generation_keyword: STRING is "line_generation"
		
		loop_keyword: STRING is "loop"
		
		msil_generation_keyword: STRING is "msil_generation"
		
		msil_generation_type_keyword: STRING is "msil_generation_type"
		
		no_keyword: STRING is "no"
		
		object_keyword: STRING is "object"
		
		optimize_keyword: STRING is "optimize"
		
		override_keyword: STRING is "override"
		
		precompile_keyword: STRING is "precompile"
		
		profile_keyword: STRING is "profile" 
		
		require_keyword: STRING is "require"
		
		root_keyword: STRING is "root"
		
		system_keyword: STRING is "system"
		
		trace_keyword: STRING is "trace"
		
		use_keyword: STRING is "use"
		
		visible_keyword: STRING is "visible"
		
		working_directory_keyword: STRING is "working_directory";

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
end -- class ACE_FILE_DICTIONARY
