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

	has_gray_icons: BOOLEAN
			-- Should gray icons be displayed?

	changed: BOOLEAN
			-- Has the toolbar been customized/changed by the user?

feature -- Status setting

	enable_text_displayed is
			-- Set `is_text_displayed' to True.
			-- Call `update_toolbar' to have change taken into account.
		do
			is_text_displayed := True
		end

	disable_text_displayed is
			-- Set `is_text_displayed' to False.
			-- Call `update_toolbar' to have change taken into account.
		do
			is_text_displayed := False
		end

	enable_gray_icons is
			-- Set `has_gray_icons' to True.
			-- Call `update_toolbar' to have change taken into account.
		do
			has_gray_icons := True
		end

	disable_gray_icons is
			-- Set `has_gray_icons' to False.
			-- Call `update_toolbar' to have change taken into account.
		do
			has_gray_icons := False
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
			dialog.customize_toolbar (widget_parent, has_gray_icons, is_text_displayed, Current)

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
				has_gray_icons := dialog.has_gray_icons
				update_toolbar
				changed := True
			end
		end

feature -- Conversion

	update_toolbar is
			-- [Re]generate `widget' using the ARRAYED_LIST.
		local
			curitem: EV_TOOL_BAR_ITEM
			recyclable_item: EB_RECYCLABLE
			cur_x, cur_y: INTEGER
			cur_bar: EV_TOOL_BAR
			cv_sep: EB_TOOLBARABLE_SEPARATOR
			cv_cmd: EB_TOOLBARABLE_COMMAND
			cmd_found: BOOLEAN
			loc_top_window: EB_VISION_WINDOW
		do
			loc_top_window := top_parent
			if loc_top_window /= Void then
				loc_top_window.lock_update
			end

				-- Discard current toolbar.
			discard_buttons
			widget.wipe_out

				-- Create a new toolbar.
			create cur_bar
			cmd_found := False
			if count > 0 then
				from
					start
				until
					after or cmd_found
				loop
					curitem := item.new_toolbar_item (is_text_displayed, has_gray_icons)
					recyclable_item ?= curitem
					if recyclable_item /= Void then
						add_recyclable (recyclable_item)
					end
					cv_sep ?= item
					if cv_sep /= Void then
						cur_bar.extend (curitem)
					else
						cv_cmd ?= item
						if cv_cmd /= Void and then cv_cmd.is_displayed then
							cur_bar.extend (curitem)
							cmd_found := True
							cur_x := curitem.pixmap.width
							cur_y := curitem.pixmap.height
						end
					end
					forth
				end

				from
				until
					after
				loop
					curitem := item.new_toolbar_item (is_text_displayed, has_gray_icons)
					recyclable_item ?= curitem
					if recyclable_item /= Void then
						add_recyclable (recyclable_item)
					end
					cv_sep ?= item
					if cv_sep /= Void then
						cur_bar.extend (curitem)
					else
						cv_cmd ?= item
						if cv_cmd /= Void and then cv_cmd.is_displayed then
							if curitem.pixmap.height /= cur_y or else curitem.pixmap.width /= cur_x then
								widget.extend (cur_bar)
								widget.disable_item_expand (cur_bar)
								create cur_bar
								cur_x := curitem.pixmap.width
								cur_y := curitem.pixmap.height
							end
							cur_bar.extend (curitem)
						end
					end
					forth
				end
				widget.extend (cur_bar)
				widget.disable_item_expand (cur_bar)
			end

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

end -- class EB_TOOLBAR
