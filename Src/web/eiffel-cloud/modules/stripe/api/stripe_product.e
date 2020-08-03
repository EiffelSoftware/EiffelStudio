note
	description: "[
		Summary description for {STRIPE_PRODUCT}.
		
			See also: https://stripe.com/docs/api/service_products/object
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_PRODUCT

inherit
	STRIPE_OBJECT
		redefine
			make_with_json
		end

create
	make_service_with_name,
	make_good_with_name,
	make_with_json

feature {NONE} -- Initialization

	make_service_with_name (a_prod_name: READABLE_STRING_GENERAL)
		do
			make_empty
			name := a_prod_name.to_string_32
			type := "service"
		ensure
			is_type_service
		end

	make_good_with_name (a_prod_name: READABLE_STRING_GENERAL)
		do
			make_empty
			name := a_prod_name.to_string_32
			type := "good"
		ensure
			is_type_good
		end

	make_with_json (j: like json)
		do
			create id.make_empty

				-- Default values
			type := "service"

			Precursor (j)
				--{
				--  "id": "prod_H8d4WQ8W5f0FJD",
				--  "object": "product",
				--  "active": true,
				--  "attributes": [],
				--  "created": 1587474412,
				--  "description": null,
				--  "images": [],
				--  "livemode": false,
				--  "metadata": {},
				--  "name": "Bronze Extended",
				--  "statement_descriptor": null,
				--  "type": "service",
				--  "unit_label": null,
				--  "updated": 1587474412
				--}

			if not j.is_empty then
				id := safe_string_8_item (j, "id", id)
				is_active := boolean_item (j, "active", False)
				description := string_32_item (j, "description")
				name := string_32_item (j, "name")

				creation_timestamp := integer_32_item (j, "created")
				modification_timestamp := integer_32_item (j, "updated")

				in_livemode := boolean_item (j, "livemode", False)
				type := safe_string_8_item (j, "type", type)
				attributes := table_item (j, "attributes")
				metadata := table_item (j, "metadata")
			end
		end

feature -- Access

	is_active: BOOLEAN
			-- Whether the product is currently available for purchase.

	description: detachable READABLE_STRING_32
			-- The product's description, meant to be displayable to the customer.
			-- Use this field to optionally store a long form explanation of the product
			-- being sold for your own rendering purposes.

	name: detachable READABLE_STRING_32
			-- The product's name, meant to be displayable to the customer.
			-- Whenever this product is sold via a subscription,
			-- name will show up on associated invoice line item descriptions.

	attributes: detachable STRING_TABLE [detachable ANY]

	metadata: detachable STRING_TABLE [detachable ANY]
			-- Set of key-value pairs that you can attach to an object.
			-- This can be useful for storing additional information about the object in a structured format.

	creation_timestamp: INTEGER
			-- Time at which the object was created. Measured in seconds since the Unix epoch.

	modification_timestamp: INTEGER
			-- Time at which the object was last updated. Measured in seconds since the Unix epoch.

	type: IMMUTABLE_STRING_8
			-- The type of the product.
			-- The product is either of type good, which is eligible for use with Orders and SKUs,
			-- or service, which is eligible for use with Subscriptions and Plans.

	is_type_service: BOOLEAN
		do
			Result := type.is_case_insensitive_equal_general ("service")
		end

	is_type_good: BOOLEAN
		do
			Result := type.is_case_insensitive_equal_general ("good")
		end

feature -- status report

	has_name: BOOLEAN
		do
			Result := attached name as s and then not s.is_whitespace
		end

end
