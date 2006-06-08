indexing
	description: "[
					A place holder zone.
					Normally used for place holder for editors zones.											
					When there is no type_editor zone in docking manager,
					This zone is the place holder for eidtors zones, when
					added new editor zones to docking manager, this zone's 
					location is the	default location for editor zones.
					Used docking library internally.
																			]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_PLACE_HOLDER_ZONE

inherit
	SD_DOCKING_ZONE
		redefine
			has,
			on_focus_in,
			on_focus_out,
			extend
		end
create
	make

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT) is
			-- Creation method
		require
			not_void: a_content /= Void
		do
			default_create
			internal_content := a_content
			internal_docking_manager := internal_content.docking_manager
			extend (a_content)
		ensure
			set: internal_content = a_content
		end

feature -- Command

	set_show_stick (a_show: BOOLEAN) is
			-- Do nothing.
		do
		end

	set_show_normal_max (a_show: BOOLEAN) is
			-- Do nothing.
		do
		end

	set_title (a_title: STRING) is
			-- Do nothing.
		do
		end

	extend (a_content: SD_CONTENT) is
			-- Do nothing.
		do
			Precursor {SD_DOCKING_ZONE} (a_content)
			extend_cell (a_content.user_widget)
		end

feature -- Query

	has (a_content: SD_CONTENT): BOOLEAN is
			-- If `a_content' is place holder content?
		do
			 Result := a_content = internal_docking_manager.zones.place_holder_content
		end

	title: STRING is
			-- Title
		local
			l_shared: SD_SHARED
		do
			create l_shared
			Result := l_shared.editor_place_holder_content_name
		end

	title_area: EV_RECTANGLE is
			-- Place holder content has zero sized title area.
		do
			create Result
		end

feature -- Agents

	on_focus_in (a_content: SD_CONTENT) is
			-- Do nothing.
		do
		end

	on_focus_out is
			-- Do nothing.
		do
		end

end
