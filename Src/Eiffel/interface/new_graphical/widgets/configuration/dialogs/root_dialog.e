indexing
	description: "Dialog to edit the root of a target."
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT_DIALOG

inherit
	PROPERTY_DIALOG [CONF_ROOT]
		redefine
			initialize,
			on_ok
		end

	CONF_INTERFACE_NAMES
		undefine
			default_create, copy
		end

	CONF_ACCESS
		undefine
			default_create, copy
		end


feature {NONE} -- Initialization

	initialize is
			-- Initialization
		local
			l_label: EV_LABEL
		do
			Precursor {PROPERTY_DIALOG}

			create l_label.make_with_text (target_dialog_root_cluster)
			element_container.extend (l_label)
			element_container.disable_item_expand (l_label)
			l_label.align_text_left
			create cluster_name
			element_container.extend (cluster_name)
			element_container.disable_item_expand (cluster_name)
			append_small_margin (element_container)

			create l_label.make_with_text (target_dialog_root_class)
			element_container.extend (l_label)
			element_container.disable_item_expand (l_label)
			l_label.align_text_left
			create class_name
			element_container.extend (class_name)
			element_container.disable_item_expand (class_name)
			append_small_margin (element_container)

			create l_label.make_with_text (target_dialog_root_feature)
			element_container.extend (l_label)
			element_container.disable_item_expand (l_label)
			l_label.align_text_left
			create feature_name
			element_container.extend (feature_name)
			element_container.disable_item_expand (feature_name)
			append_small_margin (element_container)

			create all_classes.make_with_text (target_dialog_root_all)
			element_container.extend (all_classes)
			element_container.disable_item_expand (all_classes)
			append_small_margin (element_container)

			set_size (200, 0)
			show_actions.extend (agent on_show)
			all_classes.select_actions.extend (agent on_all_classes)
		end

feature {NONE} -- Gui elements

	cluster_name: EV_TEXT_FIELD
			-- Field to enter the root cluster.

	class_name: EV_TEXT_FIELD
			-- Field to enter the root class.

	feature_name: EV_TEXT_FIELD
			-- Field to enter the root feature name.

	all_classes: EV_CHECK_BUTTON
			-- Compile all classes check box.

feature {NONE} -- Agents

	on_show is
			-- Called if the dialog is shown.
		require
			initialized: is_initialized
		do
			if value /= Void then
				if value.is_all_root then
					all_classes.enable_select
				else
					all_classes.disable_select
					if value.cluster_name /= Void then
						cluster_name.set_text (value.cluster_name)
					end
					class_name.set_text (value.class_name)
					if value.feature_name /= Void then
						feature_name.set_text (value.feature_name)
					end
				end
			end
		end

	on_all_classes is
			-- All classes was selected.
		do
			if all_classes.is_selected then
				cluster_name.disable_sensitive
				class_name.disable_sensitive
				feature_name.disable_sensitive
			else
				cluster_name.enable_sensitive
				class_name.enable_sensitive
				feature_name.enable_sensitive
			end
		end

	on_ok is
			-- Ok was pressed.
		local
			l_root: CONF_ROOT
			l_cluster, l_class, l_feature: STRING
			wd: EV_WARNING_DIALOG
		do
			if all_classes.is_selected then
				create l_root.make (Void, Void, Void, True)
			else
				l_cluster := cluster_name.text.to_string_8
				if l_cluster.is_empty then
					l_cluster := Void
				end
				l_class := class_name.text.to_string_8
				l_feature := feature_name.text.to_string_8
				if l_feature.is_empty then
					l_feature := Void
				end
				if not l_class.is_empty then
					create l_root.make (l_cluster, l_class, l_feature, False)
				elseif l_cluster /= Void or l_feature /= Void then
					create wd.make_with_text (root_no_class)
				end
			end

			if wd = Void then
				set_value (l_root)
				Precursor {PROPERTY_DIALOG}
			else
				wd.show_modal_to_window (Current)
			end
		end


invariant
	elements: is_initialized implies cluster_name /= Void and class_name /= Void and feature_name /= Void and all_classes /= Void

end
