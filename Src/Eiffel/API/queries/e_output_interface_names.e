indexing
	description: "Names used in output commands"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	E_OUTPUT_INTERFACE_NAMES

feature -- Access

	ellipse: STRING is "..."
	from_word: STRING is "from"
	history_branch: STRING is "History branch #"
	separator: STRING is "-----------------"
	long_separator: STRING is "---------------------------------------------"
	version_from_class: STRING is "Version from class"
	version_from: STRING is "(version from)"
	class_word: STRING is "Class"
	colon: STRING is ":"
	not_in_system: STRING is "(not in system)"

	compilation_for_system: STRING is "compilation for system."
	compilations_for_system: STRING is "compilations for system."

	cluster_in_system: STRING is "cluster in the system."
	clusters_in_system: STRING is "clusters in the system."

	library_in_system: STRING is "library in the system."
	libraries_in_system: STRING is "libraries in the system."

	assembly_in_system: STRING is "assembly in the system."
	assemblies_in_system: STRING is "assemblies in the system."

	classes_in_system: STRING is "classes in the system."
	class_in_system: STRING is "class in the system."
	classes_in_universe: STRING is "classes in the universe"
	class_in_universe: STRING is "class in the universe"
	compiled: STRING is "compiled"
	melted: STRING is "melted"
	precompiled: STRING is "precompiled"
	all_classes: STRING is "classes in the universe."

	clusters: STRING is "Clusters"
	libraries: STRING is "Libraries"
	assemblies: STRING is "Assemblies"

	cluster: STRING is "cluster"
	library: STRING is "library"
	assembly: STRING is "assembly"
	override: STRING is "override"

	one_class: STRING is "class"
	classes: STRING is "classes"

	lparan: STRING is "("
	rparan: STRING is ")"
	less_than: STRING is "<"
	larger_than: STRING is ">"
	comma: STRING is ","

	root_class: STRING is "Root class"
	for_system: STRING is "For system";

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
