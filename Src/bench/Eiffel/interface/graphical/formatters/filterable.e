indexing

	description:	
		"Formatters to which a filter is applicable."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class FILTERABLE

inherit

	EIFFEL_ENV;
	FORMATTER
		rename
			init as make
		redefine
			filter
		end

feature -- Filtering; Implementation

	filter (filtername: STRING) is
			-- Filter the `Current' format with `filtername'.
		local
			new_text: STRING;
			root_stone: STONE;
			mp: MOUSE_PTR
		do
			root_stone := tool.stone;
			if root_stone /= Void then
				create mp.set_watch_cursor;
				new_text := filtered_text (root_stone, filtername);
				if new_text /= Void then
					text_window.clear_text;
					tool.set_editable_text;
					text_window.set_text (new_text);
					tool.show_editable_text;
					display_filter_header (root_stone, filtername);
					tool.set_file_name (filtered_file_name 
							(root_stone, filtername))
					text_window.set_editable;
					filter_name := clone (filtername);
					filtered := true
				end;
				mp.restore
			end
		end;

feature -- Filtering; Properties

	filtered_text (stone: STONE; filtername: STRING): STRING is
			-- Output of `filtername' applied to `stone'
			-- (Void if the filter is not readable)
		require
			stone_not_void: stone /= Void;
			filtername_not_void: filtername /= Void
		local
			full_pathname: FILE_NAME;
			filter_file: PLAIN_TEXT_FILE;
			tmp_text: STRUCTURED_TEXT;
			text_filter: TEXT_FILTER
		do
			if filtername.is_empty then
				warner (popup_parent).gotcha_call (Warning_messages.w_No_filter_selected)
			else
				create full_pathname.make_from_string (filter_path);
				full_pathname.set_file_name (filtername);
				full_pathname.add_extension ("fil");
				create filter_file.make (full_pathname);
				if filter_file.exists and then filter_file.is_readable then
					create text_filter.make_from_filename (full_pathname);
					file_suffix := text_filter.file_suffix;
					tmp_text := create_structured_text (stone);
					text_filter.process_text (tmp_text);
					Result := text_filter.image
				else
					warner (popup_parent).gotcha_call 
						(Warning_messages.w_Cannot_read_filter (full_pathname))
				end
			end
		end;

	filtered_file_name (stone: STONE; filtername: STRING): STRING is
			-- Name of the file where the filtered output text will be stored
			-- (classname.file_suffix or classname.filtername)
		require
			stone_not_void: stone /= Void;
			filtername_not_void: filtername /= Void
		local
			filed_stone: FILED_STONE;
			fname: FILE_NAME;
			i: INTEGER;
			fsuffix: STRING
		do
			filed_stone ?= stone;
			if filed_stone /= Void then
				Result := clone (filed_stone.file_name);
					--| remove the extension
				from
					i := Result.count
				until 
					i = 0 or else Result.item (i) = '.'
				loop
					i := i - 1
				end;
				if i /= 0 and i >= Result.count - 3 then
					Result.head (i - 1)
				end;

				create fname.make_from_string (Result);
				if file_suffix /= Void then
					if not file_suffix.is_empty then
						fname.add_extension (file_suffix)
					end
				else
					fsuffix := clone (filtername);
					fsuffix.head (3);
					fsuffix.to_lower;
					if not fsuffix.is_empty then
						fname.add_extension (fsuffix)
					end
				end;
				Result := fname
			else
				create Result.make (0)
			end
		end;

	temp_filtered_file_name (stone: STONE; filtername: STRING): STRING is
			-- Name of the file where the filtered output text will be
			-- temporary stored (tem_dir/classname.file_suffix or 
			-- temp_dir/classname.filtername)
		require
			stone_not_void: stone /= Void;
			filtername_not_void: filtername /= Void
		local
			fname: FILE_NAME;
			fsuffix: STRING;
			class_stone: CLASSC_STONE;
			temp_name: STRING
		do
			class_stone ?= stone;
			if class_stone /= Void then
				create fname.make_from_string (tmp_directory);
				temp_name := clone (class_stone.e_class.name);
				if not fname.is_file_name_valid (temp_name) then
						-- Truncate the class name to 8 characters
						-- under Windows.
					temp_name.head (8)
				end;
				fname.set_file_name (temp_name);
				if file_suffix /= Void then
					if 
						not file_suffix.is_empty and then
						fname.is_extension_valid (file_suffix)
					then
						fname.add_extension (file_suffix)
					end
				else
					fsuffix := clone (filtername);
					fsuffix.head (3);
					fsuffix.to_lower;
					if not fsuffix.is_empty then
						fname.add_extension (fsuffix)
					end
				end;
				Result := fname
			else
				create Result.make (0)
			end
		end;

	filter_name: STRING;
			-- Name of the last filter applied

	file_suffix: STRING;
			-- Suffix of the file name where the filtered output text is stored;
			-- Void if it has not been specified in the filter specification

feature {NONE} -- Attributes

	create_structured_text (stone: STONE): STRUCTURED_TEXT is
		require
			not_stone_void: stone /= Void
		deferred
		end;

feature {NONE} -- Implementation

	display_info (stone: STONE) is
			-- Display the information about `stone' with the use
			-- of `create_structured_text'.
		do
			text_window.process_text (create_structured_text (stone))
		end;

	display_filter_header (stone: STONE; filtername: STRING) is
			-- Show header.
		require
			stone_not_void: stone /= Void;
			filtername_not_void: filtername /= Void
		local
			new_title: STRING
		do
			create new_title.make (50);
			new_title.append (title_part);
			new_title.append (stone.stone_signature);
			new_title.append (" (");
			new_title.append (filtername);
			new_title.append (" format)");
			tool.set_title (new_title)
		end;

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

end -- class FILTERABLE
