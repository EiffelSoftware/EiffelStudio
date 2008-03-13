indexing
	description: "XML display expanded viewer  ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_DISPLAY_VIEWER_BOX

inherit

	EB_OBJECT_VIEWER

	EV_SHARED_APPLICATION

	EB_CONSTANTS

	EB_SHARED_DEBUGGER_MANAGER

	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_PREFERENCES

	REFACTORING_HELPER

create
	make

feature {NONE} -- Implementation

	build_widget is
		local
			vb: EV_VERTICAL_BOX
			viewerborder: EV_VERTICAL_BOX
		do
			create vb
			widget := vb
			vb.set_border_width (layout_constants.dialog_unit_to_pixels (2))

				--| Viewer
			create viewerborder
			viewerborder.set_border_width (layout_constants.dialog_unit_to_pixels (1))
			viewerborder.set_background_color ((create {EV_STOCK_COLORS}).black)

			create viewer.make
			viewer.widget.set_minimum_height (100)
			viewer.drop_actions.extend (agent on_stone_dropped)
			viewer.drop_actions.set_veto_pebble_function (agent is_valid_stone)

			viewer.attach_to_container (viewerborder)
			vb.extend (viewerborder)

 			set_title (name)
		end

feature -- Access

	name: STRING_GENERAL is
		do
			Result := Interface_names.t_viewer_xml_display_title
		end

	widget: EV_WIDGET

	viewer: ES_GRID_XML_VIEWER

feature -- Access

	is_valid_stone (a_stone: ANY; is_strict: BOOLEAN): BOOLEAN is
			-- Is `st' valid stone for Current?
		local
			dv: DUMP_VALUE
			s: STRING
		do
			if {st: OBJECT_STONE} a_stone then
				dv := debugger_manager.dump_value_factory.new_object_value (st.object_address, st.dynamic_class)
				if dv.has_formatted_output then
					if is_strict then
						s := dv.formatted_truncated_string_representation (0, 10)
						Result := begin_with (s, "<?xml", True)
					else
						Result := True
					end
				end
			end
		end

feature -- Change

	refresh is
			-- Recompute the displayed text.
		local
			l_trunc_str: STRING_32
		do
			clear
			if
				Debugger_manager.application_is_executing
				and then Debugger_manager.application_is_stopped
			then
				if has_object then
					retrieve_dump_value
					if current_dump_value /= Void then
						l_trunc_str := current_dump_value.formatted_truncated_string_representation (0, -1)
						viewer.load_xml_string (l_trunc_str)
					end
				end
			end
		end

	destroy is
			-- Destroy Current
		do
			reset
			if widget /= Void then
				widget.destroy
				widget := Void
			end
		end

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
		do
			Result := True
		end

	parent_window (w: EV_WIDGET): EV_WINDOW is
		local
			p: EV_WIDGET
		do
			p := w.parent
			if p /= Void then
				Result ?= p
				if Result = Void then
					Result := parent_window (p)
				end
			end
		end

	clear is
			-- Clean current data, useless if dialog closed or destroyed
		do
			viewer.clear
		end

feature {NONE} -- Event handling

	on_stone_dropped (st: OBJECT_STONE) is
			-- A stone was dropped in the editor. Handle it.
		do
			set_stone (st)
		end

	close_action is
			-- Close dialog
		do
			destroy
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

end
