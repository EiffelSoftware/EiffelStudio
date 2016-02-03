note
	description: "Summary description for {CMS_MOTION_DETAIL_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_DETAIL_HANDLER

inherit

	CMS_MOTION_LIST_ABSTRACT_HANDLER

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

feature -- GET

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			wish_details (req, res)
		end

feature {NONE} -- Implementation

	wish_details (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Retrieve wish_details users.
		local
		do
			if	attached {WSF_STRING} req.path_parameter ("id") as l_id then
				wish_detail_by_id (req, res, l_id.value)
			elseif attached {WSF_STRING} req.query_parameter ("search") as l_id then
				wish_detail_by_id (req, res, l_id.value)
			end
		end

	wish_detail_by_id (req: WSF_REQUEST; res: WSF_RESPONSE; a_id: READABLE_STRING_32 )
			-- Retrieve a wish  by a given id `a_id', if any.
		local
			r: CMS_RESPONSE
		do
			if	a_id.is_integer	then
				if attached motion_api.motion_by_id (a_id.to_integer) as l_wish then
					l_wish.set_type (motion_api.item)
					create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
					if attached template_block (get_block_detail, r) as l_tpl_block then
						if attached api.user as l_user then
							if motion_api.has_permission_for_action_on_motion ("edit", l_wish, l_user) then
								l_tpl_block.set_value (True, "can_edit")
							end
							inspect motion_api.vote_motion (l_user, l_wish)
							when 0 then
								l_tpl_block.set_value (True, "can_vote")
							when 1 then
								l_tpl_block.set_value (True, "do_not_like")
							when -1 then
								l_tpl_block.set_value (True, "do_like")
							else
								-- nothing
							end
						end
						l_tpl_block.set_value (l_wish, "wish")
						r.add_block (l_tpl_block, "content")
					end
					r.execute
				else
					create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, api)
					r.execute
				end
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.execute
			end
		end


feature {NONE} -- Implementation

	get_block_detail: STRING
		do
			create Result.make_from_string (motion_api.item)
			Result.append ("_detail")
		end



end
