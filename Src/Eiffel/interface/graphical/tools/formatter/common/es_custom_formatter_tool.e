note
	description: "[
		Tool descriptor for EiffelStudio's custom formatter code browsing tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

frozen class
	ES_CUSTOM_FORMATTER_TOOL

inherit
	ES_FORMATTER_TOOL [EB_CUSTOMIZED_TOOL]
		redefine
			is_supporting_multiple_instances,
			is_recycled_on_closing
		end

create {NONE}
	default_create

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- Tool icon
			-- Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		local
			l_path: like icon_file_path
		do
			Result := internal_icon
			if Result = Void then
				l_path := icon_file_path
				if l_path /= Void and (create {RAW_FILE}.make (l_path)).exists then
					create Result
					Result.set_with_named_file (l_path)
				else
					Result := stock_pixmaps.tool_feature_icon_buffer
				end
				internal_icon := Result
			end
		rescue
			internal_icon := stock_pixmaps.tool_feature_icon_buffer
			retry
		end

	icon_pixmap: EV_PIXMAP
			-- Tool icon pixmap
			-- Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		local
			l_path: like icon_file_path
		do
			Result := internal_icon
			if Result = Void then
				l_path := icon_file_path
				if l_path /= Void and (create {RAW_FILE}.make (l_path)).exists then
					create Result
					Result.set_with_named_file (icon_file_path)
				else
					Result := stock_pixmaps.tool_feature_icon
				end
				internal_icon := Result
			end
		rescue
			internal_icon := stock_pixmaps.tool_feature_icon
			retry
		end

	title: STRING_32 assign set_title
			-- Tool title.

feature {NONE} -- Access

	shortcut_preference_name: STRING_32
			-- An optional shortcut preference name, for automatic preference binding.
		do
			--| No shortcut preference for customized tools
		end

feature {EB_CUSTOMIZED_TOOL_MANAGER, EB_CUSTOMIZED_TOOL_DIALOG} -- Access

	icon_file_path: STRING_32 assign set_icon_file_path
			-- Absolute file path of a custom pixmap

	stone_handlers: DS_HASH_TABLE [ES_TOOL [EB_TOOL], STRING_32]
			-- Table of "stone" handlers for custom redirection

feature {EB_CUSTOMIZED_TOOL_MANAGER, EB_CUSTOMIZED_TOOL_DIALOG} -- Element change

	set_title (a_title: like title)
			-- Sets custom formatter's title
			--
			-- `a_title': Title to set for the custom formatter
		require
			a_title_attached: a_title /= Void
			not_a_title_is_empty: not a_title.is_empty
		do
			title := a_title
		ensure
			title_set: title = a_title
		end

	set_icon_file_path (a_path: like icon_file_path)
			-- Sets custom formatter's icon path
			--
			-- `a_path': Path to icon file
		do
			icon_file_path := a_path
			internal_icon := Void
			internal_icon_pixmap := Void
		ensure
			icon_file_path_set: icon_file_path = a_path
		end

feature -- Status report

	is_customizable: BOOLEAN = True
			-- Indicates if the tool can be customize to support custom views.

	is_supporting_multiple_instances: BOOLEAN = True
			-- Indicates if the tool can spawn multiple instances in the
			-- same development window

feature {NONE} -- Status report

	is_recycled_on_closing: BOOLEAN = False
			-- Indicates if the tool should be recycled on closing

feature {NONE} -- Factory

	create_tool: EB_CUSTOMIZED_TOOL
			-- Creates the tool for first use on the development `window'
		do
			--create Result.make (window, Current)
		end

feature {NONE} -- Internal implementation cache

	internal_icon: like icon
			-- Cached version of `icon'
			-- Note: Do not use directly

	internal_icon_pixmap: like icon_pixmap
			-- Cached version of `icon_pixmap'
			-- Note: Do not use directly

invariant
	not_icon_file_path_is_empty: icon_file_path /= Void not icon_file_path.is_empty

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
