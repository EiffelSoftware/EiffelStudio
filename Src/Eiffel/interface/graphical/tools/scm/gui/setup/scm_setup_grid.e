note
	description: "Summary description for {SCM_SETUP_GRID}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_SETUP_GRID

inherit
	SCM_GRID
		redefine
			initialize
		end

create
	default_create,
	make_with_workspace

feature {NONE} -- Initialization

	make_with_workspace (ws: SCM_WORKSPACE)
		do
			default_create
			set_workspace (ws)
		end

	initialize
		do
			Precursor

			set_column_count_to (3)
			column (1).set_title ("Name")
			column (2).set_title ("Location")
			column (3).set_title ("SCM info")

			set_auto_resizing_column (1, True)
			set_auto_resizing_column (2, True)

			enable_default_tree_navigation_behavior (True, True, True, True)
			enable_multiple_row_selection

			key_press_actions.extend (agent  (k: EV_KEY)
				local
					b: BOOLEAN
				do
					if k.code = {EV_KEY_CONSTANTS}.key_space then
						if attached selected_rows_in_grid as lst then
							b := True
							across
								lst as ic
							loop
								if attached {EV_GRID_CHECKABLE_LABEL_ITEM} ic.item.item (1) as cb then
									b := b and cb.is_checked
								end
							end
							across
								lst as ic
							loop
								if attached {EV_GRID_CHECKABLE_LABEL_ITEM} ic.item.item (1) as cb then
									cb.set_is_checked (not b)
								end
							end
						end
					end
				end
			)
		end

feature -- Access

	workspace: detachable SCM_WORKSPACE

feature -- Basic operation

	reset
		do
			set_row_count_to (0)
		end

	set_workspace (w: SCM_WORKSPACE)
		local
			glab: EV_GRID_LABEL_ITEM
			gcb: EV_GRID_CHECKABLE_LABEL_ITEM
			r: EV_GRID_ROW
			i, j: INTEGER
			fn: READABLE_STRING_GENERAL
		do
			workspace := w
--			w.analyze
--			wipe_out
			set_row_count_to (0)

			i := 0
			across
				w.locations as ic
			loop
				fn := ic.item.location.name
				if attached {EV_GRID_ROW} potential_parent_row (fn) as pr then
					j := pr.subrow_count + 1
					pr.insert_subrow (j)
					r := pr.subrow (j)
					pr.expand
				else
					i := row_count + 1
					insert_new_row (i)
					r := row (i)
				end
				r.set_data (fn)
				create gcb.make_with_text (ic.key)
				if attached {SCM_LIBRARY} ic.item as l_scm_lib then
					if l_scm_lib.is_readonly then
						gcb.set_pixmap (icon_pixmaps.folder_library_readonly_icon)
					else
						gcb.set_pixmap (icon_pixmaps.folder_library_icon)
					end
				elseif attached {SCM_CLUSTER} ic.item then
					gcb.set_pixmap (icon_pixmaps.folder_cluster_icon)
				elseif attached {SCM_DIRECTORY} ic.item then
					gcb.set_pixmap (icon_pixmaps.folder_blank_icon)
				end
				gcb.set_is_checked (ic.item.is_included)
				gcb.checked_changed_actions.extend (agent (i_cb: EV_GRID_CHECKABLE_LABEL_ITEM; i_g: SCM_GROUP)
						do
							if i_cb.is_checked then
								i_g.include
							else
								i_g.exclude
							end
						end(?, ic.item)
					)

				r.set_item (1, gcb)
				create glab.make_with_text (fn)
				r.set_item (2, glab)
				if attached ic.item.root as v then
					r.set_item (3, new_scm_label (v))
				else
					r.set_item (3, new_scm_label (Void))
				end
			end
		end

	potential_parent_row (fn: READABLE_STRING_GENERAL): detachable EV_GRID_ROW
		local
			i,n: INTEGER
		do
			from
				n := row_count
				i := n
			until
				i = 0 or Result /= Void
			loop
				if
					attached row (i) as r and then
					attached {READABLE_STRING_GENERAL} r.data as r_fn and then
					fn.count > r_fn.count and then
					fn.starts_with (r_fn) and then
					fn [r_fn.count + 1] = {PATH}.directory_separator
				then
					Result := r
				end
				i := i - 1
			end
		end

	new_scm_label (p: detachable SCM_LOCATION): EV_GRID_LABEL_ITEM
		do
			if p = Void then
				create Result
			else
				if p.nature.is_case_insensitive_equal_general ("git") then
					create Result.make_with_text ({STRING_32} "GIT: " + p.location.name)
				elseif p.nature.is_case_insensitive_equal_general ("svn") then
					create Result.make_with_text ({STRING_32} "SVN: " + p.location.name)
				else
					create Result.make_with_text (p.nature + ": " + p.location.name)
				end
			end
		end

invariant

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
