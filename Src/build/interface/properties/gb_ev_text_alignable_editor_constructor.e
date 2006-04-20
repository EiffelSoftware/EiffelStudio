indexing
	description: "Builds an attrribute editor for modification of objects of type EV_TEXT_ALIGNABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_TEXT_ALIGNABLE_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_TEXT_ALIGNABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_TEXT_ALIGNABLE"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do	
			create Result.make_with_components (components)
			Result.set_padding_width (object_editor_vertical_padding_width)
			initialize_attribute_editor (Result)
			create label.make_with_text (gb_ev_text_alignable)
			label.set_tooltip (gb_ev_text_alignable_tooltip)
			Result.extend (label)
			create combo_box
			combo_box.set_tooltip (gb_ev_text_alignable_tooltip)
			Result.extend (combo_box)
			combo_box.disable_edit
			create item_left.make_with_text (Ev_textable_left_string)
			combo_box.extend (item_left)
			create item_center.make_with_text (Ev_textable_center_string)
			combo_box.extend (item_center)
			create item_right.make_with_text (Ev_textable_right_string)
			combo_box.extend (item_right)
			combo_box.select_actions.extend (agent selection_changed)
			combo_box.select_actions.extend (agent update_editors)

			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		local
			alignment: INTEGER
		do
			combo_box.select_actions.block

			alignment := first.text_alignment
			inspect alignment
			when feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left then
				item_left.enable_select
			when feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center then
				item_center.enable_select
			when feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right then
				item_right.enable_select	
			else
				check
					error: False					
				end
			end
			combo_box.select_actions.resume
		end
		
feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			-- nothing_to_perform_here
		end

	selection_changed is
			-- Selection in `combo_box' changed.
		do
			if combo_box.selected_item.text.is_equal (Ev_textable_left_string) then
				for_all_objects (agent {EV_TEXT_ALIGNABLE}.align_text_left)
			elseif combo_box.selected_item.text.is_equal (Ev_textable_center_string) then
				for_all_objects (agent {EV_TEXT_ALIGNABLE}.align_text_center)
			elseif combo_box.selected_item.text.is_equal (Ev_textable_right_string) then
				for_all_objects (agent {EV_TEXT_ALIGNABLE}.align_text_right)
			else
				check
					Not_a_valid_alignment: False
				end
			end
		end

	item_left, item_center, item_right: EV_LIST_ITEM

	combo_box: EV_COMBO_BOX
		-- Holds current selection.
		
	label: EV_LABEL
		-- Identifies `combo_box'.
		
	text_entry: EV_TEXT_FIELD

	Text_string: STRING is "Text"
	Text_alignment_string: STRING is "Text_alignment"
	
	Ev_textable_left_string: STRING is "Left"
	Ev_textable_center_string: STRING is "Center"
	Ev_textable_right_string: STRING is "Right";

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


end -- class GB_EV_TEXT_ALIGNABLE_EDITOR_CONSTRUCTOR
