indexing
	description: "8 * 16 icons used by Smart Docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICONS_8_16

inherit
	SHARED_PIXMAP_FACTORY

feature -- Access

	customize_indicator: EV_PIXMAP is
			--
		do
			Result := pixmap_file_content (customize_indicator_s)
		end

	customize_indicator_with_hidden_items: EV_PIXMAP is
			--
		do
			Result := pixmap_file_content (customize_indicator_hidden_s)
		end

feature {NONE}  -- Redefine

	pixmap_width: INTEGER is 8
			-- The width of the icons

	pixmap_height: INTEGER is 16
			-- The height of the icons

	pixmap_path: DIRECTORY_NAME is
			-- Path containing all of the Memory Analyzer icons
		once
			create Result.make_from_string ((create {EXECUTION_ENVIRONMENT}).current_working_directory)
			Result.extend ("images")
		ensure then
			path_valid: Result.is_valid
		end

	image_matrix: EV_PIXMAP is
			-- The pixmap contain all the icons
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("smart_docking_icon_matrix_8_16.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	pixmap_lookup: HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING] is
			--
		once
			create Result.make (1)
			Result.put ([1, 1], customize_indicator_s)
			Result.put ([1, 2], customize_indicator_hidden_s)
			Result.compare_objects
		end

feature {NONE} -- Icons' Names

	customize_indicator_s: STRING is "customize_indicator"
			-- Icon name.

	customize_indicator_hidden_s: STRING is "customize_indicator_with_hidden_items";
			-- Icon name.
indexing
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

