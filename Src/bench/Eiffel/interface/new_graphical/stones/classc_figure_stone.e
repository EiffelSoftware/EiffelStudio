indexing
	description: "CLASSC_STONEs that originate from a CLASS_FIGURE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASSC_FIGURE_STONE

inherit
	CLASSC_STONE
		rename
			make as make_with_class_c
		select
			classi_make
		end

	CLASSI_FIGURE_STONE
		undefine
			class_i, class_name, make,
			cluster, file_name, header, history_name,
			is_valid, stone_signature, synchronized_stone
		end

create
	make

feature {NONE} -- Initialization

	make (a_figure: EIFFEL_CLASS_FIGURE) is
			-- Initialize with `a_figure'.
		do
			make_with_class_c (a_figure.model.class_i.compiled_class)
			source := a_figure
		end

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

end -- class CLASSC_FIGURE_STONE

