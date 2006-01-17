indexing
	description : "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_NOTEBOOK_ITEM

inherit
	HASHABLE

create
	make,
	make_with_mini_toolbar,
	make_with_info

feature {NONE} -- Initialization

	make (a_parent: ES_NOTEBOOK; a_widget: EV_WIDGET; a_title: STRING) is
			-- Initialization
		require
			parent_not_void: a_parent /= Void
			widget_not_void: a_widget /= Void
			title_not_void: a_title /= Void
		do
			generic_make (a_parent, a_widget, a_title)
		end

	make_with_mini_toolbar (
		a_parent: ES_NOTEBOOK; a_widget: EV_WIDGET;
				a_title: STRING; a_mini_toolbar: EV_TOOL_BAR) is
			-- Initialization
		require else
			parent_not_void: a_parent /= Void
			widget_not_void: a_widget /= Void
			title_not_void: a_title /= Void
			mini_toolbar_not_void: a_mini_toolbar /= Void
		do
			mini_toolbar := a_mini_toolbar
			make (a_parent, a_widget, a_title)
		end
		
	make_with_info (
		a_parent: ES_NOTEBOOK; a_widget: EV_WIDGET;
				a_title: STRING; info: EV_HORIZONTAL_BOX; a_mini_toolbar: EV_TOOL_BAR) is
			-- Initialization
		require else
			parent_not_void: a_parent /= Void
			widget_not_void: a_widget /= Void
			title_not_void: a_title /= Void
			header_not_void: info /= Void
		do
			mini_toolbar := a_mini_toolbar
			header_box   := info
			make (a_parent, a_widget, a_title)
		end

	generic_make (a_parent: ES_NOTEBOOK; a_widget: EV_WIDGET; a_title: STRING) is
			-- Generic Initialization
		require
			a_parent_not_void: a_parent /= Void
			a_widget_not_void: a_widget /= Void
			a_title_not_void: a_title /= Void
		local
			vb: EV_VERTICAL_BOX
			tab_cell: EV_CELL
		do
			create selection_actions
			create drop_actions
			create pointer_button_pressed_actions

				--| Set the attributes
			parent := a_parent
			widget := a_widget
			title := a_title
			
			create tab_cell
			create vb
			create inside_toolbar_box
			vb.extend (inside_toolbar_box)
			vb.disable_item_expand (inside_toolbar_box)
			inside_toolbar_box.hide
			
			vb.extend (widget)
			tab_cell.extend (vb)
			
			tab_widget := tab_cell
		end
		
feature -- Access

	hash_code: INTEGER is
		do
			Result := title.hash_code
		end

	title: STRING

	mini_toolbar: EV_TOOL_BAR
	
	header_box: EV_HORIZONTAL_BOX

	parent: ES_NOTEBOOK

	tab: EV_NOTEBOOK_TAB
	
	selection_actions: EV_NOTIFY_ACTION_SEQUENCE
	
	pointer_button_pressed_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE

	drop_actions: EV_PND_ACTION_SEQUENCE

	is_selected: BOOLEAN is
		do
			Result := parent.selected_item = Current
		end

	is_destroyed: BOOLEAN is
		do
			Result := tab_widget.is_destroyed	
		end
		
feature -- Change

	close is
		local
			ddlg: ES_DOCKABLE_DIALOG
		do
			ddlg := parent_dockable_dialog (widget)
			if ddlg /= Void then
				ddlg.destroy
			else
				parent.prune (Current)
				tab := Void
			end
			
		end	

feature {ES_NOTEBOOK} -- Implementation

	inside_toolbar_box: EV_HORIZONTAL_BOX

	widget: EV_WIDGET

	tab_widget: EV_CELL

feature {ES_DOCKABLE_NOTEBOOK} -- Docking

	docked_in_witdh: INTEGER
	docked_in_height: INTEGER

	docked_out_witdh: INTEGER
	docked_out_height: INTEGER

	on_docking_started is
		local
			par: EV_CONTAINER
		do
			docked_in_witdh := tab_widget.width
			docked_in_height := tab_widget.height

			if mini_toolbar /= Void then
				par := mini_toolbar.parent
				if par /= Void then
					par.prune_all (mini_toolbar)
				end
			end
			if header_box /= Void then
				par := header_box.parent
				if par /= Void then
					par.prune_all (header_box)
				end
			end			
		end

	on_docking_ended is
		local
			ddlg: ES_DOCKABLE_DIALOG
			lw, lh: INTEGER
			hb: EV_HORIZONTAL_BOX
			lab: EV_LABEL
		do
			ddlg := parent_dockable_dialog (widget)
			if ddlg /= Void then
				if docked_out_witdh = 0 then
					lw := docked_in_witdh
				else
					lw := docked_out_witdh
				end
				if docked_out_height = 0 then
					lh := docked_in_height
				else
					lh := docked_out_height
				end
				ddlg.set_size (lw, lh)
				ddlg.resize_actions.extend (agent on_docking_dialog_resized)

				hb := inside_toolbar_box
				if hb /= Void then
					hb.wipe_out
					hb.set_padding (2)
					hb.set_border_width (2)

					create lab.make_with_text (title)
					hb.extend (lab)
					hb.disable_item_expand (lab)					
					
					if mini_toolbar /= Void then
							--| here we suppose the generic_make always add the content_box the way it is now
							--| and when we dock this item back to other place ..
							--| it will remove and put the minitoolbar somewhere else
						hb.extend (mini_toolbar)
						hb.disable_item_expand (mini_toolbar)					
					end
					if header_box /= Void then
							--| here we suppose the generic_make always add the content_box the way it is now
							--| and when we dock this item back to other place ..
							--| it will remove and put the header_box somewhere else
						hb.extend (header_box)
					end
					hb.show
				end
			end
		end

	on_docking_dialog_resized (ax, ay, awidth, aheight: INTEGER) is
		do
			docked_out_witdh := awidth
			docked_out_height := aheight
		end

feature {ES_NOTEBOOK} -- Restricted access

	set_tab (t: like tab) is
		do
			tab := t
		end
	
feature {NONE} -- Implementation

	parent_dockable_dialog (w: EV_WIDGET): ES_DOCKABLE_DIALOG is
			-- `Result' is dialog parent of `widget'.
			-- `Void' if none.
		require
			widget_not_void: w /= Void
		local
			dialog: ES_DOCKABLE_DIALOG
		do
			dialog ?= w.parent
			if dialog = Void then
				if w.parent /= Void then
					Result := parent_dockable_dialog (w.parent)
				end
			else
				Result := dialog
			end
		end

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

end
