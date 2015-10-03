class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			t: TUPLE [i: INTEGER; b: BOOLEAN]
		do
			t := [3, True]
			t.i := {NATURAL_8} 5 -- OK: conversion.
			t.b := 8             -- Error.
		end

end