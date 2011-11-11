note
	description: "Convert between character codes and numbers case-sensitive"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "I believe the State exists for the development of individual lives, not individuals for the development of the state. -  Julian Huxley (1878-1975)"

class
	CASE_SENSITIVE_STRATEGY

inherit
	CHARACTER_STRATEGY

feature

	text_to_number (in: NATURAL_8): NATURAL_8
		do
			inspect
				in
			when 0x30 then
				Result := 0x0
			when 0x31 then
				Result := 1
			when 0x32 then
				Result := 2
			when 0x33 then
				Result := 3
			when 0x34 then
				Result := 4
			when 0x35 then
				Result := 5
			when 0x36 then
				Result := 6
			when 0x37 then
				Result := 7
			when 0x38 then
				Result := 8
			when 0x39 then
				Result := 9
			when 0x41 then
				Result := 10
			when 0x42 then
				Result := 11
			when 0x43 then
				Result := 12
			when 0x44 then
				Result := 13
			when 0x45 then
				Result := 14
			when 0x46 then
				Result := 15
			when 0x47 then
				Result := 16
			when 0x48 then
				Result := 17
			when 0x49 then
				Result := 18
			when 0x4a then
				Result := 19
			when 0x4b then
				Result := 20
			when 0x4c then
				Result := 21
			when 0x4d then
				Result := 22
			when 0x4e then
				Result := 23
			when 0x4f then
				Result := 24
			when 0x50 then
				Result := 25
			when 0x51 then
				Result := 26
			when 0x52 then
				Result := 27
			when 0x53 then
				Result := 28
			when 0x54 then
				Result := 29
			when 0x55 then
				Result := 30
			when 0x56 then
				Result := 31
			when 0x57 then
				Result := 32
			when 0x58 then
				Result := 33
			when 0x59 then
				Result := 34
			when 0x5a then
				Result := 35
			when 0x61 then
				Result := 36
			when 0x62 then
				Result := 37
			when 0x63 then
				Result := 38
			when 0x64 then
				Result := 39
			when 0x65 then
				Result := 40
			when 0x66 then
				Result := 41
			when 0x67 then
				Result := 42
			when 0x68 then
				Result := 43
			when 0x69 then
				Result := 44
			when 0x6a then
				Result := 45
			when 0x6b then
				Result := 46
			when 0x6c then
				Result := 47
			when 0x6d then
				Result := 48
			when 0x6e then
				Result := 49
			when 0x6f then
				Result := 50
			when 0x70 then
				Result := 51
			when 0x71 then
				Result := 52
			when 0x72 then
				Result := 53
			when 0x73 then
				Result := 54
			when 0x74 then
				Result := 55
			when 0x75 then
				Result := 56
			when 0x76 then
				Result := 57
			when 0x77 then
				Result := 58
			when 0x78 then
				Result := 59
			when 0x79 then
				Result := 60
			when 0x7a then
				Result := 61
			end
		end

	number_to_text (in: NATURAL_8): NATURAL_8
		do
			inspect in
			when 0 then
				Result := 0x30
			when 1 then
				Result := 0x31
			when 2 then
				Result := 0x32
			when 3 then
				Result := 0x33
			when 4 then
				Result := 0x34
			when 5 then
				Result := 0x35
			when 6 then
				Result := 0x36
			when 7 then
				Result := 0x37
			when 8 then
				Result := 0x38
			when 9 then
				Result := 0x39
			when 10 then
				Result := 0x41
			when 11 then
				Result := 0x42
			when 12 then
				Result := 0x43
			when 13 then
				Result := 0x44
			when 14 then
				Result := 0x45
			when 15 then
				Result := 0x46
			when 16 then
				Result := 0x47
			when 17 then
				Result := 0x48
			when 18 then
				Result := 0x49
			when 19 then
				Result := 0x4a
			when 20 then
				Result := 0x4b
			when 21 then
				Result := 0x4c
			when 22 then
				Result := 0x4d
			when 23 then
				Result := 0x4e
			when 24 then
				Result := 0x4f
			when 25 then
				Result := 0x50
			when 26 then
				Result := 0x51
			when 27 then
				Result := 0x52
			when 28 then
				Result := 0x53
			when 29 then
				Result := 0x54
			when 30 then
				Result := 0x55
			when 31 then
				Result := 0x56
			when 32 then
				Result := 0x57
			when 33 then
				Result := 0x58
			when 34 then
				Result := 0x59
			when 35 then
				Result := 0x5a
			when 36 then
				Result := 0x61
			when 37 then
				Result := 0x62
			when 38 then
				Result := 0x63
			when 39 then
				Result := 0x64
			when 40 then
				Result := 0x65
			when 41 then
				Result := 0x66
			when 42 then
				Result := 0x67
			when 43 then
				Result := 0x68
			when 44 then
				Result := 0x69
			when 45 then
				Result := 0x6a
			when 46 then
				Result := 0x6b
			when 47 then
				Result := 0x6c
			when 48 then
				Result := 0x6d
			when 49 then
				Result := 0x6e
			when 50 then
				Result := 0x6f
			when 51 then
				Result := 0x70
			when 52 then
				Result := 0x71
			when 53 then
				Result := 0x72
			when 54 then
				Result := 0x73
			when 55 then
				Result := 0x74
			when 56 then
				Result := 0x75
			when 57 then
				Result := 0x76
			when 58 then
				Result := 0x77
			when 59 then
				Result := 0x78
			when 60 then
				Result := 0x79
			when 61 then
				Result := 0x7a
			end
		end
end
