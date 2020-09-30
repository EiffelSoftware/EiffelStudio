note
	description: "Summary description for {STRIPE_PAYMENT_RECORD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_PAYMENT_RECORD

create
	make

feature {NONE} -- Initialization

	make (p_id: like payment_id; a_date: DATE_TIME)
		do
			payment_id := p_id
			date := a_date
		end

feature -- Access

	payment_id: READABLE_STRING_32

	subscription_payment_id: detachable READABLE_STRING_32

	status: detachable READABLE_STRING_8

	date: DATE_TIME

	data: detachable READABLE_STRING_8

feature -- Element change

	set_status (s: like status)
		do
			status := s
		end

	set_subscription_payment_id (sub_p_id: like subscription_payment_id)
		do
			subscription_payment_id := sub_p_id
		end

	set_data (d: like data)
		do
			data := d
		end

feature -- Associated data

	invoice_url: detachable READABLE_STRING_8
		do
			get_data
			if attached invoice as inv then
				Result := inv.hosted_invoice_url
				if
					Result = Void and then
					attached inv.payment_intent as pi
				then
					if attached pi.charges as l_charges then
						across
							l_charges as ic
						until
							Result /= Void
						loop
							Result := ic.item.receipt_url
						end
					end
				end
			end
		end

	receipt_url: detachable READABLE_STRING_8
		local
			pi: like payment
		do
			get_data
			pi := payment
			if pi = Void then
				if attached invoice as inv then
					pi := inv.payment_intent
				end
			end
			if pi /= Void then
				if attached pi.charges as l_charges then
					across
						l_charges as ic
					until
						Result /= Void
					loop
						Result := ic.item.receipt_url
					end
				end
			end
		end

	description: detachable STRING_32
		local
			pi: like payment
		do
			get_data
			pi := payment
			if pi /= Void then
--				Result := pi.
			elseif attached invoice as inv then
				Result := inv.description
			end
		end

	total: detachable TUPLE [price_in_cents: NATURAL_32; currency: READABLE_STRING_8]
			-- Total amount due and paid.
		local
			pi: like payment
		do
			get_data
			pi := payment
			if pi /= Void then
				Result := [pi.amount, pi.currency]
			elseif attached invoice as inv then
				if
					inv.amount_paid > 0 and then
					attached inv.currency as l_currency
				then
					Result := [inv.amount_paid, l_currency]
				else
					pi := inv.payment_intent
					if pi /= Void then
						Result := [pi.amount, pi.currency]
					end
				end
			end
		end

	invoice: detachable STRIPE_INVOICE
		do
			get_data
			if attached associated_data as d then
				Result := d.invoice
			end
		end

	payment: detachable STRIPE_PAYMENT_INTENT
		do
			get_data
			if attached associated_data as d then
				Result := d.payment
			end
		end

	get_data
		local
			obj: STRIPE_OBJECT
			tu: like associated_data
		do
			tu := associated_data
			if tu = Void then
				if attached data as d then
					obj := {STRIPE_FACTORY}.stripe_object (d)
					if attached {STRIPE_INVOICE} obj as inv then
						associated_data := [inv.payment_intent, inv]
					elseif attached {STRIPE_PAYMENT_INTENT} obj as pi then
						associated_data := [pi, Void]
					end
				end
			end
		end

	associated_data: detachable TUPLE [ payment: detachable STRIPE_PAYMENT_INTENT;
										invoice: detachable STRIPE_INVOICE
									  ]

end
