note
	description: "Error for a root class having bad creation procedure arguments."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VSRP2

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode, is_defined, trace_primary_context
		end

create
	make

feature {NONE} -- Creation

	make (c: like class_c; t: like root_type; f: FEATURE_I)
			-- Create an error object with context class `c', root class type `t' and creation procedure `f'.
		require
			c_attached: attached c
			t_attached: attached t
			f_attached: attached f
		do
			set_class (c)
			root_type := t
			creation_feature := f.api_feature (f.written_in)
		ensure
			class_c_set: class_c = c
			root_type_set: root_type = t
			creation_feature_set: attached creation_feature
		end

feature -- Properties

	code: STRING = "VSRP"
			-- Error code

	subcode: INTEGER = 2
			-- Subcode

	creation_feature: E_FEATURE
			-- Creation procedure name involved in the error

	root_type: TYPE_A
			-- Root type involved in the error

feature -- Access

	is_defined: BOOLEAN
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				creation_feature /= Void
		ensure then
			valid_creation_feature: Result implies creation_feature /= Void
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			if root_type.has_generics then
				a_text_formatter.add ("Class type: ")
				root_type.append_to  (a_text_formatter)
				a_text_formatter.add_new_line
			end
			a_text_formatter.add ("Creation feature: ")
			creation_feature.append_signature (a_text_formatter)
			a_text_formatter.add_new_line
		end

	trace_primary_context (a_text_formatter: TEXT_FORMATTER)
			-- Build the primary context string so errors can be navigated to
		do
			if
				a_text_formatter /= Void and then
				attached creation_feature as l_feature and then
				attached class_c as l_class
			then
				print_context_feature (a_text_formatter, l_feature, l_class)
			else
				Precursor (a_text_formatter)
			end
		end

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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

end -- class VSRP2
