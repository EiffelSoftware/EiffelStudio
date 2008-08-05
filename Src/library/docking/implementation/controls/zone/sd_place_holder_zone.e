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
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			only_for_place_holder_zone: a_content.unique_title.is_equal ((create {SD_SHARED}).editor_place_holder_content_name)
		do
			default_create
			-- Not breaking the invariant
			create internal_shared_not_used
			create internal_shared

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

	set_title (a_title: STRING_GENERAL) is
			-- Do nothing.
		do
		end

	extend (a_content: SD_CONTENT) is
			-- <Precursor>
		local
			l_widget: EV_WIDGET
		do
			Precursor {SD_DOCKING_ZONE} (a_content)
			l_widget := a_content.user_widget

			if l_widget.parent /= Void then
				l_widget.parent.prune (l_widget)
			end
			extend_cell (l_widget)
		end

feature -- Query

	has (a_content: SD_CONTENT): BOOLEAN is
			-- If `a_content' is place holder content?
		do
			 Result := a_content = internal_docking_manager.zones.place_holder_content
		end

	title: STRING_32 is
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

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
