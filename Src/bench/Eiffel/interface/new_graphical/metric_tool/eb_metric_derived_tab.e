indexing
	description: "Tab to compose a derived metric definition."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_DERIVED_TAB

inherit
	EB_METRIC_NEW_DEFINITION_TAB
		undefine
			default_create, is_equal, copy
		redefine
			preset
		end

	EV_VERTICAL_BOX

	EB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

create
	make

feature -- Initialization

	make (i: EB_METRIC_NEW_DEFINITION_CMD) is
			-- Tab to compose a derived metric.
		require
			valid_interface: i/= Void
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			hsep: EV_HORIZONTAL_SEPARATOR
			frame: EV_FRAME
			label: EV_LABEL
		do
			interface := i
			default_create
			set_padding (5)
			set_border_width (3)

				create hb
				hb.set_padding (5)
				hb.set_border_width (3)
					create label.make_with_text ("New metric name:")
					label.align_text_left
					label.set_minimum_width (85)
					hb.extend (label)
					hb.disable_item_expand (label)

					create name_field
					name_field.set_minimum_height (22)
					name_field.key_press_actions.extend (~dialog_key_press_action (?, name_field))
					name_field.key_press_string_actions.extend (~change_in_name)
					hb.extend (name_field)
				extend (hb)
				disable_item_expand (hb)

				create hb
				hb.set_padding (5)
				hb.set_border_width (3)
					create label.make_with_text ("New metric unit:")
					label.align_text_left
					label.set_minimum_width (85)
					hb.extend (label)
					hb.disable_item_expand (label)

					create unit_field
					unit_field.set_minimum_height (22)
					unit_field.disable_edit
					unit_field.key_press_actions.extend (~dialog_key_press_action (?, unit_field))
					hb.extend (unit_field)
				extend (hb)
				disable_item_expand (hb)

				create hsep
				extend (hsep)
				disable_item_expand (hsep)

				create vb
--				vb.set_border_width (5)
--				vb.set_padding (5)

					create hb
					hb.set_border_width (3)
					hb.set_padding (5)
						create label.make_with_text ("Raw metric:")
						label.align_text_left
						label.set_minimum_width (85)
						hb.extend (label)
						hb.disable_item_expand (label)

						create raw_metric_combobox
						fill_raw_metric_combobox
--						raw_metric_combobox.set_text (raw_metric_combobox.first.text)
						raw_metric_combobox.disable_edit
						raw_metric_combobox.select_actions.extend (~choose_panel)
						hb.extend (raw_metric_combobox)
--						hb.disable_item_expand (raw_metric_combobox)
					vb.extend (hb)
					vb.disable_item_expand (hb)

				create frame.make_with_text ("Count if")
					create hb
					hb.set_border_width (5)
					hb.set_padding (5)
						create or_button.make_with_text ("At least one of the following is met")
						or_button.select_actions.extend (~enable_save)
						hb.extend (or_button)
						hb.disable_item_expand (or_button)

						create and_button.make_with_text ("All of the following are met")
						and_button.select_actions.extend (~enable_save)
						hb.extend (and_button)
						hb.disable_item_expand (and_button)

						hb.enable_homogeneous
					frame.extend (hb)
				vb.extend (frame)
				vb.disable_item_expand (frame)

				create frame.make_with_text ("Criteria")
				frame.set_minimum_size (410, 244)
					create panel
					panel.set_border_width (5)
					panel.set_padding (5)

					frame.extend (panel)
					build_classes_panel
				vb.extend (frame)
			extend (vb)

			preset
			name_field.key_press_actions.extend (~following_widget (?, raw_metric_combobox))
		end

	raw_metric_combobox: EV_COMBO_BOX
		-- Combobox containing all raw metrics.

	panel: EV_VERTICAL_BOX
		-- Panel containing radio buttons to allow user to select his criteria.
		-- Panel is specific to each raw metric.

	or_button, and_button: EV_RADIO_BUTTON
		-- Radio buttons to define the boolean combination of selected criteria
		-- (and/or combination).

	agent_array: ARRAY [FUNCTION [ANY, TUPLE [EB_METRIC_SCOPE], BOOLEAN]]
		-- Array of agents corresponding to the selected criteria.

	set_agent_array (aa: ARRAY [FUNCTION [ANY, TUPLE [EB_METRIC_SCOPE], BOOLEAN]]) is
			-- Assign `aa' to `agent_array'.
		require
			valid_aa: aa /= Void
		do
			agent_array := aa
		end

	fill_raw_metric_combobox is
			-- Build `raw_metric_combobox'.
		local
			list_item: EV_LIST_ITEM
		do
			create list_item.make_with_text (interface_names.metric_classes)
			raw_metric_combobox.extend (list_item)
			create list_item.make_with_text (interface_names.metric_dependents)
			raw_metric_combobox.extend (list_item)
			create list_item.make_with_text (interface_names.metric_features)
			raw_metric_combobox.extend (list_item)
		end

	choose_panel is
			-- Build right panel regarding selected raw metric.
		local
			selected_text: STRING
		do
			selected_text := raw_metric_combobox.text
			if not selected_text.is_empty then
				if equal (selected_text, interface_names.metric_classes) then
					unit_field.set_text (interface_names.metric_class_unit)
					build_classes_panel
				elseif equal (selected_text, interface_names.metric_dependents) then
					unit_field.set_text (interface_names.metric_class_unit)
					build_dependents_panel
				elseif equal (selected_text, interface_names.metric_features) then
					unit_field.set_text (interface_names.metric_feature_unit)
					build_features_panel
				end
			end
			enable_save
		end

	bf: EB_METRIC_BASIC_FUNCTIONALITIES
		-- Object to call crieteria agents to fill in `agent_array'.

	deferred_class, effective_class, ignore_deferred_class,
	invariant_equi, not_invariant_equi, ignore_invariant,
	obsolete_class, not_obsolete_class, ignore_obsolete: EV_RADIO_BUTTON
		-- Radio button displayed in the "classes" raw metric panel.

	build_classes_panel is
			-- Build panel for "classes" raw metric.
		local
			hb: EV_HORIZONTAL_BOX
		do
			create bf

			panel.wipe_out
			create hb

				create deferred_class.make_with_text (interface_names.metric_deferred_class)
				deferred_class.select_actions.extend (~enable_save)
				hb.extend (deferred_class)
				hb.disable_item_expand (deferred_class)

				create effective_class.make_with_text (interface_names.metric_effective_class)
				effective_class.select_actions.extend (~enable_save)
				hb.extend (effective_class)
				hb.disable_item_expand (effective_class)

				create ignore_deferred_class.make_with_text (interface_names.metric_ignore)
				ignore_deferred_class.select_actions.extend (~enable_save)
				hb.extend (ignore_deferred_class)
				ignore_deferred_class.enable_select
				hb.disable_item_expand (ignore_deferred_class)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

			create hb

				create invariant_equi.make_with_text (interface_names.metric_invariant_equipped)
				invariant_equi.select_actions.extend (~enable_save)
				hb.extend (invariant_equi)
				hb.disable_item_expand (invariant_equi)

				create not_invariant_equi.make_with_text (interface_names.metric_no_invariant)
				not_invariant_equi.select_actions.extend (~enable_save)
				hb.extend (not_invariant_equi)
				hb.disable_item_expand (not_invariant_equi)

				create ignore_invariant.make_with_text (interface_names.metric_ignore)
				ignore_invariant.select_actions.extend (~enable_save)
				hb.extend (ignore_invariant)
				ignore_invariant.enable_select
				hb.disable_item_expand (ignore_invariant)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

			create hb

				create obsolete_class.make_with_text (interface_names.metric_obsolete)
				obsolete_class.select_actions.extend (~enable_save)
				hb.extend (obsolete_class)
				hb.disable_item_expand (obsolete_class)

				create not_obsolete_class.make_with_text (interface_names.metric_no_obsolete)
				not_obsolete_class.select_actions.extend (~enable_save)
				hb.extend (not_obsolete_class)
				hb.disable_item_expand (not_obsolete_class)

				create ignore_obsolete.make_with_text (interface_names.metric_ignore)
				ignore_obsolete.select_actions.extend (~enable_save)
				hb.extend (ignore_obsolete)
				ignore_obsolete.enable_select
				hb.disable_item_expand (ignore_obsolete)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

			min_scope := Class_scope
		end

	self, not_self,	direct_clients, indirect_clients, ignore_clients,
	direct_suppliers, indirect_suppliers, ignore_suppliers,
	direct_heirs, indirect_heirs, ignore_heirs,
	direct_parents, indirect_parents, ignore_parents: EV_RADIO_BUTTON
		-- Radio button displayed in the "dependents" raw metric panel.

	build_dependents_panel is
			-- Build panel for "dependents" raw metric.
		local
			hb: EV_HORIZONTAL_BOX
		do

			create bf

			panel.wipe_out
			create hb

				create self.make_with_text ("Include self (dependent or not)")
				self.select_actions.extend (~enable_save)
				hb.extend (self)
				hb.disable_item_expand (self)

				create not_self.make_with_text ("Exclude self unless dependent")
				not_self.select_actions.extend (~enable_save)
				hb.extend (not_self)
				not_self.enable_select
				hb.disable_item_expand (not_self)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

			create hb

				create direct_clients.make_with_text ("Direct clients")
				direct_clients.select_actions.extend (~enable_save)
				hb.extend (direct_clients)
				hb.disable_item_expand (direct_clients)

				create indirect_clients.make_with_text ("Direct and indirect clients")
				indirect_clients.select_actions.extend (~enable_save)
				hb.extend (indirect_clients)
				hb.disable_item_expand (indirect_clients)

				create ignore_clients.make_with_text (interface_names.metric_ignore)
				ignore_clients.select_actions.extend (~enable_save)
				hb.extend (ignore_clients)
				ignore_clients.enable_select
				hb.disable_item_expand (ignore_clients)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

			create hb

				create direct_suppliers.make_with_text ("Direct suppliers")
				direct_suppliers.select_actions.extend (~enable_save)
				hb.extend (direct_suppliers)
				hb.disable_item_expand (direct_suppliers)

				create indirect_suppliers.make_with_text ("Direct and indirect suppliers")
				indirect_suppliers.select_actions.extend (~enable_save)
				hb.extend (indirect_suppliers)
				hb.disable_item_expand (indirect_suppliers)

				create ignore_suppliers.make_with_text (interface_names.metric_ignore)
				ignore_suppliers.select_actions.extend (~enable_save)
				hb.extend (ignore_suppliers)
				ignore_suppliers.enable_select
				hb.disable_item_expand (ignore_suppliers)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

			create hb

				create direct_heirs.make_with_text ("Direct heirs")
				direct_heirs.select_actions.extend (~enable_save)
				hb.extend (direct_heirs)
				hb.disable_item_expand (direct_heirs)

				create indirect_heirs.make_with_text ("Direct and indirect heirs")
				indirect_heirs.select_actions.extend (~enable_save)
				hb.extend (indirect_heirs)
				hb.disable_item_expand (indirect_heirs)

				create ignore_heirs.make_with_text (interface_names.metric_ignore)
				ignore_heirs.select_actions.extend (~enable_save)
				hb.extend (ignore_heirs)
				ignore_heirs.enable_select
				hb.disable_item_expand (ignore_heirs)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

			create hb

				create direct_parents.make_with_text ("Direct parents")
				direct_parents.select_actions.extend (~enable_save)
				hb.extend (direct_parents)
				hb.disable_item_expand (direct_parents)

				create indirect_parents.make_with_text ("Direct and indirect parents")
				indirect_parents.select_actions.extend (~enable_save)
				hb.extend (indirect_parents)
				hb.disable_item_expand (indirect_parents)

				create ignore_parents.make_with_text (interface_names.metric_ignore)
				ignore_parents.select_actions.extend (~enable_save)
				hb.extend (ignore_parents)
				ignore_parents.enable_select
				hb.disable_item_expand (ignore_parents)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

			min_scope := Class_scope
		end

	attr, rout, ignore_attr_rout,
	quer, comm, ignore_quer_comm,
	func, not_func, ignore_func,
	deferred_feat, effective_feat, ignore_deferred_feat,
	exported, not_exported, ignore_exported,
	inherited, not_inherited, ignore_inherited,
	pre_equi, not_pre_equi, ignore_pre_equi,
	post_equi, not_post_equi, ignore_post_equi: EV_RADIO_BUTTON
		-- Radio button displayed in the "features" raw metric panel.

	build_features_panel is
			-- Build panel for "features" raw metric.
		local
			hb: EV_HORIZONTAL_BOX
		do
			create bf

			panel.wipe_out
			create hb

				create attr.make_with_text (interface_names.metric_attributes)
				attr.select_actions.extend (~enable_save)
				hb.extend (attr)
				hb.disable_item_expand (attr)

				create rout.make_with_text (interface_names.metric_routines)
				rout.select_actions.extend (~enable_save)
				hb.extend (rout)
				hb.disable_item_expand (rout)

				create ignore_attr_rout.make_with_text (interface_names.metric_ignore)
				ignore_attr_rout.select_actions.extend (~enable_save)
				hb.extend (ignore_attr_rout)
				ignore_attr_rout.enable_select
				hb.disable_item_expand (ignore_attr_rout)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

			create hb

				create quer.make_with_text (interface_names.metric_queries)
				quer.select_actions.extend (~enable_save)
				hb.extend (quer)
				hb.disable_item_expand (quer)

				create comm.make_with_text (interface_names.metric_commands)
				comm.select_actions.extend (~enable_save)
				hb.extend (comm)
				hb.disable_item_expand (comm)

				create ignore_quer_comm.make_with_text (interface_names.metric_ignore)
				ignore_quer_comm.select_actions.extend (~enable_save)
				hb.extend (ignore_quer_comm)
				ignore_quer_comm.enable_select
				hb.disable_item_expand (ignore_quer_comm)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

			create hb

				create func.make_with_text (interface_names.metric_functions)
				func.select_actions.extend (~enable_save)
				hb.extend (func)
				hb.disable_item_expand (func)

				create not_func.make_with_text ("Not functions")
				not_func.select_actions.extend (~enable_save)
				hb.extend (not_func)
				hb.disable_item_expand (not_func)

				create ignore_func.make_with_text (interface_names.metric_ignore)
				ignore_func.select_actions.extend (~enable_save)
				hb.extend (ignore_func)
				ignore_func.enable_select
				hb.disable_item_expand (ignore_func)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

			create hb

				create deferred_feat.make_with_text (interface_names.metric_deferred_feature)
				deferred_feat.select_actions.extend (~enable_save)
				hb.extend (deferred_feat)
				hb.disable_item_expand (deferred_feat)

				create effective_feat.make_with_text ("Effective")
				effective_feat.select_actions.extend (~enable_save)
				hb.extend (effective_feat)
				hb.disable_item_expand (effective_feat)

				create ignore_deferred_feat.make_with_text (interface_names.metric_ignore)
				ignore_deferred_feat.select_actions.extend (~enable_save)
				hb.extend (ignore_deferred_feat)
				ignore_deferred_feat.enable_select
				hb.disable_item_expand (ignore_deferred_feat)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

			create hb

				create exported.make_with_text (interface_names.metric_exported)
				exported.select_actions.extend (~enable_save)
				hb.extend (exported)
				hb.disable_item_expand (exported)

				create not_exported.make_with_text ("Restricted")
				not_exported.select_actions.extend (~enable_save)
				hb.extend (not_exported)
				hb.disable_item_expand (not_exported)

				create ignore_exported.make_with_text (interface_names.metric_ignore)
				ignore_exported.select_actions.extend (~enable_save)
				hb.extend (ignore_exported)
				ignore_exported.enable_select
				hb.disable_item_expand (ignore_exported)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

			create hb

				create inherited.make_with_text (interface_names.metric_inherited)
				inherited.select_actions.extend (~enable_save)
				hb.extend (inherited)
				hb.disable_item_expand (inherited)

				create not_inherited.make_with_text ("Not inherited")
				not_inherited.select_actions.extend (~enable_save)
				hb.extend (not_inherited)
				hb.disable_item_expand (not_inherited)

				create ignore_inherited.make_with_text (interface_names.metric_ignore)
				ignore_inherited.select_actions.extend (~enable_save)
				hb.extend (ignore_inherited)
				ignore_inherited.enable_select
				hb.disable_item_expand (ignore_inherited)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

			create hb

				create pre_equi.make_with_text (interface_names.metric_precondition_equipped)
				pre_equi.select_actions.extend (~enable_save)
				hb.extend (pre_equi)
				hb.disable_item_expand (pre_equi)

				create not_pre_equi.make_with_text ("No precondition")
				not_pre_equi.select_actions.extend (~enable_save)
				hb.extend (not_pre_equi)
				hb.disable_item_expand (not_pre_equi)

				create ignore_pre_equi.make_with_text (interface_names.metric_ignore)
				ignore_pre_equi.select_actions.extend (~enable_save)
				hb.extend (ignore_pre_equi)
				ignore_pre_equi.enable_select
				hb.disable_item_expand (ignore_pre_equi)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

			create hb

				create post_equi.make_with_text (interface_names.metric_postcondition_equipped)
				post_equi.select_actions.extend (~enable_save)
				hb.extend (post_equi)
				hb.disable_item_expand (post_equi)

				create not_post_equi.make_with_text ("No postcondition")
				not_post_equi.select_actions.extend (~enable_save)
				hb.extend (not_post_equi)
				hb.disable_item_expand (not_post_equi)

				create ignore_post_equi.make_with_text (interface_names.metric_ignore)
				ignore_post_equi.select_actions.extend (~enable_save)
				hb.extend (ignore_post_equi)
				ignore_post_equi.enable_select
				hb.disable_item_expand (ignore_post_equi)

			hb.enable_homogeneous
			panel.extend (hb)
			panel.disable_item_expand (hb)

--			min_scope := Feature_scope
			min_scope := Class_scope
		end

	number_of_criteria_lines: INTEGER is
			-- Number of available criteria for the currently displayed raw metric.
		do
			if equal (raw_metric_combobox.text, interface_names.metric_classes) then
				Result := 3
			elseif equal (raw_metric_combobox.text, interface_names.metric_dependents) then
				Result := 4
			elseif equal (raw_metric_combobox.text, interface_names.metric_features) then
				Result := 8
			end
		end


	new_metric: EB_METRIC_DERIVED is
			-- Build new metric regarding selected criteria.
			-- Rely on `new_metric_element' that must be called before.
		require else
			valid_raw_metric_name: raw_metric_combobox.text /= Void and then not raw_metric_combobox.text.is_empty
		local
			and_op, include_self: BOOLEAN
			a_name, a_unit, raw_metric_name: STRING
		do
			a_name := name_field.text
			a_unit := unit_field.text
			raw_metric_name := raw_metric_combobox.text
			and_op := and_button.is_selected
			agent_array := interface.tool.file_handler.build_agent_array (metric_definition, bf)
			if equal (raw_metric_name, interface_names.metric_dependents) then
				include_self := self.is_selected
			end
			create Result.make (a_name, a_unit, raw_metric_name, interface.tool, min_scope,
						agent_array, and_op, include_self, bf)
			new_metric_successful := True
		end

	new_metric_element: XML_ELEMENT is
			-- Build a storable definition for the metric being saved.
		require else
			valid_raw_metric_name: raw_metric_combobox.text /= Void and then not raw_metric_combobox.text.is_empty
		local
			a_name, a_unit, raw_metric_name: STRING
			xml_attribute: XML_ATTRIBUTE
			formula: STRING
		do
			a_name := name_field.text
			a_unit := unit_field.text
			Result := interface.tool.file_manager.metric_element (a_name, a_unit, "Derived")
			create xml_attribute.make ("Min_scope", to_scope (min_scope))
			Result.attributes.add_attribute (xml_attribute)
			create metric_definition.make (Result, "DEFINITION")
			raw_metric_name := raw_metric_combobox.text
			metric_definition.put_last (xml_node (metric_definition, "Raw_metric", raw_metric_name))
			metric_definition.put_last (xml_node (metric_definition, "And", and_button.is_selected.out))

			if equal (raw_metric_name, interface_names.metric_classes) then
				if not ignore_deferred_class.is_selected then
					metric_definition.put_last (xml_node (metric_definition, "Deferred_class", deferred_class.is_selected.out))
				end
				if not ignore_invariant.is_selected then
					metric_definition.put_last (xml_node (metric_definition, "Invariant", invariant_equi.is_selected.out))
				end
				if not ignore_obsolete.is_selected then
					metric_definition.put_last (xml_node (metric_definition, "Obsolete", obsolete_class.is_selected.out))
				end

			elseif equal (raw_metric_name, interface_names.metric_dependents) then
				metric_definition.put_last (xml_node (metric_definition, "Self", self.is_selected.out))
				if not ignore_clients.is_selected then
					metric_definition.put_last (xml_node (metric_definition, "D_or_i_clients", direct_clients.is_selected.out))
				end
				if not ignore_suppliers.is_selected then
					metric_definition.put_last (xml_node (metric_definition, "D_or_i_suppliers", direct_suppliers.is_selected.out))
				end
				if not ignore_heirs.is_selected then
					metric_definition.put_last (xml_node (metric_definition, "D_or_i_heirs", direct_heirs.is_selected.out))
				end
				if not ignore_parents.is_selected then
					metric_definition.put_last (xml_node (metric_definition, "D_or_i_parents", direct_parents.is_selected.out))
				end

			elseif equal (raw_metric_name, interface_names.metric_features) then
				if not ignore_attr_rout.is_selected then
					metric_definition.put_last (xml_node (metric_definition, "Attr_or_rout", attr.is_selected.out))
				end
				if not ignore_quer_comm.is_selected then
					metric_definition.put_last (xml_node (metric_definition, "Quer_or_comm", quer.is_selected.out))
				end
				if not ignore_func.is_selected then
					metric_definition.put_last (xml_node (metric_definition, "Function", func.is_selected.out))
				end
				if not ignore_deferred_feat.is_selected then
					metric_definition.put_last (xml_node (metric_definition, "Deferred_feat", deferred_feat.is_selected.out))
				end
				if not ignore_exported.is_selected then
					metric_definition.put_last (xml_node (metric_definition, "Exported", exported.is_selected.out))
				end
				if not ignore_inherited.is_selected then
					metric_definition.put_last (xml_node (metric_definition, "Inherited", inherited.is_selected.out))
				end
				if not ignore_pre_equi.is_selected then
					metric_definition.put_last (xml_node (metric_definition, "Pre_equi", pre_equi.is_selected.out))
				end
				if not ignore_post_equi.is_selected then
					metric_definition.put_last (xml_node (metric_definition, "Post_equi", post_equi.is_selected.out))
				end

			end

			Result.put_last (metric_definition)
			formula := criteria
			Result.put_last (xml_node (Result, "FORMULA", formula))
		end

	criteria: STRING is
			-- Sum up of the selected criteria.
			-- represent the formula of the currently saved metric
		require
			metric_definition_built: metric_definition /= Void and then not metric_definition.is_empty
		local
			node: XML_ELEMENT
		do
			Result := ""
			from
				metric_definition.start
			until
				metric_definition.after
			loop
				node ?= metric_definition.item_for_iteration
				Result.append (node.name + ": " + interface.tool.file_handler.content_of_node (node) + ", ")
				metric_definition.forth
			end
			Result.keep_head (Result.count - 2)
		end

	valid_metric_definition: BOOLEAN is
			-- Whatever user select, metric definition cannot be wrong
			-- since it relies on selecting criteria thanks to radio buttons.
			-- There could not be any syntax error.
		do
			Result := True
		end

	error: BOOLEAN is
			-- Is there any error in `Current' definition?
			-- Error could be an empty name or
			-- choosing a name previously used to define a metric.
		local
			basic_metric: EB_METRIC_BASIC
		do
			error_name := name_field.text = Void or else name_field.text.is_empty
			if not error_name then
				error_name := name_field.text.has ('<') or name_field.text.has ('>')
			end
			if not name_field.text.is_empty then
				basic_metric ?= interface.tool.metric (name_field.text)
				existing_basic_name := basic_metric /= Void
			end

			Result := error_name or existing_basic_name
		end
		
	throw_error is
			-- Must be called after `error' to display an information dialog.
		local
			error_dialog: EB_INFORMATION_DIALOG
			x_pos, y_pos: INTEGER
		do
			x_pos := interface.new_metric_definition_dialog.x_position + 40
			y_pos := interface.new_metric_definition_dialog.y_position + 80

			if error_name then
				create error_dialog.make_with_text ("Name is empty or has invalid%N%
													%characters (<, >).")
				error_dialog.set_position (x_pos, y_pos)
				error_dialog.show_modal_to_window (interface.new_metric_definition_dialog)
			elseif existing_basic_name then
				create error_dialog.make_with_text ("There is already a basic metric%N%
											%with the same name. You cannot%N%
											%overwrite it.")
				error_dialog.set_position (x_pos, y_pos)
				error_dialog.show_modal_to_window (interface.new_metric_definition_dialog)
			end
		end


	something_to_save: BOOLEAN is
			-- Did user make any selection or any change that could be saved?
		do
			if equal (raw_metric_combobox.text, interface_names.metric_classes) then
				Result := not (ignore_deferred_class.is_selected and
					ignore_invariant.is_selected and ignore_obsolete.is_selected)
			elseif equal (raw_metric_combobox.text, interface_names.metric_dependents) then
				Result := not (ignore_clients.is_selected and ignore_heirs.is_selected and
					ignore_parents.is_selected and ignore_suppliers.is_selected)
			elseif equal (raw_metric_combobox.text, interface_names.metric_features) then
				Result := not (ignore_attr_rout.is_selected and ignore_quer_comm.is_selected and
					ignore_func.is_selected and ignore_deferred_feat.is_selected and
					ignore_exported.is_selected and ignore_inherited.is_selected and
					ignore_pre_equi.is_selected and ignore_post_equi.is_selected)
			end
			Result := Result or (name_field.text /= Void and then not name_field.text.is_empty)
		end

	preset is
			-- Reset fields and useful objects
		do
			precursor
--			raw_metric_combobox.set_text (raw_metric_combobox.first.text)
			raw_metric_combobox.first.enable_select
			unit_field.set_text (interface_names.metric_class_unit)
			or_button.enable_select
			build_classes_panel
		end

end -- class EB_METRIC_DERIVED_TAB
