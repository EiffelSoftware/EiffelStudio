note

	description: "[
		Error caused by declaration of a property with several arguments.
		The incompatibility is caused by different order used by Eiffel
		assigner commands and IL property setters.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class VIPS

inherit
	FEATURE_ERROR

create {COMPILER_EXPORTER}
	make

feature {NONE} -- Creation

	make (c: CLASS_C; f: FEATURE_I)
			-- Create an error object for the given class `c' and feature `f'.
		require
			c_attached: c /= Void
			f_attached: f /= Void
		do
			set_class (c)
			set_feature (f)
		end

feature -- Properties

	code: STRING = "VIPS"
			-- Error code

invariant
	class_c_attached: class_c /= Void
	e_feature_attached: e_feature /= Void

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
