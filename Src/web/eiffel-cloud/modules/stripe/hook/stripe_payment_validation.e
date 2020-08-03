note
	description: "Summary description for {STRIPE_PAYMENT_VALIDATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_PAYMENT_VALIDATION

create
	make_from_subscription,
	make_from_payment_intent,
	make

feature {NONE} -- Initialization

	make_from_subscription (a_sub: STRIPE_SUBSCRIPTION; a_customer: STRIPE_CUSTOMER)
		require
			a_sub.has_id
			a_sub.is_active
		do
			make (a_sub.latest_invoice, a_customer)
		end

	make_from_payment_intent (a_pay: STRIPE_PAYMENT_INTENT; a_customer: STRIPE_CUSTOMER)
		require
			a_pay.has_id
		local
			i: INTEGER
			ch: STRIPE_PAYMENT_CHARGE
		do
			make (a_pay.invoice, a_customer)
			if attached a_pay.charges as l_charges then
				across
					l_charges as ic
				loop
					ch := ic.item
					receipt_or_invoice_urls ["receipt#" + ch.id] := ch.receipt_url
				end
			end
		end

	make (a_invoice: detachable STRIPE_INVOICE; a_customer: STRIPE_CUSTOMER)
		require
			a_invoice /= Void implies a_invoice.has_id
		do
			create receipt_or_invoice_urls.make (1)
			invoice := a_invoice
			customer := a_customer
			if a_invoice /= Void then
				receipt_or_invoice_urls ["invoice"] := a_invoice.hosted_invoice_url
				receipt_or_invoice_urls ["invoice_pdf"] := a_invoice.invoice_pdf
			end
		end

feature -- Access

	invoice: detachable STRIPE_INVOICE

	customer: STRIPE_CUSTOMER

	order_id: detachable IMMUTABLE_STRING_32

	metadata: detachable STRING_TABLE [detachable ANY]

	receipt_or_invoice_urls: STRING_TABLE [detachable READABLE_STRING_8]

feature -- Element change

	set_order_id (v: detachable READABLE_STRING_GENERAL)
		do
			if v = Void then
				order_id := Void
			else
				create order_id.make_from_string_general (v)
			end
		end

	import_metadata (tb: STRING_TABLE [detachable ANY])
		local
			l_metadata: like metadata
		do
			l_metadata := metadata
			if l_metadata = Void then
				create l_metadata.make_caseless (tb.count)
				metadata := l_metadata
			end
			across
				tb as ic
			loop
				l_metadata.force (ic.item, ic.key)
			end
		end

end
