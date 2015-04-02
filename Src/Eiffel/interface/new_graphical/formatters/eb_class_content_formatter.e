note
	description: "Command to display hierarchy information or feature information concerning a compiled class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CLASS_CONTENT_FORMATTER

inherit
	EB_BROWSER_FORMATTER
		rename
			internal_recycle as browser_formatter_recycle
		end

	EB_CLASS_INFO_FORMATTER
		undefine
			retrieve_sorting_order,
			is_browser_formatter
		redefine
			line_numbers_allowed,
			widget,
			internal_recycle
		select
			internal_recycle
		end

	REFACTORING_HELPER

	QL_UTILITY

feature -- Formatting

	format
			-- Refresh `widget'.
		do
			if associated_class /= Void and then selected and then displayed and then actual_veto_format_result then
				retrieve_sorting_order
				display_temp_header
				if not widget.is_displayed then
					widget.show
				end
				setup_viewpoint
				generate_result
				display_header
			end
		end

feature -- Access

	widget: EV_WIDGET
			-- Graphical representation of the information provided.
		do
			if associated_class = Void or browser = Void then
				Result := empty_widget
			else
				Result := browser.widget
			end
		end

feature -- Setting

	reset_display
			-- Clear all graphical output.
		do
			if browser /= Void then
				browser.reset_display
			end
		end

	set_stone (new_stone: detachable STONE)
			-- Associate current formatter with class contained in `a_stone'.
		do
			force_stone (new_stone)
			if attached {CLASSC_STONE} new_stone as l_classc_stone then
				if (not l_classc_stone.is_dotnet_class) or is_dotnet_formatter then
					set_class (l_classc_stone.e_class)
				end
			else
				associated_class := Void
				reset_display
				ensure_display_in_widget_owner
			end
		end

	set_class (a_class: CLASS_C)
			-- Associate current formatter with `a_class'.
		do
			associated_class := a_class
			if a_class = Void or else not a_class.has_feature_table then
				associated_class := Void
			end
			must_format := True
			format
			ensure_display_in_widget_owner
		ensure
			class_set: (a_class /= Void and then a_class.has_feature_table) implies (a_class = associated_class)
		end

	setup_viewpoint
			-- Setup viewpoint for formatting.
		do
		end

feature -- Status report

	line_numbers_allowed: BOOLEAN = False
		-- Does it make sense to show line numbers in Current?

	is_dotnet_formatter: BOOLEAN = True
			-- Is Current able to format .NET class texts?

	has_breakpoints: BOOLEAN = False
		-- Should `Current' display breakpoints?

	is_class_feature_formatter: BOOLEAN
			-- Is current a class feature formatter?
		do
		end

	is_inheritance_formatter: BOOLEAN
			-- Is current a class inheritance (ancestor/descendant) formatter?
		do
		end

	is_reference_formatter: BOOLEAN
			-- Is current a class reference (supplier/client) formatter?
		do
		end

feature {NONE} -- Recyclable

	internal_recycle
			-- Recyclable
		do
			Precursor {EB_CLASS_INFO_FORMATTER}
			browser_formatter_recycle
		end

feature{NONE} -- Implementation

	generate_result
			-- Generate result for display
		require
			associated_class_attached: associated_class /= Void
		deferred
		end

	domain_generator: QL_DOMAIN_GENERATOR
			-- Domain generator to generate result
		deferred
		ensure
			result_attached: Result /= Void
		end

	criterion: QL_CRITERION
			-- Criterion of current formatter
		deferred
		ensure
			result_attached: Result /= Void
		end

	start_class: QL_CLASS
			-- Start class
		deferred
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
