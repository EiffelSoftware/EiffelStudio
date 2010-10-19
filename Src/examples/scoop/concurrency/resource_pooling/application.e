note
	description : "[
					10.2.3 Resource pooling exmaple
					
					More info please check Piotr Nienaltowski's SCOOP thesis, chapter 10.2
					link: http://se.ethz.ch/people/nienaltowski/papers/thesis.pdf					
																							]"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

	CONCURRENCY

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_pool: LINKED_LIST [detachable separate PHONE_LINE]
			l_line_1, l_line_2, l_line_3: PHONE_LINE
			l_count: INTEGER
		do
			-- Prepare 3 phone lines first
			create l_pool.make
			create l_line_1.make (1)
			l_pool.put (l_line_1)
			create l_line_2.make (2)
			l_pool.put (l_line_2)
			create l_line_3.make (3)
			l_pool.put (l_line_3)

			-- We connect 3 times
			from
			until
				l_count > 3
			loop
				call_m_out_of_n (agent {PHONE_LINE}.connect (Current), l_pool, 1)
				l_count := l_count + 1
			end
		end

feature -- Command

	phone_line_test
			-- Test function called by phone line
		do
			print ("Phone line test executed")
		end

end
