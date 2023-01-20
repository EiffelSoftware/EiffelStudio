note
	description: "[
		Summary description for {STRIPE_SUBSCRIPTION_ITEM}.

			See also: https://stripe.com/docs/api/subscriptions/object
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_SUBSCRIPTION_ITEM

inherit
	STRIPE_OBJECT
		redefine
			make_with_json
		end

create
	make_with_json

feature {NONE} -- Initialization


	make_with_json (j: like json)
		do
			create id.make_empty

				-- Default values
			create subscription_id.make_empty


			Precursor (j)
				--      {
				--        "id": "si_H8ymPowBXkJo9A",
				--        "object": "subscription_item",
				--        "billing_thresholds": null,
				--        "created": 1587555151,
				--        "metadata": {},
				--        "plan": {
				--          "id": "plan_H8xnioKqWUTt6V",
				--          "object": "plan",
				--          "active": true,
				--          "aggregate_usage": null,
				--          "amount": 5000,
				--          "amount_decimal": "5000",
				--          "billing_scheme": "per_unit",
				--          "created": 1587551497,
				--          "currency": "usd",
				--          "interval": "month",
				--          "interval_count": 1,
				--          "livemode": false,
				--          "metadata": {},
				--          "nickname": null,
				--          "product": "prod_H8xn4mbuQ1r7oH",
				--          "tiers": null,
				--          "tiers_mode": null,
				--          "transform_usage": null,
				--          "trial_period_days": null,
				--          "usage_type": "licensed"
				--        },
				--        "quantity": 1,
				--        "subscription": "sub_H8ymhjwhl0gDvW",
				--        "tax_rates": []
				--      }

				--    "url": "/v1/subscription_items?subscription=sub_H8ymhjwhl0gDvW"

			if not j.is_empty then
				id := safe_string_8_item (j, "id", id)
				subscription_id := safe_string_8_item (j, "subscription", subscription_id)
				created_timestamp := integer_32_item (j, "created")

				if attached {JSON_OBJECT} (j / "plan") as j_plan then
					create plan.make_with_json (j_plan)
				end
				plan_count := integer_32_item (j, "quantity")

				metadata := table_item (j, "metadata")
			end
		end

feature -- Access


	subscription_id: IMMUTABLE_STRING_8

	created_timestamp: INTEGER
			-- Time at which the object was created. Measured in seconds since the Unix epoch.



	plan: detachable STRIPE_PLAN
			-- Associated plan the customer is subscribed to.
			-- Only set if the subscription contains a single plan.	

	plan_count: INTEGER
			-- The quantity of the plan to which the customer is subscribed.
			-- For example, if your plan is $10/user/month, and your customer has 5 users,
			-- you could pass 5 as the quantity to have the customer charged $50 (5 x $10) monthly.
			-- Only set if the subscription contains a single plan.	

	metadata: detachable STRING_TABLE [detachable ANY]
			-- Set of key-value pairs that you can attach to an object.
			-- This can be useful for storing additional information about the object in a structured format.

end
