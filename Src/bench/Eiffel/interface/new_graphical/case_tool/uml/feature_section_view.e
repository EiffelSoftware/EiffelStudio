indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_SECTION_VIEW
	
inherit
	EV_MODEL_GROUP
	
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

create
	make
	
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
			bbox: EV_RECTANGLE
		do
			default_create
			
			create feature_group
			
			attr_height := 0
			create section_text.make_with_text ("+" + a_fs.features.count.out + " <<" + a_fs.name + ">>")
			set_section_text_properties (section_text)
			section_text.set_pointer_style (default_pixmaps.standard_cursor)
			section_text.pointer_button_press_actions.extend (agent on_section_press)
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
				
				create txt.make_with_text (visibility + full_name_compiled (e_feature))
				
				set_features_text_properties (txt)
				txt.set_pebble (create {FEATURE_STONE}.make (e_feature))
				txt.set_accept_cursor (cursors.cur_feature)
				txt.set_deny_cursor (cursors.cur_x_feature)
				txt.set_point_position (point_x, point_y + attr_height)
				attr_height := attr_height + txt.height
				feature_group.extend (txt)
				if e_feature.is_once then
					bbox := txt.bounding_box
					create once_line.make_with_positions (bbox.left, bbox.bottom - 4, bbox.right, bbox.bottom - 4)
					once_line.set_foreground_color (uml_class_features_color)
					feature_group.extend (once_line)
				end
				l_features.forth
			end
			extend (feature_group)
			feature_section := a_fs
			container := a_container
			is_expanded := False
			feature_group.hide
			disable_pick_and_drop
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
			container.update_size (Current)
		ensure
			is_expanded: is_expanded
		end
		
	collabse is
			-- Collabse feature section.
		require
			is_expanded: is_expanded
		do
			section_text.set_text ("+" + feature_section.features.count.out + " <<" + feature_section.name + ">>")
			feature_group.hide
			disable_pick_and_drop
			is_expanded := False
			container.update_size (Current)
		ensure
			is_collabsed: not is_expanded
		end

feature {NONE} -- Implementation

	set_features_text_properties (txt: EV_MODEL_TEXT) is
			-- Set properties of `txt' according to standarts.
		local
			ew: EG_FIGURE_WORLD
		do
			txt.set_font (uml_class_features_font)
			txt.set_foreground_color (uml_class_features_color)
			ew ?= world
			if ew /= Void and then ew.scale_factor /= 1.0 then
				txt.scale (ew.scale_factor)
			end
		end
		
	set_section_text_properties (txt: EV_MODEL_TEXT) is
			-- Set properties of `txt' according to standarts.
		local
			ew: EG_FIGURE_WORLD
		do
			txt.set_font (uml_class_feature_section_font)
			if ew /= Void and then ew.scale_factor /= 1.0 then
				txt.scale (ew.scale_factor)
			end
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
		
end -- class FEATURE_SECTION_VIEW
