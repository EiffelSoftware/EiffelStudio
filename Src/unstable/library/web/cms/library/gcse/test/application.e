note
	description : "test application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			gcse: GCSE_API
			l_parameters: GCSE_QUERY_PARAMETERS
		do
			create l_parameters.make (key, cx, "scoop")
			create gcse.make (l_parameters)
			gcse.search

			if attached {GCSE_RESPONSE} gcse.last_result as l_result then
				if attached l_result.current_page as l_page then
					print ("Current Page%N")
					print (l_page.debug_output)
				end
				if attached l_result.next_page as l_page then
					print ("Next Page%N")
					print (l_page.debug_output)
				end
				if attached l_result.previous_page as l_page then
					print ("Previous Page%N")
					print (l_page.debug_output)
				end

				if attached l_result.items as l_items then
					print ("Number of items:"  + l_items.count.out)
					across l_items as ic loop print (ic.item.debug_output) end
				end

				if attached l_result.next_page as l_page then
					l_parameters.set_start (l_page.start_index)
					gcse.search
				end
			end

			if attached {GCSE_RESPONSE} gcse.last_result as l_result then
				if attached l_result.current_page as l_page then
					print ("Current Page%N")
					print (l_page.debug_output)
				end
				if attached l_result.next_page as l_page then
					print ("Next Page%N")
					print (l_page.debug_output)
				end
				if attached l_result.previous_page as l_page then
					print ("Previous Page%N")
					print (l_page.debug_output)
				end

				if attached l_result.items as l_items then
					print ("Number of items:"  + l_items.count.out)
					across l_items as ic loop print (ic.item.debug_output) end
				end

			end


		end

feature {NONE} -- Implementation

	Key: STRING = "AIzaSyBKAXNofo-RqZb6kUmpbiCwPEy7n7-E51k"
	cx : STRING = "015017565055626880074:9gdgp1fvt-g"
end
