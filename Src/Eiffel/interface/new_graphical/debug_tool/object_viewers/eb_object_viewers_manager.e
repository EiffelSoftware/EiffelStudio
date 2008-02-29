indexing
	description: "object viewer manager ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_VIEWERS_MANAGER

inherit
	EV_SHARED_APPLICATION

	EB_CONSTANTS

	SHARED_DEBUGGER_MANAGER

	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_PREFERENCES

create
	make

create {ES_OBJECT_VIEWER_TOOL_PANEL}
	make_for_tool

feature {NONE} -- Initialization

	make is
		local
			v, vr: like current_viewer
		do
			create viewers.make (1)
			create viewer_changed_actions
			create {OBJECT_DUMPER_VIEWER_BOX} v.make (Current)
			add_viewer (v, Void)
			vr := v
			create {STRING_DISPLAY_VIEWER_BOX} v.make (Current)
			add_viewer (v, vr)
			vr := v
			create {XML_DISPLAY_VIEWER_BOX} v.make (Current)
			add_viewer (v, vr)
			create {OBJECT_BROWSER_VIEWER_BOX} v.make (Current)
			add_viewer (v, Void)
			create {OBJECT_INTERNAL_VIEWER_BOX} v.make (Current)
			add_viewer (v, Void)

			build_interface
		end

	make_for_tool (a_tool: like tool) is
		do
			tool := a_tool
			make
		end

	add_viewer (v: like current_viewer; p: like current_viewer) is
		do
			if p /= Void then
				p.subviewers.extend (v)
			else
				viewers.force (v)
			end
		end

feature -- Interface

	build_interface is
			--
		local
			vb: EV_VERTICAL_BOX
			lab: EV_LABEL
		do
			create vb
			widget := vb

			create viewer_cell
			vb.extend (viewer_cell)

			create lab.make_with_text (Interface_names.l_viewer_drop_object_here)
			lab.align_text_center
			lab.drop_actions.extend (agent set_stone)
			blank_viewer_widget := lab

			set_current_viewer (Void)
 			set_title (Interface_names.t_Object_viewer_tool)
		end

	menu: EV_MENU is
		local
			lst: LIST [EV_MENU_ITEM]
			mi: EV_MENU_ITEM
		do
			Result := internal_menu
			if Result = Void then
				create Result
				create mi.make_with_text (interface_names.b_reset)
				mi.select_actions.extend (agent reset)
				Result.extend (mi)
				Result.extend (create {EV_MENU_SEPARATOR})
				lst := menu_items (0, viewers)
				if lst /= Void and then lst.count > 0 then
					Result.append (lst)
				end
				internal_menu := Result
				update_menu
			end
		end

	menu_items (a_level: INTEGER; lst: LIST [like current_viewer]): LIST [EV_MENU_ITEM] is
		local
			mi: EV_MENU_ITEM
			v: like current_viewer
			sublst: LIST [EV_MENU_ITEM]
			s: STRING_32
		do
			if lst /= Void and then lst.count > 0 then
				create {ARRAYED_LIST [EV_MENU_ITEM]} Result.make (lst.count)
				from
					lst.start
				until
					lst.after
				loop
					v := lst.item
					create s.make_filled (' ', a_level * 2)
					s.append_string_general (v.name)
					create mi.make_with_text (s)
					mi.set_data (v)
					mi.select_actions.extend (agent set_current_viewer (v))
					Result.extend (mi)
					sublst := menu_items (a_level + 1, v.subviewers)
					if sublst /= Void then
						Result.append (sublst)
					end
					lst.forth
				end
			end
		end

feature -- Viewers

	viewer_cell: EV_CELL

	current_viewer: EB_OBJECT_VIEWER

	blank_viewer_widget: EV_WIDGET

	set_current_viewer (v: like current_viewer) is
		do
			if v = Void or else current_viewer /= v then
				if v = Void then
					if blank_viewer_widget.parent /= viewer_cell then
						replace_cell_content (viewer_cell, blank_viewer_widget)
						set_title (Interface_names.l_select_viewer)
					end
				else
					replace_cell_content (viewer_cell, v.widget)
					set_title (v.title)
					check current_object = Void or else v.is_valid_stone (current_object, False) end
					v.refresh
				end
				if v /= current_viewer then
					viewer_changed_actions.call ([v])
					current_viewer := v
				end
			end
		end

	refresh_current_viewer is
			-- Refresh Current Viewer
		local
			v: like current_viewer
		do
			v := current_viewer
			if v /= Void then
				viewer_changed_actions.call ([v])
			end
		end

	replace_cell_content (cl: EV_CELL; w: EV_WIDGET) is
			-- Replace the content of cell `c' with `w'
		local
			p: EV_CONTAINER
		do
			p := w.parent
			if p /= Void then
				p.prune_all (w)
			end
			cl.replace (w)
		end

feature -- Actions

	viewer_changed_actions: ACTION_SEQUENCE [TUPLE [like current_viewer]]
			-- Actions triggered when current viewer changed.

feature -- Access

	viewers: ARRAYED_LIST [EB_OBJECT_VIEWER]
			-- List of viewers.

	tool: ES_OBJECT_VIEWER_TOOL_PANEL
			-- Associated viewer tool.

	widget: EV_WIDGET
			-- Vision2 widget representing Current.

	title: STRING_GENERAL
			-- Global title

feature -- Change

	set_title (t: like title) is
		do
			title := t
		end

	lock is
		do
			is_locked := True
		end

	unlock is
		do
			is_locked := False
		end

feature -- Access

	is_locked: BOOLEAN
			-- Is locked ?

	is_stone_valid (st: OBJECT_STONE): BOOLEAN is
			-- Is `st' valid stone for Current?
		do
			Result := st /= Void and then valid_viewer (st) /= Void
		end

	current_object: OBJECT_STONE
			-- Object `Current' is displaying.

	has_object: BOOLEAN is
			-- Has an object been assigned to current?
		do
			Result := current_object /= Void
		end

	current_dump_value: DUMP_VALUE
			-- DUMP_VALUE `Current' is displaying.			

feature -- Change

	set_stone (st: OBJECT_STONE) is
			-- Give a new object to `Current' and refresh the display.
		require
			stone_valid: is_stone_valid (st)
			is_running: Debugger_manager.application_is_executing
		local
			l_item: EV_ANY
			l_dv: ABSTRACT_DEBUG_VALUE
			l_line: ES_OBJECTS_GRID_OBJECT_LINE
		do
			clear
			current_object := st
			Debugger_manager.application_status.keep_object (current_object.object_address)

			l_item := current_object.ev_item
			if l_item /= Void then
				l_dv ?= l_item.data
				if l_dv /= Void then
					current_dump_value := l_dv.dump_value
				else
					l_line ?= l_item.data
					if l_line /= Void then
						current_dump_value := l_line.associated_dump_value
					end
				end
			end

			retrieve_dump_value
			refresh
		end

	retrieve_dump_value is
			-- Retrieve `current_dump_value' from `current_object'.
		require
			has_current_object: has_object
			application_is_executing: debugger_manager.application_is_executing
		do
			if current_dump_value = Void then
				current_dump_value := Debugger_manager.application.dump_value_at_address_with_class (current_object.object_address, current_object.dynamic_class)
			end
		end

	refresh is
		local
			v: like current_viewer
		do
			if current_object /= Void then
				update_menu
				v := current_viewer
				if v /= Void and then v.is_valid_stone (current_object, False) then
					v.refresh
				else
					v := valid_viewer (current_object)
					if v /= Void then
						set_current_viewer (v)
					else
						--| should_not_occurs
					end
				end
			else
				set_current_viewer (Void)
			end
		end

	update_menu is
		local
			lm: EV_MENU
			lmi: EV_MENU_ITEM
			lmci: EV_CHECK_MENU_ITEM
			v: like current_viewer
		do
			lm := internal_menu
			if lm /= Void then
				from
					lm.start
				until
					lm.after
				loop
					lmi := lm.item
					v ?= lmi.data
					lmci ?= lmi
					if lmci /= Void then
						if v = current_viewer then
							lmci.enable_select
						else
							lmci.disable_select
						end
					end

					if v /= Void then
--						lmi.disable_sensitive
--					else
						if current_object = Void or else not v.is_valid_stone (current_object, False) then
							lmi.disable_sensitive
						else
							lmi.enable_sensitive
						end
					end
					lm.forth
				end
			end
		end

	valid_viewer (st: like current_object): like current_viewer is
		do
			Result := valid_viewer_from (st, viewers)
		end

	valid_viewer_from (st: like current_object; lst: LIST [like current_viewer]): like current_viewer is
		local
		do
			if lst /= Void then
				from
					lst.start
				until
					lst.after or Result /= Void
				loop
					Result := valid_viewer_from (st, lst.item.subviewers)
					if Result = Void then
						Result := lst.item
						if not Result.is_valid_stone (st, True) then
							Result := Void
						end
					end
					lst.forth
				end
			end
		end

	destroy is
			-- Destroy Current
		do
			clear
			widget.destroy
			widget := Void
		end

	reset is
		local
			st: APPLICATION_STATUS
		do
			if current_object /= Void then
				st := debugger_manager.application_status
				if st /= Void then
					st.release_object (current_object.object_address)
				end
			end
			clear
			set_current_viewer (Void)
		end

	clear is
			-- Clean current data, useless if dialog closed or destroyed
		do
			current_object := Void
			current_dump_value := Void
			clear_viewers (viewers)
		end

	reset_viewers (lst: LIST [like current_viewer]) is
		do
			if lst /= Void then
				from
					lst.start
				until
					lst.after
				loop
					lst.item.reset
					reset_viewers (lst.item.subviewers)
					lst.forth
				end
			end
		end

	clear_viewers (lst: LIST [like current_viewer]) is
		do
			if lst /= Void then
				from
					lst.start
				until
					lst.after
				loop
					lst.item.clear
					clear_viewers (lst.item.subviewers)
					lst.forth
				end
			end
		end

feature {NONE} -- Implementation

	internal_menu: like menu

	parent_window (w: EV_WIDGET): EV_WINDOW is
		local
			p: EV_WIDGET
		do
			p := w.parent
			if p /= Void then
				Result ?= p
				if Result = Void then
					Result := parent_window (p)
				end
			end
		end

invariant
	valid_stone: has_object implies is_stone_valid (current_object)

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
