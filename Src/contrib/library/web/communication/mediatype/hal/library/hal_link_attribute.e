note
	description: " Represent LINKs properties, a relation can have multiple links sharing the same key"
	date: "$Date$"
	revision: "$Revision$"
	specification: "http://stateless.co/hal_specification.html"
	EIS: "JSON HAL specification", "src=http://tools.ietf.org/html/draft-kelly-json-hal-07", "protocol=uri"

class
	HAL_LINK_ATTRIBUTE

create
	make

feature {NONE} -- Initialization

	make (a_ref: STRING)
			-- Create a link attribute with an href and
			-- set if it's a templated uri or just a uri.
		do
			set_href (a_ref)
			set_templated (is_uri_template)
		ensure
			href_set: href = a_ref
			templated_set: templated = is_uri_template
		end

feature -- Access

	href: STRING
			-- @href
			-- REQUIRED
			-- Its value is either a URI [RFC3986] or a URI Template [RFC6570].
			-- If the value is a URI Template then the Link Object SHOULD have a
   			-- "templated" attribute whose value is true.	

	templated: BOOLEAN
			-- @templated
			-- OPTIONAL
			-- its value is either a URI [RFC3986] or a URI Template[RFC6570]
			-- If the value is a URI Template then the Link Object SHOULD have a
			-- "templated" attribute whose value is true.

	type: detachable STRING
			-- @type
			-- OPTIONAL
			-- Its value is a string used as a hint to indicate the media type
   			-- expected when dereferencing the target resource.

	deprecation: detachable STRING
			-- OPTIONAL
			-- Its presence indicates that the link is to be deprecated (i.e.
   			-- removed) at a future date.  Its value is a URL that SHOULD provide
   			-- further information about the deprecation.

	name: detachable STRING
			--@name
			--OPTIONAL
			--For distinguishing between Resource and Link elements that share the same @rel value.
			--The @name attribute SHOULD NOT be used exclusively for identifying elements within a HAL representation,
			--it is intended only as a 'secondary key' to a given @rel value.

	profile: detachable STRING
			-- Its value is a string which is a URI that hints about the profile (as
   			-- defined by [I-D.wilde-profile-link]) of the target resource.	

	title: detachable READABLE_STRING_32
			--@title
			--OPTIONAL
			--For labeling the destination of a link with a human-readable identifier.

	hreflang: detachable STRING
			--@hreflang
			--OPTIONAL
			--For indicating what the language of the result of dereferencing the link should be.

feature -- Element change

	set_href (a_href: STRING)
			-- Set href with `a_href'
		do
			href := a_href
		ensure
			assigned: href = a_href
		end

	set_templated (a_value: BOOLEAN)
			-- Set `templated' with `a_value'
		do
			templated := a_value
		ensure
			templated_set: templated = a_value
		end

	set_type (a_type: STRING)
			-- 	Set `type' with `a_type'
		do
			type := a_type
		ensure
			type_set: type = a_type
		end

	set_deprecation (a_deprecation: STRING)
			-- Set `deprecation' with `a_deprecation'
		do
			deprecation := a_deprecation
		ensure
			deprecation_set: deprecation = a_deprecation
		end

	set_name (a_name: STRING)
			-- Set name with `a_name'
		do
			name := a_name
		ensure
			assigned: name = a_name
		end

	set_profile (a_profile: STRING)
			-- Set `profile' with `a_profile'
		do
			profile := a_profile
		ensure
			profile_set: profile = a_profile
		end

	set_title (a_title: READABLE_STRING_GENERAL)
			-- Set title with `a_title'
		do
			create {STRING_32} title.make_from_string_general (a_title)
		ensure
			assigned: attached title as l_title and then l_title.is_case_insensitive_equal_general (a_title)
		end

	set_hreflang (a_hreflang: STRING)
			-- Set hreflang with `a_hreflang'
		do
			hreflang := a_hreflang
		ensure
			assigned: hreflang = a_hreflang
		end

feature {NONE} -- Implementation

	is_uri_template: BOOLEAN
			-- Is the current href value a uri_template or just a uri?
		local
			l_uri_template: URI_TEMPLATE
		do
			create l_uri_template.make (href)

			check
				is_valid_template: l_uri_template.is_valid
			end

			Result := not ( l_uri_template.path_variable_names.is_empty and then l_uri_template.query_variable_names.is_empty )
		end

end
