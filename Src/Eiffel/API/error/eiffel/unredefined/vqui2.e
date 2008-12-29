note

	description:
		"[
			Error for a unique constant with a value that
			cannot be represented by the specified integer type.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class VQUI2

inherit

	VQUI
		redefine
			subcode
		end

create {COMPILER_EXPORTER}

	make

feature {NONE} -- Creation

	make (c: CLASS_C; f: STRING; t: TYPE_A)
			-- Create an error object for feature `f'
			-- of type `t' in class `c'.
		require
			c_attached: c /= Void
			f_attached: f /= Void
			t_attached: t /= Void
		do
			set_class (c)
			set_feature_name (f)
			set_type (t)
		end

feature -- Properties

	subcode: INTEGER = 2;
			-- Error subcode

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
