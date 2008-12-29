note
	description:
		"Cursors used in the interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision: "

class
	EB_SHARED_CURSORS

feature -- Accepting cursor shapes

	frozen cur_class: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_class_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_class_list: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_classes_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_favorites_folder: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_favorite_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_object: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_debug_object_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_setstop: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_debugger_step_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_interro: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_help_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_feature: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_feature_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_cluster: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_cluster_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_inherit_link: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_inherit_link_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_client_link: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_client_link_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_metric: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_metric_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_criteria: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_criteria_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_target: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_target_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_library: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_library_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_assembly: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_assembly_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_metric_generic: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.metrics_generic_cursor, 16, 16)
		end

	frozen cur_metric_line: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.metrics_line_cursor, 16, 16)
		end

	frozen cur_metric_feature: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.metrics_feature_cursor, 16, 16)
		end

	frozen cur_metric_local: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.metrics_local_cursor, 16, 16)
		end

	frozen cur_metric_assertion: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.metrics_assertion_cursor, 16, 16)
		end

feature -- Non-Accepting cursor shapes

	frozen cur_x_class: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_disabled_class_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_class_list: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_disabled_classes_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_favorites_folder: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_disabled_favorite_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_object: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_disabled_debug_object_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_setstop: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_disabled_debugger_step_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_interro: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_disabled_help_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_feature: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_disabled_feature_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_cluster: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_disabled_cluster_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_inherit_link: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_disabled_inherit_link_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_client_link: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_disabled_client_link_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_metric: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_disabled_metric_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_criteria: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_disabled_criteria_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_target: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_disabled_target_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_library: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_disabled_library_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_assembly: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.context_disabled_assembly_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_metric_generic: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.metrics_disabled_generic_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_metric_feature: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.metrics_disabled_feature_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_metric_line: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.metrics_disabled_line_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_metric_local: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.metrics_disabled_local_cursor_cursor_buffer, 16, 16)
		end

	frozen cur_x_metric_assertion: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.metrics_disabled_assertion_cursor_cursor_buffer, 16, 16)
		end

feature -- Other cursor

	frozen cur_cut_selection: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.cursor_move_cursor_cursor_buffer, 0, 0)
		end

	frozen cur_copy_selection: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.cursor_copy_cursor_cursor_buffer, 0, 0)
		end

	frozen open_hand_cursor: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.cursor_hand_open_cursor_cursor_buffer, 16, 16)
		end

	frozen closed_hand_cursor: EV_POINTER_STYLE
		once
			create Result.make_with_pixel_buffer (icon_cursors.cursor_hand_clasped_cursor_cursor_buffer, 16, 16)
		end

feature {NONE} -- Implementation

	frozen icon_cursors: ES_PIXMAPS_CURSORS
			-- Access to pixmaps cursors
		once
			create Result.make ("cursors.png")
		ensure
			result_attached: Result /= Void
		end

note
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

end -- class EB_SHARED_CURSORS
