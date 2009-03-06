note
	description: "Let you see all the features of the system in the feature tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_CHECKER_TOOL

inherit
	ANY

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_development_window: like development_window)
			-- Initialize Current using `a_development_window'.
		require
			a_development_window_attached: a_development_window /= Void
		do
			development_window := a_development_window
			build_interface
		ensure
			development_window_set: development_window = a_development_window
		end

	build_interface
			-- Build UI.
		local
			l_ev_cell_1, l_ev_cell_2, l_ev_cell_3: EV_CELL
			l_ev_horizontal_box_1,
			l_ev_horizontal_box_2, l_ev_horizontal_box_3, l_hb4: EV_HORIZONTAL_BOX
			l_ev_vertical_box_1, l_ev_vertical_box_2: EV_VERTICAL_BOX
			l_ev_label_1, l_ev_label_2, l_ev_label_3: EV_LABEL
			l_ev_frame_1: EV_FRAME
		do
			create window.make_with_title ("Features traversal")

				-- Create all widgets.
			create l_ev_horizontal_box_1
			create l_ev_vertical_box_1
			create l_ev_label_1
			create l_ev_frame_1
			create l_ev_vertical_box_2
			create ignore_library_check
			create ignore_dotnet_classes_check
			create immediate_check
			create arguments_check
			create function_check
			create reference_arguments_check
			create l_ev_horizontal_box_2
			create l_ev_label_2
			create l_hb4
			create l_ev_label_3.make_with_text ("Class ID to start from: ")
			create class_selector.make_with_value_range (create {INTEGER_INTERVAL}.make (0, 100000))
			create status_label
			create l_ev_horizontal_box_3
			create l_ev_cell_1
			create load_button
			create l_ev_cell_2
			create next_button
			create l_ev_cell_3

				-- Build widget structure.
			window.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_label_1)
			l_ev_vertical_box_1.extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (ignore_library_check)
			l_ev_vertical_box_2.extend (ignore_dotnet_classes_check)
			l_ev_vertical_box_2.extend (immediate_check)
			l_ev_vertical_box_2.extend (arguments_check)
			l_ev_vertical_box_2.extend (function_check)
			l_ev_vertical_box_2.extend (reference_arguments_check)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_2)
			l_ev_vertical_box_1.extend (l_hb4)
			l_hb4.extend (l_ev_label_3)
			l_hb4.extend (class_selector)
			l_ev_horizontal_box_2.extend (l_ev_label_2)
			l_ev_horizontal_box_2.extend (status_label)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_cell_1)
			l_ev_horizontal_box_3.extend (load_button)
			l_ev_horizontal_box_3.extend (l_ev_cell_2)
			l_ev_horizontal_box_3.extend (next_button)
			l_ev_horizontal_box_3.extend (l_ev_cell_3)

			l_ev_horizontal_box_1.set_padding (5)
			l_ev_horizontal_box_1.set_border_width (5)
			l_ev_vertical_box_1.set_padding (5)
			l_ev_vertical_box_1.set_border_width (5)
			l_ev_vertical_box_1.disable_item_expand (l_ev_label_1)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_label_1.set_text ("Select a set of properties for features you want to traverse:")
			l_ev_label_1.align_text_left
			l_ev_frame_1.set_text ("Filter")
			l_ev_vertical_box_2.set_padding (5)
			l_ev_vertical_box_2.set_border_width (5)
			l_ev_vertical_box_2.disable_item_expand (ignore_library_check)
			l_ev_vertical_box_2.disable_item_expand (ignore_dotnet_classes_check)
			l_ev_vertical_box_2.disable_item_expand (immediate_check)
			l_ev_vertical_box_2.disable_item_expand (arguments_check)
			l_ev_vertical_box_2.disable_item_expand (function_check)
			l_ev_vertical_box_2.disable_item_expand (reference_arguments_check)
			ignore_library_check.set_text ("Ignore library classes")
			ignore_dotnet_classes_check.set_text ("Ignore .NET classes")
			immediate_check.set_text ("Immediate")
			arguments_check.set_text ("Arguments")
			function_check.set_text ("Function")
			reference_arguments_check.set_text ("Reference arguments")
			l_ev_vertical_box_1.disable_item_expand (l_hb4)
			l_hb4.disable_item_expand (l_ev_label_3)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_2)
			l_ev_label_2.set_text ("Overall progress: ")
			l_ev_label_2.align_text_left
			status_label.align_text_left
			l_ev_horizontal_box_3.disable_item_expand (load_button)
			l_ev_horizontal_box_3.disable_item_expand (next_button)
			load_button.set_text ("Load Features")
			next_button.set_text ("Next Feature")
			next_button.set_minimum_width (90)
			next_button.disable_sensitive

				-- Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.
			window.close_request_actions.extend (agent window.hide)

			load_button.select_actions.extend (agent load_features)
			next_button.select_actions.extend (agent go_to_next_feature)
		end

feature -- Access

	development_window: EB_DEVELOPMENT_WINDOW
			-- Associated development window

feature -- Setting

	set_development_window (a_development_window: like development_window)
		require
			a_development_window_attached: a_development_window /= Void
		do
			development_window := a_development_window
		ensure
			development_window_set: development_window = a_development_window
		end

feature {NONE} -- Access

	window: EV_TITLED_WINDOW
			-- Associated window

	status_label: EV_LABEL
	load_button, next_button: EV_BUTTON
	class_selector: EV_SPIN_BUTTON
	ignore_library_check,
	ignore_dotnet_classes_check,
	immediate_check,
	arguments_check,
	function_check,
	reference_arguments_check: EV_CHECK_BUTTON
			-- Various interesting UI elements.

feature -- Display

	show
		do
			window.show
		end

feature {NONE} -- Actions

	classes: CLASS_C_SERVER
	class_index: INTEGER
	feature_table: COMPUTED_FEATURE_TABLE
	feature_index: INTEGER

	load_features
			-- Load all classes from system to initialize traversing.
		local
			l_value: INTEGER
		do
			l_value := class_selector.value
			classes := system.classes.twin
			if not classes.valid_index (l_value) then
				l_value := classes.lower
			end
			class_index := next_class_index (l_value)
			if classes.valid_index (class_index) then
				feature_table := classes.item (class_index).feature_table.features
				feature_table.start
				feature_index := feature_table.index - 1
				next_button.enable_sensitive
				status_label.set_text (class_index.out + "/" + classes.capacity.out +
					" (" + classes.item (class_index).name + ")")
			else
				next_button.disable_sensitive
				status_label.set_text ("No matching classes")
			end
		end

	go_to_next_feature
			-- Update associated feature tool relation with the next matching feature.
		local
			l_feature: FEATURE_I
			l_done, l_processed: BOOLEAN
		do
			if feature_table /= Void and classes.valid_index (class_index) then
					-- Repeat iteration until we found a matching routine or that we reached
					-- the end of classes.
				from
				until
					l_done or l_processed
				loop
					feature_table.go_i_th (feature_index)
					if feature_table.after then
							-- We are at the end of the current feature table, go to the next
							-- class if possible and initialize the iteration for the next class.
						class_index := next_class_index (class_index + 1)
						l_done := not classes.valid_index (class_index)
						if not l_done then
							feature_table := classes.item (class_index).feature_table.features
							feature_table.start
							feature_index := feature_table.index - 1
						end
					end
					if not l_done then
							-- Go to the next feature and see if it matches the filter, if not
							-- go to the next one until we reach the end of the feature table.
						from
							feature_table.forth
							if not feature_table.after then
								l_feature := feature_table.item
							end
						until
							feature_table.after or else is_matching_feature (l_feature)
						loop
							feature_table.forth
							if not feature_table.after then
								l_feature := feature_table.item
							end
						end
						feature_index := feature_table.index
						if not feature_table.after then
								-- We found a match, we process it.
							l_processed := True
							process_feature (l_feature)
						end
					end
				end
				if l_done then
					status_label.set_text ("Completed")
					next_button.disable_sensitive
				else
					status_label.set_text (class_index.out + "/" + classes.capacity.out + " (" + classes.item (class_index).name + ")")
				end
			end
		end

	next_class_index (a_starting_index: INTEGER): INTEGER
			-- Find valid CLASS_C object after `a_starting_index'.
		require
			a_starting_index_valid: a_starting_index >= -1
		local
			l_stop: BOOLEAN
		do
			if not classes.valid_index (a_starting_index) then
				Result := a_starting_index
			else
				from
					Result := a_starting_index
				until
					l_stop
				loop
					l_stop := not classes.valid_index (Result) or else is_matching_class (classes.item (Result))
					if not l_stop then
						Result := Result + 1
					end
				end
			end
		end

	is_matching_class (a_class: CLASS_C): BOOLEAN
			-- Does `a_class' match filter?
		do
			if a_class /= Void then
				Result := True
				if Result and then ignore_dotnet_classes_check.is_selected then
					Result := not a_class.is_external_class_c
				end
				if Result and then ignore_library_check.is_selected then
					Result := a_class.lace_class.target.system = universe.target.system
				end
			end
		end

	is_matching_feature (a_feature: FEATURE_I): BOOLEAN
			-- Does `a_feature' match filter?
		require
			a_feature_attached: a_feature /= Void
		local
			l_args: FEAT_ARG
		do
			Result := True
			if Result and then immediate_check.is_selected then
				Result := a_feature.written_in = class_index
			end
			if Result and then arguments_check.is_selected then
				Result := a_feature.argument_count > 0
			end
			if Result and then function_check.is_selected then
				Result := a_feature.has_return_value
			end
			if Result and then reference_arguments_check.is_selected then
				l_args := a_feature.arguments
				if l_args /= Void then
					from
						Result := False
						l_args.start
					until
						l_args.after
					loop
						if l_args.item.is_reference then
							Result := True
							l_args.finish
						end
						l_args.forth
					end
				end
			end
		end

	process_feature (a_feature: FEATURE_I)
			-- Set the feature relation tool to `a_feature'.
		local
			l_feature_stone: FEATURE_STONE
			l_tool: ES_FEATURE_RELATION_TOOL
		do
			create l_feature_stone.make (a_feature.api_feature (class_index))
			l_tool ?= development_window.shell_tools.tool ({ES_FEATURE_RELATION_TOOL})
			l_tool.set_mode_with_stone ({ES_FEATURE_RELATION_TOOL_VIEW_MODES}.flat, l_feature_stone)
			l_tool.show (False)
		end

invariant
	development_window_attached: development_window /= Void
	window_attached: window /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
