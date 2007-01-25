indexing
	description: "Manager that manage all saved layouts."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_NAMED_LAYOUT_MANAGER

inherit
	EC_EIFFEL_LAYOUT

create
	make

feature {NONE} -- Initlization

	make (a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Creation method
		require
			not_void: a_dev_window /= Void
		do
			create interface_names
			init_existing_layouts
			development_window := a_dev_window
		ensure
			set: development_window = a_dev_window
		end

	init_existing_layouts is
			-- Initialize `layouts'.
		local
			l_dir: DIRECTORY
			l_files: ARRAYED_LIST [STRING]
			l_file: RAW_FILE
			l_config_data: SD_CONFIG_DATA
			l_facility: SED_STORABLE_FACILITIES
			l_reader: SED_MEDIUM_READER_WRITER
			l_fn: FILE_NAME
		do
			create l_dir.make (docking_standard_layout_path)
			if l_dir.exists then
				from
					create layouts.make (10)
					layouts.compare_objects
					create file_names.make (10)
					file_names.compare_objects
					l_files := l_dir.linear_representation
					l_files.start
				until
					l_files.after
				loop
					-- If file is start with `user_layout_prefix' then that is what we want.
					if l_files.item.substring (1, user_layout_prefix.count).is_equal (user_layout_prefix) then
						create l_fn.make_from_string (l_dir.name.twin)
						l_fn.set_file_name (l_files.item)
						create l_file.make_open_read (l_fn)
						check exist: l_file.exists end
						create l_reader.make (l_file)
						create l_facility
						l_config_data ?= l_facility.retrieved (l_reader, True)

						-- Maybe it's corrupted data, we ignore it.
						if l_config_data /= Void then
							layouts.extend (l_config_data.name)
							file_names.extend (l_fn)
						end
						l_file.close
					end
					l_files.forth
				end
			end
		end

feature -- Command

	add_layout (a_name: STRING_GENERAL) is
			-- Add a new layout which name is `a_name if not exist.
			-- Otherwise overwrite the exsiting one.
		require
			not_void: a_name /= Void
			not_empty: not a_name.as_string_8.is_equal ("")
		local
			l_fn: FILE_NAME
		do
			if layouts.has (a_name) then
				l_fn := file_name_of (a_name)
			else
				l_fn := docking_standard_layout_path
				l_fn.set_file_name (user_layout_prefix + (layouts.count + 1).out)
			end

			development_window.docking_manager.save_tools_config_with_name (l_fn, a_name)
		end

	open_layout (a_name: STRING_GENERAL) is
			-- Open a named layout
			-- `a_win' is the window which show modal to.
		require
			has: layouts.has (a_name)
		local
			l_fn: FILE_NAME
			l_r: BOOLEAN
			l_pointer_style: EV_POINTER_STYLE
			l_stock_pixmaps: EV_STOCK_PIXMAPS

			l_err: EV_ERROR_DIALOG
		do
			l_pointer_style := development_window.window.pointer_style
			create l_stock_pixmaps
			development_window.window.set_pointer_style (l_stock_pixmaps.busy_cursor)

			l_fn := file_name_of (a_name)
			l_r := development_window.docking_manager.open_tools_config (l_fn)
			if not l_r then
				-- If opening failed, we open orignal layout before opening.		
				create l_err.make_with_text (interface_names.l_open_layout_error)
				l_err.show_modal_to_window (development_window.window)
				development_window.restore_standard_tools_docking_layout
			end

			development_window.window.set_pointer_style (l_pointer_style)
		end

feature -- Query

	layouts: ARRAYED_LIST [STRING_GENERAL]
			-- All names of layouts.

	file_names: ARRAYED_LIST [FILE_NAME]
			-- File names associate with `layouts'

	file_name_of (a_name: STRING_GENERAL): FILE_NAME is
			-- File name associate with the layout which name is `a_name'
		require
			has: layouts.has (a_name)
		do
			Result := file_names.i_th (layouts.index_of (a_name, 1))
		ensure
			not_void: Result /= Void
			file_exist:
		end

feature {NONE} -- Implementation

	interface_names: INTERFACE_NAMES
			-- Interface names.

	user_layout_prefix: STRING is "user_layout_"
			-- User saved named layout files prefix.

	development_window: EB_DEVELOPMENT_WINDOW
			-- Development windows related.

invariant
	not_void: layouts /= Void
	not_void: file_names /= Void

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

end -- class EB_NAMED_LAYOUT_MANAGER
