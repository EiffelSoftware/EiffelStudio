note
	description: "[
		Summary description for {STRIPE_SUBSCRIPTION}.

			See also: https://stripe.com/docs/api/subscriptions/object
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_SUBSCRIPTION

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

			create items.make (0)
			collection_method := "charge_automatically"
			status := status_incomplete


			Precursor (j)
				--{
				--  "id": "sub_H8ymhjwhl0gDvW",
				--  "object": "subscription",
				--  "application_fee_percent": null,
				--  "billing_cycle_anchor": 1587555150,
				--  "billing_thresholds": null,
				--  "cancel_at": null,
				--  "cancel_at_period_end": false,
				--  "canceled_at": null,
				--  "collection_method": "charge_automatically",
				--  "created": 1587555150,
				--  "current_period_end": 1590147150,
				--  "current_period_start": 1587555150,
				--  "customer": "cus_H8yaVr9FjFzmui",
				--  "days_until_due": null,
				--  "default_payment_method": null,
				--  "default_source": null,
				--  "default_tax_rates": [],
				--  "discount": null,
				--  "ended_at": null,
				--  "items": {
				--    "object": "list",
				--    "data": [
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
				--    ],
				--    "has_more": false,
				--    "url": "/v1/subscription_items?subscription=sub_H8ymhjwhl0gDvW"
				--  },
				--  "latest_invoice": null,
				--  "livemode": false,
				--  "metadata": {},
				--  "next_pending_invoice_item_invoice": null,
				--  "pause_collection": null,
				--  "pending_invoice_item_interval": null,
				--  "pending_setup_intent": null,
				--  "pending_update": null,
				--  "plan": {
				--    "id": "plan_H8xnioKqWUTt6V",
				--    "object": "plan",
				--    "active": true,
				--    "aggregate_usage": null,
				--    "amount": 5000,
				--    "amount_decimal": "5000",
				--    "billing_scheme": "per_unit",
				--    "created": 1587551497,
				--    "currency": "usd",
				--    "interval": "month",
				--    "interval_count": 1,
				--    "livemode": false,
				--    "metadata": {},
				--    "nickname": null,
				--    "product": "prod_H8xn4mbuQ1r7oH",
				--    "tiers": null,
				--    "tiers_mode": null,
				--    "transform_usage": null,
				--    "trial_period_days": null,
				--    "usage_type": "licensed"
				--  },
				--  "quantity": 1,
				--  "schedule": null,
				--  "start_date": 1587555150,
				--  "status": "active",
				--  "tax_percent": null,
				--  "trial_end": null,
				--  "trial_start": null
				--}

			if not j.is_empty then
				id := safe_string_8_item (j, "id", id)
				customer_id := string_32_item (j, "customer")
				status := safe_string_8_item (j, "status", status)
				start_date_timestamp := integer_32_item (j, "start_date")
				collection_method := safe_string_8_item (j, "collection_method", collection_method)
				default_payment_method := string_8_item (j, "default_payment_method")
				if attached {JSON_OBJECT} (j / "plan") as j_plan then
					create plan.make_with_json (j_plan)
				end
				if attached {JSON_ARRAY} (j / "items" / "data") as j_items then
					across
						j_items as ic
					loop
						if attached {JSON_OBJECT} ic.item as j_sub_item then
							items.force (create {STRIPE_SUBSCRIPTION_ITEM}.make_with_json (j_sub_item))
						end
					end
				end
				plan_count := integer_32_item (j, "quantity")

				if attached {JSON_OBJECT} j.item ("latest_invoice") as j_invoice then
					create latest_invoice.make_with_json (j_invoice)
				end

				in_livemode := boolean_item (j, "livemode", False)
				metadata := table_item (j, "metadata")
			end
		end

feature -- Access

	current_period_end_timestamp: INTEGER
			-- End of the current period that the subscription has been invoiced for.
			-- At the end of this period, a new invoice will be created.

	current_period_start_timestamp: INTEGER
			-- Start of the current period that the subscription has been invoiced for.

	customer_id: detachable READABLE_STRING_32
			-- ID of the customer who owns the subscription.

	default_payment_method: detachable READABLE_STRING_8
			-- ID of the default payment method for the subscription.
			-- It must belong to the customer associated with the subscription.
			-- If not set, invoices will use the default payment method in the customer's invoice settings.	

	items: ARRAYED_LIST [STRIPE_SUBSCRIPTION_ITEM]
			-- List of subscription items, each with an attached plan.

	latest_invoice: detachable STRIPE_INVOICE
			-- The most recent invoice this subscription has generated.

	metadata: detachable STRING_TABLE [detachable ANY]
			-- Set of key-value pairs that you can attach to an object.
			-- This can be useful for storing additional information about the object in a structured format.

	pending_setup_intent: detachable READABLE_STRING_GENERAL
			-- You can use this SetupIntent to collect user authentication when creating a subscription
			-- without immediate payment or updating a subscription's payment method,
			-- allowing you to optimize for off-session payments. Learn more in the SCA Migration Guide.

	status: READABLE_STRING_8
			-- Possible values are incomplete, incomplete_expired, trialing, active, past_due, canceled, or unpaid.
			-- For collection_method=charge_automatically a subscription moves into incomplete if the initial payment attempt fails.
			--		A subscription in this state can only have metadata and default_source updated.
			--		Once the first invoice is paid, the subscription moves into an active state.
			--		If the first invoice is not paid within 23 hours, the subscription transitions to incomplete_expired.
			--		This is a terminal state, the open invoice will be voided and no further invoices will be generated.
			--
			-- A subscription that is currently in a trial period is trialing and moves to active when the trial period is over.
			--
			-- If subscription collection_method=charge_automatically it becomes past_due when payment to renew it
			--		fails and canceled or unpaid (depending on your subscriptions settings)
			--		when Stripe has exhausted all payment retry attempts.

			-- If subscription collection_method=send_invoice it becomes past_due when its invoice is not paid by the due date,
			--		and canceled or unpaid if it is still not paid by an additional deadline after that.
			--		Note that when a subscription has a status of unpaid, no subsequent invoices will be attempted
			--		(invoices will be created, but then immediately automatically closed).
			--		After receiving updated payment information from a customer, you may choose to reopen and pay their closed invoices.	

	collection_method: READABLE_STRING_8
			-- Either charge_automatically, or send_invoice.
			-- When charging automatically, Stripe will attempt to pay this subscription at the end of the cycle
			-- 		using the default source attached to the customer.
			-- When sending an invoice, Stripe will email your customer an invoice with payment instructions.

	plan: detachable STRIPE_PLAN
			-- Associated plan the customer is subscribed to.
			-- Only set if the subscription contains a single plan.	

	plan_count: INTEGER
			-- The quantity of the plan to which the customer is subscribed.
			-- For example, if your plan is $10/user/month, and your customer has 5 users,
			-- you could pass 5 as the quantity to have the customer charged $50 (5 x $10) monthly.
			-- Only set if the subscription contains a single plan.	

	start_date_timestamp: INTEGER
			-- Date when the subscription was first created.
			-- The date might differ from the created date due to backdating.	

	ended_at_timestamp: INTEGER
			-- If the subscription has ended, the date the subscription ended.	

	cancel_at_period_end: BOOLEAN
			-- If the subscription has been canceled with the at_period_end flag set to true,
			-- cancel_at_period_end on the subscription will be true.
			-- You can use this attribute to determine whether a subscription
			-- that has a status of active is scheduled to be canceled at the end of the current period.

	cancel_at_timestamp: INTEGER
			-- A date in the future at which the subscription will automatically get canceled

	canceled_at_timestamp: INTEGER
			-- If the subscription has been canceled, the date of that cancellation.
			-- If the subscription was canceled with cancel_at_period_end, canceled_at
			-- will still reflect the date of the initial cancellation request,
			-- not the end of the subscription period when the subscription is automatically moved to a canceled state.				

feature -- Status

	is_active: BOOLEAN
		do
			Result := status.is_case_insensitive_equal_general (status_active)
		end

feature -- Constants

	status_incomplete: STRING = "incomplete"
	status_incomplete_expired: STRING = "incomplete_expired"
	status_trialing: STRING = "trialing"
	status_active: STRING = "active"
	status_past_due: STRING = "past_due"
	status_canceled: STRING = "canceled"
	status_unpaid: STRING = "unpaid"

end
