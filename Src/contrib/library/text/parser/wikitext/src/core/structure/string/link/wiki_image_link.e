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

	make_inlined (s: STRING)
			-- [[Image:title|string]]
		do
			make (s)
			set_inlined (True)
		end

	make (s: STRING)
			-- [[Image:title|string]]
		local
			t: STRING
		do
			Precursor (s)
			t := name
			if t.as_lower.starts_with ("image:") then
				name := t.substring (("image:").count + 1, t.count)
			end
			set_inlined (False)

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
					elseif s.ends_with_general ("px") then
						s := s.substring (1, s.count - 2)
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
						if attached width_parameter as w and then w.is_empty then
							width_parameter := Void
						end
						a_parameters.remove
					elseif s.is_case_insensitive_equal_general ("upright") then
						upright_parameter := "0.75"
						a_parameters.remove
					elseif s.starts_with_general ("upright=") then
						upright_parameter := s.substring (8, s.count)
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
		end

feature -- Query

	has_thumb_parameter: BOOLEAN

	has_frame: BOOLEAN

	has_border: BOOLEAN

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
			"Do not use has_parameter anymore [2014/July]"
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
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
