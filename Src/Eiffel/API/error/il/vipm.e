note

	description: "Error due to duplicated IL property names."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class VIPM

inherit
	COMPILER_EXPORTER
	FEATURE_ERROR
		redefine
			build_explain
		end

create {COMPILER_EXPORTER}
	make

feature {NONE} -- Creation

	make (c: CLASS_C; f1, f2: FEATURE_I; p: STRING)
			-- Create an error object for the given class `c', features `f1' and `f2', and property `p'.
		require
			c_attached: c /= Void
			f1_attached: f1 /= Void
			f2_attached: f2 /= Void
			p_attached: p /= Void
		do
			set_class (c)
			set_feature (f1)
			other_feature := f2.api_feature (c.class_id)
			property_name := p
		end

feature -- Properties

	code: STRING = "VIPM"
			-- Error code

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Output the error message.
		do
			a_text_formatter.add ("Other feature: ")
			other_feature.append_name (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Property name: ")
			a_text_formatter.add (property_name)
			a_text_formatter.add_new_line
		end

feature {NONE} -- Implementation

	other_feature: E_FEATURE
			-- Other feature involved in the name clash

	property_name: STRING
			-- Clashing property name

invariant
	class_c_attached: class_c /= Void
	e_feature_attached: e_feature /= Void
	other_feature_attached: other_feature /= Void
	property_name_attached: property_name /= Void

note
	copyright:	"Copyright (c) 2006, Eiffel Software"
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
