note
	description: "[
		Tool descriptor for EiffelStudio's class code browsing tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

frozen class
	ES_CLASS_TOOL

inherit
	ES_FORMATTER_TOOL [ES_CLASS_TOOL_PANEL]

	ES_CLASS_TOOL_COMMANDER_I
		undefine
			out
		end

create {NONE}
	default_create

feature -- Access

	icon: !EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.tool_class_icon_buffer
		end

	icon_pixmap: !EV_PIXMAP
			-- <Precursor>
		do
			Result := stock_pixmaps.tool_class_icon
		end

	title: !STRING_32
			-- <Precursor>
		do
			Result := locale_formatter.translation (t_tool_title)
		end

	mode: NATURAL_8 assign set_mode
			-- <Precursor>
		do
			if is_tool_instantiated then
				Result := panel.mode
			else
				Result := {ES_CLASS_TOOL_VIEW_MODES}.ancestors
			end
		end

feature -- Element change

	set_mode (a_mode: like mode)
			-- <Precursor>
		do
				-- Setting a mode will force the creation of the tool, by design.
			panel.set_mode (a_mode)
		end

	set_mode_with_stone (a_mode: like mode; a_stone: STONE)
			-- <Precursor>
		local
			l_stone: CLASSC_STONE
		do
				-- First clear the stone, for performance reasons
			panel.set_stone (Void)

				-- Now set the mode and stone.
			set_mode (a_mode)
			l_stone ?= a_stone
			if l_stone = Void and then {l_cis: CLASSI_STONE} a_stone then
				if l_cis.class_i.is_compiled then
					create l_stone.make (l_cis.class_i.compiled_class)
				end
			end
			if l_stone /= Void then
				panel.set_stone (l_stone)
			end
		end

feature -- Status report

	is_customizable: BOOLEAN = True
			-- Indicates if the tool can be customize to support custom views.

feature {NONE} -- Factory

	new_tool: !ES_CLASS_TOOL_PANEL
			-- <Precursor>
		do
			create Result.make (window, Current)
		end

feature {NONE} -- Internationalization

	t_tool_title: STRING = "Class"

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
