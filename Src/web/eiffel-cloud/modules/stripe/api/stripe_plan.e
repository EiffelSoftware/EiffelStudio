note
	description: "[
		Summary description for {STRIPE_PLAN}.

			See also: https://stripe.com/docs/api/plans/object
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_PLAN

inherit
	STRIPE_OBJECT
		redefine
			make_with_json
		end

create
	make,
	make_monthly, make_yearly, make_weekly, make_daily,
	make_with_json

feature {NONE} -- Initialization

	make_yearly (a_amount: NATURAL_32; a_currency: READABLE_STRING_8; a_interval_count: like interval_count; a_product_id: READABLE_STRING_GENERAL)
		do
			make (a_amount, a_currency, interval_year, a_interval_count, a_product_id)
		end

	make_monthly (a_amount: NATURAL_32; a_currency: READABLE_STRING_8; a_interval_count: like interval_count; a_product_id: READABLE_STRING_GENERAL)
		do
			make (a_amount, a_currency, interval_month, a_interval_count, a_product_id)
		end

	make_weekly (a_amount: NATURAL_32; a_currency: READABLE_STRING_8; a_interval_count: like interval_count; a_product_id: READABLE_STRING_GENERAL)
		do
			make (a_amount, a_currency, interval_week, a_interval_count, a_product_id)
		end

	make_daily (a_amount: NATURAL_32; a_currency: READABLE_STRING_8; a_interval_count: like interval_count; a_product_id: READABLE_STRING_GENERAL)
		do
			make (a_amount, a_currency, interval_day, a_interval_count, a_product_id)
		end

	make (a_amount: NATURAL_32; a_currency: READABLE_STRING_8; a_interval: READABLE_STRING_8; a_interval_count: like interval_count ; a_product_id: READABLE_STRING_GENERAL)
			-- Create plan with an amount in cents `a_amount` in `a_currency`, with cycle `a_interval` for the product `a_product_id`.
		do
			make_empty
			amount := a_amount
			currency := a_currency
			interval := a_interval
			interval_count := a_interval_count
			product := a_product_id.to_string_32
		end

	make_with_json (j: like json)
		do
			create id.make_empty

				-- Default values
			currency := "usd"
			interval := "year"
			interval_count := 1
			billing_scheme := "per_unit"

			usage_type := "licensed"
			interval := "year"
			interval_count := 1

			Precursor (j)
				--{
				--  "id": "plan_H8d4KDxgzXnpSz",
				--  "object": "plan",
				--  "active": true,
				--  "aggregate_usage": null,
				--  "amount": 999,
				--  "amount_decimal": "999",
				--  "billing_scheme": "per_unit",
				--  "created": 1587474412,
				--  "currency": "usd",
				--  "interval": "month",
				--  "interval_count": 1,
				--  "livemode": false,
				--  "metadata": {},
				--  "nickname": null,
				--  "product": "prod_H8d4WQ8W5f0FJD",
				--  "tiers": null,
				--  "tiers_mode": null,
				--  "transform_usage": null,
				--  "trial_period_days": null,
				--  "usage_type": "licensed"
				--}

			if not j.is_empty then
				id := safe_string_8_item (j, "id", id)
				is_active := boolean_item (j, "active", False)
				amount := natural_32_item (j, "amount")
				if
					amount = 0 and then
					attached string_8_item (j, "amount_decimal") as l_decimal and then
					l_decimal.is_natural_32
				then
					amount := l_decimal.to_natural_32
				end
				currency := safe_string_8_item (j, "currency", currency)
				billing_scheme := safe_string_8_item (j, "billing_scheme", billing_scheme)
				creation_timestamp := integer_32_item (j, "created")

				interval := safe_string_8_item (j, "interval", interval)
				interval_count := natural_32_item (j, "interval_count")

				in_livemode := boolean_item (j, "livemode", False)
				nickname := string_32_item (j, "nickname")

				product := string_32_item (j, "product")

				usage_type := safe_string_8_item (j, "usage_type", usage_type)
				metadata := table_item (j, "metadata")
			end
		end

feature -- Access

	is_active: BOOLEAN
			-- Whether the plan can be used for new purchases.

	amount: NATURAL_32
			-- Amount in cents to be charged on the interval specified.

	currency: IMMUTABLE_STRING_8
			-- Three-letter ISO currency code, in lowercase. Must be a supported currency.

	interval: IMMUTABLE_STRING_8
			-- The frequency at which a subscription is billed. One of day, week, month or year.

	is_interval_year: BOOLEAN
		do
			Result := interval.is_case_insensitive_equal_general (interval_year)
		end

	is_interval_month: BOOLEAN
		do
			Result := interval.is_case_insensitive_equal_general (interval_month)
		end

	is_interval_week: BOOLEAN
		do
			Result := interval.is_case_insensitive_equal_general (interval_week)
		end

	is_interval_day: BOOLEAN
		do
			Result := interval.is_case_insensitive_equal_general (interval_day)
		end

	interval_count: NATURAL_32
			-- The number of intervals (specified in the interval attribute) between subscription billings.
			-- For example, interval=month and interval_count=3 bills every 3 months.

	metadata: detachable STRING_TABLE [detachable ANY]
			-- Set of key-value pairs that you can attach to an object.
			-- This can be useful for storing additional information about the object in a structured format.

	nickname: detachable READABLE_STRING_32
			-- A brief description of the plan, hidden from customers.

	product: detachable READABLE_STRING_32
			-- The product whose pricing this plan determines.

	billing_scheme: IMMUTABLE_STRING_8
			-- Describes how to compute the price per period.
			-- Either per_unit or tiered.
			-- per_unit indicates that the fixed amount (specified in amount)
			-- will be charged per unit in quantity (for plans with usage_type=licensed),
			-- or per unit of total usage (for plans with usage_type=metered).
			-- tiered indicates that the unit pricing will be computed using a tiering strategy
			-- as defined using the tiers and tiers_mode attributes.

	creation_timestamp: INTEGER
			-- Time at which the object was created. Measured in seconds since the Unix epoch.

	usage_type: IMMUTABLE_STRING_8
			-- Configures how the quantity per period should be determined.
			-- Can be either metered or licensed.
			--  - licensed automatically bills the quantity set when adding it to a subscription.
			--  - metered aggregates the total usage based on usage records.
			-- Defaults to licensed.

	is_usage_type_licensed: BOOLEAN
		do
			Result := usage_type.is_case_insensitive_equal_general ("licensed")
		end

	is_usage_type_metered: BOOLEAN
		do
			Result := usage_type.is_case_insensitive_equal_general ("metered")
		end

feature -- Query

	identifier: detachable READABLE_STRING_32
		do
			if has_id then
				Result := id.to_string_32
			elseif attached nickname as l_nickname then
				Result := l_nickname
			elseif attached product as l_product then
				Result := l_product
			end
		end

feature -- Constants

	interval_year: STRING = "year"

	interval_month: STRING = "month"

	interval_week: STRING = "week"

	interval_day: STRING = "day"

feature -- Element change

	set_nickname (v: READABLE_STRING_GENERAL)
		do
			nickname := v.to_string_32
		end

end
