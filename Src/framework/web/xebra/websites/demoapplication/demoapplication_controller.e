note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	DEMOAPPLICATION_CONTROLLER

inherit
	XWA_CONTROLLER

create
	make

feature {NONE} -- Initialization	

	make
			--
		do

		end

feature -- Basic Operations

	on_page_load
			--
		do

		end

	login_ok: BOOLEAN
			--
		do
			Result := False

			if attached current_request as r then
				if attached r.post_parameters as post then
					if attached post.item ("name") as name then
						if attached post.item ("password") as pass then

							if name.is_equal ("fabio") and pass.is_equal ("123") then
								Result := True
							end
						end

					end
				end
			end
		end

feature -- Access

feature -- Measurement

feature -- Element change

feature -- Status report

feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

end
