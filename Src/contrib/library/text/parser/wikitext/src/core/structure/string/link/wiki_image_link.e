note
	description: "[
		Summary description for {WIKI_IMAGE_LINK}.
		
		could be ..
			[[Image:Wiki.png|frame|This is Wiki's logo]]
			[[:Image:Wiki.png]]    (direct link to image's page .. do not display)
			
			[[Media:Wiki.png]]    (direct link to the image itself)
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_IMAGE_LINK

inherit
	WIKI_LINK
		redefine
			make,
			process
		end

create
	make,
	make_inlined

feature {NONE} -- Initialization

	make_inlined (s: READABLE_STRING_8)
			-- [[Image:title|string]]
		do
			set_inlined (True)
			make (s)
		end

	make (s: READABLE_STRING_8)
			-- [[Image:title|string]]
		local
			t: STRING
		do
			Precursor (s)
			t := name
			if t.as_lower.starts_with ("image:") then
				name := t.substring (("image:").count + 1, t.count)
			end

			if attached {WIKI_STRING} text as ws and then not ws.is_empty then
				add_parameter (ws.text)
				create {WIKI_STRING} text.make ("")
			end
			analyze_image_parameters (parameters)
		end

	analyze_image_parameters (a_parameters: like parameters)
		local
			s: READABLE_STRING_8
		do
			if a_parameters /= Void then
				from
					a_parameters.start
				until
					a_parameters.after
				loop
					s := a_parameters.item
					if s.is_empty then
						a_parameters.remove
					elseif s.is_case_insensitive_equal_general ("thumb") or s.is_case_insensitive_equal_general ("thumbnail") then
						has_thumb_parameter := True
						a_parameters.remove
					elseif
						s.is_case_insensitive_equal_general ("right")
						or s.is_case_insensitive_equal_general ("left")
						or s.is_case_insensitive_equal_general ("center")
						or s.is_case_insensitive_equal_general ("none")
					then
						location_parameter := s.as_lower
						a_parameters.remove
					elseif s.starts_with_general ("align=") then
						location_parameter := s.substring (s.index_of ('=', 1) + 1 ,s.count).as_lower
						a_parameters.remove
					elseif s.starts_with_general ("alt=") then
						alt_parameter := s.substring (s.index_of ('=', 1) + 1 ,s.count)
						a_parameters.remove
					elseif
						s.is_case_insensitive_equal_general ("baseline")
						or s.is_case_insensitive_equal_general ("middle")
						or s.is_case_insensitive_equal_general ("sub")
						or s.is_case_insensitive_equal_general ("super")
						or s.is_case_insensitive_equal_general ("text-top")
						or s.is_case_insensitive_equal_general ("text-bottom")
						or s.is_case_insensitive_equal_general ("top")
						or s.is_case_insensitive_equal_general ("bottom")
					then
						alignment_parameter := s.as_lower
						a_parameters.remove
					elseif s.is_case_insensitive_equal_general ("frame") then
						has_frame := True
						a_parameters.remove
					elseif s.is_case_insensitive_equal_general ("frameless") then
						has_frame := False
						a_parameters.remove
					elseif s.is_case_insensitive_equal_general ("border") then
						has_border := True
						a_parameters.remove
					elseif s.starts_with_general ("width=") then
						width_parameter := s.substring (s.index_of ('=', 1) + 1 ,s.count).as_lower
						a_parameters.remove
					elseif s.starts_with_general ("height=") then
						height_parameter := s.substring (s.index_of ('=', 1) + 1 ,s.count).as_lower
						a_parameters.remove
					elseif s.ends_with_general ("px") or else s.is_integer then
						if s.is_integer then
								-- Keep `s` as it is.
						else
							s := s.substring (1, s.count - 2)
						end
						if s.has ('x') then
							width_parameter := Void
							height_parameter := Void
							across
								s.split ('x') as s_ic
							loop
								if width_parameter = Void then
									width_parameter := s_ic.item
								elseif height_parameter = Void then
									height_parameter := s_ic.item
								else
								end
							end
						elseif width_parameter = Void then
							width_parameter := s.as_lower
						elseif height_parameter = Void then
							height_parameter := s.as_lower
						end
						if attached width_parameter as w and then w.is_empty then
							width_parameter := Void
						end
						a_parameters.remove
					elseif s.is_case_insensitive_equal_general ("upright") then
						upright_parameter := "0.75"
						a_parameters.remove
					elseif s.starts_with_general ("upright=") then
						upright_parameter := s.substring (s.index_of ('=', 1) + 1 ,s.count)
						a_parameters.remove
					else
						if text.is_empty then
							create {WIKI_STRING} text.make (s)
							a_parameters.remove
						else
							a_parameters.forth
						end
					end
				end
			end
			if
				has_frame or has_thumb_parameter
				or location_parameter /= Void
			then
				inlined := False
			else
				inlined := True
				if attached {WIKI_STRING} text as ws then
						-- See code, it is a WIKI_STRING.
					alt_parameter := ws.text
				end
			end
		end

feature -- Query

	has_thumb_parameter: BOOLEAN

	has_frame: BOOLEAN

	has_border: BOOLEAN

	alt_parameter: detachable READABLE_STRING_8

	location_parameter: detachable READABLE_STRING_8

	alignment_parameter: detachable READABLE_STRING_8

	upright_parameter: detachable READABLE_STRING_8

	width_parameter: detachable READABLE_STRING_8

	height_parameter: detachable READABLE_STRING_8

	has_center_parameter: BOOLEAN
		do
			Result := attached alignment_parameter as s and then s.same_string ("center")
		end

	has_parameter (a_name: READABLE_STRING_GENERAL): BOOLEAN
		obsolete
			"Do not use has_parameter anymore [2017-05-31]"
		do
			if attached parameters as lst then
				across
					lst as ic
				until
					Result
				loop
					Result := ic.item.is_case_insensitive_equal_general (a_name)
				end
			end
		end

	has_width_parameter: BOOLEAN
		do
			Result := width_parameter /= Void
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_image_link (Current)
		end

note
	copyright: "2011-2017, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
