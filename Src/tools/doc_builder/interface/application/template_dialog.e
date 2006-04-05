indexing
	description: "Dialog for creating new documents from pre-defined templates."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_DIALOG

inherit
	TEMPLATE_DIALOG_IMP
		redefine
			show_modal_to_window
		end
	
	SHARED_OBJECTS
		undefine
			copy,
			default_create
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			empty_file.pointer_button_press_actions.force_extend (agent highlight_label (empty_val, empty_label))			
			sample.pointer_button_press_actions.force_extend (agent highlight_label (sample_val, sample_label))			
			project.pointer_button_press_actions.force_extend (agent highlight_label (project_val, project_label))
			ok_button.select_actions.extend (agent load_new_item)
			cancel_button.select_actions.extend (agent hide)
			label_selected := empty_label
		end

feature -- Display

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show
		do
			if shared_project.is_valid then
				empty_label.enable_sensitive
				empty_file.enable_sensitive
				sample_label.enable_sensitive
				sample.enable_sensitive
			else
				empty_label.disable_sensitive
				empty_file.disable_sensitive
				sample_label.disable_sensitive
				sample.disable_sensitive
			end	
			precursor (a_window)
		end		

feature {NONE} -- Implementation

	highlight_label (label_id: INTEGER; a_label: EV_LABEL) is
			-- Highlight label
		do
			label_selected.set_background_color (create {EV_COLOR}.make_with_rgb (1.0, 1.0, 1.0))
			label_selected := a_label
			label_number := label_id
			label_selected.set_background_color (selection_color)
			set_item_description
		end
		
	set_item_description is
			-- Set description for selected template			
		do
			inspect label_number
			when empty_val then
				create empty_tmp
				template_description.set_text (empty_tmp.description)
			when sample_val then
				create sample_tmp
				template_description.set_text (sample_tmp.description)			
			when project_val then
				create project_tmp
				template_description.set_text (project_tmp.description)
			end
		end		
		
	load_new_item is
			-- Load new chosen item
		local
			l_document: DOCUMENT
		do			
			inspect label_number
			when empty_val then
				shared_document_manager.create_document
				l_document := Shared_document_manager.current_document
				l_document.set_text (empty_tmp.content)
			when sample_val then
				shared_document_manager.create_document
				l_document := Shared_document_manager.current_document
				l_document.set_text (sample_tmp.content)		
			when project_val then
				Shared_project.create_new
			end
			hide
		end

	empty_tmp: EMPTY_TEMPLATE
	project_tmp: PROJECT_TEMPLATE
	sample_tmp: SAMPLE_TEMPLATE
			-- Templates

	label_selected: EV_LABEL
			-- Currently selected label

	label_number: INTEGER
			-- Selected label id number

	selection_color: EV_COLOR is
			-- Selection Color
		once
			create Result.make_with_rgb (0.1, 0.3, 0.5)
		end

	empty_val: INTEGER is unique
	sample_val: INTEGER is unique
	project_val: INTEGER is unique;
			-- Label number constants
	
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
end -- class TEMPLATE_DIALOG

