note
	description: "[
		Automatically generated class for EiffelStudio 16 x16  tool icons.
	]"
	generator: "Eiffel Matrix Generator"
	command_line: "emcgen.exe \work\64dev\Delivery\studio\tools\testing\icons.ini -f \work\64dev\tools\eiffel_matrix_code_generator\frames\tool.e.frame"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_ICONS

inherit
	ES_TOOL_PIXMAPS
		redefine
			matrix_pixel_border
		end

create
	make

feature -- Access

	icon_width: NATURAL_8 = 16
			-- <Precursor>

	icon_height: NATURAL_8 = 16
			-- <Precursor>

	width: NATURAL_8 = 5
			-- <Precursor>

	height: NATURAL_8 = 1
			-- <Precursor>

feature {NONE} -- Access

	matrix_pixel_border: NATURAL_8 = 1
			-- <Precursor>

feature -- Icons

	frozen test_routine_icon: EV_PIXMAP
			-- Access to 'routine' pixmap.
		require
			has_named_icon: has_named_icon (test_routine_name)
		once
			Result := named_icon (test_routine_name)
		ensure
			test_routine_icon_attached: Result /= Void
		end

	frozen test_routine_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'routine' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (test_routine_name)
		once
			Result := named_icon_buffer (test_routine_name)
		ensure
			test_routine_icon_buffer_attached: Result /= Void
		end

	frozen general_test_icon: EV_PIXMAP
			-- Access to 'test' pixmap.
		require
			has_named_icon: has_named_icon (general_test_name)
		once
			Result := named_icon (general_test_name)
		ensure
			general_test_icon_attached: Result /= Void
		end

	frozen general_test_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'test' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (general_test_name)
		once
			Result := named_icon_buffer (general_test_name)
		ensure
			general_test_icon_buffer_attached: Result /= Void
		end

	frozen general_bug_icon: EV_PIXMAP
			-- Access to 'bug' pixmap.
		require
			has_named_icon: has_named_icon (general_bug_name)
		once
			Result := named_icon (general_bug_name)
		ensure
			general_bug_icon_attached: Result /= Void
		end

	frozen general_bug_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'bug' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (general_bug_name)
		once
			Result := named_icon_buffer (general_bug_name)
		ensure
			general_bug_icon_buffer_attached: Result /= Void
		end

	frozen record_store_icon: EV_PIXMAP
			-- Access to 'store' pixmap.
		require
			has_named_icon: has_named_icon (record_store_name)
		once
			Result := named_icon (record_store_name)
		ensure
			record_store_icon_attached: Result /= Void
		end

	frozen record_store_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'store' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (record_store_name)
		once
			Result := named_icon_buffer (record_store_name)
		ensure
			record_store_icon_buffer_attached: Result /= Void
		end

	frozen record_store_disabled_icon: EV_PIXMAP
			-- Access to 'store_disabled' pixmap.
		require
			has_named_icon: has_named_icon (record_store_disabled_name)
		once
			Result := named_icon (record_store_disabled_name)
		ensure
			record_store_disabled_icon_attached: Result /= Void
		end

	frozen record_store_disabled_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'store_disabled' pixmap pixel buffer.
		require
			has_named_icon: has_named_icon (record_store_disabled_name)
		once
			Result := named_icon_buffer (record_store_disabled_name)
		ensure
			record_store_disabled_icon_buffer_attached: Result /= Void
		end

feature -- Icons: Animations

	-- No animation frames detected.

feature -- Constants: Icon names

	test_routine_name: STRING = "test routine"
	general_test_name: STRING = "general test"
	general_bug_name: STRING = "general bug"
	record_store_name: STRING = "record store"
	record_store_disabled_name: STRING = "record store_disabled"

feature {NONE} -- Basic operations

	populate_coordinates_table (a_table: HASH_TABLE [TUPLE [x: NATURAL_8; y: NATURAL_8], STRING])
			-- <Precursor>
		do
			a_table.put ([{NATURAL_8} 1, {NATURAL_8} 1], test_routine_name)
			a_table.put ([{NATURAL_8} 2, {NATURAL_8} 1], general_test_name)
			a_table.put ([{NATURAL_8} 3, {NATURAL_8} 1], general_bug_name)
			a_table.put ([{NATURAL_8} 4, {NATURAL_8} 1], record_store_name)
			a_table.put ([{NATURAL_8} 5, {NATURAL_8} 1], record_store_disabled_name)
		end

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
