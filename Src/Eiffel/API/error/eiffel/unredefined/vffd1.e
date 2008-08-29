indexing

	description: "Error for features that do not fit the known feature categories."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class VFFD1

inherit

	VFFD
		redefine
			build_explain,
			subcode
		end

create
	make_attribute_with_arguments,
	make_attribute_without_query_mark

feature {NONE} -- Creation

	make_attribute_with_arguments (c: like class_c; f: like feature_name; l: LOCATION_AS)
			-- Create error for the case when an attribute is declared with arguments.
		require
			c_attached: c /= Void
			f_attached: f /= Void
			l_attached: l /= Void
		do
			set_class (c)
			set_feature_name (f)
			set_location (l)
			is_attribute_with_arguments := True
		ensure
			class_c_set: class_c = c
			feature_name_set: feature_name = f
			is_attribute_with_arguments_set: is_attribute_with_arguments
		end

	make_attribute_without_query_mark (c: like class_c; f: like feature_name; l: LOCATION_AS)
			-- Create error for the case when an attribute is declared without query mark.
		require
			c_attached: c /= Void
			f_attached: f /= Void
			l_attached: l /= Void
		do
			set_class (c)
			set_feature_name (f)
			set_location (l)
			is_attribute_without_query_mark := True
		ensure
			class_c_set: class_c = c
			feature_name_set: feature_name = f
			is_attribute_without_query_mark_set: is_attribute_without_query_mark
		end

feature -- Properties

	subcode: INTEGER is 1
			-- <Precursor>

feature -- Status report

	is_attribute_with_arguments: BOOLEAN
			-- Is attribute declared with formal arguments?

	is_attribute_without_query_mark: BOOLEAN
			-- Is attribute declared without a query mark?

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			if is_attribute_with_arguments then
				a_text_formatter.add_string ("Details: Attribute is declared with formal arguments.")
				a_text_formatter.add_new_line
			end
			if is_attribute_without_query_mark then
				a_text_formatter.add_string ("Details: Attribute is declared without a query mark.")
				a_text_formatter.add_new_line
			end
		end

indexing
	copyright:	"Copyright (c) 2008, Eiffel Software"
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
