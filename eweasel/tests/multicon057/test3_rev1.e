
class TEST3
feature
	weasel: INTEGER = 29

	marten: INTEGER = 30

	manu: INTEGER
		external
			"C inline"
		alias
			"return 31;"
		end
end
