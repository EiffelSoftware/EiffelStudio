note
	description: "[
				Links primarily map link relations to URIs in a key/value fashion.
				Links are keyed by their link relation (rel attribute), an a key could have 
				more than one link, here we model as link and link attributes. For example
				"_links": {
		    	 	"self": { "href": "/product/987" },
			    	"upsell": [
		      				{ "href": "/product/452", "title": "Flower pot" },
		      				{ "href": "/product/832", "title": "Hover donkey" }
		    				]
					}
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	specification: "http://stateless.co/hal_specification.html"
	example: "http://blog.stateless.co/post/13296666138/json-linking-with-hal"

class
	HAL_LINK

create
	make,
	make_with_attribute,
	make_with_list

feature {NONE} -- Initialization

	make (a_rel: STRING)
		do
			set_rel (a_rel)
			create {ARRAYED_LIST [HAL_LINK_ATTRIBUTE]} attributes.make (2)
		end

	make_with_attribute (a_rel: STRING; an_attribute: HAL_LINK_ATTRIBUTE)
		do
			set_rel (a_rel)
			create {ARRAYED_LIST [HAL_LINK_ATTRIBUTE]} attributes.make (1)
			attributes.force (an_attribute)
		end

	make_with_list (a_rel: STRING; an_array_attributes: ARRAY [HAL_LINK_ATTRIBUTE])
		do
			set_rel (a_rel)
			create {ARRAYED_LIST [HAL_LINK_ATTRIBUTE]} attributes.make_from_array (an_array_attributes)
		end

feature -- Access

	rel: STRING
			-- @rel
			-- REQUIRED
			-- For identifying how the target URI relates to the 'Subject Resource'.
			-- The Subject Resource is the closest parent Resource element.
			-- This attribute is not a requirement for the root element of a HAL representation,
			-- as it has an implicit default value of 'self'
			-- @rel corresponds with the 'relation parameter' as defined in Web Linking [RFC 5988]
			-- @rel attribute SHOULD be used for identifying Resource and Link elements in a HAL representation.

	attributes: LIST [HAL_LINK_ATTRIBUTE]
			-- Multiple links can share the key (rel attribute)
			-- attributes represent the following properties
			-- href, name, title, hreflang

feature -- Element change

	set_rel (a_rel: STRING)
			-- Set rel with `a_rel'
		do
			rel := a_rel
		ensure
			assigned: rel ~ a_rel
		end

	add_attribute (an_attribute: HAL_LINK_ATTRIBUTE)
		do
			attributes.force (an_attribute)
		end

end
