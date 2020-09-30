note
	description: "Interface for accessing stripe storage"
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_STORAGE_NULL

inherit
	STRIPE_STORAGE_I

feature -- Error handler

	error_handler: ERROR_HANDLER
			-- Error handler.
		do
			create Result.make
		end

feature -- Store

	customers_by_uid (a_user: CMS_USER): detachable LIST [READABLE_STRING_32]
		do
		end

	customers_by_email (a_email: READABLE_STRING_GENERAL): detachable LIST [READABLE_STRING_32]
		do
		end

	user_by_customer_id (a_customer_id: READABLE_STRING_GENERAL): detachable CMS_USER
		do
		end

	save_customer_id (a_customer_id: READABLE_STRING_GENERAL; a_user_id: like {CMS_USER}.id; a_email: detachable READABLE_STRING_GENERAL)
		do
		end

feature -- Payment

	record_invoice (a_invoice: STRIPE_INVOICE)
		do
		end

	record_payment_intent (pi: STRIPE_PAYMENT_INTENT)
		do
		end

	is_payment_processed (a_payment_id: READABLE_STRING_GENERAL): BOOLEAN
		do
		end

	payment_records (a_payment_id: READABLE_STRING_GENERAL): detachable LIST [STRIPE_PAYMENT_RECORD]
		do
		end

	subscription_payment_records (a_subscription_id: READABLE_STRING_GENERAL): detachable LIST [STRIPE_PAYMENT_RECORD]
		do
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

