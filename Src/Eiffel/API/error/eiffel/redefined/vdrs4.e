note
	description: "Error when the compiler cannot find an effective redefinition."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class VDRS4

inherit

	EIFFEL_ERROR
		undefine
			print_single_line_error_message,
			process_issue
		redefine
			build_explain, subcode
		end

	SHARED_NAMES_HEAP

feature {NONE} -- Creation

	make (f: like feature_name_id; p: PARENT_C; c: CLASS_C)
			-- Initialize an error for a feature name ID `f` of parent `p` in class `c`.
		local
			i: like {ID_AS}.index
			l: ID_AS
		do
			feature_name_id := f
			parent := p
			set_class (c)
				-- Unless the feature is found, use the class name location.
			l := p.class_name_token
			if attached c.ast as ast then
				i := l.index
				across
					ast.parents as a
				until
					i = 0
				loop
					if a.item.type.class_name.index = i then
							-- The parent is found.
							-- Stop iteration.
						i := 0
						if attached a.item.redefining as rs then
							across
								rs as r
							loop
								if r.item.feature_name.name_id = f then
										-- The feature name is found, use its location.
									l := r.item.feature_name
								end
							end
						end
					end
				end
			end
			set_location (l)
		ensure
			feature_name_id = f
			parent = p
			class_c = c
		end

feature -- Properties

	code: STRING = "VDRS"
			-- Error code

	subcode: INTEGER = 4

feature -- Access

	feature_name_id: like {NAMES_HEAP}.id_of_32
			-- Name ID of the feature

	feature_name: READABLE_STRING_32
			-- Name of the feature.
		do
			Result := names_heap.item_32 (feature_name_id)
		end

	parent: PARENT_C
			-- Parent clause.

feature -- Output

	build_explain (t: TEXT_FORMATTER)
			-- Build specific explanation explain for current error in `t`.
		do
			t.add ("Feature name: ")
			t.add (feature_name)
			t.add_new_line
			t.add ("Parent class: ")
			parent.parent.append_name (t)
			t.add_new_line
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
