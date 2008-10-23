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
			set_data,
			print_name,
			internal_recycle
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: CLASS_I; a_name: STRING) is
			-- Create a tree item representing class `a_class' with `a_name' in its context.
		require
			a_class_ok: a_class /= Void and then a_class.is_valid
			a_name_ok: a_name /= Void
		do
			default_create
			name := a_name
			set_data (a_class)
		ensure
			name_set: name = a_name
			data_set: data = a_class
		end

feature -- Status report

	data: CLASS_I
			-- Class represented by `Current'.

	name: STRING
			-- Renamed name in the context of this item in the classes tree.

	stone: CLASSI_STONE is
			-- Class stone representing `Current', can be a classi_stone or a classc_stone.
		local
			l_classc: CLASS_C
		do
			l_classc := data.compiled_representation
			if l_classc /= Void then
				create {CLASSC_STONE} Result.make (l_classc)
			else
				create {CLASSI_STONE} Result.make (data)
			end
		end

feature -- Status setting

	set_data (a_class: CLASS_I) is
			-- Change the associated class to `a_class'.
		do
			set_text (name)
			data := a_class
			set_pebble (stone)
			drop_actions.wipe_out
			drop_actions.set_veto_pebble_function (agent droppable)
			set_accept_cursor (Cursors.cur_Class)
			set_deny_cursor (Cursors.cur_X_Class)
			set_tooltip (name)
			set_pixmap (pixmap_from_class_i (a_class))
			set_configurable_target_menu_mode
			set_configurable_target_menu_handler (agent context_menu_handler)
		end

	load_overriden_children is
			-- Add classes this class overrides or the class that overrides this class as children.
			-- (needs to be called after the class has been completely set up)
		local
			conf_class: CONF_CLASS
			overs: ARRAYED_LIST [CONF_CLASS]
			over_item: EB_CLASSES_TREE_CLASS_ITEM
			class_i: CLASS_I
		do
			conf_class := data.config_class
			if conf_class.does_override then
				from
					overs := conf_class.overrides
					overs.start
				until
					overs.after
				loop
					class_i ?= overs.item
					check
						class_i: class_i /= Void
					end
					if class_i.is_valid then
						create over_item.make (class_i, class_i.name)
						over_item.associate_with_window (associated_window)
						if associated_textable /= Void then
							over_item.set_associated_textable (associated_textable)
						end

						from
							pointer_double_press_actions.start
						until
							pointer_double_press_actions.after
						loop
							over_item.add_double_click_action (pointer_double_press_actions.item)
							pointer_double_press_actions.forth
						end

						extend (over_item)
					end
					overs.forth
				end
			elseif conf_class.is_overriden then
				class_i ?= conf_class.overriden_by
				check
					class_i: class_i /= Void
				end
				if class_i.is_valid then
					create over_item.make (class_i, class_i.name)
					over_item.associate_with_window (associated_window)
					if associated_textable /= Void then
						over_item.set_associated_textable (associated_textable)
					end

					from
						pointer_double_press_actions.start
					until
						pointer_double_press_actions.after
					loop
						over_item.add_double_click_action (pointer_double_press_actions.item)
						pointer_double_press_actions.forth
					end
					extend (over_item)
				end
			end
		end

	add_double_click_action (p: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]) is
			-- Add a double click action `p' on `Current'.
		do
			pointer_double_press_actions.extend (p)
		end

feature {NONE} -- Recycle

	internal_recycle is
			-- Recycle
		do
			Precursor {EB_CLASSES_TREE_ITEM}
			associated_window := Void
		end

feature {NONE} -- Implementation

	cluster_contains_class (f: CONF_GROUP): BOOLEAN is
			-- Does `f' recursively contains `data'?
		require
			f_not_void: f /= Void
		do
			Result := f = data.group
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

	print_name is
			-- Print class name in textable, the associated text component.
		do
			if associated_textable /= Void then
				associated_textable.set_data (data)
				associated_textable.set_text (data.name)
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
