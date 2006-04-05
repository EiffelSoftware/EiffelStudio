indexing
	description: "Dialog displaying extended information concerning an object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRETTY_PRINT_DIALOG_OLD

inherit
	EB_CONSTANTS

	SHARED_APPLICATION_EXECUTION

create {EB_PRETTY_PRINT_CMD}
	make

feature {NONE} -- Initialization

	make (cmd: EB_PRETTY_PRINT_CMD) is
			-- Initialize `Current'.
		require
			cmd_not_void: cmd /= Void
		local
			hb: EV_HORIZONTAL_BOX
			exit_button: EV_BUTTON
			vb: EV_VERTICAL_BOX
			f: EV_FRAME
		do
			parent := cmd
			
				-- Create `slice_cmd'.
			create slice_cmd.make_for_pretty_print (Current)
			
				-- Building the dialog.
			create dialog
			dialog.set_title (Interface_names.t_Enhanced_display)
			dialog.set_icon_pixmap (Pixmaps.Icon_pretty_print)
				--| FIXME XR: Implement the save to file.
			create exit_button.make_with_text (Interface_names.b_Close)
			exit_button.select_actions.extend (agent destroy)
			create slice_button.make_with_text (Interface_names.b_Slice)
			slice_button.select_actions.extend (agent slice_cmd.execute)
			slice_button.disable_sensitive
			
				-- Setting up the editor.
			create editor.make
			
			create f
			create vb
			create hb
			f.set_minimum_size (400, 200)
			f.extend (editor.widget)
			vb.extend (f)
			vb.set_padding (Layout_constants.Small_padding_size)
			vb.set_border_width (Layout_constants.Small_border_size)
			hb.set_padding (Layout_constants.Small_padding_size)
			Layout_constants.set_default_size_for_button (exit_button)
			Layout_constants.set_default_size_for_button (slice_button)
			hb.extend (create {EV_CELL})
			hb.extend (slice_button)
			hb.disable_item_expand (slice_button)
			hb.extend (exit_button)
			hb.disable_item_expand (exit_button)
			hb.extend (create {EV_CELL})
			vb.extend (hb)
			vb.disable_item_expand (hb)
			dialog.extend (vb)
			dialog.set_default_cancel_button (exit_button)
			dialog.set_default_push_button (slice_button)
			editor.drop_actions.extend (agent on_stone_dropped)
			editor.drop_actions.set_veto_pebble_function (agent is_stone_valid)
		end

feature -- Status report

	is_destroyed: BOOLEAN is
			-- Is `dialog' destroyed?
		do
			Result := dialog = Void
		end

	has_object: BOOLEAN is
			-- Has an object been assigned to current?
		do
			Result := current_object /= Void
		end
		
	current_object: OBJECT_STONE
			-- Object `Current' is displaying.

	dialog: EV_DIALOG
			-- Dialog where `editor' is displayed.

	is_stone_valid (st: OBJECT_STONE): BOOLEAN is
			-- Is `st' valid stone for Current?
		do
			Result := st /= Void and then parent.accepts_stone (st)
		end
		
feature -- Status setting

	raise is
			-- Display `dialog' and put it in front.
		do
			dialog.show_relative_to_window (parent.associated_window)
		end

	set_stone (st: OBJECT_STONE) is
			-- Give a new object to `Current' and refresh the display.
		require
			stone_valid: is_stone_valid (st)
		local
			l_tree_item: EV_TREE_ITEM
			l_dv: ABSTRACT_DEBUG_VALUE
		do
			if Application.is_dotnet then
				--| FIXME: JFIAT
				l_tree_item := st.tree_item
				if l_tree_item /= Void then
					l_dv ?= l_tree_item.data
					if l_dv /= Void then
						Application.imp_dotnet.keep_object (l_dv)
					end
				end		
			end
			current_object := st
			parent.tool.debugger_manager.kept_objects.extend (st.object_address)
			slice_cmd.enable_sensitive
			slice_button.enable_sensitive
			refresh
		end

	refresh is
			-- Recompute the displayed text.
		local
			dmp: DUMP_VALUE
			l_dlg: EV_WARNING_DIALOG
			dv: ABSTRACT_DEBUG_VALUE
		do
			if Application.status.is_stopped then
				if has_object then
					if Application.is_dotnet then
						dv := Application.imp_dotnet.kept_object_item (current_object.object_address)
						if dv /= Void then
							dmp := dv.dump_value
						end
						--| FIXME: JFIAT
					else
						create dmp.make_object (current_object.object_address, current_object.dynamic_class)
					end
					if dmp /= Void then
						editor.load_basic_text (
							dmp.string_representation (slice_cmd.slice_min, slice_cmd.slice_max)
						)
					else
						editor.clear_window						
						create l_dlg.make_with_text ("Sorry a problem occured, %Nwe are not able to show you the value ...%N")
						l_dlg.show_modal_to_window (dialog)						
					end
				else
					editor.clear_window
				end
			else
				editor.clear_window
			end
		end

	destroy is
			-- Destroy the actual dialog and forget about `Current'.
		require
			not is_destroyed
		do
			dialog.destroy
			dialog := Void
			parent.remove_dialog (Current)
		ensure
			destroyed: is_destroyed
		end

	--| FIXME XR: Maybe we should add advanced positioning methods (set_position, set_size,...).
	--| FIXME XR: Anyway they wouldn't be used at the moment.

feature {NONE} -- Implementation

	editor: EB_EDITOR
			-- Editor where the object value is displayed.

	text: STRUCTURED_TEXT
			-- Text that is displayed in the editor.

	slice_cmd: EB_SET_SLICE_SIZE_CMD
			-- Command that is supposed to resize special objects.

	parent: EB_PRETTY_PRINT_CMD
			-- Command that created `Current' and knows about it.

	slice_button: EV_BUTTON
			-- Button launching the slice command.

feature {NONE} -- Event handling

	on_stone_dropped (st: OBJECT_STONE) is
			-- A stone was dropped in the editor. Handle it.
		do
			set_stone (st)
		end

invariant
	has_parent_command: parent /= Void
	valid_stone: has_object implies is_stone_valid (current_object)

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

end -- class EB_PRETTY_PRINT_DIALOG
