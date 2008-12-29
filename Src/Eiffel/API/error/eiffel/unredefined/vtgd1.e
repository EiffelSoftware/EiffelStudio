note
	description: "Error for the formal generic part of a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VTGD1

inherit
	VTGD
		redefine
			build_explain,
			subcode
		end

create
	default_create

feature -- Properties

	subcode: INTEGER_32 = 1

	classes_with_same_feature: LIST [CLASS_C]
			-- List of classes with same feature.
			-- This is used to provide the user with a specific list of classes which contain the same feature.

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		local
			l_output: STRING_8
		do
			l_output := "The feature `" + feature_name + "' occurs in the following set of classes:%N   "
			a_text_formatter.add (l_output)
			classes_with_same_feature.do_all (agent (a_text_formatter2: TEXT_FORMATTER; a_first: CLASS_C; a_item: CLASS_C)
				do
					if a_item /= a_first then
						a_text_formatter2.add (", ")
					end
					a_item.append_name (a_text_formatter2)
				end (a_text_formatter, classes_with_same_feature.first, ?))
			a_text_formatter.add_new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (a_feature_name: STRING_8)
			-- Set feature_name to `a_feature_name'
		do
			feature_name := a_feature_name
		ensure
			set: feature_name = a_feature_name
		end

	set_classes_with_same_feature (a_list: LIST [CLASS_C])
			-- Set classes_with_same_feature to `a_list'
		require
			a_list_not_void: a_list /= Void
		do
			classes_with_same_feature := a_list
		ensure
			is_set: classes_with_same_feature = a_list
		end

note
	copyright: "Copyright (c) 1984-2006, Eiffel Software"
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

end -- class VTGD1

