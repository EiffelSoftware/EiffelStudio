note
	description: "Objects that represent windows in a GB_WIDGET_SELECTOR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_WIDGET_SELECTOR_ITEM

inherit
	GB_WIDGET_SELECTOR_COMMON_ITEM
		redefine
			destroy
		end

	GB_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_object

feature {NONE} -- Initialization

	make_with_object (an_object: GB_OBJECT; a_components: GB_INTERNAL_COMPONENTS)
			-- Create `Current' and associate with `an_object'.
		require
			object_not_void: an_object /= Void
			a_components_not_void: a_components /= Void
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			components := a_components
			common_make
			object := an_object

				-- Ensure that `Current' graphically reflects `an_object'.
			update_to_reflect_name_change

				-- Assign the appropriate pixmap.
			create pixmaps
			tree_item.set_pixmap (pixmaps.pixmap_by_name (an_object.type.as_lower))

				-- Set a pebble for transport
			tree_item.set_pebble_function (agent retrieve_pebble)

				-- Make `Current' available from `an_object'.
			an_object.set_widget_selector_item (Current)
			tree_item.select_actions.extend (agent (components.tools.widget_selector).selected_window_changed (Current))
			tree_item.drop_actions.extend (agent object.handle_object_drop)
			tree_item.drop_actions.set_veto_pebble_function (agent object.can_add_child)
		ensure
			object_set: object = an_object
			components_set: components = a_components
		end

feature -- Access

	object: GB_OBJECT
			-- Object referenced by `Current'
			-- Note that it is safe to keep a reference to `object' here and not an id reference
			-- as used elsewhere by a system, as `Current' is part of an object and therefore the
			-- object is responsible for ensuring that the references are correct.

	is_destroyed: BOOLEAN
		-- Is `Current' destroyed?

	file_exists: BOOLEAN
			-- Does the interface file corresponding to `object' currently exist on disk?
		local
			directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			path: ARRAYED_LIST [STRING]
			file_name: PATH
			file: RAW_FILE
		do
			directory ?= parent
			if directory /= Void then
				path := directory.path
				create file_name.make_from_string (components.system_status.current_project_settings.actual_generation_location)
				from
					path.start
				until
					path.off
				loop
					file_name := file_name.extended (path.item)
					path.forth
				end
				file_name := file_name.extended (object.name + ".e")
				create file.make_with_path (file_name)
				Result := file.exists
			else
					-- In this case, we are not contained in a sub-directory so simply take the root location.
				create file_name.make_from_string (components.system_status.current_project_settings.project_location)
				file_name := file_name.extended (object.name + ".e")
				create file.make_with_path (file_name)
				Result := file.exists
			end
		end


feature -- Status setting

	update_to_reflect_name_change
			-- Update `Current' to reflect a name change of `object'.
		do
			tree_item.set_text (object.name.as_upper)
		end

feature --{NONE} -- Implementation

	retrieve_pebble: ANY
			-- Retrieve pebble for transport.
			-- A convenient was of setting up the drop
			-- actions for GB_OBJECT.
		do
				-- If the ctrl key is pressed, then we must
				-- start a new object editor for `Current', instead
				-- of beginning the pick and drop.
			if application.ctrl_pressed then
				components.object_editors.new_object_editor (object)
			else
				Result := create {GB_STANDARD_OBJECT_STONE}.make_with_object (object)
			end
		end

feature {GB_OBJECT} -- Implementation

	set_object (an_object: GB_OBJECT)
			-- Assign `an_object' to `object'
		require
			an_object_not_void: an_object /= Void
		do
			object := an_object
		ensure
			object_set: object = an_object
		end

	destroy
			-- Destroy `Current'.
		do
			is_destroyed := True
			object := Void
			Precursor {GB_WIDGET_SELECTOR_COMMON_ITEM}
		end

invariant
	object_not_void: not is_destroyed implies object /= Void

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


end -- class GB_WIFGET_SELECTOR_ITEM
