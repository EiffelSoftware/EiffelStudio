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

feature -- Pixmap Icons

	icon_bon_deferred: EV_PIXMAP is
			--
		once
			Result := pixmap_file_content ("icon_bon_deferred")
		ensure
			result_not_void: Result /= Void
		end

	icon_bon_effective: EV_PIXMAP is
			--
		once
			Result := pixmap_file_content ("icon_bon_effective")
		ensure
			result_not_void: Result /= Void
		end

	icon_bon_interfaced: EV_PIXMAP is
			--
		once
			Result := pixmap_file_content ("icon_bon_interfaced")
		ensure
			result_not_void: Result /= Void
		end

	icon_bon_persistent: EV_PIXMAP is
			--
		once
			Result := pixmap_file_content ("icon_bon_persistent")
		ensure
			result_not_void: Result /= Void
		end

	icon_close: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_close")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_delete: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_delete")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_down_triangle: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_down_triangle")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_edit_expression: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_edit_expression")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_expand_string: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_expand_string")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_maximize: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_maximize")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_minimize: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_minimize")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_mini_back: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_mini_back")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_mini_down: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_mini_down")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_mini_forth: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_mini_forth")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_mini_up: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_mini_up")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_new_class: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_new_class")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_new_cluster: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_new_cluster")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_new_expression: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_new_expression")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_new_feature: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_new_feature")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_new: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_new")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_nothing: EV_PIXMAP is
			--
		once
			Result := pixmap_file_content ("icon_nothing")
		ensure
			result_not_void: Result /= Void
		end

	icon_numeric_format: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_numeric_format")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_on_off: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_on_off")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_open_menu: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_open_menu")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_restore: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_restore")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_save_call_stack: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_save_call_stack")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_set_stack_depth: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_set_stack_depth")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_slice_limits: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_slice_limits")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_toggle_alias: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_toggle_alias")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_toggle_assigner: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_toggle_assigner")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_toggle_signature: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_toggle_signature")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_view: ARRAY [EV_PIXMAP] is
			--
		once
			Result := <<pixmap_file_content ("icon_view")>>
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon_dbg_error: EV_PIXMAP is
			--
		once
			Result := pixmap_file_content ("icon_dbg_error")
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
			Result := pixmap_file_content ("icon_matrix_8")
		end

	pixmap_path: DIRECTORY_NAME is
			-- Path to cursor pixmaps
		once
			create Result.make_from_string (eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "bitmaps", "png">>)
		end

	pixmap_lookup: HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING] is
			-- Lookup hash table for studio pixmaps
		once
			create Result.make (40)

			Result.put ([1, 1], "icon_close")
			Result.put ([1, 2], "icon_maximize")
			Result.put ([1, 3], "icon_restore")
			Result.put ([1, 4], "icon_minimize")
			Result.put ([1, 5], "icon_down_triangle")
			Result.put ([1, 6], "icon_new_feature")
			Result.put ([1, 7], "icon_toggle_signature")
			Result.put ([1, 8], "icon_toggle_assigner")
			Result.put ([1, 9], "icon_toggle_alias")
			Result.put ([1, 10], "icon_new")
			Result.put ([1, 11], "icon_mini_back")
			Result.put ([1, 12], "icon_mini_down")
			Result.put ([1, 13], "icon_mini_forth")
			Result.put ([1, 14], "icon_mini_up")
			Result.put ([1, 15], "icon_new_class")
			Result.put ([1, 16], "icon_view")

			Result.put ([2, 1], "icon_new_cluster")
			Result.put ([2, 2], "icon_numeric_format")
			Result.put ([2, 3], "icon_nothing")
			Result.put ([2, 4], "icon_dbg_error")
			Result.put ([2, 5], "icon_open_menu")
			Result.put ([2, 6], "icon_new_expression")
			Result.put ([2, 7], "icon_edit_expression")
			Result.put ([2, 8], "icon_on_off")
			Result.put ([2, 9], "icon_delete")
			Result.put ([2, 10], "icon_save_call_stack")
			Result.put ([2, 11], "icon_set_stack_depth")
			Result.put ([2, 12], "icon_slice_limits")
			Result.put ([2, 13], "icon_expand_string")
			Result.put ([2, 14], "icon_bon_persistent")
			Result.put ([2, 15], "icon_bon_interfaced")
			Result.put ([2, 16], "icon_bon_effective")

			Result.put ([3, 1], "icon_bon_deferred")
			Result.put ([3, 2], "bon_persistent")
			Result.put ([3, 3], "bon_interfaced")
			Result.put ([3, 4], "bon_effective")
			Result.put ([3, 5], "bon_deferred")

			Result.compare_objects
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

end -- class EB_SHARED_PIXMAPS_8
