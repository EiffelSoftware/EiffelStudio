note
	description: "Summary description for {EV_RIBBON_DROP_DOWN_GALLERY_ITEM}."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_DROP_DOWN_GALLERY_ITEM

feature -- Query

	image: detachable EV_PIXEL_BUFFER
			-- String label

	label: detachable STRING_32
			-- String label

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Select actions executed just after user clicked
		local
			l_cache: like select_actions_cache
		do
			l_cache := select_actions_cache
			if l_cache = Void then
				create l_cache
				select_actions_cache := l_cache
			end
			Result := l_cache
		end

	preview_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Show a preview of a visual element.
		local
			l_cache: like preview_actions_cache
		do
			l_cache := preview_actions_cache
			if l_cache = Void then
				create l_cache
				preview_actions_cache := l_cache
			end
			Result := l_cache
		end

	cancel_preview_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Cancel a preview of a visual element.
		local
			l_cache: like cancel_preview_actions_cache
		do
			l_cache := cancel_preview_actions_cache
			if l_cache = Void then
				create l_cache
				cancel_preview_actions_cache := l_cache
			end
			Result := l_cache
		end

feature -- Command

	set_image (a_image: like image)
			-- Set `image' with `a_image'
		do
			image := a_image
		ensure
			set: image = a_image
		end

	set_label (a_label: like label)
			-- Set `label' with `a_label'
		do
			label := a_label
		ensure
			set: label = a_label
		end

feature {EV_RIBBON_DROP_DOWN_GALLERY} -- Implementation

	select_actions_cache, preview_actions_cache, cancel_preview_actions_cache: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Lazy initialization

end
