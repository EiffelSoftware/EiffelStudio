note
	description: "Object view that represent a wish interaction"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_INTERACTION_FORM_VIEW

create
	make

feature {NONE} -- Intialization

	make (a_status: like status; a_categories: like categories)
			-- Create an object instance
			-- Set `status' to `a_status'
			-- Set `categories' to `a_categories'.
		do
			status := a_status
			categories := a_categories
		ensure
			status_set:  status = a_status
			categories_set:  categories = a_categories
		end


feature -- Access

	status: LIST [CMS_MOTION_LIST_STATUS]
			-- Possible list of status.

	categories:  LIST [CMS_MOTION_LIST_CATEGORY]
			-- Possible list of categories.

	description: detachable READABLE_STRING_32
			-- Interaction description.

	selected_status: INTEGER_64;
			-- Current selected status.

	category: INTEGER_64
			-- Current selected category.

	wish: detachable CMS_MOTION_LIST
			-- Current current wish item to add an interaction.

	id: INTEGER_64
		-- Current interaction id.		

	uploaded_files: detachable LIST [CMS_MOTION_FILE]
		-- Uploaded files.

	temporary_files: detachable LIST [CMS_MOTION_FILE]
		-- Temporary files.	

	temporary_files_names: detachable LIST [READABLE_STRING_GENERAL]
		-- Temporary files names.	

feature -- Status Report

	is_valid_form: BOOLEAN
			-- An interaction form is valid iff
			-- A description is defined and it's not empty
			-- A selected status by default is 0
			-- A category by default is 0.
		do
			if attached description as l_description and then
			   not l_description.is_empty  and then
			   selected_status >= 0 and then category >= 0 then
			   	Result := True
			end
		end

	confirm_changes
		do
			if
				selected_status = 0 and then
			    category = 0 and then
			    attached wish as l_wish and then
			    attached l_wish.status as l_status and then
			    attached l_wish.category as l_category
			then
			    set_status_by_synopsis(l_status.synopsis)
			   	set_category_by_synopsis (l_category.synopsis)
			end
		end

feature -- Element Change

	set_selected_status (a_status: like selected_status)
			-- Set `selected_status' with `a_status'.
		do
			selected_status := a_status
		ensure
			selected_status_set: selected_status = a_status
		end

	set_category (a_category: like category)
			-- Set `category' with `a_category'.
		do
			category := a_category
		ensure
			category_set: category = a_category
		end

	set_wish (a_wish: like wish)
			-- Set `wish' with `a_wish'.
		do
			wish := a_wish
		ensure
			wish_set: wish = a_wish
		end

	set_description (a_description: like description)
			-- Set `description' with `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

	set_id (a_id: INTEGER_64)
			-- Set `id' with `a_id'.
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

	set_status_by_synopsis (a_synopsis: READABLE_STRING_GENERAL)
			-- Set `selected_status' id by synosis, if match.
		do
			across status as c loop
				if a_synopsis.same_string (c.item.synopsis) then
					set_selected_status (c.item.id)
				end
			end
		end

	set_category_by_synopsis (a_synopsis: READABLE_STRING_GENERAL)
			-- Set `category' id by synosis, if match.
		do
			across categories as c loop
				if a_synopsis.same_string (c.item.synopsis) then
					set_category (c.item.id)
				end
			end
		end

	set_files (a_files: like uploaded_files)
			-- Set `uploaded_files' with `a_files'.
		do
			uploaded_files := a_files
		ensure
			uploaded_files_set: uploaded_files = a_files
		end

	set_temporary_files (a_files: like temporary_files)
			-- Set `temporary_files' with `a_files'.
		do
			temporary_files := a_files
		ensure
			temporary_files_set: temporary_files = a_files
		end

	add_temporary_file_name (a_name: READABLE_STRING_GENERAL)
		local
			l_files: like temporary_files_names
		do
			l_files := temporary_files_names
			if l_files = Void then
				create {ARRAYED_LIST [READABLE_STRING_GENERAL]} l_files.make (1)
				temporary_files_names := l_files
			end
			l_files.force (a_name)
		end
end
