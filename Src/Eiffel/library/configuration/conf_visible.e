indexing
	description: "Objects that specify visibility of classes."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_VISIBLE

inherit
	CONF_ACCESS

feature -- Basic commands

	update_visible is
			-- Update visible options on classes.
		local
			l_vis: TUPLE [class_renamed: STRING; features: CONF_HASH_TABLE [STRING, STRING]]
			l_class: CONF_CLASS
			l_error: BOOLEAN
		do
			if classes /= Void and visible /= Void then
				create last_warnings.make
				from
					visible.start
				until
					l_error or else visible.after
				loop
					l_vis := visible.item_for_iteration
					l_class := classes.item (visible.key_for_iteration)
					if l_class = Void then
						last_warnings.force (create {CONF_ERROR_VISI}.make (visible.key_for_iteration))
					else
						l_class.add_visible (l_vis)
						if l_class.is_error then
							l_error := True
							set_error (l_class.last_error)
						end
					end

					visible.forth
				end
			end
		end

feature -- Status

	last_warnings: LINKED_LIST [CONF_ERROR]
			-- Warnings generated during `update_visible'.

feature {CONF_ACCESS} -- Access, stored in configuration file

	visible: CONF_HASH_TABLE [TUPLE [class_renamed: STRING; features: CONF_HASH_TABLE [STRING, STRING]], STRING]
			-- Table of table of features of classes that are visible.
			-- Mapped to their rename (if any).
			-- CLASS_NAME => [CLASS_RENAMED, feature_name => feature_renamed]
			-- CLASS_NAME => [CLASS_RENAMED, Void] means everything is visible

feature {CONF_ACCESS} -- Update, stored to configuration file

	add_visible (a_class, a_feature, a_class_rename, a_feature_rename: STRING) is
			-- Add a visible.
		require
			a_class_ok: a_class /= Void and then not a_class.is_empty
			a_feature_ok: a_feature /= Void implies a_feature.is_equal (a_feature.as_lower) and not a_feature.is_empty
			a_class_rename_ok: a_class_rename /= Void implies not a_class_rename.is_empty
			a_feature_rename_ok: a_feature_rename /= Void implies not a_feature_rename.is_empty
			a_feature_rename_implies_feature: a_feature_rename /= Void implies a_feature /= Void
		local
			l_v_cl: CONF_HASH_TABLE [STRING, STRING]
			l_tpl: TUPLE [class_renamed: STRING; features: CONF_HASH_TABLE [STRING, STRING]]
			l_visible_name, l_feature_name: STRING
			l_class, l_feature: STRING
		do
			if visible = Void then
				create visible.make (1)
			end
			l_class := a_class.as_upper
			if a_feature /= Void then
				l_feature := a_feature.as_lower
			end
			if a_class_rename /= Void then
				l_visible_name := a_class_rename.as_upper
			else
				l_visible_name := l_class
			end
			if a_feature_rename /= Void then
				l_feature_name := a_feature_rename.as_lower
			else
				l_feature_name := l_feature
			end

			l_tpl := visible.item (l_class)
			if l_tpl = Void then
				create l_tpl
			end
			l_tpl.class_renamed := l_visible_name
			if l_feature /= Void then
				l_v_cl := l_tpl.features
				if l_v_cl = Void then
					create l_v_cl.make (1)
					l_tpl.features := l_v_cl
				end
				l_v_cl.force (l_feature_name, l_feature)
			end
			visible.force (l_tpl, l_class)
		end

feature {NONE} -- Implementation

	classes: HASH_TABLE [CONF_CLASS, STRING] is
			-- List of classes.
		deferred
		end

	set_error (an_error: CONF_ERROR) is
			-- Set `an_error'.
		deferred
		end

end
