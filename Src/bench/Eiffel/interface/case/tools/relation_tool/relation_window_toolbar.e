indexing
	description: "Toolbar for Class Window"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	RELATION_WINDOW_TOOLBAR

inherit
		ECASE_TOOLBAR
			redefine
					make -- ,fill_with_buttons
			end

creation
	make

feature -- Initialization

	make (p: like parent) is
		do
			parent := p

			if parent /= Void then
				!! tool_bar.make ( parent.global_container )
				precursor ( parent )
				tool_bar.set_vertical_resize ( FALSE )
				tool_bar.set_expand(FALSE)
			end
		end

feature -- Settings

	fill_with_buttons is 
		local
			pixmap: EV_PIXMAP

			relation_command: RELATION_WIN_MAIN_HOLE_COM
			class_from_command: RELATION_WIN_CLASS_HOLE_COM
			class_to_command: RELATION_WIN_CLASS_HOLE_COM

			handle_left_command: ADV_LEFT
			handle_right_command: ADV_RIGHT
			remove_handle_command: REMOVE_HANDLES
		do
			!! relation_b.make (tool_bar)
			!! relation_command.make (parent, relation_b)
			pixmap := pixmaps.relation_pixmap
			relation_b.add_click_command (relation_command, Void)
			relation_b.set_pixmap (pixmap)

			!! class_from_b.make (tool_bar)
			pixmap := pixmaps.class_pixmap 
			!! class_from_command.make_from (parent, class_from_b)
			class_from_b.add_click_command (class_from_command, Void)
			class_from_b.set_pixmap (pixmap)

			!! class_to_b.make (tool_bar)
			pixmap := pixmaps.class_pixmap 
			!! class_to_command.make_to (parent, class_to_b)
			class_to_b.add_click_command (class_to_command, Void)
			class_to_b.set_pixmap (pixmap)

	--		!! handle_left_b.make (tool_bar)
	--		handle_left_b.set_expand(FALSE)
	--		pixmap := pixmaps.left_handle
	--		!! handle_left_command.make (parent)
	--		handle_left_b.add_click_command (handle_left_command, Void)
	--		handle_left_b.set_pixmap (pixmap)

	--		!! handle_right_b.make (tool_bar)
	--		handle_right_b.set_expand(FALSE)
	--		pixmap := pixmaps.right_handle
	--		!! handle_right_command.make (parent)
	--		handle_right_b.add_click_command (handle_right_command, Void)
	--		handle_right_b.set_pixmap (pixmap)
	
	--		!! remove_handle_b.make (tool_bar)
	--		remove_handle_b.set_expand(FALSE)
	--		pixmap := pixmaps.remove_handles_pixmap
	--		!! remove_handle_command.make (parent)
	--		remove_handle_b.add_click_command (remove_handle_command, Void)
	--		remove_handle_b.set_pixmap (pixmap)

			--!! class_window_name_from.make ("Class Tool", tool_bar, parent)
			--class_window_name_from.add_activate_command (class_window_name_from, Void)

			--!! class_window_name_to.make ("Class Tool", tool_bar, parent)
			--class_window_name_to.add_activate_command (class_window_name, Void)
		end

feature {NONE} -- Implementation

	relation_b: EV_TOOL_BAR_BUTTON
	class_from_b: EV_TOOL_BAR_BUTTON
	class_to_b: EV_TOOL_BAR_BUTTON

	handle_left_b: EV_TOOL_BAR_BUTTON
	handle_right_b: EV_TOOL_BAR_BUTTON
	remove_handle_b: EV_TOOL_BAR_BUTTON
	
	class_window_name_from: ANY -- CLASS_WINDOW_NAME
	class_window_name_to: ANY -- CLASS_WINDOW_NAME

	parent: EC_RELATION_WINDOW

end -- class CLASS_WINDOW_TOOLBAR
