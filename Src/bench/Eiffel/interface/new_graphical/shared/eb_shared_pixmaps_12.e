indexing
	description: "12x12 matrix pixmap for EiffelStudio user interface"
	date       : "$Date$"
	revision   : "$Revision$"

class 
	EB_SHARED_PIXMAPS_12

inherit
	EIFFEL_ENV
		export
			{NONE} all
		end	
		
	EB_SHARED_PIXMAP_FACTORY
		export
			{NONE} all
		end
	
feature -- Breakpoint Icons

	icon_bp_arrow: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_bp_arrow")
		end
		
	icon_bp_slot: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_bp_slot")
		end
		
	icon_bp_enabled: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_bp_enabled")
		end

	icon_bp_disabled: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_bp_disabled")
		end

	icon_bp_slot_arrow: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_bp_slot_arrow")
		end

	icon_bp_enabled_arrow: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_bp_enabled_arrow")
		end

	icon_bp_disabled_arrow: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_bp_disabled_arrow")
		end

	icon_bp_slot_stopped: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_bp_slot_stopped")
		end

	icon_bp_enabled_stopped: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_bp_enabled_stopped")
		end

	icon_bp_disabled_stopped: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_bp_disabled_stopped")
		end

	icon_bp_enabled_condition: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_bp_enabled_condition")
		end

	icon_bp_disabled_condition: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_bp_disabled_condition")
		end
		
feature -- Logical Icon Groups
	
	icon_group_bp_slot: ARRAY [EV_PIXMAP] is
			-- Regular (no modifiers) breakpoint icon group.
		once
			Result := <<icon_bp_slot, icon_bp_slot_arrow, icon_bp_slot_stopped>>
		ensure
			result_not_void: Result /= Void
		end
		
	icon_group_bp_enabled: ARRAY [EV_PIXMAP] is
			-- Enabled breakpoint icon group.
		once
			Result := <<icon_bp_enabled, icon_bp_enabled_arrow, icon_bp_enabled_stopped>>
		ensure
			result_not_void: Result /= Void
		end
	
	icon_group_bp_disabled: ARRAY [EV_PIXMAP] is
			-- Disabled breakpoint icon group.
		once
			Result := <<icon_bp_disabled, icon_bp_disabled_arrow, icon_bp_disabled_stopped>>
		ensure
			result_not_void: Result /= Void
		end	
		
	icon_group_bp_enabled_condition: ARRAY [EV_PIXMAP] is
			-- Conditional, enabled breakpoint icon group.
		once
			Result := <<icon_bp_enabled_condition, icon_bp_enabled_arrow, icon_bp_enabled_stopped>>
		ensure
			result_not_void: Result /= Void
		end
		
	icon_group_bp_disabled_condition: ARRAY [EV_PIXMAP] is
			-- Conditional, disabled breakpoint icon group.
		once
			Result := <<icon_bp_disabled_condition, icon_bp_disabled_arrow, icon_bp_disabled_stopped>>
		ensure
			result_not_void: Result /= Void
		end	
		
feature {NONE} -- {EB_SHARED_PIXMAP_FACTORY} Implementation

	pixmap_width: INTEGER is 12
		-- Width in pixels of generated factory image
		
	pixmap_height: INTEGER is 12
		-- Height in pixels of generated factory image

	image_matrix: EV_PIXMAP is
			-- Matrix pixmap containing all of the icons
		once
			Result := pixmap_file_content ("icon_matrix_12")
		end

	pixmap_path: DIRECTORY_NAME is
			-- Path to cursor pixmaps
		once
			create Result.make_from_string (eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "bitmaps", "png">>)
		end

	pixmap_lookup: HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING] is
			-- Lookup hash table for Studio pixmaps
		once
			create Result.make (12)
			Result.put ([1, 1], "icon_bp_arrow")
			Result.put ([1, 2], "icon_bp_slot")
			Result.put ([1, 3], "icon_bp_enabled")
			Result.put ([1, 4], "icon_bp_disabled")
			Result.put ([1, 5], "icon_bp_slot_arrow")
			Result.put ([1, 6], "icon_bp_enabled_arrow")
			Result.put ([1, 7], "icon_bp_disabled_arrow")
			Result.put ([1, 8], "icon_bp_slot_stopped")
			Result.put ([1, 9], "icon_bp_enabled_stopped")
			Result.put ([1, 10], "icon_bp_disabled_stopped")
			Result.put ([1, 11], "icon_bp_enabled_condition")
			Result.put ([1, 12], "icon_bp_disabled_condition")
			Result.compare_objects
		end

end -- class EB_SHARED_PIXMAPS_12
