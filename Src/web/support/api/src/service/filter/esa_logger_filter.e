note
	description: "Logger filter"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_LOGGER_FILTER


inherit
	WSF_URI_TEMPLATE_HANDLER

	ESA_ABSTRACT_HANDLER
		rename
			set_esa_config as make
		end
	WSF_FILTER

create
	make

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		local
			s: STRING_8
		do
			log.write_debug (generator + ".execute")
			create s.make (2048)
			if attached req.content_type as l_type then
				s.append ("[length=")
				s.append_natural_64 (req.content_length_value)
				s.append_character (']')
				s.append_character (' ')
				s.append (l_type.debug_output)
				s.append_character ('%N')
			end

			append_iterable_to ("Path parameters", req.path_parameters, s)
			append_iterable_to ("Query parameters", req.query_parameters, s)
			append_iterable_to ("Form parameters", req.form_parameters, s)

			if not s.is_empty then
				log.write_debug (generator + ".execute" + s)
			end
			execute_next (req, res)
		end


note
	copyright: "2011-2012, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
