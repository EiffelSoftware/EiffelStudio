note
	description:
		"Page size constants for use with EV_POSTSCRIPT_PROJECTOR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "postscript, page, size, dimensions"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POSTSCRIPT_PAGE_CONSTANTS

feature -- Constants

	Comm10Envelope: INTEGER = 1
	C5Envelope: INTEGER = 2
	DLEnvelope: INTEGER = 3
	Folio: INTEGER = 4
	Executive: INTEGER = 5
	Letter: INTEGER = 6
	Legal: INTEGER = 7
	Ledger: INTEGER = 8
	Tabloid: INTEGER = 9
	A0: INTEGER = 10
	A1: INTEGER = 11
	A2: INTEGER = 12
	A3: INTEGER = 13
	A4: INTEGER = 14
	A5: INTEGER = 15
	A6: INTEGER = 16
	A7: INTEGER = 17
	A8: INTEGER = 18
	A9: INTEGER = 19
	B0: INTEGER = 20
	B1: INTEGER = 21
	B2: INTEGER = 22
	B3: INTEGER = 23
	B4: INTEGER = 24
	B5: INTEGER = 25
	B6: INTEGER = 26
	B7: INTEGER = 27
	B8: INTEGER = 28
	B9: INTEGER = 29
	B10: INTEGER = 30
		-- Valid page constants.

feature -- Status report

	page_width (a_size: INTEGER; landscape: BOOLEAN): INTEGER
			-- Return the page width in points (1 inch/72)
			-- for the specified page size and orientation.
		require
			valid_size: valid_page_size (a_size)
		do
			if landscape then
				inspect
					a_size
				when Comm10Envelope then
					Result := 684
				when C5Envelope then
					Result := 648
				when DLEnvelope then
					Result := 624
				when Folio then
					Result := 935
				when Executive then
					Result := 756
				when Letter then
					Result := 792
				when Legal then
					Result := 1008
				when Ledger then
					Result := 792
				when Tabloid then
					Result := 1224
				when A0 then
					Result := 3370
				when A1 then
					Result := 2384
				when A2 then
					Result := 1684
				when A3 then
					Result := 1191
				when A4 then
					Result := 842
				when A5 then
					Result := 595
				when A6 then
					Result := 420
				when A7 then
					Result := 297
				when A8 then
					Result := 210
				when A9 then
					Result := 148
				when B0 then
					Result := 4127
				when B1 then
					Result := 2920
				when B2 then
					Result := 2064
				when B3 then
					Result := 1460
				when B4 then
					Result := 1032
				when B5 then
					Result := 729
				when B6 then
					Result := 516
				when B7 then
					Result := 363
				when B8 then
					Result := 258
				when B9 then
					Result := 181
				when B10 then
					Result := 127
				end
			else
				inspect
					a_size
				when Comm10Envelope then
					Result := 297
				when C5Envelope then
					Result := 461
				when DLEnvelope then
					Result := 312
				when Folio then
					Result := 595
				when Executive then
					Result := 522
				when Letter then
					Result := 612
				when Legal then
					Result := 612
				when Ledger then
					Result := 1224
				when Tabloid then
					Result := 792
				when A0 then
					Result := 2384
				when A1 then
					Result := 1684
				when A2 then
					Result := 1191
				when A3 then
					Result := 842
				when A4 then
					Result := 595
				when A5 then
					Result := 420
				when A6 then
					Result := 297
				when A7 then
					Result := 210
				when A8 then
					Result := 148
				when A9 then
					Result := 105
				when B0 then
					Result := 2920
				when B1 then
					Result := 2064
				when B2 then
					Result := 1460
				when B3 then
					Result := 1032
				when B4 then
					Result := 729
				when B5 then
					Result := 516
				when B6 then
					Result := 363
				when B7 then
					Result := 258
				when B8 then
					Result := 181
				when B9 then
					Result := 127
				when B10 then
					Result := 91
				end
			end
		end

	page_height (a_size: INTEGER; landscape: BOOLEAN): INTEGER
			-- Return the page height in points (1 inch/72)
			-- for the specified page size and orientation.
		require
			valid_size: valid_page_size (a_size)
		do
			if landscape then
				inspect
					a_size
				when Comm10Envelope then
					Result := 297
				when C5Envelope then
					Result := 461
				when DLEnvelope then
					Result := 312
				when Folio then
					Result := 595
				when Executive then
					Result := 522
				when Letter then
					Result := 612
				when Legal then
					Result := 612
				when Ledger then
					Result := 1224
				when Tabloid then
					Result := 792
				when A0 then
					Result := 2384
				when A1 then
					Result := 1684
				when A2 then
					Result := 1191
				when A3 then
					Result := 842
				when A4 then
					Result := 595
				when A5 then
					Result := 420
				when A6 then
					Result := 297
				when A7 then
					Result := 210
				when A8 then
					Result := 148
				when A9 then
					Result := 105
				when B0 then
					Result := 2920
				when B1 then
					Result := 2064
				when B2 then
					Result := 1460
				when B3 then
					Result := 1032
				when B4 then
					Result := 729
				when B5 then
					Result := 516
				when B6 then
					Result := 363
				when B7 then
					Result := 258
				when B8 then
					Result := 181
				when B9 then
					Result := 127
				when B10 then
					Result := 91
				end
			else
				inspect
					a_size
				when Comm10Envelope then
					Result := 684
				when C5Envelope then
					Result := 648
				when DLEnvelope then
					Result := 624
				when Folio then
					Result := 935
				when Executive then
					Result := 756
				when Letter then
					Result := 792
				when Legal then
					Result := 1008
				when Ledger then
					Result := 792
				when Tabloid then
					Result := 1224
				when A0 then
					Result := 3370
				when A1 then
					Result := 2384
				when A2 then
					Result := 1684
				when A3 then
					Result := 1191
				when A4 then
					Result := 842
				when A5 then
					Result := 595
				when A6 then
					Result := 420
				when A7 then
					Result := 297
				when A8 then
					Result := 210
				when A9 then
					Result := 148
				when B0 then
					Result := 4127
				when B1 then
					Result := 2920
				when B2 then
					Result := 2064
				when B3 then
					Result:= 1460
				when B4 then
					Result := 1032
				when B5 then
					Result := 729
				when B6 then
					Result := 516
				when B7 then
					Result := 363
				when B8 then
					Result := 258
				when B9 then
					Result := 181
				when B10 then
					Result := 127
				end
			end
		end

	Default_left_margin: INTEGER = 20
		-- Default size in pixels of the left side page margin.

	Default_bottom_margin: INTEGER = 20
		-- Default size in pixels of the right side page margin.

feature -- Contract support

	valid_page_size (a_size: INTEGER): BOOLEAN
			-- Is `a_size' a valid page value?
		do
			Result := a_size >= Comm10Envelope and
			a_size <= B10
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_POSTSCRIPT_PAGE_CONSTANTS

