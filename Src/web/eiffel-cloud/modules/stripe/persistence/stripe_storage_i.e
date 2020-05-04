note
	description: "Interface for accessing shop storage"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	STRIPE_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Store

	customers_by_uid (a_user: CMS_USER): detachable LIST [READABLE_STRING_32]
		require
			a_user.has_id
		deferred
		end

	customers_by_email (a_email: READABLE_STRING_GENERAL): detachable LIST [READABLE_STRING_32]
		require
			not a_email.is_whitespace
		deferred
		end

	user_by_customer_id (a_customer_id: READABLE_STRING_GENERAL): detachable CMS_USER
		deferred
		end

	save_customer_id (a_customer_id: READABLE_STRING_GENERAL; a_user_id: like {CMS_USER}.id; a_email: detachable READABLE_STRING_GENERAL)
		require
			a_user_id /= 0 or a_email /= Void
		deferred
		end


note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

