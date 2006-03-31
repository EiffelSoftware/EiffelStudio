indexing
	description: "8x8 matrix pixmap for EiffelStudio user interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_PIXMAPS_8

inherit
	EB_SHARED_PIXMAP_FACTORY

	EIFFEL_ENV
		export
			{NONE} all
		end

	EB_SHARED_PIXMAP_FACTORY
		export
			{NONE} all
		redefine
			pixmap_lookup_table
		end

feature -- Pixmap Icons

	icon_bon_deferred: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_bon_deferred_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_bon_effective: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_bon_effective_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_bon_interfaced: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_bon_interfaced_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_bon_persistent: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_bon_persistent_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_close: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_close_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_delete: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_delete_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_down_triangle: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_down_triangle_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_edit_expression: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_edit_expression_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_expand_string: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_expand_string_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_maximize: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_maximize_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_minimize: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_minimize_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_mini_back: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_mini_back_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_mini_down: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_mini_down_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_mini_forth: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_mini_forth_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_mini_up: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_mini_up_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_new_class: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_new_class_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_new_cluster: EV_PIXMAP is
		once
			Result := pixmap_from_constant (icon_new_cluster_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_new_expression: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_new_expression_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_new_feature: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_new_feature_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_new: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_new_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_nothing: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_nothing_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_numeric_format: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_numeric_format_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_on_off: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_on_off_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_open_menu: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_open_menu_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_restore: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_restore_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_save_call_stack: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_save_call_stack_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_set_stack_depth: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_set_stack_depth_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_slice_limits: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_slice_limits_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_toggle_alias: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_toggle_alias_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_toggle_assigner: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_toggle_assigner_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_toggle_signature: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_toggle_signature_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_view: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_view_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_dbg_error: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (icon_dbg_error_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_small_cross: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (small_close_cross_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_unpined: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (unpined_value)
		ensure
			result_not_void: Result /= Void
		end

	icon_pined: EV_PIXMAP is
			--
		once
			Result := pixmap_from_constant (pined_value)
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- {EB_SHARED_PIXMAP_FACTORY} Implementation

	pixmap_width: INTEGER is 8
		-- Width in pixels of generated factory image

	pixmap_height: INTEGER is 8
		-- Height in pixels of generated factory image

	image_matrix: EV_PIXMAP is
			-- Matrix pixmap containing all of the screen cursors
		once
			Result := load_pixmap_from_repository ("icon_matrix_8")
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
			create Result.make_with_values (16, 3)
			Result.add_pixmap (1, 1, icon_close_value)
			Result.add_pixmap (2, 2, icon_numeric_format_value)
			Result.add_pixmap (2, 1, icon_maximize_value)
			Result.add_pixmap (3, 1, icon_restore_value)
			Result.add_pixmap (4, 1, icon_minimize_value)
			Result.add_pixmap (5, 1, icon_down_triangle_value)
			Result.add_pixmap (6, 1, icon_new_feature_value)
			Result.add_pixmap (7, 1, icon_toggle_signature_value)
			Result.add_pixmap (8, 1, icon_toggle_assigner_value)
			Result.add_pixmap (9, 1, icon_toggle_alias_value)
			Result.add_pixmap (10, 1, icon_new_value)
			Result.add_pixmap (11, 1, icon_mini_back_value)
			Result.add_pixmap (12, 1, icon_mini_down_value)
			Result.add_pixmap (13, 1, icon_mini_forth_value)
			Result.add_pixmap (14, 1, icon_mini_up_value)
			Result.add_pixmap (15, 1, icon_new_class_value)
			Result.add_pixmap (16, 1, icon_view_value)
			Result.add_pixmap (1, 2, icon_new_cluster_value)
			Result.add_pixmap (2, 2, icon_numeric_format_value)
			Result.add_pixmap (3, 2, icon_nothing_value)
			Result.add_pixmap (4, 2, icon_dbg_error_value)
			Result.add_pixmap (5, 2, icon_open_menu_value)
			Result.add_pixmap (6, 2, icon_new_expression_value)
			Result.add_pixmap (7, 2, icon_edit_expression_value)
			Result.add_pixmap (8, 2, icon_on_off_value)
			Result.add_pixmap (9, 2, icon_delete_value)
			Result.add_pixmap (10, 2, icon_save_call_stack_value)
			Result.add_pixmap (11, 2, icon_set_stack_depth_value)
			Result.add_pixmap (12, 2, icon_slice_limits_value)
			Result.add_pixmap (13, 2, icon_expand_string_value)
			Result.add_pixmap (14, 2, icon_bon_persistent_value)
			Result.add_pixmap (15, 2, icon_bon_interfaced_value)
			Result.add_pixmap (16, 2, icon_bon_effective_value)
			Result.add_pixmap (1, 3, icon_bon_deferred_value)
			Result.add_pixmap (2, 3, bon_persistent_value)
			Result.add_pixmap (3, 3, bon_interfaced_value)
			Result.add_pixmap (4, 3, bon_effective_value)
			Result.add_pixmap (5, 3, bon_deferred_value)
			Result.add_pixmap (6, 3, small_close_cross_value)
			Result.add_pixmap (7, 3, unpined_value)
			Result.add_pixmap (8, 3, pined_value)
		end

feature {NONE} -- Constants

	icon_close_value,
	icon_maximize_value,
	icon_restore_value,
	icon_minimize_value,
	icon_down_triangle_value,
	icon_new_feature_value,
	icon_toggle_signature_value,
	icon_toggle_assigner_value,
	icon_toggle_alias_value,
	icon_new_value,
	icon_mini_back_value,
	icon_mini_down_value,
	icon_mini_forth_value,
	icon_mini_up_value,
	icon_new_class_value,
	icon_view_value,
	icon_new_cluster_value,
	icon_numeric_format_value,
	icon_nothing_value,
	icon_dbg_error_value,
	icon_open_menu_value,
	icon_new_expression_value,
	icon_edit_expression_value,
	icon_on_off_value,
	icon_delete_value,
	icon_save_call_stack_value,
	icon_set_stack_depth_value,
	icon_slice_limits_value,
	icon_expand_string_value,
	icon_bon_persistent_value,
	icon_bon_interfaced_value,
	icon_bon_effective_value,
	icon_bon_deferred_value,
	bon_persistent_value,
	bon_interfaced_value,
	bon_effective_value,
	bon_deferred_value,
	small_close_cross_value,
	unpined_value,
	pined_value: INTEGER is unique;
		-- Constants used for pixmap lookup.

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

end -- class EB_SHARED_PIXMAPS_8
