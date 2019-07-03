class TEST

create
	make

feature {NONE} -- Creation

	make
		do
			$ERROR{B}.none_none
			$ERROR{B}.none_unexported
			{B}.none_exported
			{B}.none_any
			$ERROR{B}.unexported_none
			$ERROR{B}.unexported_unexported
			{B}.unexported_exported
			{B}.unexported_any
			{B}.exported_none
			{B}.exported_unexported
			{B}.exported_exported
			{B}.exported_any
			{B}.any_none
			{B}.any_unexported
			{B}.any_exported
			{B}.any_any
		end

end
