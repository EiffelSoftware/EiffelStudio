indexing
	description	: "Notion of customizable toolbar.%
				  %N%
				  %it stores both the available commands (whose `is_displayed' %
				  %is False), the currently displayed commands (whose `is_displayed' is True),%
				  %and displayed separators.%N%
				  %The order inside it corresponds to the order of buttons in the actual tool%
				  %bar. However, non-displayed controls can be in any order, and can even be%
				  %dispatched among displayed controls. `widget' does not reflect the arrayed %
				  %list of components until `update_toolbar' is called."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"


class
	EB_TOOLBAR

inherit
	ARRAYED_LIST [EB_TOOLBARABLE]
		rename
			make as arrayed_list_make
		redefine
			default_create
		end

	EB_RECYCLER
		rename
			destroy as recycle
		undefine
			is_equal, copy, default_create
		redefine
			recycle
		select
			recycle
		end

	EB_RECYCLER
		rename
			destroy as discard_buttons
		undefine
			is_equal, copy, default_create
		end

	EB_RECYCLABLE
		undefine
			is_equal, copy, default_create
		end

create
	default_create

create {EB_TOOLBAR}
	make_filled

feature {NONE} -- Initialization

	default_create is
		do
			arrayed_list_make (10)
			create widget
		end

feature -- Access

	widget: EV_HORIZONTAL_BOX
			-- Container that receives all the toolbar buttons

feature -- Status report

	is_text_displayed: BOOLEAN
			-- Should text be displayed next to buttons when available?

	is_text_important: BOOLEAN
			-- Should only text deemed as important be displayed?

	changed: BOOLEAN
			-- Has the toolbar been customized/changed by the user?

feature -- Status setting

	enable_text_displayed is
			-- Set `is_text_displayed' to True.
			-- Call `update_toolbar' to have change taken into account.
		do
			is_text_important := False
			is_text_displayed := True
		end

	disable_text_displayed is
			-- Set icons only
			-- Call `update_toolbar' to have change taken into account.
		do
			is_text_important := False
			is_text_displayed := False
		end

	enable_important_text is
			-- Set `is_text_important' to True
			-- This shows only icons with important text
			-- Call `update_toolbar' to have change taken into account.
		do
			is_text_displayed := False
			is_text_important := True
		end

	reset_changed is
			-- Reset `changed' to False
		do
			changed := False
		end

feature -- Transformation

	customize is
			-- Allow the user to customize the tool bar through a dialog box.
		local
			dialog: EB_TOOLBAR_EDITOR_BOX
				-- Dialog used to customize toolbars.
			widget_parent: EV_WINDOW
			curr_widget: EV_WIDGET
		do
			create dialog.make

				-- Find top level window containing `widget'.
			if widget /= Void then
				from
					curr_widget := widget
				until
					curr_widget.parent = Void
				loop
					curr_widget := curr_widget.parent
				end
				widget_parent ?= curr_widget
			end
			if widget_parent = Void then
				create widget_parent
			end

				-- Show the dialog and let the user customize the toolbar.
			dialog.customize_toolbar (widget_parent, is_text_displayed, is_text_important, Current)

				-- Rebuilt the toolbar if needed.
			if dialog.valid_data then
				wipe_out
				from
					dialog.final_toolbar.start
				until
					dialog.final_toolbar.after
				loop
					extend (dialog.final_toolbar.item)
					dialog.final_toolbar.forth
				end
				is_text_displayed := dialog.is_text_displayed
				is_text_important := dialog.is_text_important
				update_toolbar
				changed := True
			end
		end

feature -- Conversion

	new_toolbar: EV_TOOL_BAR is
			--
		do
			create Result
			if is_text_important then
				Result.disable_vertical_button_style
			else
				Result.enable_vertical_button_style
			end
		end

	update_toolbar is
			-- [Re]generate `widget' using the ARRAYED_LIST.
		local
			curitem: EV_TOOL_BAR_ITEM
			recyclable_item: EB_RECYCLABLE
			cur_bar: EV_TOOL_BAR
			cv_sep: EB_TOOLBARABLE_SEPARATOR
			cv_cmd: EB_TOOLBARABLE_COMMAND
			loc_top_window: EB_VISION_WINDOW
			in_text_toolbar: BOOLEAN
			tool_bar_b: EV_TOOL_BAR_BUTTON
		do
			loc_top_window := top_parent
			if loc_top_window /= Void then
				loc_top_window.lock_update
			end

				-- Discard current toolbar.
			discard_buttons
			widget.wipe_out

				-- Create a new toolbar.
			from
				start
				cur_bar := new_toolbar
			until
				after
			loop
				curitem := item.new_toolbar_item (is_text_displayed or else is_text_important)
				recyclable_item ?= curitem
				if recyclable_item /= Void then
					add_recyclable (recyclable_item)
				end
				cv_sep ?= item
				if cv_sep /= Void then
					cur_bar.extend (curitem)
					widget.extend (cur_bar)
					widget.disable_item_expand (cur_bar)
					cur_bar := new_toolbar
					in_text_toolbar := False
				else
					cv_cmd ?= item
					if cv_cmd /= Void and then cv_cmd.is_displayed then
						if is_text_important then
							if cv_cmd.is_tooltext_important then
								if not in_text_toolbar then
									widget.extend (cur_bar)
									widget.disable_item_expand (cur_bar)
									cur_bar := new_toolbar
									in_text_toolbar := True
								end
							else
									-- Strip unimportant text if not needed
								tool_bar_b ?= curitem
								tool_bar_b.remove_text
								if in_text_toolbar then
									widget.extend (cur_bar)
									widget.disable_item_expand (cur_bar)
									cur_bar := new_toolbar
									in_text_toolbar := False
								end
							end
						end
						cur_bar.extend (curitem)
					end
				end
				forth
			end
			widget.extend (cur_bar)
			widget.disable_item_expand (cur_bar)

			if loc_top_window /= Void then
				loc_top_window.unlock_update
			end
		end

	top_parent: EB_VISION_WINDOW is
		local
			loc_parent: EV_CONTAINER
		do
			loc_parent := widget.parent
			if loc_parent /= Void then
				from
				until
					loc_parent.parent = Void
				loop
					loc_parent := loc_parent.parent
				end
			end
			Result ?= loc_parent
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			Precursor {EB_RECYCLER}
			if widget /= Void then
				widget.destroy
				widget := Void
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

end -- class EB_TOOLBAR
