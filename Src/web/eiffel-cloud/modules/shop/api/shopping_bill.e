note
	description: "Summary description for {SHOPPING_BILL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHOPPING_BILL

create
	make

feature {NONE} -- Initialization

	make (a_date: like date)
		do
			date := a_date
			status := unknown_status
		end

feature -- Access

	date: DATE_TIME

	title: detachable READABLE_STRING_32
		do
			Result := internal_title
			if
				Result = Void and then
				attached order as o
			then
				if attached o.associated_cart as l_cart then
					Result := l_cart.cart_title (Void)
				end
			end
		end

	order: detachable SHOPPING_ORDER

	status: NATURAL_8

	total_price_as_string: detachable READABLE_STRING_32

	external_invoice_url: detachable READABLE_STRING_8 assign set_external_invoice_url

	external_receipt_url: detachable READABLE_STRING_8 assign set_external_receipt_url

	is_draft: BOOLEAN
		do
			Result := status = draft_status
		end

	is_open: BOOLEAN
		do
			Result := status = open_status
		end

	is_paid: BOOLEAN
		do
			Result := status = paid_status
		end

	is_void: BOOLEAN
		do
			Result := status = void_status
		end

feature -- Internals

	unknown_status: NATURAL_8 = 0

	draft_status: NATURAL_8 = 1

	open_status: NATURAL_8 = 2

	paid_status: NATURAL_8 = 3

	void_status: NATURAL_8 = 4

	internal_title: like title

feature -- Element change

	set_title (a_title: like title)
		do
			internal_title := a_title
		end

	set_order (o: like order)
		do
			order := o
		end

	set_total_price_as_string (a_total: like total_price_as_string)
		do
			total_price_as_string := a_total
		end

	set_external_invoice_url (a_url: like external_invoice_url)
		do
			external_invoice_url := a_url
		end

	set_external_receipt_url (a_url: like external_receipt_url)
		do
			external_receipt_url := a_url
		end

	set_status_to_draft
		do
			status := draft_status
		end

	set_status_to_open
		do
			status := open_status
		end

	set_status_to_paid
		do
			status := paid_status
		end

	set_status_to_void
		do
			status := void_status
		end


end
