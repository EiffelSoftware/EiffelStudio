note
	description: "Summary description for {JWT_CONTEXT}."
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_CONTEXT

feature -- Access

	time: detachable DATE_TIME
			-- Date time to use for validation, if Void, use current date time.

	validation_ignored: BOOLEAN
			-- Read claimset of JWT without performing validation of the signature
			-- or any of the regustered claim names.
			-- Warning: - Use this setting with care, only if you clearly understand
			--			  what you are doing.
			-- 			- Without digital signature information, the integrity or authenticity
			--			  of the claimset cannot be trusted.

	issuer: detachable READABLE_STRING_8

	audience: detachable READABLE_STRING_8

feature -- Element change

	ignore_validation (b: BOOLEAN)
			-- If `b` then ignore validations.
		do
			validation_ignored := b
		end

	set_time (dt: detachable DATE_TIME)
		do
			time := dt
		end

	set_issuer (iss: like issuer)
		do
			issuer := iss
		end

	set_audience (aud: like audience)
		do
			audience := aud
		end


end
