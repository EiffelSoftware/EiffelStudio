indexing
	description: "Docking manager properties."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER_PROPERTY

create
	make

feature {NONE}  -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			internal_docking_manager := a_docking_manager
			create internal_clicked_list.make
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature -- Properties

	last_focus_content: SD_CONTENT
			-- Last focused zone.

	set_last_focus_content (a_content: SD_CONTENT) is
			-- Set `last_focus_content'.
		require
			a_content_not_void: a_content /= Void
		do
			last_focus_content := a_content
			set_content_first (a_content)
		ensure
			set: last_focus_content = a_content
		end

	contents_by_click_order: ARRAYED_LIST [SD_CONTENT] is
			-- All contents by user click order.
		local
			l_current_list: ARRAYED_LIST [SD_CONTENT]
			l_order_list: like internal_clicked_list
		do
			l_current_list := internal_docking_manager.contents.twin
			l_order_list := internal_clicked_list
			from
				create Result.make (1)
				l_order_list.start
			until
				l_order_list.after
			loop
				if l_current_list.has (l_order_list.item) then
					Result.extend (l_order_list.item)
					l_current_list.start
					l_current_list.prune (l_order_list.item)
				end
				l_order_list.forth
			end
			-- Then added SD_CONTENT which user never clicked.
			Result.append (l_current_list)
		end

feature -- Contract support

	has (a_content: SD_CONTENT): BOOLEAN is
			-- Dose docking manager has a_content?
		do
			Result := internal_docking_manager.contents.has (a_content)
		end

feature {NONE}  -- Implementation

	set_content_first (a_content: SD_CONTENT) is
			-- Set a_content which is just clicked by user to first of `contents_by_click_order'.
		require
			has: has (a_content)
		do
			internal_clicked_list.start
			internal_clicked_list.put_left (a_content)
		end

	internal_clicked_list: LINKED_SET [SD_CONTENT]
			-- User clicked SD_CONTENT order.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.

invariant

	internal_clicked_list_not_void: internal_clicked_list /= Void

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
