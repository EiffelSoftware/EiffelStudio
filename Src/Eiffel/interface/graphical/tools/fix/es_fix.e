note
	description: "Automated fix for an issue."

deferred class
	ES_FIX

inherit

	EB_SHARED_PIXMAPS export {NONE} all end

	ES_GRID_PIXMAP_COMPONENT
		rename
			make as make_component
		end

	SHARED_LOCALE export {NONE} all end

feature {NONE} -- Creation

	make (f: like item)
			-- Initialize GUI component with a fix `f' that may be applied.
		require
			is_class_writable: not f.source_class.is_read_only
		local
			formatter: EB_EDITOR_TOKEN_GENERATOR
			tooltip: EB_EDITOR_TOKEN_TOOLTIP
		do
			item := f
			make_component (icon_pixmaps.errors_and_warnings_fix_apply_icon)
				-- TODO: handle multi-line fix option description.
			create formatter.make
			f.append_description (formatter)
			if attached formatter.last_line as d and then d.count > 0 then
					-- Use fix option description as a tooltip.
				create tooltip.make (pointer_enter_actions, pointer_leave_actions, Void,
					agent: BOOLEAN do Result := attached grid_item as x implies x.is_destroyed end)
				tooltip.set_tooltip_text (d.content)
				set_general_tooltip (tooltip)
			end
		ensure
			item_set: item = f
		end

feature -- Access

	compiled_class: CLASS_C
			-- Associated class.
		do
			Result := item.source_class.compiled_class
		end

feature {NONE} -- Access

	item: FIX_CLASS
			-- The fix to apply.

feature -- Output

	menu_item: EV_MENU_ITEM
			-- A menu entry describing the fix.
		local
			formatter: EB_EDITOR_TOKEN_GENERATOR
			message: STRING_32
		do
			create formatter.make
			item.append_name (formatter)
			if attached formatter.last_line as l then
				message := l.wide_image
			end
			if attached message implies message.is_empty then
				message := locale.translation ("Apply a fix")
			end
			create Result.make_with_text (message)
		end

feature -- Fixing

	apply_to (m: ES_CLASS_TEXT_AST_MODIFIER)
			-- Attempt to apply the fix using `m`.
			-- Useful when several modifications should be done for the same source code in a row.
		require
			m.is_prepared
		deferred
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2014-2017, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
