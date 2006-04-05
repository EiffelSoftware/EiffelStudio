indexing
	description: "Objects that is a view for a FEATURE_SECTION."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_SECTION_VIEW

inherit
	EV_MODEL_GROUP
		redefine
			world
		end

	FEATURE_NAME_EXTRACTOR
		export
			{NONE} all
		undefine
			default_create
		end

	UML_CONSTANTS
		undefine
			default_create
		end

	EB_CONSTANTS
		undefine
			default_create
		end

	OBSERVER
		rename
			update as retrieve_preferences
		undefine
			default_create
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create
		end

create
	make

create {FEATURE_SECTION_VIEW}
	make_filled

feature {NONE} -- Initialize

	make (a_fs: like feature_section; a_container: like container) is
			-- Create a FEATURE_SECTION_VIEW showing `a_fs' in `a_container'.
		require
			a_fs_not_Void: a_fs /= Void
			a_container_not_Void: a_container /= Void
		local
			l_features: LIST [FEATURE_AS]
			l_feature: FEATURE_AS
			txt: EV_MODEL_TEXT
			attr_height: INTEGER
			e_feature: E_FEATURE
			visibility: STRING
			once_line: EV_MODEL_LINE
			signature: STRING
			f_names: EIFFEL_LIST [FEATURE_NAME]
		do
			default_create

			create feature_group

			attr_height := 0
			create section_text.make_with_text (" <<" + a_fs.name + ">>")
			section_text.set_pointer_style (default_pixmaps.standard_cursor)
			section_text.pointer_button_press_actions.extend (agent on_section_press)
			section_text.pointer_double_press_actions.force_extend (agent on_double_press)
			section_text.disable_events_sended_to_group

			section_text.set_point_position (point_x, point_y)
			attr_height := attr_height + section_text.height
			extend (section_text)
			if a_fs.is_any then
				visibility := "+ "
			elseif a_fs.is_some then
				visibility := "# "
			else
				visibility := "- "
			end

			from
				l_features := a_fs.features
				l_features.start
			until
				l_features.after
			loop
				l_feature := l_features.item

				e_feature := a_fs.class_c.feature_with_name (l_feature.feature_name)

				signature := full_signature_compiled (e_feature)

				from
					f_names := e_feature.ast.feature_names
					f_names.start
				until
					f_names.after
				loop
					create txt.make_with_text (visibility + f_names.item.visual_name + signature)

					txt.set_pebble (create {FEATURE_STONE}.make (e_feature))
					txt.set_accept_cursor (cursors.cur_feature)
					txt.set_deny_cursor (cursors.cur_x_feature)
					txt.set_point_position (point_x, point_y + attr_height)
					attr_height := attr_height + txt.height
					feature_group.extend (txt)
					if e_feature.is_once then
						create once_line
						feature_group.extend (once_line)
					end
					features_count := features_count + 1
					f_names.forth
				end

				l_features.forth
			end
			extend (feature_group)

			section_text.set_text ("+" + features_count.out + section_text.text)
			feature_section := a_fs
			container := a_container
			is_expanded := False
			feature_group.hide
			disable_pick_and_drop

			preferences.diagram_tool_data.add_observer (Current)
			retrieve_preferences

		ensure
			set: feature_section = a_fs and container = a_container
			collabsed: not is_expanded
		end

feature -- Access

	feature_section: FEATURE_SECTION
			-- Model `Current' is a View for.

	container: UML_CLASS_FIGURE
			-- container containing `Current'

	is_expanded: BOOLEAN
			-- Is section expanded?

	world: EG_FIGURE_WORLD is
			-- World `Current' is part of.
		do
			Result ?= Precursor {EV_MODEL_GROUP}
		end

feature -- Element change

	expand is
			-- Expand feature section.
		require
			is_collabsed: not is_expanded
		do
			section_text.set_text ("- <<" + feature_section.name + ">>")
			feature_group.show
			enable_pick_and_drop
			is_expanded := True
			if container.has_section (Current) then
				container.update_size (Current)
			end
		ensure
			is_expanded: is_expanded
		end

	collabse is
			-- Collabse feature section.
		require
			is_expanded: is_expanded
		do
			section_text.set_text ("+" + features_count.out + " <<" + feature_section.name + ">>")
			feature_group.hide
			disable_pick_and_drop
			is_expanded := False
			if container.has_section (Current) then
				container.update_size (Current)
			end
		ensure
			is_collabsed: not is_expanded
		end

feature {NONE} -- Implementation

	features_count: INTEGER
			-- Number of features in section.

	set_features_text_properties (txt: EV_MODEL_TEXT) is
			-- Set properties of `txt' according to standarts.
		do
			txt.set_identified_font (uml_class_features_font)
			txt.set_foreground_color (uml_class_features_color)
		end

	set_section_text_properties (txt: EV_MODEL_TEXT) is
			-- Set properties of `txt' according to standarts.
		do
			txt.set_identified_font (uml_class_feature_section_font)
			txt.set_foreground_color (uml_class_feature_section_color)
		end

	section_text: EV_MODEL_TEXT

	feature_group: EV_MODEL_GROUP

	on_section_press (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- User pressed on section name.
		do
			if is_expanded then
				collabse
			else
				expand
			end
		end

	disable_pick_and_drop is
			-- Disable pick and drop of features.
		do
			from
				feature_group.start
			until
				feature_group.after
			loop
				feature_group.item.disable_sensitive
				feature_group.forth
			end
		end

	enable_pick_and_drop is
			-- Enable pick and drop of features.
		do
			from
				feature_group.start
			until
				feature_group.after
			loop
				feature_group.item.enable_sensitive
				feature_group.forth
			end
		end

	retrieve_preferences is
			-- Retrieve properties from preference.
		local
			txt, last_txt: EV_MODEL_TEXT
			line: EV_MODEL_LINE
			bbox: EV_RECTANGLE
		do
			set_section_text_properties (section_text)
			from
				feature_group.start
			until
				feature_group.after
			loop
				txt ?= feature_group.item
				if txt /= Void then
					set_features_text_properties (txt)
					last_txt := txt
				else
					line ?= feature_group.item
					if line /= Void then
						line.set_foreground_color (uml_class_features_color)
						check
							once_line_for_feature: last_txt /= Void
						end
						bbox := last_txt.bounding_box
						line.set_point_a_position (bbox.left, bbox.bottom - 4)
						line.set_point_b_position (bbox.right, bbox.bottom - 4)
					end
				end
				feature_group.forth
			end
			container.request_update
		end

	on_double_press is
			-- Do nothing, but block the delegation to `container'.
		do
		end

indexing
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

end -- class FEATURE_SECTION_VIEW
