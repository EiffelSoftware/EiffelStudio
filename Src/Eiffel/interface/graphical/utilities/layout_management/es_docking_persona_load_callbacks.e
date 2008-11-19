indexing
	description: "[
		Gobo XML callbacks used to construct an EiffelStudio layout based on a loaded persona XML file.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_DOCKING_PERSONA_LOAD_CALLBACKS

inherit
	XM_STATE_LOAD_CALLBACKS
		rename
			make as make_load_callbacks
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: !like development_window; a_parser: !like xml_parser)
			-- Initializes callbacks using an existing XML parser.
			-- Note: Initialization will set the parser's callbacks to Current.
			--
			-- `a_parser': An XML parser Current is used with.
		require
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			development_window := a_window
			create current_zone_tools.make_default
			make_load_callbacks (a_parser)
		ensure
			xml_parser_set: xml_parser = a_parser
			xml_parser_callbacks_set: xml_parser.callbacks = Current
			development_window_set: development_window = a_window
		end

feature -- Access

	development_window: !EB_DEVELOPMENT_WINDOW
			-- Window used to modify docking layout data.

feature {NONE} -- Access

	current_zone_state: NATURAL_8
			-- Current zone's docking state direction.

	current_zone_style: NATURAL_8
			-- Current zone's docking style.

	current_zone_size: NATURAL_8
			-- Current zone's percentage of usage.

	current_zone_tools: !DS_ARRAYED_LIST [!STRING]
			-- Current zone's tool identifiers.

feature {NONE} -- Access: Defaults

	default_floating_x: INTEGER
			-- Default floating X position.
		local
			l_window: EV_WINDOW
		do
			l_window := development_window.window
			Result := l_window.x_position + ((l_window.width - default_floating_width) / 2).truncated_to_integer
		end

	default_floating_y: INTEGER
			-- Default floating X position.
		local
			l_window: EV_WINDOW
		do
			l_window := development_window.window
			Result := l_window.y_position + ((l_window.height - default_floating_height) / 2).truncated_to_integer
		end

	default_floating_width: INTEGER
			-- Default floating width.
		do
			Result := 300
		end

	default_floating_height: INTEGER
			-- Default floating height.
		do
			Result := 200
		end

feature {NONE} -- Status report

	is_strict: BOOLEAN
			-- <Precursor>
		do
				-- Ignore mistakes in file.
			Result := False
		end

feature {NONE} -- Basic operation

	reset_zone
			-- Reset current zone properties.
		do
			current_zone_state := v_none
			current_zone_style := v_floating
			current_zone_size := 30
			current_zone_tools.wipe_out
		ensure
			current_zone_state_reset: current_zone_state = v_none
			current_zone_style_reset: current_zone_style = v_floating
			current_zone_tools_is_empty: current_zone_tools.is_empty
		end

	build_current_zone
			-- Builds the current zone
		require
			not_current_zone_tools_is_empty: not current_zone_tools.is_empty
		local
			l_zones: !like current_zone_tools
			l_item: !STRING
			l_type: ?TYPE [ES_TOOL [EB_TOOL]]
			l_tool: ?ES_TOOL [EB_TOOL]
			l_panel: EB_TOOL
			l_first_panel: EB_TOOL
			l_first_tool_set: BOOLEAN
			l_auto_hide: BOOLEAN
			l_is_auto_hidden: BOOLEAN
		do
			if {l_tools: ES_SHELL_TOOLS} development_window.shell_tools and then l_tools.is_interface_usable then
				l_zones := current_zone_tools
				from l_zones.finish until l_zones.before loop
					l_item := l_zones.item_for_iteration
					if not l_item.is_empty then
						l_type := l_tools.dynamic_tool_type (l_item)
						if l_type /= Void then
							l_tool := l_tools.tool (l_type)
							if l_tool /= Void and then l_tool.is_interface_usable then
								l_panel := l_tool.panel
								if not l_first_tool_set then
									l_auto_hide := current_zone_style = v_auto_hide
									if current_zone_style /= v_floating then
											-- Reason why l_panel.content.set_auto_hide is called twice -- paulb:
											--
											-- First we pin it, then pin it again. So we can make sure the tab stub order and tab stub direction.
											-- Docking library will add a feature to set auto hide tab stub order directly in the future. -- larryl 2007/7/13

										l_is_auto_hidden := l_auto_hide and then l_panel.content.state_value = {SD_ENUMERATION}.auto_hide

											-- There is not docking property for floating windows.
										inspect current_zone_state
										when v_bottom then
											if l_auto_hide then
												l_panel.content.set_auto_hide ({SD_ENUMERATION}.bottom)
												if l_is_auto_hidden then
														-- See above comments.
													l_panel.content.set_auto_hide ({SD_ENUMERATION}.bottom)
												end
											else
												l_panel.content.set_top ({SD_ENUMERATION}.bottom)
											end
										when v_top then
											if l_auto_hide then
												l_panel.content.set_auto_hide ({SD_ENUMERATION}.top)
												if l_is_auto_hidden then
														-- See above comments.
													l_panel.content.set_auto_hide ({SD_ENUMERATION}.top)
												end
											else
												l_panel.content.set_top ({SD_ENUMERATION}.top)
											end
										when v_left then
											if l_auto_hide then
												l_panel.content.set_auto_hide ({SD_ENUMERATION}.left)
												if l_is_auto_hidden then
														-- See above comments.
													l_panel.content.set_auto_hide ({SD_ENUMERATION}.left)
												end
											else
												l_panel.content.set_top ({SD_ENUMERATION}.left)
											end
										when v_right then
											if l_auto_hide then
												l_panel.content.set_auto_hide ({SD_ENUMERATION}.right)
												if l_is_auto_hidden then
														-- See above comments.
													l_panel.content.set_auto_hide ({SD_ENUMERATION}.right)
												end
											else
												l_panel.content.set_top ({SD_ENUMERATION}.right)
											end
										else
											if l_auto_hide then
												l_panel.content.set_auto_hide ({SD_ENUMERATION}.bottom)
												if l_is_auto_hidden then
														-- See above comments.
													l_panel.content.set_auto_hide ({SD_ENUMERATION}.bottom)
												end
											else
												l_panel.content.set_top ({SD_ENUMERATION}.bottom)
											end
										end
										l_panel.content.set_split_proportion (1.0 - (current_zone_size.min (100) / 100))
									else
											-- Default to floating.
										l_panel.content.set_floating_width (default_floating_width)
										l_panel.content.set_floating_height (default_floating_height)
										l_panel.content.set_floating (default_floating_x, default_floating_y)
										l_tool.show (False)
									end
									l_first_tool_set := True
									l_first_panel := l_panel
								else
										-- Tab other content
									l_panel.content.set_tab_with (l_first_panel.content, True)
								end
							end
						end
					end
					l_zones.back
				end
			end
		end

feature {NONE} -- Process

	process_tag_state (a_state: NATURAL_8)
			-- <Precursor>
		do
			inspect a_state
			when t_layout then
				process_layout
			when t_zone then
				reset_zone
			else

			end
		end

	process_end_tag_state (a_state: NATURAL_8)
			-- <Precursor>
		do
			inspect a_state
			when t_zone then
				process_zone
			when t_tool then
				process_tool
			else

			end
		end

	process_layout
			-- Process a layout declaration.
		do
				-- Remove all the tools
			development_window.close_all_tools
		end

	process_zone
			-- Process a zone declaration.
		local
			l_attributes: !like current_attributes
			l_value: STRING
			l_size: NATURAL_8
		do
			l_attributes := current_attributes

				-- Style attributes
			if l_attributes.has (at_style) then
				l_value := l_attributes.item (at_style)
				if l_value.is_case_insensitive_equal ({ES_DOCKING_PERSONA_ENTITY_NAMES}.auto_hide_style_value) then
					current_zone_style := v_auto_hide
				elseif l_value.is_case_insensitive_equal ({ES_DOCKING_PERSONA_ENTITY_NAMES}.floating_style_value) then
					current_zone_style := v_floating
				elseif l_value.is_case_insensitive_equal ({ES_DOCKING_PERSONA_ENTITY_NAMES}.tabbed_style_value) then
					current_zone_style := v_tabbed
				elseif l_value.is_case_insensitive_equal ({ES_DOCKING_PERSONA_ENTITY_NAMES}.tiled_style_value) then
					current_zone_style := v_tiled
				end
			end

				-- Docking direction attribute
			if l_attributes.has (at_dock) then
				l_value := l_attributes.item (at_dock)
				if l_value.is_case_insensitive_equal ({ES_DOCKING_PERSONA_ENTITY_NAMES}.botton_dock_value) then
					current_zone_state := v_bottom
				elseif l_value.is_case_insensitive_equal ({ES_DOCKING_PERSONA_ENTITY_NAMES}.left_dock_value) then
					current_zone_state := v_left
				elseif l_value.is_case_insensitive_equal ({ES_DOCKING_PERSONA_ENTITY_NAMES}.right_dock_value) then
					current_zone_state := v_right
				elseif l_value.is_case_insensitive_equal ({ES_DOCKING_PERSONA_ENTITY_NAMES}.top_dock_value) then
					current_zone_state := v_top
				end
			end

				-- Docking direction attribute
			if l_attributes.has (at_size) then
				l_value := l_attributes.item (at_size)
				l_value.left_adjust
				l_value.right_adjust
				if not l_value.is_natural_8 then
						-- Remove % marker
					l_value.prune_all_trailing ('%%')
					l_value.right_adjust
				end
				if l_value.is_natural_8 then
					l_size := l_value.to_natural_8
					if l_size >= 1 and then l_size <= 100 then
						current_zone_size := l_size
					else
-- Error
					end
				else
-- Error
				end
			end

			build_current_zone
		end

	process_tool
			-- Process a tool declaration.
		local
			l_attributes: !like current_attributes
			l_value: STRING
		do
			l_attributes := current_attributes
			if l_attributes.has (at_id) then
				l_value := l_attributes.item (at_id)
				if l_value /= Void then
					current_zone_tools.force_last (l_value)
				end
			end
		end

feature {NONE} -- State transistions

	tag_state_transitions: !DS_HASH_TABLE [!DS_HASH_TABLE [NATURAL_8, !STRING], NATURAL_8]
			-- <Precursor>
		local
			l_trans: !DS_HASH_TABLE [NATURAL_8, !STRING]
		do
			create Result.make (8)

				-- XML
				-- => layout
			create l_trans.make (1)
			l_trans.put (t_layout, {ES_DOCKING_PERSONA_ENTITY_NAMES}.layout_tag)
			Result.put (l_trans, t_none)

				-- layout
				-- => zone
			create l_trans.make (1)
			l_trans.put (t_zone, {ES_DOCKING_PERSONA_ENTITY_NAMES}.zone_tag)
			Result.put (l_trans, t_layout)

				-- zone
				-- => tool
				-- => zone
			create l_trans.make (2)
			l_trans.put (t_tool, {ES_DOCKING_PERSONA_ENTITY_NAMES}.tool_tag)
			l_trans.put (t_zone, {ES_DOCKING_PERSONA_ENTITY_NAMES}.zone_tag)
			Result.put (l_trans, t_zone)
		end

	attribute_states: !DS_HASH_TABLE [!DS_HASH_TABLE [NATURAL_8, !STRING], NATURAL_8]
			-- <Precursor>
		local
			l_attr: !DS_HASH_TABLE [NATURAL_8, !STRING]
		once
			create Result.make_default

				-- layout
				-- @ name
			create l_attr.make (1)
			l_attr.put (at_name, {ES_DOCKING_PERSONA_ENTITY_NAMES}.layout_tag)
			Result.put (l_attr, t_layout)

				-- zone
				-- @ dock
				-- @ size
				-- @ style
			create l_attr.make (3)
			l_attr.put (at_dock, {ES_DOCKING_PERSONA_ENTITY_NAMES}.dock_attribute)
			l_attr.put (at_style, {ES_DOCKING_PERSONA_ENTITY_NAMES}.style_attribute)
			l_attr.put (at_size, {ES_DOCKING_PERSONA_ENTITY_NAMES}.size_attribute)
			Result.put (l_attr, t_zone)

				-- tool
				-- @ id
			create l_attr.make (1)
			l_attr.put (at_id, {ES_DOCKING_PERSONA_ENTITY_NAMES}.id_attribute)
			Result.put (l_attr, t_tool)
		end

feature {NONE} -- Tag states

	t_layout: NATURAL_8     = 0x01
	t_zone: NATURAL_8       = 0x02
	t_tool: NATURAL_8       = 0x03

feature {NONE} -- Attribute states

	at_name: NATURAL_8      = 0x01
	at_dock: NATURAL_8      = 0x02
	at_size: NATURAL_8      = 0x03
	at_style: NATURAL_8     = 0x04
	at_id: NATURAL_8        = 0x05

feature {NONE} -- Attribute values

	v_none: NATURAL_8      = 0x00
	v_bottom: NATURAL_8    = 0x01
	v_top: NATURAL_8       = 0x02
	v_left: NATURAL_8      = 0x03
	v_right: NATURAL_8     = 0x04
			-- zone@dock values

	v_floating: NATURAL_8  = 0x0
	v_tiled: NATURAL_8     = 0x1
	v_tabbed: NATURAL_8    = 0x2
	v_auto_hide: NATURAL_8 = 0x3
			-- zone@style values


;indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
