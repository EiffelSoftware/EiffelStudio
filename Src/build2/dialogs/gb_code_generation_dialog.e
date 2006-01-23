indexing
	description	: "Dialog for output while generating code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_CODE_GENERATION_DIALOG

inherit
	EV_DIALOG

	EV_LAYOUT_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end

	GB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

create
	make_default,
	make_for_single_generation

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_default (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create current in default state and assign `a_components'
			-- to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create

				-- Create all widgets.
			create l_vertical_box_1
			create l_horizontal_box_1
			create l_cell_1
			create l_label_1
			create l_horizontal_box_2
			create generation_progress

				-- Build_widget_structure.
			extend (l_vertical_box_1)
			l_vertical_box_1.extend (l_horizontal_box_1)
			l_horizontal_box_1.extend (l_cell_1)
			l_horizontal_box_1.extend (l_label_1)
			l_vertical_box_1.extend (l_horizontal_box_2)
			l_horizontal_box_2.extend (generation_progress)

				-- Initialize properties of all widgets.

			set_minimum_width (250)
			disable_user_resize
			set_title ("Generation progress")
			l_vertical_box_1.disable_item_expand (l_horizontal_box_2)
			l_horizontal_box_1.disable_item_expand (l_cell_1)
			l_cell_1.set_minimum_width (10)
			l_label_1.set_text ("Generating...")
			l_label_1.align_text_left
			l_horizontal_box_2.set_border_width (10)
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_build_window @ 1)
			show_actions.extend (agent start_generation)
		ensure
			components_set: components = a_components
		end

	make_for_single_generation (an_object_name: STRING; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' for generation of the single window named `an_object_name'.
			-- Assign `a_components' to `components'.
		require
			an_object_name_not_void: an_object_name /= Void
			a_components_not_void: a_components /= Void
		do
			object_name := an_object_name
			make_default (components)
		ensure
			object_name_set: object_name = an_object_name
			components_set: components = a_components
		end

feature {GB_GENERATION_COMMAND} -- Basic operation

	show_completion is
			-- Display to user that completion has finished.
		do
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_build_window @ 1)
			generation_progress.set_proportion (1)
			components.status_bar.set_timed_status_text ("Generation successful - " + components.system_status.current_project_settings.actual_generation_location)
			destroy
		end

	start_generation is
			-- Begin generation and set generation
			-- output progress bar to `progress_bar'.
		local
			code_generator: GB_CODE_GENERATOR
		do
			create code_generator.make_with_components (components)
			code_generator.set_progress_bar (generation_progress)
			if object_name /= Void then
				code_generator.generate_single_window (object_name)
			else
				code_generator.generate
			end
			if code_generator.last_generation_successful then
				show_completion
			else
				destroy
			end
		end


feature {NONE} -- Implementation

	l_vertical_box_1: EV_VERTICAL_BOX
	l_horizontal_box_1, l_horizontal_box_2: EV_HORIZONTAL_BOX
	l_cell_1: EV_CELL
	l_label_1: EV_LABEL
	generation_progress: EV_HORIZONTAL_PROGRESS_BAR

	object_name: STRING;
		-- Name of single object to generate, or None if Void.

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


end -- class GB_CODE_GENERATION_DIALOG

