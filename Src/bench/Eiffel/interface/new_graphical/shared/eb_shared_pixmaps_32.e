indexing
	description: "32x32 matrix pixmap for EiffelStudio user interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_PIXMAPS_32

inherit
	EB_SHARED_PIXMAP_FACTORY

	EIFFEL_ENV
		export
			{NONE} all
		end

	EB_SHARED_PIXMAP_FACTORY
		export
			{NONE} all
		end

feature -- Pixmap Icons

	icons_progress_degree: ARRAY [EV_PIXMAP] is
			-- Icons representing a thermometer a different temperatures.
		once
			create Result.make (-3, 6)
			Result.put (pixmap_from_constant (icon_degree_minus_3_value), -3)
			Result.put (pixmap_from_constant (icon_degree_minus_2_value), -2)
			Result.put (pixmap_from_constant (icon_degree_minus_1_value), -1)
			Result.put (pixmap_from_constant (icon_degree_0_value), 0)
			Result.put (pixmap_from_constant (icon_degree_1_value), 1)
			Result.put (pixmap_from_constant (icon_degree_2_value), 2)
			Result.put (pixmap_from_constant (icon_degree_3_value), 3)
			Result.put (pixmap_from_constant (icon_degree_4_value), 4)
			Result.put (pixmap_from_constant (icon_degree_5_value), 5)
			Result.put (pixmap_from_constant (icon_degree_6_value), 6)
		end

	icon_wizard_blank_project: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_wizard_blank_project_value)
		end

	icon_wizard_project: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_wizard_project_value)
		end

	icon_wizard_ace_project: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_wizard_ace_project_value)
		end

	icon_open_project: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_open_project_value)
		end

feature {NONE} -- {EB_SHARED_PIXMAP_FACTORY} Implementation

	pixmap_width: INTEGER is 32
		-- Width in pixels of generated factory image

	pixmap_height: INTEGER is 32
		-- Height in pixels of generated factory image

	image_matrix: EV_PIXMAP is
			-- Matrix pixmap containing all of the screen cursors
		once
			Result := load_pixmap_from_repository ("icon_matrix_32")
		end

	pixmap_path: DIRECTORY_NAME is
			-- Path to cursor pixmaps
		once
			create Result.make_from_string (eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "bitmaps", "png">>)
		end

	pixmap_lookup_table: ES_PIXMAP_LOOKUP_TABLE is
			-- Lookup hash table for studio pixmaps
		once
			create Result.make_with_values (8, 2)
			Result.add_pixmap (1, 1, icon_degree_minus_3_value)
			Result.add_pixmap (2, 1, icon_degree_minus_2_value)
			Result.add_pixmap (3, 1, icon_degree_minus_1_value)
			Result.add_pixmap (4, 1, icon_degree_0_value)
			Result.add_pixmap (5, 1, icon_degree_1_value)
			Result.add_pixmap (6, 1, icon_degree_2_value)
			Result.add_pixmap (7, 1, icon_degree_3_value)
			Result.add_pixmap (8, 1, icon_degree_4_value)
			Result.add_pixmap (1, 2, icon_degree_5_value)
			Result.add_pixmap (2, 2, icon_degree_6_value)
			Result.add_pixmap (3, 2, icon_open_project_value)
			Result.add_pixmap (4, 2, icon_wizard_ace_project_value)
			Result.add_pixmap (5, 2, icon_wizard_project_value)
			Result.add_pixmap (6, 2, icon_wizard_blank_project_value)
		end

feature {NONE} -- Constants

	icon_degree_minus_3_value,
	icon_degree_minus_2_value,
	icon_degree_minus_1_value,
	icon_degree_0_value,
	icon_degree_1_value,
	icon_degree_2_value,
	icon_degree_3_value,
	icon_degree_4_value,
	icon_degree_5_value,
	icon_degree_6_value,
	icon_open_project_value,
	icon_wizard_ace_project_value,
	icon_wizard_project_value,
	icon_wizard_blank_project_value: INTEGER is unique;
		-- Constants used for pixmap lookup.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class EB_SHARED_PIXMAPS_32
