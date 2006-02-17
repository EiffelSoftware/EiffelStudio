indexing
	description: "Contents that have a menu items client programmer want to managed by docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_CONTENT

create
	make,
	make_with_tool_bar

feature {NONE} -- Initlization

	make (a_title: STRING; a_items: like menu_items) is
			-- Creation method.
		require
			a_title_not_void: a_title /= Void
			a_items_not_void: a_items /= Void
		local
			l_button: EV_TOOL_BAR_BUTTON
		do
			title := a_title
			menu_items := a_items

			create menu_items_texts.make (menu_items.count)
			from
				menu_items.start
				menu_items_texts.start
			until
				menu_items.after
			loop
				l_button ?= menu_items.item
				if l_button /= Void then
					menu_items_texts.extend (l_button.text)
				else
					menu_items_texts.extend ("")
				end
				menu_items.forth
			end

		ensure
			set: title = a_title
			set: menu_items = a_items
		end

	make_with_tool_bar (a_title: STRING; a_tool_bar: EV_TOOL_BAR) is
			-- Creation method. A helper function, actually SD_MENU_ZONE only appcept EV_TOOL_BAR_ITEMs.
		require
			a_title_not_void: a_title /= Void
			a_tool_bar_not_void: a_tool_bar /= Void
		local
			l_item: EV_TOOL_BAR_ITEM
			l_temp_items: like menu_items
		do
			from
				a_tool_bar.start
				create l_temp_items.make (0)
			until
				a_tool_bar.after
			loop
				l_item := a_tool_bar.item
				if a_tool_bar.parent /= Void then
					a_tool_bar.item.parent.prune (a_tool_bar.item)
				end
				l_temp_items.extend (l_item)
				a_tool_bar.forth
			end
			make (a_title, l_temp_items)

		ensure
			set: a_title = title
			set: a_tool_bar.count = menu_items.count
		end

feature -- Properties

	title: STRING
			-- Menu title.

	menu_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
			-- All 	EV_TOOL_BAR_ITEM in `Current'.

	items_except_separator: ARRAYED_LIST [EV_TOOL_BAR_ITEM] is
			-- `menu_items' except EV_TOOL_BAR_SEPARATOR.
		local
			l_separator: EV_TOOL_BAR_SEPARATOR
			l_snap_shot: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
		do
			Result := menu_items.twin
			l_snap_shot := menu_items.twin
			from
				l_snap_shot.start
			until
				l_snap_shot.after
			loop
				l_separator := Void
				l_separator ?= l_snap_shot.item
				if l_separator /= Void then
					Result.start
					Result.prune (l_separator)
				end
				l_snap_shot.forth
			end
		ensure
			not_void: Result /= Void
		end

	group_count: INTEGER is
			-- Group count, group is buttons before one separatpr.
		local
			l_separator: EV_TOOL_BAR_SEPARATOR
		do
			Result := 1
			from
				menu_items.start
			until
				menu_items.after
			loop
				l_separator ?= menu_items.item
				if l_separator /= Void then
					Result := Result + 1
				end
				menu_items.forth
			end
		end

	group (a_group_index: INTEGER): ARRAYED_LIST [EV_TOOL_BAR_ITEM] is
			--
		require
			valid: 0 < a_group_index and a_group_index <= group_count
		local
			l_separator: EV_TOOL_BAR_SEPARATOR
			l_group_count: INTEGER
			l_stop: BOOLEAN
		do
			from
				create Result.make (1)
				l_group_count := 1
				menu_items.start
			until
				menu_items.after or l_stop
			loop
				l_separator ?= menu_items.item
				if l_separator /= Void then
					l_group_count := l_group_count + 1
				elseif l_group_count = a_group_index then
					Result.extend (menu_items.item)
				end
				if l_group_count > a_group_index then
					l_stop := True
				end
				menu_items.forth
			end
		ensure
			not_void: Result /= Void
			not_contain_separator:
		end

feature -- Query

	item_count_except_separator: INTEGER is
			-- Item count except EV_TOOL_BAR_SEPARATOR.
		local
			l_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
			l_separator: EV_TOOL_BAR_SEPARATOR
		do
			from
				l_items := menu_items
				l_items.start
			until
				l_items.after
			loop
				l_separator ?= l_items.item
				if l_separator = Void then
					Result := Result + 1
				end
				l_items.forth
			end
		end

feature {SD_MENU_ZONE, SD_FLOATING_MENU_ZONE, SD_MENU_ZONE_ASSISTANT}  -- Internal issues.

	prune_items_from_parent is
			-- Prune all items from its parent if exists.
		do
			from
				menu_items.start
			until
				menu_items.after
			loop
				if menu_items.item.parent /= Void then
					menu_items.item.parent.prune (menu_items.item)
				end
				menu_items.forth
			end
		end

	text_of (a_item: EV_TOOL_BAR_ITEM): STRING is
			-- Text of a_item
		require
			has: menu_items.has (a_item)
		do
			menu_items.start
			menu_items.search (a_item)
			Result := menu_items_texts.i_th (menu_items.index)
		ensure
			not_void: Result /= Void
		end

	size_of (a_item: EV_TOOL_BAR_ITEM; is_vertical: BOOLEAN): INTEGER is
			-- Size of a_item
		require
			has: menu_items.has (a_item)
			type_valid: is_type_valid (a_item)
		local
			l_tool_bar: EV_TOOL_BAR
		do
			l_tool_bar := a_item.parent
			if is_vertical then
				Result := l_tool_bar.height
			else
				Result := l_tool_bar.width
			end
		end

	maximum_item_width: INTEGER is
			-- Maximumu item size.
		local
			l_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
		do
			l_items := menu_items
			from
				l_items.start
			until
				l_items.after
			loop
				if Result < l_items.item.parent.width then
					Result := l_items.item.parent.width
				end
			end
		end

	menu_items_texts: ARRAYED_LIST [STRING];
			-- All strings on `menu_items'.

	button_count_except_separator: INTEGER is
			-- Button count except EV_TOOL_BAR_SEPARATOR.
		local
			l_separetor: EV_TOOL_BAR_SEPARATOR
		do
			from
				menu_items.start
			until
				menu_items.after
			loop
				l_separetor ?= menu_items.item
				if l_separetor = Void then
					Result := Result + 1
				end
				menu_items.forth
			end
		end

	item_start_index (a_group_index: INTEGER): INTEGER is
			-- Start index in `menu_items' of a group. Start index not include EV_TOOL_BAR_SEPARATOR.
		require
			valid: a_group_index > 0 and a_group_index <= group_count
		local
			l_separator: EV_TOOL_BAR_SEPARATOR
			l_group_count: INTEGER
		do
			from
				Result := 1
				l_group_count := 1
				menu_items.start
			until
				menu_items.after or l_group_count = a_group_index
			loop
				l_separator ?= menu_items.item
				if l_separator /= Void then
					l_group_count := l_group_count + 1
				end
				Result := Result + 1

				menu_items.forth
			end
		ensure
			valid: Result > 0 and Result <= menu_items.count
		end

	item_end_index (a_group_index: INTEGER): INTEGER is
			-- End index in `menu_items' of a group. End index not include EV_TOOL_BAR_SEPARATOR.
		require
			valid: a_group_index > 0 and a_group_index <= group_count
		do
			if a_group_index /= group_count then
				Result := item_start_index (a_group_index + 1) - 2
			else
				Result := menu_items.count
			end
		ensure
			valid: Result > 0 and Result <= menu_items.count
		end

feature {SD_MENU_ZONE, SD_FLOATING_MENU_ZONE, SD_MENU_ZONE_ASSISTANT} -- Contract support

	is_type_valid (a_item: EV_TOOL_BAR_ITEM): BOOLEAN is
			-- If a_item type valid?
		local
			l_separator: EV_TOOL_BAR_SEPARATOR
		do
			l_separator ?= a_item
			Result := l_separator = Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
