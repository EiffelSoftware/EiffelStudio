indexing
	description: "Variable Initialization error."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VEVI

inherit
	FEATURE_ERROR
		redefine
			build_explain,
			print_single_line_error_message
		end

create
	make_attribute,
	make_local,
	make_result

feature {NONE} -- Creation

	make_attribute (f: FEATURE_I; class_id: INTEGER; c: AST_CONTEXT; l: LOCATION_AS)
			-- Create error object for feature `f' from a class identified by `class_id'.
		require
			valid_f: f /= Void
			valid_class_id: class_id > 0
			c_attached: c /= Void
			l_attached: l /= Void
		do
			attribute_variable :=  f.enclosing_feature.api_feature (class_id)
			c.init_error (Current)
			set_location (l)
		ensure
			attribute_variable_attached: attribute_variable /= Void
		end

	make_local (n: STRING; c: AST_CONTEXT; l: LOCATION_AS)
			-- Create error object for a local `n'.
		require
			n_attached: n /= Void
			n_not_empty: not n.is_empty
			c_attached: c /= Void
			l_attached: l /= Void
		do
			local_name := n
			c.init_error (Current)
			set_location (l)
		ensure
			local_name_set: local_name = n
		end

	make_result (c: AST_CONTEXT; l: LOCATION_AS)
			-- Create error object for Result.
		require
			c_attached: c /= Void
			l_attached: l /= Void
		do
			c.init_error (Current)
			set_location (l)
		end

feature -- Error properties

	code: STRING is "VEVI"
			-- Error code

feature {NONE} -- Variable name

	attribute_variable: E_FEATURE
			-- Attribute

	local_name: STRING
			-- Local variable

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			Precursor (a_text_formatter)
			append_variable_name (a_text_formatter)
			a_text_formatter.add_new_line
		end

feature {NONE} -- Output

	print_single_line_error_message (a_text_formatter: TEXT_FORMATTER)
			-- Displays single line help in `a_text_formatter'.
		do
			Precursor (a_text_formatter)
			a_text_formatter.add (" ")
			append_variable_name (a_text_formatter)
		end

	append_variable_name (a_text_formatter: TEXT_FORMATTER)
			-- Append associated variable name to `a_text_formatter'.
		do
			if attribute_variable /= Void then
				a_text_formatter.add ("Attribute: ")
				attribute_variable.append_signature (a_text_formatter)
				a_text_formatter.add (" from ")
				attribute_variable.written_class.append_name (a_text_formatter)
			elseif local_name /= Void then
				a_text_formatter.add ("Local: ")
				a_text_formatter.add_local (local_name)
			else
				a_text_formatter.add ("Variable: ")
				a_text_formatter.process_keyword_text ("Result", Void)
			end
		end

indexing
	copyright:	"Copyright (c) 2007, Eiffel Software"
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
