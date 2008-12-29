note
	description: "Objects that specify visibility of classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_VISIBLE

inherit
	CONF_ACCESS

feature -- Basic commands

	update_visible (a_added_classes: DS_HASH_SET [CONF_CLASS])
			-- Update visible options on classes.
		require
			a_added_classes_not_void: a_added_classes /= Void
		local
			l_vis: EQUALITY_TUPLE [TUPLE [class_renamed: STRING; features: EQUALITY_HASH_TABLE [STRING, STRING]]]
			l_class: CONF_CLASS
			l_error: BOOLEAN
			l_map: HASH_TABLE [STRING, STRING]
			l_name: STRING
		do
			if classes /= Void and visible /= Void then
				create last_warnings.make
				from
					l_map := mapping
					visible.start
				until
					l_error or else visible.after
				loop
					l_name := visible.key_for_iteration
					if l_map.has_key (l_name) then
						l_name := l_map.found_item
					end
					l_vis := visible.item_for_iteration.item
					l_class := classes.item (l_name)
					if l_class = Void then
						last_warnings.force (create {CONF_ERROR_VISI}.make (l_name))
					else
						l_class.add_visible (l_vis)
						if l_class.is_error then
							l_error := True
							set_error (l_class.last_error)
						end
						if not l_class.is_compiled and l_class.is_always_compile then
							a_added_classes.force (l_class)
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

	visible: EQUALITY_HASH_TABLE [EQUALITY_TUPLE [TUPLE [class_renamed: STRING; features: EQUALITY_HASH_TABLE [STRING, STRING]]], STRING]
			-- Table of table of features of classes that are visible.
			-- Mapped to their rename (if any).
			-- CLASS_NAME => [CLASS_RENAMED, feature_name => feature_renamed]
			-- CLASS_NAME => [CLASS_RENAMED, Void] means everything is visible

feature {CONF_ACCESS} -- Update, stored to configuration file

	set_visible (a_visible: like visible)
			-- Set `visible' to `a_visible'.
		do
			visible := a_visible
		ensure
			visible_set: visible = a_visible
		end

	add_visible (a_class, a_feature, a_class_rename, a_feature_rename: STRING)
			-- Add a visible.
		require
			a_class_ok: a_class /= Void and then not a_class.is_empty
			a_feature_ok: a_feature /= Void implies not a_feature.is_empty
			a_class_rename_ok: a_class_rename /= Void implies not a_class_rename.is_empty
			a_feature_rename_ok: a_feature_rename /= Void implies not a_feature_rename.is_empty
			a_feature_rename_implies_feature: a_feature_rename /= Void implies a_feature /= Void
		local
			l_v_cl: EQUALITY_HASH_TABLE [STRING, STRING]
			l_tpl: EQUALITY_TUPLE [TUPLE [class_renamed: STRING; features: EQUALITY_HASH_TABLE [STRING, STRING]]]
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
			l_tpl.item.class_renamed := l_visible_name
			if l_feature /= Void then
				l_v_cl := l_tpl.item.features
				if l_v_cl = Void then
					create l_v_cl.make (1)
					l_tpl.item.features := l_v_cl
				end
				l_v_cl.force (l_feature_name, l_feature)
			end
			visible.force (l_tpl, l_class)
		end

feature {NONE} -- Implementation

	mapping: EQUALITY_HASH_TABLE [STRING_8, STRING_8]
			-- Special classes name mapping (eg. STRING => STRING_32).
		deferred
		ensure
			result_not_void: Result /= Void
		end

	classes: HASH_TABLE [CONF_CLASS, STRING]
			-- List of classes.
		deferred
		end

	set_error (an_error: CONF_ERROR)
			-- Set `an_error'.
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
