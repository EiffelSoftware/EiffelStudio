note
	description	: "All shared attributes specific to a development window during a session"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_SESSION_DATA

inherit
	EB_DEVELOPMENT_WINDOW_DATA

	ES_TOOLBAR_PREFERENCE

	SESSION_DATA_I

create
	make_from_window_data

feature {NONE} -- Creation

	make_from_window_data (a_window_data: EB_DEVELOPMENT_WINDOW_DATA)
			-- Make `Current' using window data `a_window_data'.
		require
			a_window_data_not_void: a_window_data /= Void
		do
			save_window_state (a_window_data.is_minimized, a_window_data.is_maximized)
			save_size (a_window_data.width, a_window_data.height)
			save_position (a_window_data.x_position, a_window_data.y_position)
			save_maximized_position (a_window_data.maximized_x_position, a_window_data.maximized_y_position)
		end

feature {EB_DEVELOPMENT_WINDOW, EB_DEVELOPMENT_WINDOW_DIRECTOR} -- Access

	current_target: STRING
			-- Class or group the development window is currently targeting.
			-- We save the ID of a class or a cluster.

	current_target_type: BOOLEAN
			-- Class if False, otherwise a group

	open_classes: HASH_TABLE [STRING, STRING]
			-- Open classes
			-- 1st parametar is class name
			-- 2nd parameter is docking content unique name

	open_clusters: HASH_TABLE [STRING, STRING]
			-- Open clusters
			-- 1st parametar is cluster name
			-- 2nd parameter is docking content unique name			

	feature_relation_feature_id: STRING
			-- ID of the feature targeted in Feature relation tool.

	class_class_id: STRING
			-- ID of the class targeted in Class tool.

	context_tab_index: INTEGER
			-- Index of the selected tab in the context pane.

	editor_position: INTEGER
			-- Position that editor was set to if any.

	show_formatter_marks: BOOLEAN
			-- Show formatter marks?

feature {EB_DEVELOPMENT_WINDOW} -- Element change

	save_current_target (a_current_target: like current_target; a_type: BOOLEAN)
			-- Save the object that the window is currently targeting.
		do
			if a_current_target /= Void then
				current_target := a_current_target.twin
			else
				current_target := Void
			end
			current_target_type := a_type
		ensure
			current_target_cloned: a_current_target /= Void implies
									(current_target /= a_current_target and then
									current_target.is_equal (a_current_target))
			type_set: current_target_type = a_type
		end

	save_open_classes (a_open_classes: like open_classes)
			-- Save Open classes
		require
			a_open_classes_not_void: a_open_classes /= Void
		do
			open_classes := a_open_classes
		ensure
			open_classes_not_void: open_classes /= Void
		end

	save_open_clusters (a_open_clusters: like open_clusters)
			-- Save open clusters
		require
			a_open_clusters_not_void: a_open_clusters /= Void
		do
			open_clusters := a_open_clusters
		ensure
			open_clusters_not_void: open_clusters /= Void
		end

	save_formatting_marks (a_show_formatter_marks: like show_formatter_marks)
			-- Save formatter marks
		do
			show_formatter_marks := a_show_formatter_marks
		ensure
			show_formatter_marks_set: show_formatter_marks = a_show_formatter_marks
		end

	save_context_data (a_class_id, a_feature_id: STRING; a_tab_index: INTEGER)
			-- Save the context information of the window.
			-- Feature in feature relation tool.
			-- Class in class tool. There is no need to save classes targeted in other tools
			-- Because the class is propagated when setting.
		do
			class_class_id := a_class_id
			feature_relation_feature_id := a_feature_id
			context_tab_index := a_tab_index
		ensure
			class_class_id_set: class_class_id = a_class_id
			feature_relation_feature_id_set: feature_relation_feature_id = a_feature_id
		end

	save_editor_position (a_position: INTEGER)
			-- Save the position that editor cursor is currently on.
		require
			a_position_valid: a_position > 0
		do
			editor_position := a_position
		ensure
			editor_position_set: editor_position = a_position
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_DEVELOPMENT_WINDOW_DATA
