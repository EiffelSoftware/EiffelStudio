indexing

	description:
		"Command to display homonyms of `current_feature'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_ROUTINE_HOMONYMNS

inherit

	E_FEATURE_CMD
		redefine
			has_valid_feature
		end;
	SHARED_EIFFEL_PROJECT

create
	make, default_create

feature -- Access

	has_valid_feature: BOOLEAN is True
			-- Always a valid feature

feature -- Execution

	work is
			-- Execute Current command.
		local
			clusters: ARRAYED_LIST [CLUSTER_I];
			classes: HASH_TABLE [CLASS_I, STRING];
			e_class: CLASS_C;
			feat: E_FEATURE;
			feature_name: STRING;
			class_name: STRING
		do
			feature_name := current_feature.name;
			clusters := Eiffel_universe.clusters;
			from
				clusters.start
			until
				clusters.after
			loop
				classes := clusters.item.classes;
				from
					classes.start
				until
					classes.after
				loop
					e_class := classes.item_for_iteration.compiled_class;
					if e_class /= Void and e_class.has_feature_table then
						feat := e_class.feature_with_name (feature_name);
						if feat /= Void then
							class_name := e_class.name;
							feat.append_signature (text_formatter);
							text_formatter.add_new_line;
							text_formatter.add_indent;
							text_formatter.add ("From class ");
							e_class.append_signature (text_formatter, True);
							text_formatter.add_new_line;
						end
					end;
					classes.forth
				end;
				clusters.forth
			end
		end;

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

end -- class E_SHOW_ROUTINE_HOMONYMNS
