indexing
	description: "12x12 matrix pixmap for EiffelStudio user interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date       : "$Date$"
	revision   : "$Revision$"

class
	EB_SHARED_PIXMAPS_12

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

feature -- Breakpoint Icons

	icon_bp_arrow: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_bp_arrow_value)
		end

	icon_bp_slot: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_bp_slot_value)
		end

	icon_bp_enabled: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_bp_enabled_value)
		end

	icon_bp_disabled: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_bp_disabled_value)
		end

	icon_bp_slot_arrow: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_bp_slot_arrow_value)
		end

	icon_bp_enabled_arrow: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_bp_enabled_arrow_value)
		end

	icon_bp_disabled_arrow: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_bp_disabled_arrow_value)
		end

	icon_bp_slot_stopped: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_bp_slot_stopped_value)
		end

	icon_bp_enabled_stopped: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_bp_enabled_stopped_value)
		end

	icon_bp_disabled_stopped: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_bp_disabled_stopped_value)
		end

	icon_bp_enabled_condition: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_bp_enabled_condition_value)
		end

	icon_bp_disabled_condition: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_bp_disabled_condition_value)
		end

feature -- Logical Icon Groups

	icon_group_bp_slot: ARRAY [EV_PIXMAP] is
			-- Regular (no modifiers) breakpoint icon group.
		once
			Result := <<icon_bp_slot, icon_bp_slot_arrow, icon_bp_slot_stopped>>
		ensure
			result_not_void: Result /= Void
		end

	icon_group_bp_enabled: ARRAY [EV_PIXMAP] is
			-- Enabled breakpoint icon group.
		once
			Result := <<icon_bp_enabled, icon_bp_enabled_arrow, icon_bp_enabled_stopped>>
		ensure
			result_not_void: Result /= Void
		end

	icon_group_bp_disabled: ARRAY [EV_PIXMAP] is
			-- Disabled breakpoint icon group.
		once
			Result := <<icon_bp_disabled, icon_bp_disabled_arrow, icon_bp_disabled_stopped>>
		ensure
			result_not_void: Result /= Void
		end

	icon_group_bp_enabled_condition: ARRAY [EV_PIXMAP] is
			-- Conditional, enabled breakpoint icon group.
		once
			Result := <<icon_bp_enabled_condition, icon_bp_enabled_arrow, icon_bp_enabled_stopped>>
		ensure
			result_not_void: Result /= Void
		end

	icon_group_bp_disabled_condition: ARRAY [EV_PIXMAP] is
			-- Conditional, disabled breakpoint icon group.
		once
			Result := <<icon_bp_disabled_condition, icon_bp_disabled_arrow, icon_bp_disabled_stopped>>
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- {EB_SHARED_PIXMAP_FACTORY} Implementation

	pixmap_width: INTEGER is 12
		-- Width in pixels of generated factory image

	pixmap_height: INTEGER is 12
		-- Height in pixels of generated factory image

	image_matrix: EV_PIXMAP is
			-- Matrix pixmap containing all of the icons
		once
			Result := load_pixmap_from_repository ("icon_matrix_12")
		end

	pixmap_path: DIRECTORY_NAME is
			-- Path to cursor pixmaps
		once
			create Result.make_from_string (eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "bitmaps", "png">>)
		end

	pixmap_lookup_table: ES_PIXMAP_LOOKUP_TABLE is
			--
		once
			create Result.make_with_values (12, 1)
			Result.add_pixmap (1, 1, icon_bp_arrow_value)
			Result.add_pixmap (2, 1, icon_bp_slot_value)
			Result.add_pixmap (3, 1, icon_bp_enabled_value)
			Result.add_pixmap (4, 1, icon_bp_disabled_value)
			Result.add_pixmap (5, 1, icon_bp_slot_arrow_value)
			Result.add_pixmap (6, 1, icon_bp_enabled_arrow_value)
			Result.add_pixmap (7, 1, icon_bp_disabled_arrow_value)
			Result.add_pixmap (8, 1, icon_bp_slot_stopped_value)
			Result.add_pixmap (9, 1, icon_bp_enabled_stopped_value)
			Result.add_pixmap (10, 1, icon_bp_disabled_stopped_value)
			Result.add_pixmap (11, 1, icon_bp_enabled_condition_value)
			Result.add_pixmap (12, 1, icon_bp_disabled_condition_value)
		end

feature {NONE} -- Constants

	icon_bp_arrow_value,
	icon_bp_slot_value,
	icon_bp_enabled_value,
	icon_bp_disabled_value,
	icon_bp_slot_arrow_value,
	icon_bp_enabled_arrow_value,
	icon_bp_disabled_arrow_value,
	icon_bp_slot_stopped_value,
	icon_bp_enabled_stopped_value,
	icon_bp_disabled_stopped_value,
	icon_bp_enabled_condition_value,
	icon_bp_disabled_condition_value: INTEGER is unique;
		-- Constants used for pixmap table lookup.

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

end -- class EB_SHARED_PIXMAPS_12
