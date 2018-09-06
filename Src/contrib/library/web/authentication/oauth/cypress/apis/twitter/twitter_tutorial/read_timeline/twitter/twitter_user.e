note
	description: "Summary description for {TWITTER_USER}."
	author: "Jocelyn Fiat"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Object USER", "src=https://dev.twitter.com/overview/api/users", "protocol=uri"

class
	TWITTER_USER

--TODO
--Check Twitter Object User and see if this class if up to date!!!.
feature -- Access: Basic

	id: INTEGER
			-- a permanent unique id referencing an object, such as user or status
			-- Examples: 14198354 (user)

	name: detachable STRING
			-- full name of a registered user

	screen_name: detachable STRING
			-- display name for a user
			-- Examples: tweetybird, johnd

	location: detachable STRING
			-- user specified string representing where they are from
			-- Examples: empty (Default), California OR New York, NY, In The Woods, 27.893621,-82.243706

	description: detachable STRING
			-- 160 characters or less of text that describes a user
			-- Examples: empty (Default), I like new shiny things.	

	profile_image_url: detachable STRING
			-- location to a user's avatar file
			-- Examples:  http://static.twitter.com/images/default_profile_normal.png (Default), http://s3.amazonaws.com/twitter_production/profile_images/14198354/sweet_avatar.jpg

	url: detachable STRING
			-- user's homepage
			-- Examples: empty, http://downforeveryoneorjustme.com	

	protected: BOOLEAN
			-- boolean indicating if a user has a protected profile

	followers_count: INTEGER
			-- number of users following a user's updates

	status: detachable TWITTER_STATUS
			-- Latest update status

feature -- Access: Extended	


	profile_background_color: detachable STRING
			-- hex RGB value for a user's background color
			-- Example: 9ae4e8 (Default)	

	profile_text_color: detachable STRING
			-- hex RGB value for a user's text color
			-- Example: 000000 (Default)

	profile_link_color: detachable STRING
			-- hex RGB value for a user's link color
			-- Example: 0000ff (Default)	

	profile_sidebar_fill_color: detachable STRING
			-- hex RGB value for a user's sidebar color
			-- Example: e0ff92 (Default)	

	profile_sidebar_border_color: detachable STRING
			-- hex RGB value for a user's border color
			-- Example: 87bc44 (Default)

	friends_count: INTEGER
			-- number of users a user is following

	created_at: detachable STRING
			-- timestamp of element creation, either status or user
			-- Example: Sat Jan 24 22:14:29 +0000 2009

	favorites_count: INTEGER
			-- number of statuses a user has marked as favorite

	utc_offset: INTEGER
			-- number of seconds between a user's registered time zone and Coordinated Universal Time
			-- Examples: -21600 (Default), 36000	

	time_zone: detachable STRING
			-- a user's time zone
			-- Examples: Central Time (US & Canada) (Default), Sydney	

	profile_background_image_url: detachable STRING
			-- location of a user's background image
			-- Examples: empty, http://static.twitter.com/images/themes/theme1/bg.gif (Default), http://s3.amazonaws.com/twitter_production/profile_background_images/2752608/super_sweet.jpg	

	profile_background_tile: BOOLEAN
			-- boolean indicating if a user's background is tiled

	following: BOOLEAN
			-- boolean indicating if a user is following a given user

	notifications: BOOLEAN
			-- boolean indicating if a user is receiving device updates for a given user

	statuses_count: INTEGER
			-- the total number of status updates performed by a user, excluding direct messages sent

feature -- Access

	short_out: STRING
			-- <Precursor>
		local
			n: detachable STRING
		do
			create Result.make_from_string ("USER#")
			Result.append_integer (id)

			if attached screen_name as l_screen_name then
				n := l_screen_name.string
			end
			if attached name as l_name then
				if n /= Void and then not n.same_string (l_name) then
					n.prepend_string (l_name + " (")
					n.append_string (")")
				end
			end
			if n /= Void then
				Result.append_string (" %"")
				Result.append_string (n)
				Result.append_string ("%"")
			end
			if protected then
				Result.append_string (" +Protected")
			end
		end

	full_out: STRING
			-- <Precursor>
		local
			l_offset: STRING
		do
			l_offset := "  "

			create Result.make_from_string (short_out)
			Result.append_string ("%N")

			if attached location as l_location then
				Result.append_string (l_offset)
				Result.append_string ("location=")
				Result.append_string (l_location)
				Result.append_string ("%N")
			end
			if attached description as l_description then
				Result.append_string (l_offset)
				Result.append_string ("description=")
				Result.append_string (l_description)
				Result.append_string ("%N")
			end
			if attached url as l_url then
				Result.append_string (l_offset)
				Result.append_string ("url=")
				Result.append_string (l_url)
				Result.append_string ("%N")
			end
			if attached created_at as l_created_at then
				Result.append_string (l_offset)
				Result.append_string ("created_at=")
				Result.append_string (l_created_at)
				Result.append_string ("%N")
			end

			if statuses_count > 0 then
				Result.append_string (l_offset)
				Result.append_string ("statuses_count=")
				Result.append_integer (statuses_count)
				Result.append_string ("%N")
			end
			if followers_count > 0 then
				Result.append_string (l_offset)
				Result.append_string ("followers_count=")
				Result.append_integer (followers_count)
				Result.append_string ("%N")
			end
			if friends_count > 0 then
				Result.append_string (l_offset)
				Result.append_string ("friends_count=")
				Result.append_integer (friends_count)
				Result.append_string ("%N")
			end
			if favorites_count > 0 then
				Result.append_string (l_offset)
				Result.append_string ("favorites_count=")
				Result.append_integer (favorites_count)
				Result.append_string ("%N")
			end

			if following then
				Result.append_string (l_offset)
				Result.append_string ("following=")
				Result.append_boolean (True)
				Result.append_string ("%N")
			end
			if notifications then
				Result.append_string (l_offset)
				Result.append_string ("notifications=")
				Result.append_boolean (True)
				Result.append_string ("%N")
			end

			if attached time_zone as l_time_zone then
				Result.append_string (l_offset)
				Result.append_string ("time_zone=")
				Result.append_string (l_time_zone)
				if utc_offset /= 0 then
					Result.append_string (" (+" + utc_offset.out + " sec.)")
				end
				Result.append_string ("%N")
			end

			if attached status as l_status then
				Result.append_string (l_offset)
				Result.append_string ("status=[")
				Result.append_string (l_status.short_out)
				Result.append_string ("]%N")
			end
		end

feature -- Element change: basic

	set_id (a_id: like id)
			-- Set `id' to `a_id'
		do
			id := a_id
		end

	set_name (a_name: like name)
			-- Set `name' to `a_name'
		do
			name := a_name
		end

	set_screen_name (a_screen_name: like screen_name)
			-- Set `screen_name' to `a_screen_name'
		do
			screen_name := a_screen_name
		end

	set_location (a_location: like location)
			-- Set `location' to `a_location'
		do
			location := a_location
		end

	set_description (a_description: like description)
			-- Set `description' to `a_description'
		do
			description := a_description
		end

	set_profile_image_url (a_profile_image_url: like profile_image_url)
			-- Set `profile_image_url' to `a_profile_image_url'
		do
			profile_image_url := a_profile_image_url
		end

	set_url (a_url: like url)
			-- Set `url' to `a_url'
		do
			url := a_url
		end

	set_protected (a_protected: like protected)
			-- Set `protected' to `a_protected'
		do
			protected := a_protected
		end

	set_followers_count (a_followers_count: like followers_count)
			-- Set `followers_count' to `a_followers_count'
		do
			followers_count := a_followers_count
		end

	set_status (a_status: like status)
			-- Set `status' to `a_status'
		do
			status := a_status
		end


feature -- Element change: Extended	

	set_profile_background_color (a_profile_background_color: like profile_background_color)
			-- Set `profile_background_color' to `a_profile_background_color'
		do
			profile_background_color := a_profile_background_color
		end

	set_profile_text_color (a_profile_text_color: like profile_text_color)
			-- Set `profile_text_color' to `a_profile_text_color'
		do
			profile_text_color := a_profile_text_color
		end

	set_profile_link_color (a_profile_link_color: like profile_link_color)
			-- Set `profile_link_color' to `a_profile_link_color'
		do
			profile_link_color := a_profile_link_color
		end

	set_profile_sidebar_fill_color (a_profile_sidebar_fill_color: like profile_sidebar_fill_color)
			-- Set `profile_sidebar_fill_color' to `a_profile_sidebar_fill_color'
		do
			profile_sidebar_fill_color := a_profile_sidebar_fill_color
		end

	set_profile_sidebar_border_color (a_profile_sidebar_border_color: like profile_sidebar_border_color)
			-- Set `profile_sidebar_border_color' to `a_profile_sidebar_border_color'
		do
			profile_sidebar_border_color := a_profile_sidebar_border_color
		end

	set_friends_count (a_friends_count: like friends_count)
			-- Set `friends_count' to `a_friends_count'
		do
			friends_count := a_friends_count
		end

	set_created_at (a_created_at: like created_at)
			-- Set `created_at' to `a_created_at'
		do
			created_at := a_created_at
		end

	set_favorites_count (a_favorites_count: like favorites_count)
			-- Set `favorites_count' to `a_favorites_count'
		do
			favorites_count := a_favorites_count
		end

	set_utc_offset (a_utc_offset: like utc_offset)
			-- Set `utc_offset' to `a_utc_offset'
		do
			utc_offset := a_utc_offset
		end

	set_time_zone (a_time_zone: like time_zone)
			-- Set `time_zone' to `a_time_zone'
		do
			time_zone := a_time_zone
		end

	set_profile_background_image_url (a_profile_background_image_url: like profile_background_image_url)
			-- Set `profile_background_image_url' to `a_profile_background_image_url'
		do
			profile_background_image_url := a_profile_background_image_url
		end

	set_profile_background_tile (a_profile_background_tile: like profile_background_tile)
			-- Set `profile_background_tile' to `a_profile_background_tile'
		do
			profile_background_tile := a_profile_background_tile
		end

	set_following (a_following: like following)
			-- Set `following' to `a_following'
		do
			following := a_following
		end

	set_notifications (a_notifications: like notifications)
			-- Set `notifications' to `a_notifications'
		do
			notifications := a_notifications
		end

	set_statuses_count (a_statuses_count: like statuses_count)
			-- Set `statuses_count' to `a_statuses_count'
		do
			statuses_count := a_statuses_count
		end

invariant
	valid_description: attached description as d implies d.count <= 160

note
	copyright: "Copyright (c) 2003-2009, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
