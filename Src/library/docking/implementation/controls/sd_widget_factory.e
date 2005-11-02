indexing
	description: "Factory with responsibility for create docking library widgets base on different style."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_WIDGET_FACTORY

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method.
		do
			set_style (style_different)
		ensure
			default_style_set: internal_style = style_different
		end
		
feature -- Status setting

	set_style (a_style: INTEGER) is
			-- Set style to one of enumeration at end of this class.
		require
			a_style_valid: style_valid (a_style)
		do
			internal_style := a_style
		ensure
			a_style_set: a_style = internal_style
		end
		
feature -- Status report

	style_valid (a_style: INTEGER): BOOLEAN is
			-- If `a_style' valid?
		do
			Result := a_style = style_all_same or a_style = style_different
		end
		
feature -- Factory method.
	
	title_bar (a_type: INTEGER; a_zone: SD_ZONE): SD_TITLE_BAR is
			-- 
		local
			l_auto_hide_zone: SD_AUTO_HIDE_ZONE
			l_docking_zone: SD_DOCKING_ZONE
			l_tab_zone: SD_TAB_ZONE
		do
			if internal_style = style_all_same  then
				create Result.make
			elseif internal_style = style_different then
				l_auto_hide_zone ?= a_zone
				l_docking_zone ?= a_zone
				if l_auto_hide_zone /= Void or l_docking_zone /= Void then
					create Result.make
				end
				
				l_tab_zone ?= a_zone
				if l_tab_zone /= Void then
					
					if a_type = {SD_SHARED}.type_editor then
						Result := create {SD_VOID_TITLE_BAR}.make	
					elseif a_type = {SD_SHARED}.type_normal then
						create Result.make
					end
					
				end				
			end
		ensure
			not_void: Result /= Void
		end

	tab_zone (a_content: SD_CONTENT; a_target_zone: SD_DOCKING_ZONE): SD_TAB_ZONE is
			-- 
		require
			a_content_not_void: a_content /= Void
			a_target_zone_not_void: a_target_zone /= Void
		do
			if internal_style = style_all_same then
				create Result.make (a_content, a_target_zone)
			elseif internal_style = style_different then
				if a_content.type = {SD_SHARED}.type_normal then
					create Result.make (a_content, a_target_zone)
				elseif a_content.type = {SD_SHARED}.type_editor then
					Result := create {SD_TAB_ZONE_UPPER}.make (a_content, a_target_zone)	
				end
			end
			
		ensure
			not_void: Result /= Void
		end
		
feature {NONE} -- Implementation
	
	internal_style: INTEGER
			-- One value from style enumeration.

feature -- Enumeration
	
	style_all_same: INTEGER is 1
			-- Look and feel which like Eclipse.
	style_different: INTEGER is 2
			-- Look and feel which like Visual Studio 2003.
				
end
