indexing
	description: "Command to display hierarchy information or feature information concerning a compiled class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CLASS_CONTENT_FORMATTER

inherit
	EB_CLASS_INFO_FORMATTER
		redefine
			line_numbers_allowed,
			widget,
			empty_widget
		end

	REFACTORING_HELPER

	QL_UTILITY

feature -- Formatting

	format is
			-- Refresh `widget'.
		do
			if associated_class /= Void and then selected and then displayed then
				display_temp_header
				if not widget.is_displayed then
					widget.show
				end
				generate_result
				display_header
			end
		end

feature -- Access

	browser: EB_CLASS_BROWSER_GRID_VIEW
			-- Browser where information gets displayed

	widget: EV_WIDGET is
			-- Graphical representation of the information provided.
		do
			if associated_class = Void or browser = Void then
				Result := empty_widget
			else
				Result := browser.widget
			end
		end

	empty_widget: EV_WIDGET is
			-- Widget displayed when no information can be displayed.
		local
			def: EV_STOCK_COLORS
			l_frame: EV_FRAME
			l_cell: EV_CELL
		do
			create def
			create l_frame
			l_frame.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			create l_cell
			l_cell.extend (l_frame)
			Result := l_cell
			l_frame.set_background_color (def.White)
			l_frame.drop_actions.extend (agent on_class_drop)
		end

feature -- Setting

	reset_display is
			-- Clear all graphical output.
		do
			if browser /= Void then
				browser.reset_display
			end
		end

	set_browser (a_browser: like browser) is
			-- Set `browser' with `a_browser'.
		require
			a_browser_attached: a_browser /= Void
		do
			browser := a_browser
		ensure
			browser_set: browser = a_browser
		end

	set_stone (new_stone: CLASSI_STONE) is
			-- Associate current formatter with class contained in `a_stone'.
		local
			a_stone: CLASSC_STONE
		do
			force_stone (new_stone)
			a_stone ?= new_stone
			if a_stone /= Void then
				if (not a_stone.class_i.is_external_class) or is_dotnet_formatter then
					set_class (a_stone.e_class)
				end
			else
				associated_class := Void
				reset_display
				if
					selected and then
					not widget.is_displayed
				then
					if widget_owner /= Void then
						widget_owner.set_widget (widget)
					end
					display_header
				end
			end
		end

	set_class (a_class: CLASS_C) is
			-- Associate current formatter with `a_class'.
		do
			associated_class := a_class
			if a_class = Void or else not a_class.has_feature_table then
				associated_class := Void
			end
			must_format := True
			format
			if selected then
				if widget_owner /= Void then
					widget_owner.set_widget (widget)
				end
				display_header
			end
		ensure
			class_set: (a_class /= Void and then a_class.has_feature_table) implies (a_class = associated_class)
		end

feature -- Status report

	line_numbers_allowed: BOOLEAN is False
		-- Does it make sense to show line numbers in Current?

	is_dotnet_formatter: BOOLEAN is True
			-- Is Current able to format .NET class texts?

	has_breakpoints: BOOLEAN is False
		-- Should `Current' display breakpoints?

	is_class_feature_formatter: BOOLEAN is
			-- Is current a class feature formatter?
		do
		end

	is_class_hierarchy_formatter: BOOLEAN is
			-- Is current a class hierarchy formatter?
		do
		end

feature{NONE} -- Implementation

	generate_result is
			-- Generate result for display
		require
			associated_class_attached: associated_class /= Void
		deferred
		end

	domain_generator: QL_DOMAIN_GENERATOR is
			-- Domain generator to generate result
		deferred
		ensure
			result_attached: Result /= Void
		end

	criterion: QL_CRITERION is
			-- Criterion of current formatter
		deferred
		ensure
			result_attached: Result /= Void
		end

	start_class: QL_CLASS is
			-- Start class
		deferred
		end

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

end
