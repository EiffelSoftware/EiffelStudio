indexing
	description: "Representation of a class in the cluster tree."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASSES_TREE_CLASS_ITEM

inherit
	EB_CLASSES_TREE_ITEM
		redefine
			data,
			set_data
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		undefine
			default_create, is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: CLASS_I) is
			-- Create a tree item representing class `a_class'.
		do
			default_create
			set_data (a_class)
		end

feature -- Status report

	data: CLASS_I
			-- Class represented by `Current'.

	stone: CLASSI_STONE is
			-- Class stone representing `Current', can be a classi_stone or a classc_stone.
		do
			if data.compiled then
				create {CLASSC_STONE} Result.make (data.compiled_class)
			else
				create {CLASSI_STONE} Result.make (data)
			end
		end

feature -- Status setting

	set_data (a_class: CLASS_I) is
			-- Change the associated class to `a_class'.
		local
			name: STRING
		do
			name := a_class.name_in_upper
			set_text (name)
			data := a_class
			set_pebble_function (agent stone)
			drop_actions.wipe_out
			drop_actions.set_veto_pebble_function (agent droppable)
			set_accept_cursor (Cursors.cur_Class)
			set_deny_cursor (Cursors.cur_X_Class)
			set_tooltip (name)
			set_pixmap (pixmap_from_class_i (a_class))
		end

	set_associated_textable (textable: EV_TEXT_COMPONENT) is
			-- Associate `Current' with `textable' and change event handling.
		require
			textable /= Void
		do
			associated_textable := textable
			select_actions.wipe_out
			select_actions.extend (agent print_name)
		end

	set_associated_window (window: like associated_window) is
			-- Associate `Current' with `window' and change event handling.
		require
			window /= Void
		do
			if associated_window = Void then
				pointer_button_press_actions.extend (agent double_press_action)
			end
			associated_window := window
		end

	add_double_click_action (p: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]) is
			-- Add a double click action `p' on `Current'.
		do
			pointer_double_press_actions.extend (p)
		end

feature {NONE} -- Implementation

	cluster_contains_class (f: CONF_GROUP): BOOLEAN is
			-- Does `f' recursively contains `data'?
		require
			f_not_void: f /= Void
		do
			Result := f = data.group
		end

	double_press_action (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER
						 a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE
						 a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Send a stone corresponding to `Current' to `associated_window'.
		do
			if a_button = 1 and then associated_window /= Void then
				associated_window.set_stone (stone)
			end
		end

	droppable (a_pebble: ANY): BOOLEAN is
			-- Can user drop `a_pebble' on `Current'?
		local
			conv_folder: CLUSTER_STONE
			conv_st: CLASSI_STONE
			fs: FEATURE_STONE
			fparent: EB_CLASSES_TREE_FOLDER_ITEM
		do
				-- we can only drop things on clusters
			fparent ?= parent
			if fparent /= Void and then fparent.data.is_cluster then
				conv_folder ?= a_pebble
				if conv_folder /= Void then
					Result := not cluster_contains_class (conv_folder.group)
				else
					conv_st ?= a_pebble
					fs ?= a_pebble

					Result :=
							-- We have a class stone...
						conv_st /= Void and then
							-- ...from a different cluster...
						conv_st.class_i.group /= data.group and then
							-- ...and that is not a feature.
						fs = Void
				end
			end
		end

	associated_textable: EV_TEXT_COMPONENT
			-- Text component in which `Current' writes its name when clicked on.

	associated_window: EB_STONABLE
			-- Is `Current' already associated to a window?

	print_name is
			-- Print class name in textable, the associated text component.
		do
			if associated_textable /= Void then
				associated_textable.set_text (data.name_in_upper)
			end
		end

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

end -- class EB_CLASSES_TREE_CLASS_ITEM
