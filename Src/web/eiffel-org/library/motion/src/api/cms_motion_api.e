note
	description: "[
			API to manage CMS Motion List.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_MOTION_API

inherit
	CMS_MODULE_API

	REFACTORING_HELPER

feature {NONE} -- Initialization

	make_with_storage (a_api: CMS_API; a_motion_storage: CMS_MOTION_LIST_STORAGE_I)
			-- Create an object with api `a_api' and storage `a_motion_storage'.
		do
			motion_storage := a_motion_storage
			make (a_api)
		ensure
			motion_storage_set:  motion_storage = a_motion_storage
		end

feature {CMS_MODULE} -- Access: Motion List storage.

	motion_storage: CMS_MOTION_LIST_STORAGE_I
			-- storage interface.


feature -- Access: Motion List

	row_count_motion_list (a_category: INTEGER; a_status: STRING; a_filter: STRING; a_content:INTEGER ): INTEGER
			-- Row count for motion list
		do
			Result := motion_storage.row_count_motion_list (a_category, a_status, a_filter, a_content)
		end


	motion_list (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_category: INTEGER; a_status: STRING; a_column: READABLE_STRING_32; a_order: INTEGER; a_filter:STRING; a_content:INTEGER): LIST [CMS_MOTION_LIST]
			-- All Motion items, filter by page `a_page_numer' and rows per page `a_row_per_page'
		do
			Result := motion_storage.motion_list (a_page_number, a_rows_per_page, a_category, a_status, a_column, a_order, a_filter, a_content)
		end

	motion_by_id (a_wid: INTEGER): detachable CMS_MOTION_LIST
			-- Motion item for the given id `a_wid', if any.
		require
			valid_id: a_wid > 0
		do
			Result := motion_storage.motion_by_id (a_wid)
			if Result /= Void then
				if attached motion_storage.motion_interactions (a_wid) as l_interactions then
					Result.set_interactions (l_interactions)
					across l_interactions as c loop
						c.item.set_attachments (motion_storage.motion_attachments (a_wid, c.item.id))
					end
				end
				if attached motion_storage.motion_attachments (a_wid, 0) as l_attachments then
					Result.set_attachments (l_attachments)
				end
			end
		end

	motion_attachments (a_wid: INTEGER_64): LIST [CMS_MOTION_FILE]
			--  Motion attachments for a given wish `a_wid', if any.
		do
			if attached motion_storage.motion_attachments (a_wid, 0) as l_list then
				Result := l_list
			else
				create {ARRAYED_LIST [CMS_MOTION_FILE]} Result.make (0)
			end
		end

	motion_interactions_attachments (a_wid: INTEGER_64; a_interaction_id: INTEGER_64): LIST [CMS_MOTION_FILE]
			--  Motion attachments for a given wish `a_wid', if any.
		do
			if attached motion_storage.motion_attachments (a_wid, a_interaction_id) as l_list then
				Result := l_list
			else
				create {ARRAYED_LIST [CMS_MOTION_FILE]} Result.make (0)
			end
		end

	is_author_of_motion (u: CMS_USER; a_wish: CMS_MOTION_LIST): BOOLEAN
			-- Is the user `u' owner of the wish `a_wish'.
		do
			if attached motion_storage.motion_author (a_wish) as l_author then
				Result := u.same_as (l_author)
			end
		end

	vote_motion (u: CMS_USER; a_motion: CMS_MOTION_LIST): INTEGER
			-- Has the user `u' vote for the motion `a_wish'.
			-- 0 no vote
			-- 1 like
			-- -1 not like
		do
			Result := motion_storage.vote_motion (u, a_motion)
		end

feature -- Change Motion votes

	add_motion_like (a_user: CMS_USER; a_wid: INTEGER_64)
			-- User `a_user' add like to motion `a_wid'.
		require
			valid_user: a_user.has_id
			valid_motion: a_wid > 0
		do
			motion_storage.add_motion_like (a_user, a_wid)
		end

	add_motion_not_like (a_user: CMS_USER; a_wid: INTEGER_64)
			-- User `a_user' add not like to motion `a_wid'.
		require
			valid_user: a_user.has_id
			valid_motion: a_wid > 0
		do
			motion_storage.add_motion_not_like (a_user, a_wid)
		end

feature -- Permission Scope: Node

	has_permission_for_action_on_motion (a_action: READABLE_STRING_8; a_wish: CMS_MOTION_LIST; a_user: detachable CMS_USER; ): BOOLEAN
			-- Has permission to execute action `a_action' on wish `a_wish', by eventual user `a_user'?
		local
			l_type_name: READABLE_STRING_8
		do
			l_type_name := a_wish.type
			Result := cms_api.user_has_permission (a_user, a_action + " any " + l_type_name)
			if not Result and a_user /= Void then
				if is_author_of_motion (a_user, a_wish) then
					Result := cms_api.user_has_permission (a_user, a_action + " own " + l_type_name)
				end
			end
		end

feature -- Change: Motion list

	save_motion (a_motion: CMS_MOTION_LIST)
			-- Save a new motion `a_motion'.
		do
			motion_storage.save_motion (a_motion)
		end

	save_motion_interaction (a_motion_interaction: CMS_MOTION_LIST_INTERACTION)
			-- Save a new motion `a_motion_interaction' interaction.
		do
			motion_storage.save_motion_interaction (a_motion_interaction)
		end

	upload_motion_attachment (a_id: INTEGER_64; a_file: CMS_MOTION_FILE)
			-- Save attachement `a_file' for the motion list item associated with the id `a_id'.
		do
			motion_storage.upload_motion_attachment  (a_id, 0,  a_file.size, a_file.content, a_file.name)
		end

	upload_motion_interaction_attachment (a_id: INTEGER_64; a_interaction_id: INTEGER_64; a_file: CMS_MOTION_FILE)
			-- Save attachement `a_file' for the motion list item associated with the id `a_id'.
		do
			motion_storage.upload_motion_attachment  (a_id, a_interaction_id,  a_file.size, a_file.content, a_file.name)
		end

	remove_motion_attachments (a_id: INTEGER_64)
			-- Remove all attachments associated with `a_id'.
		do
			motion_storage.remove_motion_attachments (a_id, 0)
		end

	remove_motion_interaction_attachments (a_id: INTEGER_64; a_interaction_id: INTEGER_64)
			-- Remove all attachments associated with `a_id'.
		do
			motion_storage.remove_motion_attachments (a_id, a_interaction_id)
		end

	remove_motion_attachment_by_name (a_id: INTEGER_64; a_name: READABLE_STRING_32)
			-- Remove attachment with name `a_name' associated with wish `a_id'.
		do
			motion_storage.remove_motion_attachment_by_name (a_id, 0, a_name)
		end

	remove_wish_interaction_attachment_by_name (a_id: INTEGER_64; a_interaction_id: INTEGER_64; a_name: READABLE_STRING_32)
			-- Remove attachment with name `a_name' associated with motion `a_id'.
		do
			motion_storage.remove_motion_attachment_by_name (a_id, a_interaction_id, a_name)
		end

feature -- Access - Categories

	categories_count: INTEGER_64
			-- Number of categories.
		do
			Result := motion_storage.categories_count
		end

	recent_categories (params: CMS_DATA_QUERY_PARAMETERS): ITERABLE [CMS_MOTION_LIST_CATEGORY]
			-- List of the `a_rows' most recent categories starting from `a_offset'.
		do
			Result := motion_storage.recent_categories (params.offset.to_integer_32, params.size.to_integer_32)
		end

	categories: LIST [CMS_MOTION_LIST_CATEGORY]
			-- List of wish list categories.
		do
			Result := motion_storage.categories
		end

	category_by_id (a_id: INTEGER_64): detachable CMS_MOTION_LIST_CATEGORY
			-- Category for the given id `a_id', if any.
		do
			Result := motion_storage.category_by_id (a_id)
		end

	category_by_name (a_name: READABLE_STRING_32): detachable CMS_MOTION_LIST_CATEGORY
			-- Category for the given name`a_name', if any.
		do
			Result := motion_storage.category_by_name (a_name)
		end

feature -- Change - Category

	save_category (a_category: CMS_MOTION_LIST_CATEGORY)
			-- Save category `a_category'.
		do
			motion_storage.save_category (a_category)
		end

feature -- Access - Status

	status: LIST [CMS_MOTION_LIST_STATUS]
			-- List of motion list status.
		do
			Result := motion_storage.status
		end


feature -- Resource Access

	name, collection: STRING
			-- Resource name, also
			-- used as a collection of resources
			-- like wish_list
		deferred
		end

	resource_path: STRING
			-- Path to the resource
			-- For example "/resources"
		deferred
		end

	item: STRING
			-- Element in a collection of resources
			-- for example wish in a wish_list
		deferred
		end

end
