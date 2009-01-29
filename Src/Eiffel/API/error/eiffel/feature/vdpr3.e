note
	description: "Error in precursor construct."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VDPR3

inherit

	VDPR
		redefine
			subcode, build_explain
		end

create
	default_create,
	make_with_list

feature {NONE} -- Initialization

	make_with_list (a_list: LIST [TUPLE [feat: FEATURE_I; parent_type: CL_TYPE_A]])
		require
			a_list_not_void: a_list /= Void
			a_list_not_empty: not a_list.is_empty
		do
			create conflicting_features.make (a_list.count)
			from
				a_list.start
			until
				a_list.after
			loop
				conflicting_features.extend ([a_list.item.feat.api_feature (a_list.item.parent_type.class_id), a_list.item.parent_type])
				a_list.forth
			end
		end

feature -- Properties

	subcode: INTEGER = 3;

feature {NONE} -- Access

	conflicting_features: ARRAYED_LIST [TUPLE [feat: E_FEATURE; parent_type: CL_TYPE_A]]
			-- List of features causing a conflict

feature

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			if conflicting_features /= Void then
				a_text_formatter.add ("Ambiguous Precursor between effective features:")
				a_text_formatter.add_new_line
				from
					conflicting_features.start
				until
					conflicting_features.after
				loop
					a_text_formatter.add (" - ")
					conflicting_features.item.feat.append_name (a_text_formatter)
					a_text_formatter.add (" from ")
					conflicting_features.item.parent_type.append_to (a_text_formatter)
					a_text_formatter.add_new_line
					conflicting_features.forth
				end
			end
		end

note
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

end -- class VUPR3

