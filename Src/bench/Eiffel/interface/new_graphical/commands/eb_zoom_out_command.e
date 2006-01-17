indexing
	description: "Command to reduce the diagram"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ZOOM_OUT_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			initialize
		end

create
	make
	
feature {NONE} -- Initialization
		
	initialize is
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (key_constants.key_numpad_subtract),
				False, False, False)
			accelerator.actions.extend (agent execute)
		end

feature -- Basic operations

	execute is
			-- Perform operation.
		local
			l_world: EIFFEL_WORLD
			new_scale_factor, l_scale_factor: DOUBLE
			l_zoom_selector: EB_ZOOM_SELECTOR
			new_scale, old_scale: INTEGER
			l_projector: EIFFEL_PROJECTOR
		do
			if is_sensitive then
				l_world := tool.world
				l_scale_factor := l_world.scale_factor
				new_scale_factor := (0.1 - l_scale_factor) / -l_scale_factor
				if l_world.scale_factor * new_scale_factor > 0.1 then
					old_scale := (l_world.scale_factor * 100).rounded
					l_world.scale (new_scale_factor)
					tool.crop_diagram
					l_projector := tool.projector
					l_projector.full_project
					new_scale := (l_world.scale_factor * 100).rounded
					l_zoom_selector := tool.zoom_selector
					l_zoom_selector.show_as_text (new_scale)
					history.register_named_undoable (
							Interface_names.t_Diagram_zoom_out_cmd,
							[<<agent l_world.scale (new_scale_factor), agent tool.crop_diagram, agent l_zoom_selector.show_as_text (new_scale), agent l_projector.full_project>>],
							[<<agent l_world.scale (1/new_scale_factor), agent tool.crop_diagram, agent l_zoom_selector.show_as_text (old_scale), agent l_projector.full_project>>])
				end
			end
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_zoom_out
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_zoom_out
		end

	name: STRING is "Zoom_out";
			-- Name of the command. Used to store the command in the
			-- preferences.

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

end -- class EB_ZOOM_OUT_COMMAND
