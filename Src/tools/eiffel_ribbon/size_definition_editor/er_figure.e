note
	description: "Summary description for {ER_FIGURE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_FIGURE

inherit
	COMPARABLE
		undefine
			is_equal
--			copy
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			is_valid_position := True
			update_pixmap
		end

feature -- Command

	id: INTEGER
			-- FIXME: use Object id instead?

	set_highlight (a_bool: BOOLEAN)
			--
		do
			is_highlight := a_bool
			update_pixmap
		ensure
			set: is_highlight = a_bool
		end

	set_is_valid_position (a_bool: BOOLEAN)
			--
		do
			is_valid_position := a_bool
			update_pixmap
		ensure
			set: is_valid_position = a_bool
		end

	set_x (a_x: INTEGER)
			--
		do
			x := a_x
		ensure
			set: x = a_x
		end

	set_y (a_y: INTEGER)
			--
		do
			y := a_y
		ensure
			set: y = a_y
		end

	set_label_visible (a_bool: BOOLEAN)
			--
		do
			is_label_visible := a_bool
			update_pixmap
		ensure
			set: is_label_visible = a_bool
		end

	set_is_large_image_size (a_large: BOOLEAN)
			--
		do
			is_large_image_size := a_large
			update_pixmap
		ensure
			set: is_large_image_size = a_large
		end

feature -- Query

	is_valid_position: BOOLEAN
			-- If figer position valid? eg, it can be used for Size Definition

	pixmap: EV_PIXMAP
			--

	is_highlight: BOOLEAN
			--

	x: INTEGER
			--

	y: INTEGER
			--

	width: INTEGER
			--
		do
			Result := pixmap.width
		end

	height: INTEGER
			--
		do
			Result := pixmap.height
		end

	is_label_visible: BOOLEAN
			--

	is_large_image_size: BOOLEAN
			-- True means large
			-- False means small

	has_point (a_x, a_y: INTEGER): BOOLEAN
			--
		do
			Result := x <= a_x and y <= a_y and a_x <= (x + width) and a_y <= (y + height)
		end

feature -- Compare

	is_less alias "<" (a_other: ER_FIGURE): BOOLEAN
			-- <Precursor>
			-- Only compare position, used by {SD_TOOL_BAR_ROW}.zones
		do
			Result := x < a_other.x
		end

	is_equal (a_other: ER_FIGURE): BOOLEAN
			-- <Precursor>
			-- Only compare position, used by {SD_TOOL_BAR_ROW}.zones
		do
			Result := x = a_other.x
		end

feature {NONE} -- Implementation

	constants: ER_MISC_CONSTANTS
			--
		once
			create Result
		end

	update_pixmap
			--
		do
			pixmap := calculate_pixmap
		end

	calculate_pixmap: EV_PIXMAP
			--
		local
			l_path: FILE_NAME
			l_retried: BOOLEAN
			l_shared: ER_SHARED_SINGLETON
			l_error: EV_ERROR_DIALOG
			l_interface_names: ER_INTERFACE_NAMES
			l_misc_constants: ER_MISC_CONSTANTS
		do
			if not l_retried then
				create l_path.make_from_string (constants.images)
				create Result
				if is_large_image_size then
					if is_highlight then
						check is_valid_position end
						if is_label_visible then
							l_path.set_file_name ("button_with_text_large_highlight.png")
						else
							l_path.set_file_name ("button_without_text_large_highlight.png")
						end
					else
						if not is_valid_position then
							if is_label_visible then
								l_path.set_file_name ("button_with_text_large_invalid.png")
							else
								l_path.set_file_name ("button_without_text_large_invalid.png")
							end
						else
							if is_label_visible then
								l_path.set_file_name ("button_with_text_large.png")
							else
								l_path.set_file_name ("button_without_text_large.png")
							end
						end

					end
				else
					if is_highlight then
						check is_valid_position end
						if is_label_visible then
							l_path.set_file_name ("button_with_text_highlight.png")
						else
							l_path.set_file_name ("button_without_text_highlight.png")
						end
					else
						if not is_valid_position then
							if is_label_visible then
								l_path.set_file_name ("button_with_text_invalid.png")
							else
								l_path.set_file_name ("button_without_text_invalid.png")
							end
						else
							if is_label_visible then
								l_path.set_file_name ("button_with_text.png")
							else
								l_path.set_file_name ("button_without_text.png")
							end
						end

					end
				end

				Result.set_with_named_file (l_path)
			else
				create Result.make_with_size (10, 10)
			end
		rescue
			l_retried := True
			create l_shared
			create l_interface_names
			create l_misc_constants
			if attached l_misc_constants.ise_eiffel as l_ise_eiffel then
				create l_error.make_with_text (l_interface_names.cannot_find_templates (l_ise_eiffel))
			else
				create l_error.make_with_text (l_interface_names.ise_eiffel_not_defined)
			end
			l_error.set_buttons (<<l_interface_names.ok>>)
			if attached l_shared.main_window_cell.item as l_win then
				l_error.show_modal_to_window (l_win)
			else
				l_error.show
			end
			retry
		end

end
