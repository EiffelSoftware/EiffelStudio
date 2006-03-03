indexing
	description: "Description of a visible class in Ace"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CLAS_VISI_SD

inherit
	AST_LACE

create
	initialize

feature {NONE} -- Initialization

	initialize (cn: like class_name; vn: like visible_name;
		cr: like creation_restriction; er: like export_restriction;
		r: like renamings) is
			-- Create a new CLAS_VISI AST node.
		require
			cn_not_void: cn /= Void
		do
			class_name := cn
			cn.to_upper
			visible_name := vn
			if vn /= Void then
				vn.to_upper
			end
			creation_restriction := cr
			export_restriction := er
			renamings := r
		ensure
			class_name_set: class_name = cn
			visible_name_set: visible_name = vn
			creation_restriction_set: creation_restriction = cr
			export_restriction_set: export_restriction = er
			renamings_set: renamings = r
		end

feature -- Properties

	class_name: ID_SD
			-- Eiffel class name of visible class
			-- Never Void

	visible_name: ID_SD
			-- Exported name
			-- Can be Void

	creation_restriction: LACE_LIST [ID_SD]
			-- Can be Void

	export_restriction: LACE_LIST [ID_SD]
			-- Can be Void

	renamings: LACE_LIST [TWO_NAME_SD]
			-- Can be Void

invariant
	class_name_not_void: class_name /= Void
	class_name_in_upper: class_name.as_upper.is_equal (class_name)
	visible_name_in_upper: visible_name /= Void implies visible_name.as_upper.is_equal (visible_name)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class CLAS_VISI_SD



