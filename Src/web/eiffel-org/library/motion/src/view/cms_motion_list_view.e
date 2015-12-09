note
	description: "Object that represent a Wish list item to be rendered in a View, for example HTML"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_LIST_VIEW

create
	make

feature {NONE} -- Initialization

	make (a_wish_list: LIST [CMS_MOTION_LIST]; a_index: INTEGER; a_pages: INTEGER; a_categories: LIST [CMS_MOTION_LIST_CATEGORY]; a_status: LIST [CMS_MOTION_LIST_STATUS];)
			-- Create a new object with wish_list `a_wish_list'
			-- current page `a_index'
			-- number of pages `a_pages'
			-- a possible list of categories `a_categories'
			-- a possible list of status `a_status'
		do
			wish_list := a_wish_list
			index := a_index
			pages := a_pages
			categories := a_categories
			status := a_status
		ensure
			wish_list_set: wish_list = a_wish_list
			index_set: index = a_index
			pages_set: pages = a_pages
			categories_set: categories = a_categories
			status_set: status = a_status
		end

feature -- Access

	id: detachable STRING
		-- Report id.

	wish_list: LIST [CMS_MOTION_LIST]
		-- Possible list of wish.

	index: INTEGER
		--  Current index.

	size: INTEGER
		-- Page Size	

	pages: INTEGER
		-- Number of pages.

	categories: LIST [CMS_MOTION_LIST_CATEGORY]
		-- Possible list of wishlist  categories.

	status: LIST [CMS_MOTION_LIST_STATUS]
		-- Possible list wish list status.

	selected_status: INTEGER
		-- Status selected.

	selected_category: INTEGER
		-- Category selected.

	order_by: detachable STRING_32
		-- Field used to sort the reports.

	direction: detachable STRING_32
		-- Direction ASC|DESC.

	filter: detachable STRING_32
		-- Filter text to search
		-- By default search by synopsis.
		-- If content is checked, also search by ToReproduce, Descriptions and Interactions Contents.

	filter_content: INTEGER
		-- Is filter by content checked?
		-- 1: yes, 0: no.

feature -- Change Element

	set_id (a_id: STRING)
			-- Set `id' to `a_id'.
		do
			id := a_id
		ensure
			selected_id: id = a_id
		end

	set_selected_status (a_val: INTEGER)
			-- Set `selected_status' to selected value `a_val'.
		do
			selected_status := a_val
		ensure
			selected_status_set: selected_status = a_val
		end

	set_selected_category (a_val: INTEGER)
			-- Set `selected_category' to selected value `a_val'.
		do
			selected_category := a_val
		ensure
			selected_category_set: selected_category = a_val
		end

	set_order_by (a_order_by: READABLE_STRING_32)
			-- Set `orger_by' to `a_order_by'.
		do
			order_by := a_order_by
		end

	set_direction (a_direction: STRING)
			-- Set `direction' to `a_direction'.
			-- direction (ASC|DESC)
		do
			direction := a_direction
		end

	set_size (a_size: INTEGER)
			-- Set `size' to `size'
		do
			size := a_size
		ensure
			size_set: size = a_size
		end

	set_filter (a_filter: like filter)
			-- Set `filter' to `a_filter'.
		do
			filter := a_filter
		ensure
			filter_set: filter = a_filter
		end

	set_filter_content (a_filter_content: like filter_content)
			-- Set `filter_content' to `a_filter_content'.
		do
			filter_content := a_filter_content
		ensure
			filter_content_set: filter_content = a_filter_content
		end

end
