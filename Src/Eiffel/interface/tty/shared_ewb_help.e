﻿note
	description: "Help constants for menu entries."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SHARED_EWB_HELP

inherit
	SHARED_LOCALE

feature {NONE}

	ace_help: STRING_GENERAL do Result := locale.translation ("specify the Ace file (obsolete)") end

	ace_loop_help: STRING_GENERAL do Result := locale.translation ("show the config file") end

	add_subquery_help: STRING_GENERAL do Result := locale.translation ("add a subquery") end

	ancestors_help: STRING_GENERAL do Result := locale.translation ("show the ancestors of a class") end

	arguments_help: STRING_GENERAL do Result := locale.translation ("set the arguments") end

	aversions_help: STRING_GENERAL do Result := locale.translation ("show the ancestor versions of a feature") end

	attributes_help: STRING_GENERAL do Result := locale.translation ("show the attributes of a class") end

	batch_help: STRING_GENERAL do Result := locale.translation ("launch the compilation without user request") end

	c_compile_help: STRING_GENERAL do Result := locale.translation ("launch C compilation if needed") end

	ca_class_help: READABLE_STRING_GENERAL do Result := locale.translation ("analyze code of a class or of all non-library classes (-all)") end

	ca_default_help: READABLE_STRING_GENERAL do Result := locale.translation ("restore default code analyzer preferences") end

	ca_rule_help: READABLE_STRING_GENERAL do Result := locale.translation ("activate code analyzer rule(s) (with settings)") end

	ca_setting_help: READABLE_STRING_GENERAL do Result := locale.translation ("load code analyzer preferences from a file") end

	callers_help: STRING_GENERAL do Result := locale.translation ("show the callers of a feature") end

	callees_help: STRING_GENERAL do Result := locale.translation ("show the callees of a feature") end

	change_operator_help: STRING_GENERAL do Result := locale.translation ("change the boolean operator") end

	class_help: STRING_GENERAL do Result := locale.translation ("class formats and information") end

	class_list_help: STRING_GENERAL do Result := locale.translation ("show the classes in alphabetic order") end

	clean_help: STRING_GENERAL do Result := locale.translation ("delete existing project if any and perform a fresh compilation") end

	clients_help: STRING_GENERAL do Result := locale.translation ("show the clients of a class") end

	cluster_hierarchy_help: STRING_GENERAL do Result := locale.translation ("display the cluster hierarchy of the system") end

	clusters_help: STRING_GENERAL do Result := locale.translation ("show the system's classes, cluster by cluster") end

	compat_help: STRING_GENERAL do Result := locale.translation ("enable pre-attached type compatibility") end

	compile_help: STRING_GENERAL do Result := locale.translation ("compile or run the system") end

	config_help: STRING_GENERAL do Result := locale.translation ("specify the configuration (ECF) file") end

	config_option_help: STRING_GENERAL do Result := locale.translation ("override configuration options of a target") end

	Convert_profile_help: STRING_GENERAL do Result := locale.translation ("convert profiler output files") end

	Debug_help: STRING_GENERAL do Result := locale.translation ("debug the system as a command loop") end

	defaults_help: STRING_GENERAL do Result := locale.translation ("reset all values to their defaults") end

	deferred_help: STRING_GENERAL do Result := locale.translation ("show the deferred features of a class") end

	descendants_help: STRING_GENERAL do Result := locale.translation ("show the descendants of a class") end

	Descendants_time_help: STRING_GENERAL do Result := locale.translation (" output of time spent in descendants of a function") end

	Documentation_help: STRING_GENERAL do Result := locale.translation ("create documents from the system") end

	dversions_help: STRING_GENERAL do Result := locale.translation ("show the descendant versions of a feature") end

	edit_ace_help: STRING_GENERAL do Result := locale.translation ("edit the config file") end

	edit_class_help: STRING_GENERAL do Result := locale.translation ("edit the text of a class") end

	experiment_help: STRING_GENERAL do Result := locale.translation ("enable experimental functionalities") end

	exported_help: STRING_GENERAL do Result := locale.translation ("show the exported features of a class") end

	externals_help: STRING_GENERAL do Result := locale.translation ("show the external features of a class") end

	f_compile_help: STRING_GENERAL do Result := locale.translation ("(re)compile the C code generated by finalize") end

	feature_help: STRING_GENERAL do Result := locale.translation ("feature formats and information") end

	Featurename_help: STRING_GENERAL do Result := locale.translation (" output of feature names") end

	file_help: STRING_GENERAL do Result := locale.translation ("save the output to a file") end

	filter_help: STRING_GENERAL do Result := locale.translation ("show a filtered form (troff, ...) of the class text") end

	finalize_help: STRING_GENERAL do Result := locale.translation ("finalize the system (discard assertions by default)") end

	flat_help: STRING_GENERAL do Result := locale.translation ("show the flat form of a class") end

	flatshort_help: STRING_GENERAL do Result := locale.translation ("show the flat-short form of a class") end

	freeze_help: STRING_GENERAL do Result := locale.translation ("freeze the system") end

	full_help: STRING_GENERAL do Result := locale.translation ("with full class checking regardless of ECF settings") end

	Generate_help: STRING_GENERAL do Result := locale.translation ("generate profile information for latest run") end

	gui_help: STRING_GENERAL do Result := locale.translation ("start the graphical environment") end

	help_help: STRING_GENERAL do Result := locale.translation ("show this help message") end

	homonyms_help: STRING_GENERAL do Result := locale.translation ("shown the homonyms of a feature") end

	implementers_help: STRING_GENERAL do Result := locale.translation ("show the classes implementing a feature") end

	indexing_help: STRING_GENERAL do Result := locale.translation ("show indexing clauses of classes") end

	Input_help: STRING_GENERAL do Result := locale.translation ("specify input file (filename or last_output)") end

	Language_help: STRING_GENERAL do Result := locale.translation ("specify language (eiffel, c, cycles)") end

	library_help: STRING_GENERAL do Result := locale.translation ("specify a library for single file compilation") end

	loop_help: STRING_GENERAL do Result := locale.translation ("run ec as a command loop") end

	loop_help_help: STRING_GENERAL do Result := locale.translation ("show list of commands") end

	overwrite_old_project_help: STRING_GENERAL do Result := locale.translation ("overwrite any existing old project") end

	main_help: STRING_GENERAL do Result := locale.translation ("go back to main menu") end

	melt_help: STRING_GENERAL do Result := locale.translation ("melt the system") end

	modified_help: STRING_GENERAL do Result := locale.translation ("show classes modified since last compilation") end

	Number_of_calls_help: STRING_GENERAL do Result := locale.translation (" output of number of calls to a feature") end

	once_help: STRING_GENERAL do Result := locale.translation ("show the once & constant features of a class") end

	parent_help: STRING_GENERAL do Result := locale.translation ("go back to parent menu") end

	Percentage_help: STRING_GENERAL do Result := locale.translation (" output of percentage of time spent in a feature") end

	precompile_help: STRING_GENERAL do Result := locale.translation ("precompile the system") end

	pretty_help: STRING_GENERAL do Result := locale.translation ("show the pretty form of a class") end

	finalize_precompile_help: STRING_GENERAL do Result := locale.translation ("precompile and finalize the system") end

	Profile_help: STRING_GENERAL do Result := locale.translation ("information about a profiled run") end

	project_path_help: STRING_GENERAL do Result := locale.translation ("specify the compilation directory") end

	project_help: STRING_GENERAL do Result := locale.translation ("specify the project file to load (obsolete)") end

	preference_help: READABLE_STRING_32 do Result := locale.translation_in_context ("override default or stored preference value", "compiler.command-line.option") end

	queries_help: STRING_GENERAL do Result := locale.translation ("manipulate subqueries") end

	quick_melt_help: STRING_GENERAL do Result := locale.translation ("quick melt the system") end

	quit_help: STRING_GENERAL do Result := locale.translation ("terminate session") end

	r_flat_help: STRING_GENERAL do Result := locale.translation ("show the flat form of a feature") end

	r_text_help: STRING_GENERAL do Result := locale.translation ("show the text of a feature") end

	reactivate_subquery_help: STRING_GENERAL do Result := locale.translation ("reactivate subquery") end

	inactivate_subquery_help: STRING_GENERAL do Result := locale.translation ("inactivate subquery") end

	reset_ide_layout_help: STRING_GENERAL do Result := locale.translation ("reset the IDE layout") end

	routines_help: STRING_GENERAL do Result := locale.translation ("show the routines of a class") end

	invariants_help: STRING_GENERAL do Result := locale.translation ("show the invariants of a class") end

	creators_help: STRING_GENERAL do Result := locale.translation ("show the creation procedures of a class") end

	run_help: STRING_GENERAL do Result := locale.translation ("execute the system") end

	run_prof_help: STRING_GENERAL do Result := locale.translation ("run the query") end

	Self_sec_help: STRING_GENERAL do Result := locale.translation (" output of time spent in a function itself") end

	single_file_compilation_help: STRING_GENERAL do Result := locale.translation ("specify a class file for single file compilation") end

	short_help: STRING_GENERAL do Result := locale.translation ("show the short form of a class") end

	show_subqueries_help: STRING_GENERAL do Result := locale.translation ("show the list of queries") end

	statistics_help: STRING_GENERAL do Result := locale.translation ("show system statistics") end

	stop_help: STRING_GENERAL do Result := locale.translation ("stop on error") end

	storage_help: STRING_GENERAL do Result := locale.translation ("store in EiffelCase format") end

	suppliers_help: STRING_GENERAL do Result := locale.translation ("show the suppliers of a class") end

	switches_help: STRING_GENERAL do Result := locale.translation ("show the output switches") end

	system_help: STRING_GENERAL do Result := locale.translation ("Config and cluster details") end

	text_help: STRING_GENERAL do Result := locale.translation ("show the text of a class") end

	path_help: STRING_GENERAL do Result := locale.translation ("show the path of a class") end

	target_help: STRING_GENERAL do Result := locale.translation ("specify the target") end

	use_settings_help: STRING_GENERAL do Result := locale.translation ("use settings for project location") end

	no_library_help: STRING_GENERAL do Result := locale.translation ("do not convert clusters into libraries") end

	Total_sec_help: STRING_GENERAL do Result := locale.translation (" output of time spent in both the function and its descendants") end

	yank_help: STRING_GENERAL do Result := locale.translation ("yank (save) output of last command to a file") end

	w_compile_help: STRING_GENERAL do Result := locale.translation ("(re)compile the C code generated by freeze") end

	flat_doc_help: STRING_GENERAL do Result := locale.translation ("Generate flat form of all classes in system") end

	flat_short_doc_help: STRING_GENERAL do Result := locale.translation ("Generate flat/short form of all classes in system") end

	short_doc_help: STRING_GENERAL do Result := locale.translation ("Generate short form of all classes in system") end

	text_doc_help: STRING_GENERAL do Result := locale.translation ("Generate text form of all classes in system") end

	app_info_help: STRING_GENERAL do Result := locale.translation ("Output various application information (-appinfo ? to list available informations)") end

	version_help: STRING_GENERAL do Result := locale.translation ("show compiler version number") end

	gc_stats_help: STRING_GENERAL do Result := locale.translation ("Show GC statistics") end

	metadata_cache_path_help: STRING_GENERAL do Result := locale.translation ("Location of .NET MetadData consumer cache") end

note
	ca_ignore: "CA033", "CA033: too large class"
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
