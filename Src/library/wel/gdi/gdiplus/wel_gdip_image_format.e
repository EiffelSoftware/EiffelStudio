indexing
	description: "Image format used by Gdi+"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_IMAGE_FORMAT

obsolete
	"Use {WEL_GDIP_IMAGE_ENCODER} instead"

create
	make

feature {NONE} -- Initlization

	make (a_guid: WEL_GUID) is
			-- Creation method
		require
			not_void: a_guid /= Void
		do
			guid := a_guid
		ensure
			set: guid = a_guid
		end

feature -- Query

	guid: WEL_GUID
			-- Guid

	find_encoder: WEL_GDIP_IMAGE_CODEC_INFO is
			-- Find image encoder related.
		local
			l_all_encoders: ARRAYED_LIST [WEL_GDIP_IMAGE_CODEC_INFO]
			l_image: WEL_GDIP_IMAGE
		do
			from
				create l_image
				l_all_encoders := l_image.all_image_encoders
				l_all_encoders.start
			until
				l_all_encoders.after or Result /= Void
			loop
				if l_all_encoders.item.format_id.is_equal (guid) then
					Result := l_all_encoders.item
				end
				l_all_encoders.forth
			end
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
