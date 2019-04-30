note
	description: "Provide EiffelStudio release information "
	date: "$Date$"
	revision: "$Revision$"

class
	ES_UPDATE_RELEASE

create
	make

feature -- Access

	make (a_channel: READABLE_STRING_8; a_fn: READABLE_STRING_8; a_platform: READABLE_STRING_8; a_link: READABLE_STRING_8; a_number: READABLE_STRING_8)
			-- create an object with channel `a_channel`, filename `fn`, platform `a_platform`, linnk `a_link`, number `a_number`.
		do
			set_number (a_number)
			set_filename (a_fn)
			set_platform (a_platform)
			set_link (a_link)
			set_channel (a_channel)
		ensure
			channel_set:  channel = a_channel
			number_set :  number  = a_number
			filename_set: filename = a_fn
			platform_set: platform = a_platform
			link_set:     link = a_link
		end


feature -- Access

	number: STRING
		-- Release.

	filename: STRING
		-- EiffelStudio name.

	platform: STRING
		-- Target platform.

	link: STRING
		-- Link.

	channel: STRING
		-- Release channel (beta|stable)


feature -- Change Element

	set_number (a_number: READABLE_STRING_8)
			-- Set `number` with `a_number`.
		do
			number := a_number
		ensure
			number_set: number = a_number
		end

	set_filename (a_filename: READABLE_STRING_8)
			-- Set `filename` with `a_filename`.
		do
			filename := a_filename
		ensure
			filename_set: filename = a_filename
		end

	set_platform (a_platform: READABLE_STRING_8)
			-- Set `platform` with `a_platform`.
		do
			platform := a_platform
		ensure
			platform_set: platform = a_platform
		end

	set_link (a_link: READABLE_STRING_8)
			-- Set `link` with `a_link`.
		do
			link := a_link
		ensure
			link_set: link = a_link
		end

	set_channel (a_channel: READABLE_STRING_8)
			-- Set `channel` with `a_channel`.
		do
			channel := a_channel
		ensure
			link_set: channel = a_channel
		end

end
