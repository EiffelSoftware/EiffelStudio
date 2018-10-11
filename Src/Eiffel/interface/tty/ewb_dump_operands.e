note

	description:
		"Dumps operands of a feature to stdout."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_DUMP_OPERANDS

inherit

	EWB_FEATURE
		rename
			name as text_cmd_name,
			help_message as r_text_help,
			abbreviation as text_abb
		export
			{ANY} execute
		redefine
			process_feature
		end

	INTERNAL_COMPILER_STRING_EXPORTER

create

	make, do_nothing

feature {NONE} -- Properties

	associated_cmd: E_FEATURE_CMD
			-- Associated feature command to be executed
			-- after successfully retrieving the feature_i
		do
		end

	process_feature (e_feature: E_FEATURE; e_class: CLASS_C)
			-- Process `e_feature' defined in `e_class'.
		local
			gs: EIFFEL_LIST [FORMAL_DEC_AS]
			gts: ARRAY [STRING]
			types: LINEAR [TYPE_A]
			l_names: LINEAR [STRING]
			i: INTEGER
			s: STRING
		do
			if attached e_class.generics as l_generics then
				if l_generics.is_empty then
					create gts.make_empty
				else
					from
						create gts.make_filled ("", 1, l_generics.count)
						gs := l_generics
						gs.start
						i := 1
					until
						gs.after
					loop
						gts.put (gs.item.constraints.dump (False),i)
						i := i + 1
						gs.forth
					end
				end
			end

			if attached e_feature.arguments as l_feat_args and then attached l_feat_args.argument_names as l_feat_args_names then
				types := l_feat_args.linear_representation
				l_names := l_feat_args_names.linear_representation

				from
					types.start
					l_names.start
				until
					types.after
				loop
					print (l_names.item + ": ")
					if attached types.item as l_type then
						s := l_type.dump
					else
						s := "Void"
					end
					if gts /= Void then
						from
							i := gts.lower
						until
							i > gts.upper
						loop
							s.replace_substring_all ("G#" + i.out, gts.item (i))
							i := i + 1
						end
					end
					if s.item (1) = '[' then
						s.replace_substring ("", 1, s.index_of (']', 1) + 1)
					end
					types.forth
					l_names.forth
					print (s+ "%N")
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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

end -- class EWB_DUMP_FEATURES
