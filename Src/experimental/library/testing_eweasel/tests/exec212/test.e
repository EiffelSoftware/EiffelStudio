class TEST

create
	make

feature -- Creation

	make is
			-- Run test.
		local
			export_status: EXPORT_STATUS
			extended_status: EXTENDED_STATUS
		do
			export_status := {EXPORT_STATUS}.exports_some
			extended_status := {EXTENDED_STATUS}.exports_all
			io.put_integer (export_status)
			io.put_integer (extended_status)
			io.put_new_line
		end

end
