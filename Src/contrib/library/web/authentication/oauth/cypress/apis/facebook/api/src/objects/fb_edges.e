note
	description: "[
		Object Representing edges - the connections between those "things", such as a Page's Photos, or a Photo's Comments
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Edges", "src=https://developers.facebook.com/docs/graph-api/overview", "protocol=uri"

class
	FB_EDGES [G]


--| Could this class implements an ITERABLE interface?
--| Yes: and it would iterate over Pages.


create
	make

feature -- Initialization

	make (a_api: FACEBOOK_JSON)
		do
			api := a_api
			create {ARRAYED_LIST [G]} data.make (0)
		end

feature -- Access

	data:  LIST [G]
			-- A list of data nodes.

feature -- Element Change

	set_data (a_data: like data)
			-- Set `data' with  `a_data'.
		do
			data := a_data
		ensure
			data_set: data = a_data
		end

	set_paging (a_paging: like paging)
			-- Set `paging' with `a_paging'.
		do
			paging := a_paging
		ensure
			paging_set: paging = a_paging
		end

	set_summary (a_summary: like summary)
			-- Set `summary' with `a_summary'.
		do
			summary := a_summary
		ensure
			summary_set: summary = a_summary
		end

feature {FB_EDGES} -- Implementation

	paging: detachable FB_PAGING
			--  pagination.

	summary: detachable FB_SUMMARY
			-- Aggregated information about the edge, such as counts.
			-- Specify the fields to fetch in the summary param (like summary=total_count).

	action_back: detachable FUNCTION [detachable FB_EDGES [G]]
			-- Agent to create a new item of type FB_CONNECTION [G].

	action_forth: detachable FUNCTION [detachable FB_EDGES [G]]
			-- Agent to create a new item of type FB_CONNECTION [G].

feature -- Change Actions

	set_action_back (a_back: like action_back)
			-- Set `action_back' with `a_back'.
		do
			action_back := a_back
		ensure
			action_back_set: action_back = a_back
		end

	set_action_forth (a_forth: like action_forth)
			-- Set `action_forth' with `a_forth'.
		do
			action_forth := a_forth
		ensure
			action_forth_set: action_forth = a_forth
		end

feature -- Status report

	after: BOOLEAN
			-- Is there no valid cursor position to the right of cursor?
		do
			if attached paging  as l_paging then
				Result := l_paging.next = Void
			else
				Result := True
			end
		end

	before: BOOLEAN
			-- Is there no valid cursor position to the left of cursor?
		do
			if attached paging  as l_paging then
				Result := l_paging.previous = Void
			else
				Result := True
			end
		end

feature -- Cursor movement

	forth
			-- Move to next position;
		require
		 	has_next: not after
		do
			if
				attached paging as l_paging and then
				attached l_paging.next as l_next and then
				attached action_forth as l_forth and then
				attached l_forth.item ([]) as l_page
			then
				if attached l_page.data as l_data then
					set_data (l_data)
				end
				set_paging (l_page.paging)
				set_action_back (l_page.action_back)
				set_action_forth (l_page.action_forth)
			end
		end

	back
		require
			has_previous: not before
		do
			if
				attached paging as l_paging and then
				attached l_paging.previous as l_previous and then
				attached action_back as l_back and then
				attached l_back.item ([]) as l_page
			then
				if attached l_page.data as l_data then
					set_data (l_data)
				end
				set_paging (l_page.paging)
				set_action_back (l_page.action_back)
				set_action_forth (l_page.action_forth)
			end
		end

feature {NONE} -- Implementation

	api: FACEBOOK_JSON
			-- API interface.

end
