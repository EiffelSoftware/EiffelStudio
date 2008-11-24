indexing
	description: "[
		Widget showing status and control buttons for an {EIFFEL_TEST_FACTORY_I}
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_CREATOR_WIDGET

inherit
	ES_TESTING_TOOL_PROCESSOR_WIDGET
		rename
			processor as factory
		redefine
			build_notebook_widget_interface
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	build_notebook_widget_interface (a_widget: like widget)
			-- <Precursor>
		local
			l_label: EV_LABEL
		do
			create l_label.make_with_text ("Created tests")
			l_label.align_text_left
			a_widget.extend (l_label)
			a_widget.disable_item_expand (l_label)

			Precursor (a_widget)
		end

feature {NONE} -- Access

	title: !STRING_32
		do
			if generator_factory_type.attempt (factory) /= Void then
				Result := locale_formatter.translation (t_generator_title)
			elseif extractor_factory_type.attempt (factory) /= Void then
				Result := locale_formatter.translation (t_extractor_title)
			else
				Result := locale_formatter.translation (t_creator_title)
			end
		end

	icon: !EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.overlay_new_icon_buffer
		end

	icon_pixmap: !EV_PIXMAP
			-- <Precursor>
		do
			Result := stock_pixmaps.overlay_new_icon
		end

feature {NONE} -- Events

feature {NONE} -- Internationalization

	t_generator_title: !STRING = "Generation"
	t_extractor_title: !STRING = "Extraction"
	t_creator_title: !STRING = "New manual tests"

;indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
