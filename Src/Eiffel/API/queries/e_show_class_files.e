indexing
	description: "Command to display classes in the cluster,%
		%with their associated files"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	E_SHOW_CLASS_FILES

inherit
	E_CLUSTER_CMD

create
	make, do_nothing

feature -- Execution

	work is
		local
			sorted_class_names: SORTED_TWO_WAY_LIST [STRING]
			classes: HASH_TABLE [CLASS_I, STRING]
			a_classi: CLASS_I
			a_class: CLASS_C
		do
			create sorted_class_names.make
			classes := current_cluster.classes
			from
				classes.start
			until
				classes.after
			loop
				sorted_class_names.put_front (classes.key_for_iteration)
				classes.forth
			end
			sorted_class_names.sort
			text_formatter.add ("Cluster: ")
			text_formatter.add_cluster (current_cluster, current_cluster.cluster_name)
			if current_cluster.is_precompiled then
				text_formatter.add (" (Precompiled)")
				text_formatter.add_new_line
			else
				text_formatter.add_new_line
				from
					sorted_class_names.start
				until
					sorted_class_names.after
				loop
					text_formatter.add_indent
					a_classi := classes.item (sorted_class_names.item)
					a_class := a_classi.compiled_class
					if a_class /= Void then
						a_class.append_signature (text_formatter)
					else
						a_classi.append_name (text_formatter)
					end
					text_formatter.add (" : ")
					text_formatter.add (a_classi.file_name)
					text_formatter.add_new_line
					sorted_class_names.forth
				end
			end
		end

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

end -- class E_SHOW_CLASS_FILES
