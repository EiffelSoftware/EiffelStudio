note
	description: "[
		Alpha-blend window for EiffelRibbon tool
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_FEEDBACK_INDICATOR

inherit
	SD_FEEDBACK_INDICATOR
		export
			{ANY} destroy
		redefine
			create_implementation,
			destroy
		end

create
	make_for_error

feature {NONE} -- Initialization

	make_for_error (a_width, a_height: INTEGER)
			-- Creation method with GDI+ image
		require
			valid: a_width > 0 and a_height > 0
		local
			l_image:WEL_GDIP_BITMAP
			l_graphics: WEL_GDIP_GRAPHICS
			l_brush: WEL_GDIP_BRUSH
			l_pen: WEL_GDIP_PEN
			l_pixel_buffer: EV_PIXEL_BUFFER
			l_shared: ER_SHARED_TOOLS
		do
			create l_image.make_with_size (a_width, a_height)
			create l_graphics.make_from_image (l_image)
			create l_brush.make_solid (create {WEL_GDIP_COLOR}.make_from_argb (100, 255, 0, 0))
			l_graphics.fill_ellipse (l_brush, 0, 0, a_width - 1, a_height - 1)

			create l_pen.make (create {WEL_GDIP_COLOR}.make_from_rgb (255, 0, 0), 2) -- Red
			l_graphics.draw_ellipse (l_pen, 0, 0, a_width - 1, a_height - 1)
			l_graphics.dispose

			create l_pixel_buffer.make_with_size (a_width, a_height)
			if attached {EV_PIXEL_BUFFER_IMP} l_pixel_buffer.implementation as l_imp then
				l_imp.set_gdip_image (l_image)
			end

			make_for_splash (l_pixel_buffer)

			create l_shared
			l_shared.all_feedback_indicators.extend (Current)
		end

feature -- Command

	show_on (a_tree_node: EV_TREE_NODE)
			-- <Precursor>
		do
			hook_widget (a_tree_node)
			update_initial_parent_offset (a_tree_node)
			if is_tree_node_displayed (a_tree_node) then
				show
			end
		end

	set_error_text (a_text: STRING_32)
			-- Set `error_text' with `a_text'
		do
			error_text := a_text
		ensure
			set: error_text = a_text
		end

	initial_parent_x_offset, initial_parent_y_offset: INTEGER
			-- Initial parent tree x and y position

	on_parent_tree_focus_out
			-- Handle parent tree focus out action
		local
			l_env: EV_ENVIRONMENT
		do
			if not is_destroyed then
				-- Hide on idle, otherwise when clicked on Current, this action will be executed first
				should_hide := True
				create l_env
				if attached l_env.application as l_app then
					l_app.add_idle_action_kamikaze (agent
														do
															if should_hide then
																if not is_destroyed then
																	hide
																end
																should_hide := False
															end
														end)
				end

			end
		end

	should_hide: BOOLEAN
			-- Should current hide?

	on_parent_tree_focus_in
			-- Handle parent tree focus in action
		local
			l_env: EV_ENVIRONMENT
		do
			create l_env
			-- Use idle action, otherwise
			if attached l_env.application as l_app then
				l_app.add_idle_action_kamikaze (agent
													do
														if not is_destroyed then
															if attached tree_node as l_tree_node then
																if is_tree_node_displayed (l_tree_node) then
																	show
																end
															end
														end
													end)
			end
		end

	check_feedback_is_topmost
			-- Check if current is topmost, otherwise hide
		local
			l_screen: EV_SCREEN
		do
			create l_screen
			if not is_destroyed and then attached parent_tree as l_parent_tree then
				if attached l_screen.widget_at_position (screen_x - 1, screen_y - 1) as l_widget then
					if l_widget = l_parent_tree then
						if not is_displayed then
							show
						end
					else
						hide
					end
				else
					hide
				end
			end
		end

	parent_tree: detachable EV_TREE
			-- Parent tree if exists
		do
			if attached tree_node as l_tree_node then
				Result := l_tree_node.parent_tree
			end
		end

	hook_widget (a_tree_node: EV_TREE_NODE)
			-- Hook `a_tree_node'
		local
			l_parent_tree_resize_action: like parent_tree_resize_action
			l_parent_tree_focus_out_action: like parent_tree_focus_out_action
			l_parent_tree_focus_in_action: like parent_tree_focus_in_action
			l_parent_tree_vertical_scroll_action: like parent_tree_vertical_scroll_action
			l_parent_tree_horizontal_scroll_action: like parent_tree_horizontal_scroll_action
			l_parent_window_move_action: like parent_window_move_action
			l_parent_window_maximize_action: like parent_window_maximize_action
			l_parent_tree_mouse_wheel_action: like parent_tree_mouse_wheel_action
		do
			tree_node := a_tree_node
			if attached a_tree_node.parent_tree as l_parent_tree then
				-- Hook Current actions
				pointer_motion_actions.extend (agent on_pointer_motion)
				pointer_enter_actions.extend (agent on_pointer_enter)
				pointer_leave_actions.extend (agent on_pointer_leave)
				pointer_button_press_actions.extend (agent on_pointer_release)

				-- Parent tree action							
				check not_initialized: parent_tree_resize_action = Void end
				l_parent_tree_resize_action := agent on_resize_action (?, ?, ?, ?, a_tree_node)
				parent_tree_resize_action := l_parent_tree_resize_action
				l_parent_tree.resize_actions.extend (l_parent_tree_resize_action)

				-- Parent tree mouse wheel action
				l_parent_tree_mouse_wheel_action := agent on_mouse_wheel (?, a_tree_node)
				parent_tree_mouse_wheel_action := l_parent_tree_mouse_wheel_action
				l_parent_tree.mouse_wheel_actions.extend (l_parent_tree_mouse_wheel_action)

				-- Hook tree scroll area move action
				if attached {EV_TREE_IMP} l_parent_tree.implementation as l_imp then
					check not_initialized: parent_tree_vertical_scroll_action = Void end
					l_parent_tree_vertical_scroll_action := agent on_vertical_scroll (?, ?, a_tree_node)
					parent_tree_vertical_scroll_action := l_parent_tree_vertical_scroll_action
					l_imp.vertical_scroll_action.extend (l_parent_tree_vertical_scroll_action)

					check not_initialized: parent_tree_horizontal_scroll_action = Void end
					l_parent_tree_horizontal_scroll_action := agent on_horizontal_scroll (?, ?, a_tree_node)
					parent_tree_horizontal_scroll_action := l_parent_tree_horizontal_scroll_action
					l_imp.horizontal_scroll_action.extend (l_parent_tree_horizontal_scroll_action)

					-- Set focus to parent tree, otherwise focus stay on Current. The first `focus_out' action will not work.
					l_parent_tree.set_focus

					check not_initialized: parent_tree_focus_out_action = Void end
					l_parent_tree_focus_out_action := agent on_parent_tree_focus_out
					parent_tree_focus_out_action := l_parent_tree_focus_out_action
					l_parent_tree.focus_out_actions.extend (l_parent_tree_focus_out_action)

					check not_initialized: parent_tree_focus_in_action = Void end
					l_parent_tree_focus_in_action := agent on_parent_tree_focus_in
					parent_tree_focus_in_action := l_parent_tree_focus_in_action
					l_parent_tree.focus_in_actions.extend (l_parent_tree_focus_in_action)
				end
				-- Hook parent window move action															
				if attached {EV_TITLED_WINDOW} parent_window_recursive (l_parent_tree) as l_parent_window then

					check not_initialized: parent_window_move_action = Void end
					l_parent_window_move_action := agent on_window_move_action (?, ?, ?, ?, a_tree_node)
					parent_window_move_action := l_parent_window_move_action
					l_parent_window.move_actions.extend (l_parent_window_move_action)

					check not_initialized: parent_window_maximize_action = Void end
					l_parent_window_maximize_action := agent on_window_maximize (a_tree_node)
					parent_window_maximize_action := l_parent_window_maximize_action
					l_parent_window.maximize_actions.extend (l_parent_window_maximize_action)
				end
			end
		ensure
			set: tree_node /= Void
		end

	on_window_maximize (a_tree_node: EV_TREE_NODE)
			-- Hanlde window maximize action
		do
			update_error_feedback_visibility (a_tree_node)
			update_screen_position_for_scroll (a_tree_node, 0, false)
		end

	on_vertical_scroll (a_action_type: INTEGER; a_positon: INTEGER; a_tree_node: EV_TREE_NODE)
			-- Handle tree vertical scroll action
		do
			update_error_feedback_visibility (a_tree_node)
			update_screen_position_for_scroll (a_tree_node, a_action_type, true)
		end

	on_horizontal_scroll (a_action_type: INTEGER; a_positon: INTEGER; a_tree_node: EV_TREE_NODE)
			-- Handle tree horizontal scrool action
		do
			update_error_feedback_visibility (a_tree_node)
			update_screen_position_for_scroll (a_tree_node, a_action_type, false)
		end

	parent_window_recursive (a_widget: EV_WIDGET): detachable EV_WINDOW
			-- Find parent window of `a_widget' recursively
		do
			if attached a_widget.parent as l_parent then
				if attached {EV_WINDOW} l_parent as l_parent_window then
					Result := l_parent_window
				else
					Result := parent_window_recursive (l_parent)
				end
			end
		end

	on_window_move_action (a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32; a_tree_node: EV_TREE_NODE)
			-- Handle parent window move action
		do
			update_screen_position (a_tree_node)
		end

	on_resize_action (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER; a_tree_node: EV_TREE_NODE)
			-- Handle resize action
		do
			update_screen_position_for_scroll (a_tree_node, 0, true)
			update_screen_position (a_tree_node)
			update_error_feedback_visibility (a_tree_node)
		end

	update_screen_position_for_scroll (a_tree_node: EV_TREE_NODE; a_action_type: INTEGER; a_vertical_scroll: BOOLEAN)
			-- Update `a_tree_node's position
		local
			l_x, l_y: INTEGER
			l_changed: BOOLEAN
		do
			if not is_destroyed and then is_displayed then
				l_x := a_tree_node.screen_x
				l_y := a_tree_node.screen_y

--				if a_vertical_scroll then
--					if a_action_type = {EV_SCROLL_CONSTANTS}.thumb_track then
--						l_y := l_y + a_tree_node.height
--					end
--				end
				if l_x /= screen_x or else l_y /= screen_y then
					l_changed := True
					set_x_position (l_x)
					set_y_position (l_y)
				end
				update_initial_parent_offset (a_tree_node)
			end
			if l_changed then
				destroy_error_explain_dialog
			end
		end

	update_initial_parent_offset (a_tree_node: EV_TREE_NODE)
			-- Update parent offset
		do
			if attached a_tree_node.parent_tree as l_parent_tree then
				initial_parent_x_offset := l_parent_tree.screen_x - screen_x
				initial_parent_y_offset := l_parent_tree.screen_y - screen_y
			end
		end

	update_screen_position (a_tree_node: EV_TREE_NODE)
			-- Update `a_tree_node's position base on parent's position
		do
			if attached a_tree_node.parent_tree as l_parent_tree then
				if not is_destroyed then
					set_x_position (l_parent_tree.screen_x - initial_parent_x_offset)
					set_y_position (l_parent_tree.screen_y - initial_parent_y_offset)
				end
			end
		end

	update_error_feedback_visibility (a_tree_node: EV_TREE_NODE)
			-- Update error feedback visibility
		do
			if is_tree_node_displayed (a_tree_node) then
				if not is_destroyed then
					show
				end
			else
				if not is_destroyed then
					hide
				end
			end
		end

	destroy
			-- <Precursor>
		do
			if attached tree_node as l_tree_node then
				clear_resource (l_tree_node)
			end
			Precursor
		end

feature -- Query

	is_tree_node_displayed (a_tree_node: EV_TREE_NODE): BOOLEAN
			-- Is `a_tree_node' displayed?
		local
			l_tree_rect, l_item_rect: EV_RECTANGLE
		do
			if attached a_tree_node.parent_tree as l_parent_tree then
				if l_parent_tree.is_displayed then
					-- Check if `a_tree_node' visible
					create l_tree_rect.make (l_parent_tree.screen_x, l_parent_tree.screen_y, l_parent_tree.width, l_parent_tree.height)
					create l_item_rect.make (a_tree_node.screen_x, a_tree_node.screen_y, a_tree_node.width, a_tree_node.height)
					if l_tree_rect.intersects (l_item_rect) then
						-- Should display error feedback
						Result := True
					end
				end
			end
		end

	error_text: detachable STRING_32
			-- Error text displayed when pointer hover on current

feature {NONE} -- Implementation

	error_explain_dialog: detachable EV_POPUP_WINDOW
			-- Dialog to explain error

	on_pointer_motion (a_x: INTEGER_32; a_y: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			-- Handle pointer motion actions
		do
			show_error_explain_dialog
		end

	show_error_explain_dialog
			-- Show error explain dialog
		local
			l_dialog: like error_explain_dialog
			l_label: EV_LABEL
		do
			if error_explain_dialog = Void then
				create l_dialog
				l_dialog.disconnect_from_window_manager
				if attached error_text as l_text then
					create l_label.make_with_text (l_text)
				else
					create l_label.make_with_text ("Error explanation not set")
				end

				l_dialog.extend (l_label)
				l_dialog.set_position (x_position + width, y_position)
				l_dialog.show

				error_explain_dialog := l_dialog
			end

		ensure
			set: error_explain_dialog /= void
		end

	destroy_error_explain_dialog
			-- Destroy error explain dialog
		do
			if attached error_explain_dialog as l_dialog then
				l_dialog.destroy
				error_explain_dialog := Void
			end
		ensure
			clear: error_explain_dialog = void
		end

	on_pointer_enter
			-- Handle pointer enter actions
		do
			show_error_explain_dialog
		end

	on_pointer_leave
			-- Handle poiner leave actions
		do
			destroy_error_explain_dialog
		end

	on_mouse_wheel (a_value: INTEGER_32; a_tree_node: EV_TREE_NODE)
			-- Handle mouse wheel actions
		do
			update_error_feedback_visibility (a_tree_node)
			update_screen_position_for_scroll (a_tree_node, 0, true)
		end

	on_pointer_release (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			-- Handle pointer release actions
		do
			should_hide := False
			on_pointer_leave
			-- FIXME: sometimes the fading effect (using timer) will not work.
			-- EV_TIMER.actions not be called
			-- We disable fading effect now, destroy it directly
--			clear
			destroy
		end

	tree_node: detachable EV_TREE_NODE
			-- Tree node hooked

	clear_resource (a_tree_node: EV_TREE_NODE)
			-- Clear all resources used
		do
			on_pointer_leave
			focus_in_actions.wipe_out
			focus_out_actions.wipe_out

			pointer_enter_actions.wipe_out
			pointer_leave_actions.wipe_out
			pointer_button_press_actions.wipe_out

			if attached a_tree_node.parent_tree as l_parent_tree then

				if attached {EV_TREE_IMP} l_parent_tree.implementation as l_imp then
					if attached parent_tree_horizontal_scroll_action as l_horizontal_scroll_action then
						l_imp.horizontal_scroll_action.prune_all (l_horizontal_scroll_action)
					end

					if attached parent_tree_vertical_scroll_action as l_vertical_scroll_action then
						l_imp.vertical_scroll_action.prune_all (l_vertical_scroll_action)
					end

					if attached parent_tree_mouse_wheel_action as l_mouse_wheel_action then
						l_imp.mouse_wheel_actions.prune_all (l_mouse_wheel_action)
					end
				end

				-- Hook parent window move action															
				if attached {EV_TITLED_WINDOW} parent_window_recursive (l_parent_tree) as l_parent_window then
					if attached parent_window_maximize_action as l_maximize_action then
						l_parent_window.maximize_actions.prune_all (l_maximize_action)
					end
					if attached parent_window_move_action as l_move_action then
						l_parent_window.move_actions.prune_all (l_move_action)
					end

					if attached parent_tree_focus_in_action as l_focus_in_action then
						l_parent_window.focus_in_actions.prune_all (l_focus_in_action)
					end
					if attached parent_tree_focus_out_action as l_focus_out_action then
						l_parent_window.focus_out_actions.prune_all (l_focus_out_action)
					end
				end
			else
				check cannot_clear_parent_trees_action: False end
			end
		end

	create_implementation
			-- <Precursor>
		do
			create {ER_FEEDBACK_INDICATOR_IMP} implementation.make
		end

feature {NONE} -- Resources

	parent_tree_mouse_wheel_action: detachable PROCEDURE [INTEGER_32]
			-- Parent tree mouse wheel action

	parent_tree_resize_action: detachable PROCEDURE [INTEGER_32, INTEGER_32, INTEGER_32, INTEGER_32]
			-- Parent tree resize action

	parent_tree_focus_out_action: detachable PROCEDURE
			-- Parent tree focus out action

	parent_tree_focus_in_action: detachable PROCEDURE
			-- Parent tree focus in action

	parent_tree_vertical_scroll_action: detachable PROCEDURE [INTEGER, INTEGER]
			-- Parent tree vertical scroll action

	parent_tree_horizontal_scroll_action: detachable PROCEDURE [INTEGER, INTEGER]
			-- Parent tree horizontal scroll action

	parent_window_move_action: detachable PROCEDURE [INTEGER_32, INTEGER_32, INTEGER_32, INTEGER_32]
			-- Parent tree move action

	parent_window_maximize_action: detachable PROCEDURE
			-- Parent tree maximize action

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
