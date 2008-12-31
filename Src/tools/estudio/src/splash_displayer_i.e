note
	description: "Splash displayer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	SPLASH_DISPLAYER_I

feature {NONE} -- Creation

	make_with_text (s: STRING_GENERAL)
		do
			text := s
		end

feature -- Access

	show
			-- Show spash box
		deferred
		end

	close
			-- Close spash box
		deferred
		end

	verbose_text: STRING_GENERAL;
			-- verbose text to display if needed


feature -- Change

	set_splash_pixmap_filename (fn: STRING)
		require
			file_exists: (create {RAW_FILE}.make (fn)).exists
		do
			splash_pixmap_filename := fn
		end

	set_verbose_text (s: STRING_GENERAL)
		do
			verbose_text := s
		end

	output_text (s: STRING_GENERAL)
		require
			s /= Void
		do
			io.put_string (s.as_string_8)
		end

feature {NONE} -- Properties

	splash_pixmap_filename: STRING
			-- File name of the splash pixmap

	text: STRING_GENERAL;
			-- bottom text to display

note
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
